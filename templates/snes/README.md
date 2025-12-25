# SNES Development Template

Complete, production-ready SNES development template for the S-NES-BOY framework.

## SNES-Specific Architecture

This template is designed specifically for SNES hardware:
- **65816 CPU** (native mode, register width control)
- **S-PPU** (8 background modes, Mode 7, windowing)
- **SPC700 + S-DSP** (separate audio processor)
- **DMA/HDMA** (8 channels, per-scanline effects)
- **LoROM mapping** (32 KB banks)

## Directory Structure

```
templates/snes/
├── src/                    # SNES source code
│   ├── init/               # Initialization code
│   │   ├── cpu_init.s    # 65816 CPU initialization
│   │   ├── ppu_init.s    # S-PPU initialization
│   │   └── spc700_boot.s  # SPC700 audio boot
│   ├── core/               # Core systems
│   │   ├── main.s        # Main game loop
│   │   ├── nmi.s         # VBlank interrupt handler
│   │   └── irq.s         # IRQ handler
│   ├── dma/                # DMA utilities
│   │   ├── oam_dma.s     # OAM DMA updates
│   │   ├── vram_dma.s    # VRAM DMA transfers
│   │   └── cgram_dma.s   # CGRAM DMA transfers
│   ├── ppu/                # PPU systems
│   │   ├── backgrounds.s # Background layer management
│   │   ├── sprites.s    # Sprite system
│   │   ├── mode7.s      # Mode 7 utilities
│   │   └── windowing.s  # Window system
│   ├── audio/              # Audio (SPC700)
│   │   ├── spc700_boot.s # SPC700 boot protocol
│   │   ├── dsp_control.s # S-DSP register control
│   │   └── brr_upload.s  # BRR sample upload
│   ├── input/              # Input handling
│   │   ├── auto_joypad.s # Auto-joypad reading
│   │   └── button_state.s # Button state tracking
│   └── headers/            # Header files
│       ├── snes_registers.inc # SNES register definitions
│       ├── snes_constants.inc  # SNES constants
│       └── memory_map.inc      # Memory map definitions
├── linker/                 # Linker configurations
│   ├── lorom.cfg           # LoROM mapping
│   ├── hirom.cfg           # HiROM mapping
│   └── exhirom.cfg         # ExHiROM mapping
├── assets/                 # Game assets
│   ├── graphics/           # Graphics data
│   │   ├── tiles/          # Tile graphics
│   │   ├── palettes/       # Color palettes
│   │   └── sprites/        # Sprite graphics
│   └── audio/              # Audio data
│       ├── samples/        # BRR audio samples
│       └── music/          # Music sequences
├── tools/                  # Build tools
│   └── asset_converters/   # Asset conversion scripts
└── Makefile                # Build system
```

## Key Features

### SNES-Native Initialization
- Native 65816 mode entry (`clc; xce`)
- Register width configuration (8-bit A, 16-bit X/Y)
- Stack and direct page initialization
- Complete PPU register initialization
- SPC700 boot protocol

### DMA-Based Systems
- OAM updates via DMA channel 0
- VRAM transfers via DMA
- CGRAM transfers via DMA
- HDMA for per-scanline effects

### SNES-Specific Features
- Background modes 0-7 support
- Mode 7 affine transformation
- Windowing system
- Color math (add/sub blending)
- Auto-joypad reading
- SPC700 audio integration

## Building

```bash
cd templates/snes
make
make run
```

## Requirements

- **ca65** (cc65 toolchain) - 65816 assembler
- **ld65** (cc65 toolchain) - Linker
- **bsnes** or **higan** - SNES emulator

## Hardware Assumptions

- LoROM mapping mode
- Native 65816 mode
- NTSC timing (60.098 Hz)
- Standard SNES controller
- Mode 0 background (configurable)

## Extending the Template

1. **Add subsystems**: Create modules in `src/`
2. **Add assets**: Place graphics/audio in `assets/`
3. **Configure mapping**: Modify `linker/` for different ROM mapping
4. **Add tools**: Place asset converters in `tools/`

## Related Documentation

- [SNES Documentation](../../docs/snes/README.md) - Complete SNES docs
- [Getting Started](../../docs/snes/getting-started/) - Learning guides
- [Hardware Documentation](../../docs/snes/hardware/) - Hardware details
- [Programming Guides](../../docs/snes/programming/) - Development guides
- [Examples](../../examples/snes/) - Code examples

---

**This template is SNES-specific and does not match NES structure.**
