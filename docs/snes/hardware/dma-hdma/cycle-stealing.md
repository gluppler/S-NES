# DMA Cycle Stealing

## Overview

DMA operations **steal CPU cycles** during transfer. Understanding this is critical for timing-sensitive code.

## General DMA Cycle Stealing

### During Transfer
- **CPU is blocked**: Cannot execute instructions
- **Cycle cost**: ~2 cycles per byte transferred
- **Total time**: Setup cycles + (bytes × 2 cycles)

### Example

```asm
; Transfer 544 bytes OAM
; Setup: ~20 cycles
; Transfer: 544 × 2 = 1,088 cycles
; Total: ~1,108 cycles
```

## HDMA Cycle Stealing

### Per-Scanline
- **Overhead**: 8-24 cycles per scanline
- **Frame overhead**: 224 scanlines × 8-24 cycles = 1,792-5,376 cycles
- **Runs during**: H-Blank (between scanlines)

### Impact on CPU

HDMA reduces available CPU time during rendering:
- **Without HDMA**: ~20,113 cycles available (visible period)
- **With HDMA**: ~14,737-18,321 cycles available (after HDMA overhead)

## Timing Considerations

### VBlank Budget

- **Total VBlank**: ~1,364 cycles (NTSC)
- **OAM DMA**: ~1,090 cycles
- **Remaining**: ~274 cycles for other tasks

### Visible Period Budget

- **Total visible**: ~20,113 cycles (NTSC)
- **HDMA overhead**: 1,792-5,376 cycles (if using HDMA)
- **Remaining**: ~14,737-18,321 cycles for game logic

## Optimization

- **Minimize HDMA channels**: Use only what you need
- **Batch DMA transfers**: Combine multiple transfers
- **Use forced blanking**: For large transfers

## Cross-References

- [General DMA](general-dma.md) - One-time DMA
- [HDMA Per-Scanline](hdma-per-scanline.md) - H-Blank DMA
- [CPU Timing](../../cpu-65816/cpu-timing.md) - CPU cycle timing
