# SNES Timing Quick Reference

## CPU Timing

### Clock Rates
- **NTSC**: 3.58 MHz
- **PAL**: 3.55 MHz

### Frame Timing (NTSC)
- **Frame Rate**: 60.098 Hz
- **Frame Duration**: ~21,477 cycles
- **VBlank Duration**: ~1,364 cycles (38 scanlines)
- **Visible Period**: ~20,113 cycles (224 scanlines)

### Frame Timing (PAL)
- **Frame Rate**: 50.007 Hz
- **Frame Duration**: ~21,200 cycles
- **VBlank Duration**: ~2,620 cycles (73 scanlines)
- **Visible Period**: ~18,580 cycles (239 scanlines)

## VBlank Windows

### NTSC
- **Start**: Scanline 225
- **End**: Before scanline 1
- **Duration**: 38 scanlines (~1,364 cycles)

### PAL
- **Start**: Scanline 240
- **End**: Before scanline 1
- **Duration**: 73 scanlines (~2,620 cycles)

## DMA Timing

### OAM DMA
- **Size**: 544 bytes
- **Time**: ~1,090 cycles
- **Must complete**: During VBlank

### VRAM DMA
- **Time**: ~2 cycles per byte
- **Must occur**: During VBlank or forced blanking

## HDMA Timing

- **Per-scanline overhead**: 8-24 cycles
- **Frame overhead**: 1,792-5,376 cycles (NTSC)
- **Runs during**: H-Blank (between scanlines)

## Cross-References

- [CPU Timing](../../hardware/cpu-65816/cpu-timing.md) - Detailed CPU timing
- [VBlank Windows](../../programming/game-loop/vblank-windows.md) - VBlank details
- [DMA/HDMA Timing](../../hardware/dma-hdma/cycle-stealing.md) - DMA timing
