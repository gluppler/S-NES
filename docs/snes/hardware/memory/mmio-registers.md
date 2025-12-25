# MMIO Registers

## Overview

MMIO (Memory-Mapped I/O) registers allow the CPU to communicate with SNES hardware components.

## Register Categories

### S-PPU Registers ($2100-$213F)

- **$2100-$2104**: Screen display, OAM
- **$2105-$2114**: Background configuration, scrolling
- **$2115-$2119**: VRAM access
- **$211A-$2120**: Mode 7
- **$2121-$2122**: CGRAM
- **$2123-$212F**: Windowing, layer enables
- **$2130-$213F**: Color math, status

### S-CPU I/O ($4200-$421F)

- **$4200**: Interrupt enable (NMI, auto-joypad)
- **$4202-$4206**: MUL/DIV hardware
- **$4207-$420A**: H/V count timers
- **$420B**: DMA enable
- **$420C**: HDMA enable
- **$420D**: Fast ROM enable
- **$4210-$421F**: Status, auto-joypad data

### DMA Registers ($4300-$43FF)

- **$4300-$430F**: DMA channel 0
- **$4310-$431F**: DMA channel 1
- **...**: Channels 2-7

### SPC700 Communication ($2140-$2143)

- **$2140-$2143**: CPU ↔ SPC700 communication ports

### WRAM Access ($2180-$2183)

- **$2180**: WRAM data
- **$2181-$2183**: WRAM address

## Register Access Rules

- **Read-only**: Status registers, read ports
- **Write-only**: Control registers, write ports
- **Dual-write**: Scroll registers, Mode 7 matrix
- **Timing**: Some registers only writable during VBlank/H-Blank

## Cross-References

- [PPU Register Map](../../references/ppu-register-map.md) - Complete PPU register map
- [DMA/HDMA Reference](../../references/dma-hdma-reference.md) - DMA register map
