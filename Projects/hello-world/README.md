# Hello World NES Program

A complete NES program that displays text using a full alphabet/lexicon (A-Z, 0-9, punctuation). The code follows NES documentation best practices and includes a text rendering system.

## Features

- **Complete Alphabet/Lexicon**: All uppercase letters (A-Z), numbers (0-9), and common punctuation
- **Text Rendering System**: Write any text string to the name table
- **Character Lookup**: Efficient ASCII to tile index conversion
- **NES Best Practices**: Follows official documentation patterns
- **Clean Code Structure**: Well-organized with clear sections and comments

## Architecture

- **PRG ROM**: 16 KB (Mapper 0, NROM)
- **CHR ROM**: 8 KB (512 tiles)
- **Text System**: Null-terminated strings with automatic character conversion

## Requirements

- **ca65** - 6502 assembler (part of cc65)
- **ld65** - Linker (part of cc65)
- **FCEUX** - NES emulator (or compatible)

### Installation

**Debian/Ubuntu:**
```bash
sudo apt-get install cc65 fceux
```

**Arch Linux:**
```bash
sudo pacman -S cc65 fceux
```

## Building

```bash
make
```

This creates `hello-world.nes` (24592 bytes).

## Running

```bash
make run
```

Or manually:
```bash
fceux hello-world.nes
```

## Character Mapping

The program includes the following characters:

- **Space**: Tile 0
- **Numbers 0-9**: Tiles 1-10
- **Letters A-Z**: Tiles 11-36
- **Punctuation**: Tiles 37-44 (., ! ? : ; - ')

## Text Rendering

The program includes a `write_text` function that writes null-terminated strings to the name table. Example:

```asm
LDA #<my_text    ; Low byte of text address
STA text_ptr
LDA #>my_text    ; High byte of text address
STA text_ptr+1
JSR write_text   ; Write text string
```

The function automatically:
- Converts ASCII characters to tile indices
- Handles null-terminated strings
- Limits text to 32 characters per line (name table width)

## Code Structure

The code is organized into clear sections:

1. **Zero Page Variables**: Frequently accessed data in zero page for efficiency
2. **Reset Handler**: System initialization following NES documentation
3. **NMI Handler**: Frame-synchronized rendering updates
4. **Text Rendering**: Functions for writing text to name table
5. **Character Conversion**: ASCII to tile index lookup
6. **Data Section**: Palettes and text strings

## Files

- `main.asm` - Main assembly source (refactored with best practices)
- `nes.cfg` - Linker configuration (16 KB PRG ROM)
- `Makefile` - Build system with targets
- `chars_data.asm` - CHR ROM with complete alphabet tiles (contains all character data)
- `README.md` - This file

## What It Displays

The program displays:
- "HELLO WORLD!" at row 5, column 5
- Complete alphabet (A-Z) at row 7
- Numbers (0-9) at row 8
- Punctuation (.,!?:;-') at row 9

## Customization

To change the displayed text, modify the text strings in the data section:

```asm
hello_text:
    .byte "YOUR TEXT HERE", 0
```

The text rendering system automatically converts ASCII characters to tile indices.

## Build Targets

- `make` or `make all` - Build ROM (default)
- `make clean` - Remove build artifacts (object files and ROM)
- `make distclean` - Deep clean
- `make verify` - Verify ROM structure (size and header)
- `make run` - Run ROM in FCEUX
- `make help` - Show help information

## Technical Details

### Name Table Layout

- Name table: $2000-$23BF (960 bytes, 32×30 tiles)
- Attribute table: $23C0-$23FF (64 bytes)
- All tiles use palette 0 (attribute bytes set to 0)

### Character Conversion

The `char_to_tile` function converts ASCII to tile indices:
- Numbers ('0'-'9'): Direct mapping to tiles 1-10
- Uppercase letters ('A'-'Z'): Direct mapping to tiles 11-36
- Lowercase letters ('a'-'z'): Converted to uppercase first
- Punctuation: Direct mapping to tiles 37-44
- Unknown characters: Default to tile 0 (space)

### PPU Initialization

The program follows NES documentation initialization sequence:
1. Disable interrupts and PPU rendering
2. Wait for 2 VBlanks (PPU stabilization)
3. Clear RAM
4. Load palette and background
5. Enable rendering during VBlank

## Notes

- Uses tile indices to display text
- Text is positioned using name table addresses
- All character tiles are included in CHR ROM
- Code follows NES documentation best practices
- Zero page variables used for efficiency
- Proper NMI handler with register saving
- Hardware-accurate implementation

## Troubleshooting

### Build Issues

- **"ca65: command not found"**: Install cc65 package
- **"ld65: command not found"**: Install cc65 package
- **Linker errors**: Check `nes.cfg` matches segment definitions

### Runtime Issues

- **Blank screen**: Check PPU initialization in `reset:`
- **Text not displaying**: Verify CHR ROM contains character tiles
- **Wrong characters**: Check character-to-tile mapping in `char_to_tile`

## References

This code follows patterns from:
- NES Programming Knowledge Base documentation
- Official NES hardware documentation
- Best practices for 6502 assembly on NES

## License

This project is part of the NES Programming Knowledge Base and is licensed under the MIT License.

---

**Note**: This program follows hardware-accurate NES programming practices. All code is designed to work on real NES hardware, not just emulators.
