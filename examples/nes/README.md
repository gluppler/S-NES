# NES Examples

Working example projects demonstrating NES development with the S-NES-BOY framework.

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

### prng_example

Random number generator example demonstrating:
- 16-bit LFSR PRNG (galois16)
- Simple and overlapped implementations
- Visual random number display
- PRNG usage patterns
- Proper PPU initialization and CHR data handling

**Location**: [`examples/nes/prng_example/`](prng_example/)

**Build**:
```bash
cd examples/nes/prng_example
make
```

**Source**: Based on [prng_6502](https://github.com/bbbradsmith/prng_6502)

**Files**: `src/common.asm`, `src/galois16.asm`, `src/main.asm` (all `.asm` files)

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

## Related Documentation

- [Template Documentation](../../templates/nes/README.md) - Full template documentation
- [NES Documentation](../../docs/nes/README.md) - Complete NES learning path
- [NES Fundamentals](../../docs/nes/fundamentals/) - Core hardware concepts
- [NES Advanced Fundamentals](../../docs/nes/advanced_fundamentals/) - Timing and optimization
