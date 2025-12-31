# NES Examples

Working example projects demonstrating NES development with the S-NES-BOY framework. Each example is a complete, buildable NES ROM that demonstrates specific hardware features, programming techniques, or development patterns.

## Examples

### hello_world

Simple NES text rendering example demonstrating:
- Hardware initialization
- PPU setup and usage
- Basic text rendering
- Minimal project structure

**Location**: [`examples/nes/hello_world/`](hello_world/)

**Build**:
```bash
cd examples/nes/hello_world
make
```

**Files**: All source files use `.asm` extension (6502 assembly standard)

### vdelay_example

Variable delay routine example demonstrating:
- Cycle-accurate variable delays (29-65535 cycles)
- Interactive parameter selection via controller
- Debug breakpoint usage
- Timing-critical code patterns
- PPU initialization with proper latch handling

**Location**: [`examples/nes/vdelay_example/`](vdelay_example/)

**Build**:
```bash
cd examples/nes/vdelay_example
make
```

**Source**: Based on [6502vdelay](https://github.com/bbbradsmith/6502vdelay)

**Files**: `src/vdelay.asm`, `src/main.asm` (all `.asm` files)

### prng_6502_example

Complete PRNG example demonstrating all three PRNG widths:
- 16-bit LFSR PRNG (galois16)
- 24-bit LFSR PRNG (galois24)
- 32-bit LFSR PRNG (galois32)
- Simple and overlapped implementations for each width
- Visual random number display for all three PRNGs
- Separate seed storage to avoid interference

**Location**: [`examples/nes/prng_6502_example/`](prng_6502_example/)

**Build**:
```bash
cd examples/nes/prng_6502_example
make
```

**Source**: Based on [prng_6502](https://github.com/bbbradsmith/prng_6502)

**Files**: `src/common.asm`, `src/galois16.asm`, `src/galois24.asm`, `src/galois32.asm`, `src/main.asm` (all `.asm` files)

### hex_string_example

Hex string macro example demonstrating:
- Multibyte constant definition using hex strings
- Readable hex string formatting with underscores
- Hex macro usage for lookup tables and constants
- Alternative to verbose `.byte` directives

**Location**: [`examples/nes/hex_string_example/`](hex_string_example/)

**Build**:
```bash
cd examples/nes/hex_string_example
make
```

**Files**: `src/main.asm`, `src/macros/hex_string.inc` (all `.asm` files)

### nrom_example

Complete NROM template example demonstrating:
- System initialization
- DMC-safe controller reading
- Sprite system with animation
- Background management
- Game loop structure
- Build tools for graphics conversion (Python scripts)

**Location**: [`examples/nes/nrom_example/`](nrom_example/)

**Build**:
```bash
cd examples/nes/nrom_example
make
```

**Source**: Based on [nrom-template](https://github.com/pinobatch/nrom-template)

**Files**: All source files in `src/` use `.asm` extension

### snrom_example

Complete SNROM/MMC1 template example demonstrating:
- MMC1 mapper initialization
- PRG/CHR bank switching
- Inter-bank function calls
- All nrom-template features plus mapper support

**Location**: [`examples/nes/snrom_example/`](snrom_example/)

**Build**:
```bash
cd examples/nes/snrom_example
make
```

**Source**: Based on [snrom-template](https://github.com/pinobatch/snrom-template)

**Files**: All source files in `src/` use `.asm` extension

### nes-basic-controls

Basic controller input example demonstrating:
- Controller reading routines
- Input handling patterns
- Button state management

**Location**: [`examples/nes/nes-basic-controls/`](nes-basic-controls/)

### nes-basic-graphics

Basic graphics rendering example demonstrating:
- PPU initialization
- Pattern table usage
- Nametable management

**Location**: [`examples/nes/nes-basic-graphics/`](nes-basic-graphics/)

### nes-basic-sound

Basic audio example demonstrating:
- APU initialization
- Sound channel usage
- Audio programming patterns

**Location**: [`examples/nes/nes-basic-sound/`](nes-basic-sound/)

### nes-birthday-blast

Complete game example demonstrating:
- Full game structure
- Multiple systems integration
- Game development patterns

**Location**: [`examples/nes/nes-birthday-blast/`](nes-birthday-blast/)

### fds

Famicom Disk System examples demonstrating:
- FDS hardware features
- Disk system programming
- FDS-specific patterns

**Location**: [`examples/nes/fds/`](fds/)

Includes multiple FDS test and example programs.

## Usage

Each example includes:
- Complete source code (all `.asm` files for 6502 assembly)
- Working Makefile or makefile
- Build instructions
- README with details
- Proper PPU initialization and hardware setup

## Building Examples

All examples use the cc65 toolchain (`ca65`, `ld65`):

```bash
cd examples/nes/<example_name>
make clean
make
make run  # If emulator is configured
```

## File Structure

All NES examples use:
- `.asm` file extension for 6502 assembly source files
- Standard NES development patterns
- Proper hardware initialization sequences
- Working build systems

## Example Count

This directory contains **12 example directories**:
- 6 core examples (hello_world, vdelay_example, prng_6502_example, hex_string_example, nrom_example, snrom_example)
- 3 basic tutorials (nes-basic-controls, nes-basic-graphics, nes-basic-sound)
- 1 complete game (nes-birthday-blast)
- 1 FDS examples directory (fds/) containing multiple FDS programs

All examples build with the cc65 toolchain (`ca65`, `ld65`) and demonstrate proper NES hardware initialization and usage patterns.

## Related Documentation

- [Template Documentation](../../templates/nes/README.md) - Production-ready NES template
- [NES Documentation](../../docs/nes/README.md) - Complete NES learning path
- [NES Fundamentals](../../docs/nes/fundamentals/) - Core hardware concepts
- [NES Advanced Fundamentals](../../docs/nes/advanced_fundamentals/) - Timing and optimization
- [NES Test ROMs](../../tests/nes/README.md) - Test ROM collection for hardware verification
