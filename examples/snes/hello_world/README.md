# SNES Hello World Example

Minimal SNES program demonstrating correct hardware initialization and basic text rendering.

## Features

- Native 65816 mode entry (`clc; xce`)
- Complete SNES initialization
- PPU setup and text rendering
- DMA-based VRAM clearing
- LoROM mapping with correct header

## Building

```bash
make
```

Produces `hello.smc` for SNES emulators.

## Requirements

- cc65 toolchain (ca65, ld65)
- SNES emulator (bsnes, higan, etc.)

## Code Structure

- `main.s` - Main source with initialization and rendering
- `snes.cfg` - LoROM linker configuration
- `Makefile` - Build system
- `headers/` - SNES register definitions
- `assets/data/` - Character set data

## What This Demonstrates

1. **Native Mode Entry**: `clc; xce` switches to native mode
2. **Register Widths**: 8-bit A, 16-bit X/Y
3. **PPU Initialization**: Complete S-PPU register setup
4. **DMA Usage**: VRAM clearing via DMA
5. **Text Rendering**: Character set loading and display

## Related Documentation

See [SNES Documentation](../../../docs/snes/README.md) for complete SNES development guides.

## Related Documentation

- [SNES Documentation](../../../docs/snes/README.md) - SNES documentation index
- [Getting Started](../../../docs/snes/getting-started/) - Learning guides
- [Hardware Overview](../../../docs/snes/getting-started/01-hardware-overview.md) - System architecture
- [CPU Initialization](../../../docs/snes/programming/initialization/cpu-init.md) - 65816 initialization
- [PPU Initialization](../../../docs/snes/programming/initialization/ppu-init.md) - S-PPU initialization
