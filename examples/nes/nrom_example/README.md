# NROM Template Example

Complete working example of the nrom-template NES development template.

## Overview

This is a complete, working NES game template demonstrating:

- System initialization code
- Static background setup
- Game loop structure
- Controller reading (DMC-safe, synchronized with OAM DMA)
- 8.8 fixed-point arithmetic
- Acceleration-based character movement physics
- Sprite drawing and animation with horizontal flipping
- Makefile-controlled conversion of sprite sheet images to NES format

## Source

Based on [nrom-template](https://github.com/pinobatch/nrom-template) by Damian Yerrick.

## Building

```bash
cd examples/nes/nrom_example
make
make run
```

## Features

- **NROM mapper**: Simplest mapper (Mapper 0), perfect for beginners
- **DMC-safe input**: Controller reading synchronized with OAM DMA
- **Sprite system**: Complete sprite management with animation
- **Background system**: Nametable and attribute management
- **Build tools**: Python scripts for graphics conversion

## Requirements

- `ca65` and `ld65` (cc65 toolchain)
- Python 3 with Pillow library
- NES emulator (fceux, Mesen2, etc.)

## Related Documentation

- [NROM Template Documentation](https://github.com/pinobatch/nrom-template) - Original template repository
- [NES Fundamentals](../../../docs/nes/fundamentals/) - Core NES hardware concepts
- [NES Documentation](../../../docs/nes/README.md) - Complete NES learning path
