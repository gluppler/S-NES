# S-NES-BOY NES Development Template

Production-ready NES development template for the S-NES-BOY Learning & Development Framework.

## Scope

This template is part of the S-NES-BOY framework and provides a complete, hardware-accurate starting point for NES development. It is designed to generate a valid iNES ROM with correct vectors and NMI usage, respect PPU timing rules, and support CHR-ROM or CHR-RAM cleanly.

## Directory Layout

The NES template uses the following layout:

- `build/` - Build output directory (object files, ROMs, maps)
- `src/` - NES source code organized by subsystem:
  - `src/main.asm` - Entry point and main loop
  - `src/reset.asm` - Reset handler and initialization
  - `src/nmi.asm` - NMI (VBlank) handler
  - `src/irq.asm` - IRQ handler
  - `src/vectors.asm` - Interrupt vectors
  - `src/input/` - Controller input handling
  - `src/ppu/` - PPU utilities and rendering
  - `src/sprites/` - Sprite management
  - `src/text/` - Text rendering
  - `src/palette/` - Palette management
  - `src/tilemap/` - Tilemap loading and management
  - `src/audio/` - APU initialization and audio
  - `src/game/` - Game logic
  - `src/screens/` - Screen/state management
  - `src/state/` - State machine
- `assets/` - Tile, tilemap, and palette data used by the ROM
  - `assets/graphics/chr/` - CHR tile data
- `linker/` - Linker configuration files (NROM, MMC1, etc.)
- `headers/` - Hardware register definitions and memory layout includes
- `macros/` - Assembly macros and reusable patterns
- `tools/` - Helper tools and scripts
- `config/` - Mapper, mirroring, and build options
- `rom/` - Output ROM images (generated during build)

## Template Contents

- **Reset and initialization**: `src/reset.asm` handles power-on reset and hardware initialization
- **Interrupt handlers**: `src/nmi.asm` (VBlank), `src/irq.asm` (IRQ), `src/vectors.asm` (interrupt vectors)
- **Main loop**: `src/main.asm` provides the main game loop structure
- **Input system**: `src/input/controller.asm` for controller reading
- **PPU utilities**: `src/ppu/` for PPU initialization, writes, scrolling, and attributes
- **Sprite system**: `src/sprites/` for sprite DMA and utilities
- **Text rendering**: `src/text/` for text printing and string handling
- **Palette management**: `src/palette/` for palette loading and fading
- **Tilemap system**: `src/tilemap/` for tilemap loading, metatiles, and collision
- **Audio system**: `src/audio/` for APU initialization, music, and SFX
- **Game logic**: `src/game/` for entities, collisions, and game rules
- **Screen management**: `src/screens/` for different game screens
- **State machine**: `src/state/` for state transitions and management
- **Linker configurations**: `linker/` for NROM and other mappers
- **Headers**: Constants and memory definitions in `src/constants/` and `src/memory/`
- **Macros**: Reusable patterns in `src/macros/` for timing, memory, PPU, branches, etc.
- **Build system**: `Makefile` that compiles all `.asm` files and produces a `.nes` ROM in `build/rom/`

## Building

From `templates/nes/`:

```bash
make clean    # Remove build artifacts
make          # Build ROM (or make all)
make run      # Run in emulator (if configured)
```

The build system:
- Compiles all `.asm` files in `src/` (excluding files included in `main.asm`)
- Links object files using the configured linker script
- Produces `build/rom/game.nes` ROM file
- Generates map file in `build/map/` for debugging

## Requirements

- `ca65` – 6502 assembler (part of cc65)
- `ld65` – Linker (part of cc65)
- NES emulator such as Mesen2 or FCEUX

## Hardware Assumptions

This template assumes:
- **NROM mapper (Mapper 0)** with 32 KB PRG ROM and 8 KB CHR ROM
- **NTSC timing** (60.098 Hz frame rate, 262 scanlines)
- **Standard NES controller input** (controller port 1)
- **Horizontal mirroring** for nametables (configurable in linker)
- **All PPU updates occur during VBlank** (proper timing discipline)
- **NMI handler completes within VBlank window** (cycle budget respected)
- **Files included in main.asm** are not compiled separately (handled by Makefile)

## Extending the Template

To extend this template:

1. **Add new subsystems**: Create modules in `src/` following existing patterns (use `.asm` extension)
2. **Add assets**: Place tile data, tilemaps, and palettes in `assets/graphics/`
3. **Add macros**: Place reusable assembly macros in `src/macros/` (use `.inc` extension)
4. **Add constants**: Place hardware definitions in `src/constants/` (use `.inc` extension)
5. **Add memory definitions**: Place RAM/zeropage definitions in `src/memory/` (use `.inc` extension)
6. **Configure mapper**: Modify `linker/` configuration for different mappers
7. **Include in main.asm**: Files included with `.include` in `main.asm` are automatically excluded from separate compilation

**Important**: Files included in `main.asm` with `.include` should NOT be compiled separately. The Makefile handles this automatically.

Follow the existing code structure and maintain hardware-accurate timing constraints.

## Related Documentation

- [Framework Overview](../../README.md) - Main framework README
- [NES Documentation Index](../../docs/nes/README.md) - NES documentation index
- [NES Fundamentals](../../docs/nes/fundamentals/) - Core NES hardware concepts
- [NES Advanced Fundamentals](../../docs/nes/advanced_fundamentals/) - Timing and constraints
- [NES Core Concepts](../../docs/nes/concepts/) - System interaction patterns

## Philosophy

The NES template is intended to be a minimal, correct starting point for real-hardware-safe NES projects. It follows hardware-first principles and respects all NES timing constraints and hardware limitations.
