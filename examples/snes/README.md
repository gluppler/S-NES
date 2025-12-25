# SNES Examples

This directory contains SNES programming examples demonstrating various concepts and techniques.

## Examples

### `hello_world/`
Minimal SNES example displaying text on screen. Demonstrates:
- Basic SNES initialization
- VRAM character data loading
- Background layer setup
- Text rendering

### `move_sprite/`
**Modular sprite movement example** with controller input. Demonstrates:
- **Modular code structure** - Organized into `src/common/`, `src/PPU/`, `src/Game/`, and `assets/`
- **SNES initialization** - Comprehensive PPU/CPU register clearing (`InitSNES.s`)
- **Sprite display** - Loading sprites into VRAM and CGRAM
- **DMA for OAM updates** - Efficient sprite updates using DMA during V-Blank
- **Controller input** - Auto-joypad reading with trigger/held button detection
- **Input handling** - D-pad movement with boundary checking

**Structure:**
- `src/common/` - Shared utilities (Registers, InitSNES, Joypad, Vector)
- `src/PPU/` - PPU operations (LoadVRAM, LoadCGRAM, UpdateOAMRAM)
- `src/Game/` - Game-specific code (Init, Input handling)
- `src/Main.s` - Entry point and game loop
- `assets/` - Sprite and palette data

### `bounce_sprite/`
**Modular bouncing sprite example** with automatic physics. Demonstrates:
- **Modular code structure** - Organized into `src/common/`, `src/PPU/`, `src/Game/`, and `assets/`
- **SNES initialization** - Comprehensive PPU/CPU register clearing (`InitSNES.s`)
- **Sprite display** - Loading sprites into VRAM and CGRAM
- **DMA for OAM updates** - Efficient sprite updates using DMA during V-Blank
- **Bouncing physics** - Automatic sprite movement with boundary collision detection
- **Speed inversion** - Physics-based bouncing off screen edges

**Structure:**
- `src/common/` - Shared utilities (Registers, InitSNES, Vector)
- `src/PPU/` - PPU operations (LoadVRAM, LoadCGRAM, UpdateOAMRAM)
- `src/Game/` - Game-specific code (Init, Physics/Bouncing)
- `src/Main.s` - Entry point and game loop
- `assets/` - Sprite and palette data

### `lorom-template/`
Complete template project structure for SNES development using LoROM mapping. Includes:
- Audio support (SPC700, Pently music engine)
- Sprite and background graphics
- Asset conversion tools
- Comprehensive build system

## Building

Each example has its own build file (`Makefile` or `makefile`). To build an example:

```bash
cd examples/snes/<example_name>
make          # Build the ROM
make run      # Build and run in bsnes (default)
make run EMU=higan  # Run with different emulator
make clean    # Clean build artifacts
```

### Modular Examples (`move_sprite`, `bounce_sprite`)

These examples use a modular structure:
- Code is organized into logical modules (`common/`, `PPU/`, `Game/`)
- Each module has `.s` (implementation) and `.inc` (interface) files
- Assets are separated into `assets/` directory
- Build files automatically compile all modules with proper include paths

## Requirements

- **cc65** toolchain (ca65, ld65) - Required for assembly
- **bsnes** or **higan** emulator - For running ROMs
- **Python 3** (for `lorom-template` asset conversion tools)

## Code Organization

### Modular Structure Pattern

The modular examples (`move_sprite`, `bounce_sprite`) follow this structure:

```
<example>/
├── src/
│   ├── common/          # Shared utilities
│   │   ├── Registers.inc
│   │   ├── InitSNES.s/.inc
│   │   ├── Joypad.s/.inc (move_sprite only)
│   │   ├── Vector.s
│   │   └── ...
│   ├── PPU/             # PPU operations
│   │   ├── PPU.s/.inc
│   ├── Game/            # Game-specific code
│   │   ├── Init.s/.inc
│   │   ├── Input.s/.inc (move_sprite)
│   │   └── Physics.s/.inc (bounce_sprite)
│   └── Main.s           # Entry point
├── assets/              # Asset files
│   ├── Assets.s/.inc
│   ├── Sprites.vra
│   └── SpriteColors.pal
├── makefile
└── MemoryMap.cfg
```

This modular approach:
- Separates concerns (PPU, Game logic, Common utilities)
- Makes code reusable and maintainable
- Follows SNES development best practices

All examples use `.s` file extension and follow SNES-native conventions.
