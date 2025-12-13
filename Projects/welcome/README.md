# Welcome Typography NES Program

A typography demonstration program for the NES that displays "Hello World!" centered on screen with multiple typography designs that cycle automatically.

## Overview

This program demonstrates typography techniques on the NES by displaying "Hello World!" centered both horizontally and vertically on the screen. The program automatically cycles through four different typography styles, each using different color palettes to create distinct visual designs.

## Features

- **Centered Text**: "Hello World!" is perfectly centered on the NES screen
- **Typography Cycling**: Automatically cycles through 4 different typography styles
- **Color Variations**: Each style uses a different color palette:
  - Style 0: White text
  - Style 1: Yellow text
  - Style 2: Red/Blue/Green text
  - Style 3: Purple text
- **Hardware Accurate**: Follows strict NES documentation principles

## Architecture

- **16 KB PRG ROM** (Mapper 0, NROM)
- **8 KB CHR ROM** (512 tiles)
- **Name Table Rendering** with centered text positioning
- **Attribute Table Manipulation** for typography style changes

## Requirements

- `ca65` (assembler, part of cc65)
- `ld65` (linker, part of cc65)
- `FCEUX` or compatible NES emulator

## Build Instructions

### Build ROM

```bash
make
```

### Run in Emulator

```bash
make run
```

### Clean Build Files

```bash
make clean
```

### Verify ROM Structure

```bash
make verify
```

## Technical Details

### Centering Calculation

The NES name table is 32 tiles wide and 30 tiles tall. To center "Hello World!" (12 characters):

- **Horizontal Center**: (32 - 12) / 2 = 10 columns from left
- **Vertical Center**: Row 15 (center of 30 rows)
- **Name Table Address**: $2000 + (15 × 32) + 10 = $21EA

### Typography Styles

The program uses the attribute table to change typography styles. Each style uses a different background palette:

- **Palette 0**: White text on black background
- **Palette 1**: Yellow text on black background
- **Palette 2**: Red/Blue/Green text on black background
- **Palette 3**: Purple text on black background

### Style Cycling

Typography styles change every 120 frames (approximately 2 seconds at 60 FPS). The program cycles through all 4 styles continuously.

### Attribute Table Layout

The text spans 12 characters (columns 10-21), which covers 2 attribute groups horizontally. The attribute table is updated at:
- $23CA-$23CB (first row of text area)
- $23D2-$23D3 (second row of text area)

## Files

- `main.asm` - Main assembly source with typography system
- `nes.cfg` - Linker configuration (16 KB PRG ROM)
- `Makefile` - Build system with targets
- `chars_data.asm` - CHR ROM with character tiles
- `README.md` - This file

## Code Structure

1. **Zero Page Variables**: Typography index, frame counter, timers
2. **Reset Handler**: System initialization following NES documentation
3. **NMI Handler**: Frame-synchronized updates
4. **Text Rendering**: Centered text positioning and writing
5. **Typography System**: Attribute table updates for style changes
6. **Character Conversion**: ASCII to tile index lookup
7. **Data Section**: Palettes, typography attributes, text strings

## Customization

### Change Text

Modify the text string in the data section:

```asm
hello_text:
    .byte "YOUR TEXT HERE", 0
```

**Note**: Centering calculation assumes 12 characters. Adjust the centering address if text length changes.

### Change Typography Styles

Modify the palette data and attribute bytes:

```asm
palette_data:
    .byte $0F, $30, $10, $00  ; Your palette colors
    ; ...

typography_attributes:
    .byte %00000000, %00000000  ; Your attribute bytes
    ; ...
```

### Change Cycling Speed

Modify the timer comparison in the main loop:

```asm
CMP #120            ; Change 120 to desired frame count
```

## Build Targets

- `make` or `make all` - Build ROM (default)
- `make clean` - Remove build artifacts (object files and ROM)
- `make distclean` - Deep clean
- `make verify` - Verify ROM structure (size and header)
- `make run` - Run ROM in FCEUX
- `make help` - Show help information

## Related Documentation

- [NES Programming Knowledge Base](../../docs/README.md) - Comprehensive NES development guide
- [PPU Fundamentals](../../docs/01-fundamentals/1.4-ppu-fundamentals.md) - Name table and attribute table details
- [Rendering Architecture](../../docs/03-core-concepts/3.3-rendering-architecture.md) - PPU update patterns
