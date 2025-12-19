# NES Hello World Learning Example

A minimal NES "Hello, World!" program from the S-NES-BOY Learning & Development Framework, based on the canonical [nes-hello](https://github.com/pinobatch/nes-hello) implementation.

## Features

- Displays "Hello, World!" text
- Shows complete alphabet (A-Z)
- Shows numbers (0-9)
- Shows punctuation characters
- Uses hardware-accurate NES initialization patterns
- Minimal, canonical code structure

## Building

This example uses the same build process as nes-hello:

```bash
make
```

This will produce `hello.nes` using `cl65 -t nes`.

## Requirements

- [cc65](https://github.com/cc65/cc65) toolchain (ca65, ld65, cl65)
- NES emulator (e.g., FCEUX, Nestopia, Mesen)

## Running

```bash
make run EMU=fceux
```

Or manually:
```bash
fceux hello.nes
```

## Code Structure

- `main.asm` - Main program source
- `headers/ppu.inc` - PPU register definitions
- `headers/apu.inc` - APU register definitions
- `headers/neshdr.asm` - iNES header
- `assets/data/neschar.asm` - Character font data

## Based On

This example is based on the canonical [nes-hello](https://github.com/pinobatch/nes-hello) project, which provides a minimal, hardware-accurate NES program structure.

## Related Documentation

For detailed NES programming documentation, see:

- [NES Documentation Index](../../../docs/nes/README.md) - NES documentation index
- [NES Fundamentals](../../../docs/nes/fundamentals/) - Core NES hardware concepts
- [NES Advanced Fundamentals](../../../docs/nes/advanced_fundamentals/) - Timing and constraints
- [NES References](../../../docs/nes/REFERENCES.md) - External resources and authoritative links

## Related Resources

- [NES Template](../../../templates/nes/) - Complete NES template with full structure
- [Framework Overview](../../../README.md) - Main framework README
