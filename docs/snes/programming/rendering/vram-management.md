# VRAM Management

## Overview

SNES VRAM is 64 KB and must be managed carefully. VRAM access is only safe during VBlank or forced blanking.

## VRAM Organization

### Common Layout

```
$0000-$1FFF: Background tiles (Mode 0-6)
$2000-$3FFF: Sprite tiles
$4000-$5FFF: Background tiles (additional)
$6000-$7FFF: Nametables (tilemaps)
```

## VRAM Access

### Setting VRAM Address

```asm
lda #$80            ; Increment by 1 word
sta VMAINC          ; $2115
ldx #VRAM_ADDRESS
stx VMADDL          ; $2116-$2117: Set VRAM address
```

### Writing to VRAM

```asm
; Write tile data (dual-write: low, then high)
lda tile_data_low
sta VMDATAL         ; $2118: Write low byte
lda tile_data_high
sta VMDATAH         ; $2119: Write high byte (auto-increments)
```

## DMA VRAM Transfer

```asm
.proc load_bg_tiles
  phb
  phk
  plb

  ; Copy background tiles to PPU using DMA
  setaxy16
  stz PPUADDR       ; VRAM address = $0000
  lda #DMAMODE_PPUDATA  ; DMAMODE_PPUDATA = (<PPUDATA << 8) | DMA_01 | DMA_FORWARD
  ldy #chr_bin_size
  ldx #chr_bin & $FFFF
  jsl ppu_copy

  plb
  rtl
.endproc
```

### DMA Mode Constants

```asm
DMAMODE_PPUDATA = (<PPUDATA << 8) | DMA_01 | DMA_FORWARD
DMAMODE_CGDATA  = (<CGDATA << 8)  | DMA_00 | DMA_FORWARD
DMAMODE_OAMDATA = (<OAMDATA << 8) | DMA_00 | DMA_FORWARD
```

## VRAM Timing

- **Must occur**: During VBlank or forced blanking
- **DMA time**: ~2 cycles per byte
- **Manual write**: ~4-6 cycles per word

## Cross-References

- [PPU Rendering Rules](../../hardware/ppu/ppu-rendering-rules.md) - VRAM access rules
- [DMA OAM Updates](dma-oam-updates.md) - DMA patterns
