# NES Template

A minimal, working NES program template ready for immediate use. This template provides a complete foundation for NES development with proper initialization, NMI handling, and frame synchronization.

## Overview

This template includes:

- **Complete NES initialization**: Proper reset sequence, RAM clearing, PPU setup
- **NMI handler**: Frame-synchronized interrupt handler for rendering updates
- **Main loop**: Frame-based game loop with proper synchronization
- **OAM buffer**: Sprite attribute memory buffer setup
- **Palette loading**: Default palette configuration
- **Empty CHR ROM**: 8 KB empty pattern table ready for your graphics
- **Build system**: Makefile for easy compilation

## Files

- `main.asm` - Main assembly source file with complete NES program structure
- `nes.cfg` - Linker configuration file for ca65/ld65
- `Makefile` - Build system with compile, run, and clean targets
- `chars.chr` - Empty CHR ROM file (8 KB of zeros, ready to replace)

## Requirements

- **ca65** - 6502 assembler (part of cc65)
- **ld65** - Linker (part of cc65)
- **FCEUX** - NES emulator

### Installation

**Debian/Ubuntu:**
```bash
sudo apt-get install cc65
```

**Arch Linux:**
```bash
sudo pacman -S cc65
```

**From source:**
```bash
git clone https://github.com/cc65/cc65.git
cd cc65
make
sudo make install
```

## Quick Start

1. **Build the ROM:**
   ```bash
   make
   ```
   This creates `template.nes`

2. **Run in emulator:**
   ```bash
   make run
   ```
   Or manually:
   ```bash
   fceux template.nes
   ```

3. **Clean build files:**
   ```bash
   make clean
   ```

## Template Structure

### Initialization (`reset:`)

- Disables interrupts and decimal mode
- Initializes stack pointer
- Disables PPU rendering
- Waits for PPU stabilization (two VBlank periods)
- Clears all RAM ($0000-$07FF)
- Initializes PPU registers
- Sets up game state variables
- Loads default palette
- Clears OAM buffer

### NMI Handler (`nmi:`)

- Saves CPU registers
- Reads PPU status (clears VBlank flag)
- Performs OAM DMA transfer
- Updates scroll registers
- Updates PPU control register
- Increments frame counter
- Sets frame ready flag
- Restores CPU registers

### Main Loop (`main_loop:`)

- Waits for frame ready flag (set by NMI)
- Clears frame flag
- Reads controller input
- Updates game logic
- Updates rendering data
- Loops back

## Zero Page Variables

The template defines common zero page variables:

- `zp_temp` ($00) - Temporary variable
- `zp_ptr` ($02-$03) - 16-bit pointer (low, high)
- `frame_counter` ($04) - Frame counter
- `frame_ready` ($05) - Frame synchronization flag
- `scroll_x` ($06) - Horizontal scroll position
- `scroll_y` ($07) - Vertical scroll position
- `ppu_ctrl` ($08) - PPU control register value

## RAM Usage

- `oam_buffer` ($0200-$02FF) - Object Attribute Memory buffer (256 bytes, 64 sprites)

## Customization

### Adding Your Game Logic

Edit `main.asm` and modify these functions:

- `update_game:` - Add your game logic here
- `update_rendering:` - Prepare rendering data (OAM buffer, etc.)
- `read_controllers:` - Process controller input

### Adding Graphics

Replace `chars.chr` with your own 8 KB CHR ROM file containing tile graphics.

### Modifying Palette

Edit the `palette_data:` section in `main.asm` to change colors.

### Adding Background

Uncomment the `load_background:` call in `reset:` and implement your background loading logic.

## Build Configuration

The `nes.cfg` file defines:

- **PRG ROM**: 32 KB ($8000-$FFFF)
- **CHR ROM**: 8 KB ($0000-$1FFF)
- **Mapper**: 0 (NROM)
- **Mirroring**: Horizontal

To change these, modify:
1. The iNES header in `main.asm` (`.segment "HEADER"`)
2. The memory configuration in `nes.cfg`

## Code Structure

```asm
.segment "HEADER"    ; iNES header
.segment "VECTORS"   ; Interrupt vectors
.segment "CODE"      ; Program code
.segment "CHARS"     ; CHR ROM data
```

## Example Usage

After building, the template produces a working NES ROM that:

- Initializes properly on real hardware
- Runs at 60 Hz (NTSC) frame rate
- Handles NMI interrupts correctly
- Provides frame synchronization
- Has empty screen (ready for your graphics)

## Troubleshooting

### Build Errors

- **"ca65: command not found"**: Install cc65 package
- **"ld65: command not found"**: Install cc65 package
- **Linker errors**: Check `nes.cfg` matches your segment definitions

### Runtime Issues

- **Black screen**: Check PPU initialization in `reset:`
- **No sprites**: Verify OAM buffer is being written correctly
- **Flickering**: Ensure NMI handler completes quickly (< 2000 cycles)

## Next Steps

1. Add your tile graphics to `chars.chr`
2. Implement game logic in `update_game:`
3. Add sprites to OAM buffer in `update_rendering:`
4. Customize palette colors
5. Add background tiles

## Resources

- [NES Documentation](../docs/README.md) - Complete NES programming guide
- [References](../REFERENCES.md) - External resources and links
- [NesDev Wiki](https://www.nesdev.org/) - Official NES development wiki

## License

This template is part of the NES Programming Knowledge Base project and is licensed under the MIT License.

---

**Note**: This template follows hardware-accurate NES programming practices. All code is designed to work on real NES hardware, not just emulators.
