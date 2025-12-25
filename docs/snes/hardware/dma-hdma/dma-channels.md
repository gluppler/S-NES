# DMA Channels

## Overview

SNES has **8 independent DMA channels** (0-7), each with its own configuration.

## Channel Priority

- **Channel 0**: Highest priority
- **Channel 7**: Lowest priority
- **Multiple channels**: Processed in priority order (0-7)

## Channel Configuration

Each channel requires:
1. **DMAPx**: DMA parameters (mode, direction)
2. **BBADx**: B-bus address (PPU register destination)
3. **A1TxL/H/B**: Source address (low, high, bank)
4. **DASxL/H**: Transfer size (low, high)

## Common Channel Assignments

| Channel | Typical Use | Destination |
|---------|-------------|-------------|
| 0 | OAM updates | OAMDATA ($2104) |
| 1 | VRAM transfers | VMDATAL ($2118) |
| 2 | CGRAM transfers | CGDATA ($2122) |
| 3-7 | Available | Various |

## Enabling Channels

### General DMA

```asm
lda #$01            ; Enable channel 0
sta MDMAEN          ; $420B: General DMA enable
```

### HDMA

```asm
lda #$02            ; Enable channel 1
sta HDMAEN          ; $420C: HDMA enable
```

## Multiple Channels

You can enable multiple channels simultaneously:

```asm
lda #$07            ; Enable channels 0, 1, 2
sta MDMAEN          ; Channels process in priority order (0, 1, 2)
```

## Cross-References

- [General DMA](general-dma.md) - One-time DMA
- [HDMA Per-Scanline](hdma-per-scanline.md) - H-Blank DMA
- [Cycle Stealing](cycle-stealing.md) - DMA timing
