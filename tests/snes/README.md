# SNES Test Suite

SNES hardware validation tests and test demos for verifying SNES development code accuracy.

## Directory Structure

```
tests/snes/
├── colourmath/     # Color math demonstration
├── ctrltest/       # Controller test
├── multest/        # Multiply/divide test
├── extbgtest/      # Mode 7 EXTBG test
├── iplfast/        # SPC700 fast boot
├── noise31/        # SPC700 noise example
├── palcycle/       # Palette cycling demo
├── dizworld/       # Mode 7 graphics demo
├── elasticity/     # High-color graphics
├── twoship/        # Mode 5 high-res demo
├── smalltext/      # Large text display
└── mset/           # Mouse test
```

## Purpose

This directory contains SNES test demos to ensure:
- Hardware accuracy of SNES code
- Correct initialization sequences
- Proper register usage
- Timing accuracy
- DMA/HDMA correctness
- SPC700 communication correctness

## Test Categories

### CPU Tests
- Native vs emulation mode switching
- Register width control
- Direct page addressing
- Stack operations
- Interrupt handling
- MUL/DIV hardware

### PPU Tests
- Background mode correctness
- Mode 7 math accuracy
- Sprite rendering limits
- Windowing system
- Color math operations

### DMA/HDMA Tests
- DMA channel configuration
- HDMA table formats
- Cycle stealing behavior
- Timing accuracy

### Audio Tests
- SPC700 boot protocol
- CPU-APU communication
- BRR sample playback
- DSP register access

### Memory Tests
- WRAM organization
- ROM mapping (LoROM/HiROM)
- SRAM access
- MMIO register behavior

## Test Demos

### colourmath
SNES color math demonstration showing various blending modes (add, subtract, half blend).

**Features:**
- Color math modes (add, subtract, half blend)
- Main/sub screen composition
- Water effects
- Ghost fade effects
- Darkness effects

### ctrltest
SNES generic controller test demonstrating auto-joypad reading.

**Features:**
- Auto-joypad reading
- All 12 SNES buttons
- Controller state display
- Multiple test variants (ctrltest, ctrltest_auto, ctrltest_simple)

### multest
Test of hardware multiply/divide algorithms for 65816 CPU.

**Features:**
- Hardware MUL/DIV testing
- 16-bit multiply/divide operations
- Performance validation
- Builds two ROMs: `multest_mul16.sfc` and `multest_div16.sfc`

### extbgtest
Test of Mode 7 EXTBG (external background) feature.

**Features:**
- Mode 7 external background
- Priority and transparency
- Mode 7 rendering

### iplfast
SPC-700 IPL fast loader experiment (150% bandwidth improvement).

**Features:**
- Fast SPC700 boot protocol
- 3-byte-per-acknowledge loading
- Audio processor initialization
- Requires wla-dx for SPC700 code compilation

### noise31
Minimal SPC-700 sound example playing noise loudly.

**Features:**
- SPC700 audio initialization
- Noise generation
- DSP register control
- Requires wla-dx for SPC700 code compilation

### palcycle
Demonstration of 256-color palette cycling.

**Features:**
- CGRAM palette cycling
- 256-color display
- Color animation

### dizworld
Practical Mode 7 graphics demonstration with multiple viewing modes.

**Features:**
- Mode 7 rotation and scaling
- Perspective planes
- HDMA for perspective effects
- Multiple viewing modes (Boss, Tank, Tilt, Flyer)

### elasticity
Demonstration of high-color graphics.

**Features:**
- High-color modes
- Color depth demonstration

### twoship
Demonstration of high-resolution Mode 5 graphics.

**Features:**
- Mode 5 (512×448 resolution)
- High-resolution rendering

### smalltext
SNES 64×60 character display test.

**Features:**
- Large character display
- Text rendering

### mset
SNES Mouse test.

**Features:**
- Mouse input handling
- Pointer device support
- Requires runtime.lib (C code compilation)

## Building Tests

Tests use the same toolchain as examples:
- **ca65** (cc65 toolchain) - 65816 assembler
- **ld65** (cc65 toolchain) - Linker
- **wla-dx** - SPC700 assembler (for audio tests: iplfast, noise31)
- **cc65** - C compiler (for C code tests: ctrltest, mset)

### Building All Demos

From the `tests/snes/` directory:

```bash
make              # Build all demos with Makefiles
make <demo_name>  # Build specific demo
make clean        # Clean all demos
make help         # Show help
```

### Building Individual Demos

Each demo has its own Makefile. Build with:

```bash
cd tests/snes/<demo_name>
make              # Build ROM
make run          # Build and run in emulator
make clean        # Clean build artifacts
```

### All Demos Have Makefiles

All demos have been updated with Makefiles that auto-install dependencies:
- `cc65` toolchain (ca65, ld65, and cc65 compiler for C code)
- `wla-dx` toolchain (for SPC700 code: iplfast, noise31)
- `python3` (for checksum calculation)
- SNES emulator (bsnes or higan)

**Note:** C code demos (`ctrltest`, `mset`) require `runtime.lib` which must be built separately if missing. See their individual directories for instructions.

## Demo Categories

### Standard Assembly Demos
- `colourmath` - Color math demonstration
- `smalltext` - 64×60 character text display
- `dizworld` - Mode 7 graphics demo
- `elasticity` - High-color graphics
- `extbgtest` - Mode 7 EXTBG test
- `palcycle` - Palette cycling demo
- `twoship` - Mode 5 high-res demo
- `multest` - Multiply/divide hardware test (builds two ROMs)

### C Code Demos (require runtime.lib)
- `ctrltest` - Controller test (builds 3 ROMs: ctrltest, ctrltest_auto, ctrltest_simple)
- `mset` - Mouse test

### SPC700 Audio Demos (require wla-dx)
- `iplfast` - SPC700 fast boot (alternative IPL)
- `noise31` - SPC700 noise example

## Validation

Test ROMs should be validated against:
- Real SNES hardware
- Hardware-accurate emulators (bsnes, higan)
- Authoritative SNES documentation

## Credits

### Test Demos

**Author:** Brad Smith (rainwarrior)  
**Website:** https://rainwarrior.ca  
**Repository:** https://github.com/rainwarrior/snes-stuff  
**License:** See individual demo directories for license information

These demos are from [SNES Stuff](https://github.com/rainwarrior/snes-stuff), a collection of small SNES programs demonstrating specific hardware features and techniques.

### Toolchain

- **cc65** - 65816 assembler and C compiler
- **wla-dx** - SPC700 assembler (for audio demos)
- **python3** - For asset conversion and checksum calculation

## Related Documentation

- [SNES Documentation](../../docs/snes/README.md) - Complete SNES documentation
- [Hardware Documentation](../../docs/snes/hardware/) - Hardware details
- [Programming Guides](../../docs/snes/programming/) - Development guides
- [References](../../docs/snes/references/) - Quick reference guides

---

**This directory is for SNES-specific tests only. These demos demonstrate real-world SNES development techniques.**
