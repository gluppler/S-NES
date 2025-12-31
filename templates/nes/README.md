# NES Project Template

A complete, working NES game template using the cc65 toolchain.

## Features

- ✅ Complete build system with Makefile
- ✅ Modular source code structure
- ✅ Working ROM (40976 bytes)
- ✅ Full PPU initialization
- ✅ Text display system
- ✅ Input handling
- ✅ Audio support (APU)
- ✅ Proper NMI/IRQ handlers

## Quick Start

```bash
make clean
make all
```

The ROM will be generated at `build/rom/game.nes`.

## Project Structure

```
templates/nes/
├── src/              # Source code
│   ├── reset.asm     # Reset handler & init
│   ├── nmi.asm       # NMI handler
│   ├── irq.asm       # IRQ handler
│   ├── main.asm      # Main game loop
│   ├── audio/        # Audio system
│   ├── game/         # Game logic
│   ├── input/        # Controller reading
│   ├── palette/      # Palette handling
│   ├── ppu/          # PPU utilities
│   ├── screens/      # Screen management
│   ├── sprites/      # Sprite handling
│   ├── state/        # State machine
│   ├── text/         # Text rendering
│   └── tilemap/      # Tilemap system
├── assets/           # Graphics/audio data
│   └── data/
│       └── neschar.asm  # Character graphics
├── linker/           # Linker configurations
│   └── nrom.cfg      # NROM mapper config
├── build/            # Build output
│   ├── obj/          # Object files
│   ├── rom/          # Final ROM
│   └── map/          # Linker map files
└── Makefile          # Build system
```

## Building

### Prerequisites

- `cc65` toolchain (ca65, ld65)
- `make`

### Commands

- `make` or `make all` - Build the ROM
- `make clean` - Remove build artifacts
- `make run` - Build and run in emulator (if installed)

## ROM Specifications

- **Mapper**: NROM (Mapper 0)
- **PRG ROM**: 32KB (2 banks)
- **CHR ROM**: 8KB (1 bank)
- **Mirroring**: Horizontal
- **Format**: iNES 1.0

## Display Output

The template displays:
```
  NES TEMPLATE
  READY TO CODE
```

## Customization

### Changing Text

Edit `src/text/strings.asm` to modify displayed text.

### Adding Graphics

Replace `assets/data/neschar.asm` with your own CHR data.

### Modifying Game Logic

The main game loop is in `src/main.asm`. Add your game code there.

## Technical Details

### Memory Map

- `$0000-$00FF`: Zero Page
- `$0100-$01FF`: Stack
- `$0200-$02FF`: OAM (sprite data)
- `$0300-$07FF`: RAM
- `$8000-$FFFF`: PRG ROM

### Interrupt Vectors

- `$FFFA`: NMI vector
- `$FFFC`: Reset vector  
- `$FFFE`: IRQ vector

## Resources

- [NESdev Wiki](https://www.nesdev.org/)
- [cc65 Documentation](https://cc65.github.io/doc/)
- [NES Programming Guide](../../docs/nes/)

## License

See repository LICENSE file.
