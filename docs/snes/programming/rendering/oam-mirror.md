# OAM Mirror

## Overview

SNES maintains OAM (Object Attribute Memory) data in **WRAM** (OAM mirror) and transfers it to hardware OAM via DMA during VBlank.

## Why OAM Mirror?

- **Hardware OAM is read-only** during rendering
- **OAM mirror in WRAM** allows CPU to modify sprite data anytime
- **DMA transfer** during VBlank updates hardware OAM

## OAM Structure

### Sprite Data (512 bytes)
- 128 sprites × 4 bytes each
- Each sprite: Y(1), Tile(1), Attr(1), X(1)

### Size/Priority Table (32 bytes)
- 4 sprites per byte
- Bits 0-1: Sprite 0 size bit
- Bits 2-3: Sprite 1 size bit
- Bits 4-5: Sprite 2 size bit
- Bits 6-7: Sprite 3 size bit

**Total**: 544 bytes

## OAM Mirror Location

```asm
.segment "BSS"
OAM_MIRROR: .res 512  ; Sprite data
OAM_HI:     .res 32   ; Size/priority table
```

Common location: $7E0400-$7E061F

## Updating OAM Mirror

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

## Packing OAM_HI Table

```asm
.proc pack_oam_hi
    ldx #0
    txy
pack_loop:
    sep #$20
    lda OAM_HI+13,y     ; Sprite 3 size bit
    asl a
    asl a
    ora OAM_HI+9,y      ; Sprite 2 size bit
    asl a
    asl a
    ora OAM_HI+5,y      ; Sprite 1 size bit
    asl a
    asl a
    ora OAM_HI+1,y      ; Sprite 0 size bit
    sta OAM_HI,x
    rep #$21            ; 16-bit + clear carry
    inx
    tya
    adc #16             ; Next group of 4 sprites
    tay
    cpx #32             ; 128 sprites / 4 = 32 bytes
    bcc pack_loop
    rts
.endproc
```

## Transferring to Hardware OAM

See [DMA OAM Updates](dma-oam-updates.md) for DMA transfer code.

## Cross-References

- [DMA OAM Updates](dma-oam-updates.md) - DMA transfer code
- [OAM System](../../hardware/ppu/oam-system.md) - OAM structure details
- [NMI Handler](../game-loop/nmi-handler.md) - VBlank handling
