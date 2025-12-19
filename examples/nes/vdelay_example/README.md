# vdelay Example

Working example demonstrating the 6502vdelay variable delay routine.

## Overview

This example demonstrates how to use the `vdelay` routine for cycle-accurate variable delays in NES development. The example creates an interactive NES ROM where you can:

- Use the D-pad to select and adjust a 4-digit hexadecimal delay parameter
- Press A to execute the delay routine
- Use a debugger to verify the cycle count

## Source

Based on [6502vdelay](https://github.com/bbbradsmith/6502vdelay) by:
- Brad Smith
- Fiskbit
- Eric Anderson
- Joel Yliluoma
- George Foot
- Sidney Cadot

## Building

```bash
cd examples/nes/vdelay_example
make
make run
```

## Usage

1. **Build the ROM**: `make`
2. **Run in emulator**: `make run`
3. **Use D-pad** to select digit (left/right) and adjust value (up/down)
4. **Press A** to execute the delay
5. **Set breakpoints** on `$FE` (`DEBUG_START`) and `$FF` (`DEBUG_END`) in your debugger to measure cycles

## Features

- **Interactive parameter selection**: Adjust delay value with controller
- **Debug breakpoints**: Built-in markers for cycle counting
- **Cycle-accurate delays**: Demonstrates 29-65535 cycle delays

## Requirements

- `ca65` and `ld65` (cc65 toolchain)
- NES emulator (fceux, Mesen2, etc.)

## Related Documentation

- [Variable Delay Documentation](../../../docs/nes/advanced_fundamentals/2.1-cpu-timing-cycles.md)
- [6502vdelay Repository](https://github.com/bbbradsmith/6502vdelay)
