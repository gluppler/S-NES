# SNROM Template Example

Complete working example of the snrom-template for MMC1 mapper development.

## Overview

This is a complete, working NES game template demonstrating:

- MMC1 mapper initialization and bank switching
- CHR RAM loading
- Calls from one PRG bank to another
- All features from nrom-template plus mapper support

## Source

Based on [snrom-template](https://github.com/pinobatch/snrom-template) by Damian Yerrick.

## Building

```bash
cd examples/nes/snrom_example
make
make run
```

## Features

- **MMC1 mapper**: Bank switching for larger games
- **CHR RAM support**: Loading tile data into CHR RAM
- **Inter-bank calls**: Function calls across PRG banks
- **All nrom-template features**: Plus mapper functionality

## Requirements

- `ca65` and `ld65` (cc65 toolchain)
- Python 3 with Pillow library
- NES emulator (fceux, Mesen2, etc.)

## Related Documentation

- [SNROM Template Documentation](https://github.com/pinobatch/snrom-template) - Original template repository
- [MMC1 Mapper Documentation](../../../docs/nes/fundamentals/1.5-rom-fundamentals.md) - Mapper fundamentals
- [NES Documentation](../../../docs/nes/README.md) - Complete NES learning path
