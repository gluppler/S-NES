# NES PPU (RP2C02 / RP2C07)

> **Status**: This is a stub. For complete PPU documentation, see [NESdev Wiki - PPU](https://www.nesdev.org/wiki/PPU).

## Overview

The Picture Processing Unit handles all graphics rendering for the NES.

### Key Specifications

- **Resolution**: 256x240 pixels
- **Colors**: 54 colors (6-bit palette)
- **Sprites**: 64 sprites, 8 per scanline
- **Nametables**: 2KB VRAM (4 nametables with mirroring)

## Registers

All PPU registers are memory-mapped at $2000-$2007:

```
$2000 PPUCTRL   - PPU Control
$2001 PPUMASK   - PPU Mask  
$2002 PPUSTATUS - PPU Status (read-only)
$2003 OAMADDR   - OAM Address
$2004 OAMDATA   - OAM Data
$2005 PPUSCROLL - Scroll Position
$2006 PPUADDR   - PPU Address
$2007 PPUDATA   - PPU Data
```

## Rendering Pipeline

1. **Pre-render scanline** (-1)
2. **Visible scanlines** (0-239)
3. **Post-render scanline** (240)
4. **Vertical blank** (241-260)

## Timing

- **Frame rate**: 60.0988 Hz (NTSC), 50.0070 Hz (PAL)
- **Scanlines per frame**: 262 (NTSC), 312 (PAL)
- **Cycles per scanline**: 341

## Memory Map

```
$0000-$0FFF: Pattern Table 0
$1000-$1FFF: Pattern Table 1
$2000-$23FF: Nametable 0
$2400-$27FF: Nametable 1
$2800-$2BFF: Nametable 2
$2C00-$2FFF: Nametable 3
$3000-$3EFF: Mirrors of $2000-$2EFF
$3F00-$3F1F: Palette RAM
$3F20-$3FFF: Mirrors of $3F00-$3F1F
```

## Resources

- [NESdev Wiki - PPU](https://www.nesdev.org/wiki/PPU)
- [NESdev Wiki - PPU Rendering](https://www.nesdev.org/wiki/PPU_rendering)
- [NESdev Wiki - PPU Registers](https://www.nesdev.org/wiki/PPU_registers)
