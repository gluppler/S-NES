# DMA OAM Updates

## Overview

SNES uses **DMA channel 0** to transfer OAM (Object Attribute Memory) data from WRAM to PPU. This is the standard method for updating sprites.

## Why DMA for OAM?

- **Speed**: DMA is 10-100x faster than manual writes
- **Required**: OAM is 544 bytes (too large for manual writes during VBlank)
- **Standard**: All SNES games use DMA for OAM updates

## OAM Structure

OAM consists of:
- **512 bytes**: Sprite data (128 sprites × 4 bytes)
- **32 bytes**: Size/priority table (4 sprites per byte)

**Total**: 544 bytes

## OAM Mirror in WRAM

Maintain OAM data in WRAM (OAM mirror):

```asm
.segment "BSS"
OAM_MIRROR: .res 512  ; Sprite data
OAM_HI:     .res 32   ; Size/priority table
```

## DMA Channel 0 Configuration

### Register Setup

```asm
.proc ppu_copy_oam
  setaxy16
  lda #DMAMODE_OAMDATA  ; DMAMODE_OAMDATA = (<OAMDATA << 8) | DMA_00 | DMA_FORWARD
  ldx #OAM              ; OAM mirror address
  ldy #544              ; 544 bytes (512 OAM + 32 size table)
  ; falls through to ppu_copy
.endproc

.proc ppu_copy
  php
  setaxy16
  sta DMAMODE           ; $4300: DMA parameters
  stx DMAADDR           ; $4302-$4303: Source address
  sty DMALEN            ; $4305-$4306: Transfer size
  seta8
  phb
  pla
  sta DMAADDRBANK       ; $4304: Source bank
  lda #%00000001
  sta COPYSTART         ; $420B: Start DMA channel 0
  plp
  rtl
.endproc
```

### Using DMA Macros

```asm
; DMA mode constants
DMAMODE_OAMDATA = (<OAMDATA << 8) | DMA_00 | DMA_FORWARD
DMAMODE_PPUDATA = (<PPUDATA << 8) | DMA_01 | DMA_FORWARD
DMAMODE_CGDATA  = (<CGDATA << 8)  | DMA_00 | DMA_FORWARD

; Usage:
lda #DMAMODE_OAMDATA
ldx #OAM_MIRROR
ldy #544
jsl ppu_copy
```

## Complete OAM Update Pattern

### 1. Update OAM Mirror

```asm
.proc update_sprite
    ; Update sprite in OAM mirror
    ldx sprite_index
    lda sprite_y
    sta OAM_MIRROR,x    ; Y position
    inx
    lda sprite_tile
    sta OAM_MIRROR,x    ; Tile index
    inx
    lda sprite_attr
    sta OAM_MIRROR,x    ; Attributes
    inx
    lda sprite_x
    sta OAM_MIRROR,x    ; X position
    rts
.endproc
```

### 2. Pack OAM_HI Table

```asm
.proc ppu_pack_oamhi
  setxy16
  ldx #0
  txy
packloop:
  ; pack four sprites' size+xhi bits from OAMHI
  sep #$20
  lda OAMHI+13,y
  asl a
  asl a
  ora OAMHI+9,y
  asl a
  asl a
  ora OAMHI+5,y
  asl a
  asl a
  ora OAMHI+1,y
  sta OAMHI,x
  rep #$21  ; seta16 + clc for following addition

  ; move to the next set of 4 OAM entries
  inx
  tya
  adc #16
  tay
  
  ; done yet?
  cpx #32  ; 128 sprites divided by 4 sprites per byte
  bcc packloop
  rtl
.endproc
```

**Note**: OAMHI contains bit 8 of X (horizontal position) and the size bit for each sprite. It's a bit wasteful of memory (512 bytes), but makes sprite drawing code much simpler.

### 3. Transfer via DMA

```asm
.proc transfer_oam_dma
    ; Set OAM address to 0
    stz OAMADDL
    stz OAMADDH
    
    ; Configure DMA
    lda #%00000010      ; Mode 2
    sta DMAP0
    lda #$04            ; OAMDATA
    sta BBAD0
    lda #<OAM_MIRROR
    sta A1T0L
    lda #>OAM_MIRROR
    sta A1T0H
    stz A1T0B
    ldx #544
    stx DAS0L
    lda #$01
    sta MDMAEN
    
    rts
.endproc
```

## NMI Handler Integration

```asm
.proc nmi_handler
    ; Acknowledge NMI
    lda RDNMI           ; $4210
    
    ; Update OAM via DMA
    jsr transfer_oam_dma
    
    ; Other VBlank tasks...
    
    rti
.endproc
```

## Timing Requirements

- **Must complete during VBlank**: OAM DMA must finish before rendering starts
- **VBlank Duration**: ~1,364 cycles (NTSC)
- **DMA Time**: ~1,090 cycles for 544 bytes
- **Available Time**: ~274 cycles for other VBlank tasks

## Common Mistakes

### Wrong DMA Mode
```asm
; ❌ BAD: Wrong mode (OAM needs mode 2)
lda #%00000000
sta DMAP0  ; Mode 0 is wrong for OAM
```

### Wrong Destination
```asm
; ❌ BAD: Wrong destination
lda #$18
sta BBAD0  ; $18 is VMDATAL, not OAMDATA
```

### Correct Configuration
```asm
; ✅ GOOD: Mode 2, OAMDATA destination
lda #%00000010  ; Mode 2
sta DMAP0
lda #$04        ; OAMDATA ($2104)
sta BBAD0
```

## Cross-References

- [General DMA](../../hardware/dma-hdma/general-dma.md) - DMA fundamentals
- [OAM System](../../hardware/ppu/oam-system.md) - OAM structure
- [OAM Mirror](oam-mirror.md) - WRAM sprite buffer
- [NMI Handler](../../programming/game-loop/nmi-handler.md) - VBlank handling
