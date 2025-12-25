# General DMA

## Overview

SNES has **8 DMA channels** (0-7) for automatic data transfer between CPU memory and PPU memory (VRAM, CGRAM, OAM).

## Why DMA?

- **Speed**: 10-100x faster than manual writes
- **Required**: OAM is 544 bytes (too large for manual writes)
- **Efficient**: CPU can do other work during transfer

## DMA Channels

Each channel has independent configuration:
- **Channel 0**: Typically used for OAM
- **Channels 1-7**: Available for VRAM, CGRAM, or other transfers

## DMA Registers (per channel)

| Register | Channel 0 | Channel 1 | Description |
|----------|-----------|-----------|-------------|
| DMAPx | $4300 | $4310 | DMA parameters |
| BBADx | $4301 | $4311 | B-bus address (PPU register) |
| A1TxL | $4302 | $4312 | Source address (low) |
| A1TxH | $4303 | $4313 | Source address (high) |
| A1Bx | $4304 | $4314 | Source address (bank) |
| DASxL | $4305 | $4315 | Transfer size (low) |
| DASxH | $4306 | $4316 | Transfer size (high) |

## DMA Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| 0 | 1 register write once | CGRAM |
| 1 | 2 registers write once | VRAM |
| 2 | 1 register write twice | OAM |
| 3-7 | Various combinations | Special cases |

## Common DMA Transfers

### OAM Update (Channel 0)

```asm
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
```

### VRAM Transfer (Channel 1)

```asm
lda #%00000001      ; Mode 1
sta DMAP1
lda #$18            ; VMDATAL
sta BBAD1
lda #<vram_data
sta A1T1L
lda #>vram_data
sta A1T1H
lda #^vram_data
sta A1B1
ldx #size
stx DAS1L
lda #$02
sta MDMAEN
```

## Timing

- **Setup**: ~20-30 cycles
- **Transfer**: ~2 cycles per byte
- **Total**: Setup + (bytes × 2 cycles)

## Cross-References

- [HDMA Per-Scanline](hdma-per-scanline.md) - H-Blank DMA
- [DMA Channels](dma-channels.md) - Channel configuration
- [Cycle Stealing](cycle-stealing.md) - DMA timing impact
