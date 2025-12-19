# PRNG Example

Working example demonstrating the prng_6502 random number generator.

## Overview

This example demonstrates how to use the `galois16` LFSR-based random number generator for NES development. The example creates a simple NES ROM that:

- Generates random numbers using the 16-bit Galois LFSR
- Displays the random values on screen in hexadecimal
- Updates every frame

## Source

Based on [prng_6502](https://github.com/bbbradsmith/prng_6502) by Brad Smith (rainwarrior).

## Building

```bash
cd examples/nes/prng_example
make
make run
```

## Features

- **16-bit LFSR PRNG**: Demonstrates galois16 implementation
- **Simple version**: 133-141 cycles, 19 bytes
- **Overlapped version**: 69 cycles fixed, 35 bytes (galois16o)
- **Visual display**: Shows random values on screen

## Usage

1. **Build the ROM**: `make`
2. **Run in emulator**: `make run`
3. **Observe**: Random hexadecimal values displayed on screen, updating each frame

## Requirements

- `ca65` and `ld65` (cc65 toolchain)
- NES emulator (fceux, Mesen2, etc.)

## Related Documentation

- [NES References](../../../docs/nes/REFERENCES.md) - Authoritative NES development resources
- [prng_6502 Repository](https://github.com/bbbradsmith/prng_6502) - Original PRNG implementation
