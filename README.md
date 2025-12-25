# S-NES-BOY

S-NES-BOY is a **Learning & Development Framework** for three Nintendo systems: NES (Nintendo Entertainment System), SNES (Super Nintendo Entertainment System), and Game Boy (DMG/CGB).

## Overview

This framework provides a complete learning and development environment organized around three independent system trees. Each system has its own comprehensive documentation, production-ready templates, and working examples. System-specific content is strictly isolated to maintain clarity and focus.

### Supported Systems

- NES (Nintendo Entertainment System)
- SNES (Super Nintendo Entertainment System)
- Game Boy (DMG/CGB)

## Documentation

Comprehensive hardware-accurate documentation lives under `docs/`:

- `docs/nes/` - Complete NES learning path: fundamentals, advanced topics, core concepts, techniques, cheatsheets, tooling, and references
- `docs/snes/` - Complete SNES learning path: getting started, hardware documentation (CPU, PPU, DMA, audio, memory), programming guides (initialization, game loop, rendering, input), techniques (Mode 7, HDMA effects), and references
- `docs/gameboy/` - Complete Game Boy learning path: fundamentals, advanced topics, core concepts, cheatsheets, references, and gold-standard examples

Each system documentation tree is written in hardware terms, is self-contained, and provides a complete learning path from basics to advanced development. SNES documentation follows a three-processor architecture structure (65816 CPU, S-PPU, SPC700 audio).

## Hardware Schematics

Hardware schematic diagrams for console and cartridge circuits:

- `schematics/nes/` - NES console and cartridge schematic diagrams (KiCad and PDF)
- `schematics/snes/` - SNES console and cartridge schematic diagrams (PDF)
- `schematics/gb/` - Game Boy schematics (directory structure ready)

These schematics provide circuit-level documentation essential for understanding hardware behavior, developing accurate emulators, and creating hardware projects.

## Development Templates

Production-ready development templates live under `templates/`:

- `templates/nes/` - Complete NES development template that builds valid iNES ROMs with proper hardware initialization (matches hello_world pattern)
- `templates/snes/` - Complete SNES development template that boots correctly on real hardware with proper 65816 native mode setup, DMA utilities, and SPC700 boot code
- `templates/gb/` - Complete Game Boy development template that builds valid `.gb` ROMs with correct cartridge headers

Each template provides a complete, hardware-accurate starting point for development with a consistent structure: `build`, `src`, `assets`, `linker`, `headers`, `macros`, `tools`, `config`, and `rom` directories.

## Learning Examples

Working example projects live under `examples/`:

### NES Examples

- `examples/nes/hello_world` - NES text rendering example demonstrating hardware initialization and PPU usage (matches canonical nes-hello pattern)
- `examples/nes/vdelay_example` - Variable delay routine demonstrating cycle-accurate timing (29-65535 cycles)
- `examples/nes/prng_6502_example` - Complete PRNG example demonstrating all three PRNG widths (16, 24, and 32-bit) with separate seed storage
- `examples/nes/hex_string_example` - Hex string macro example demonstrating multibyte constant definition
- `examples/nes/nrom_example` - Complete NROM template with sprite system, DMC-safe controller reading, and game loop
- `examples/nes/snrom_example` - Complete SNROM/MMC1 template with bank switching and inter-bank function calls

### SNES Examples

- `examples/snes/hello_world` - Minimal SNES program demonstrating text rendering, native mode entry, and PPU setup
- `examples/snes/move_sprite` - Modular sprite movement example with controller input, DMA OAM updates, and auto-joypad reading
- `examples/snes/bounce_sprite` - Modular bouncing sprite example with automatic physics and boundary collision detection
- `examples/snes/lorom-template` - Complete LoROM template with audio support (SPC700, Pently music engine), sprite/background graphics, and asset conversion tools

### Game Boy Examples

- `examples/gameboy/hello_world` - Game Boy text rendering example demonstrating LCD initialization and tile rendering

These examples serve as learning resources, demonstrating correct hardware initialization, text rendering, timing patterns, sprite systems, input handling, and basic program structure for each system.

## Test ROMs

Comprehensive test ROM collections for verifying hardware behavior, emulator accuracy, and code correctness live under `tests/`:

- `tests/nes/` - NES test ROMs: CPU tests, PPU tests, APU tests, mapper tests, timing tests, and specialized tests (64+ test directories)
- `tests/snes/` - SNES test ROMs: hardware validation tests and test demos for CPU, PPU, DMA/HDMA, audio, memory, Mode 7, color math, and graphics (12+ test demos)
- `tests/gb/` - Game Boy test ROMs (directory structure ready)

These test ROMs are authoritative tools for:
- Hardware behavior verification
- Emulator accuracy testing
- Code correctness validation
- Timing edge case discovery

See [`tests/nes/README.md`](tests/nes/README.md) for detailed information about NES test ROMs. See [`tests/snes/README.md`](tests/snes/README.md) for detailed information about SNES test demos.

## Quick Start

See [`GETTINGSTARTED.md`](GETTINGSTARTED.md) for installation and environment setup instructions.

To use the NES template:

```bash
cd templates/nes
make
make run
```

To use the SNES template:

```bash
cd templates/snes
make
make run
```

To use the Game Boy template:

```bash
cd templates/gb
make
make run
```

## Framework Files

Key top-level files:

- [`README.md`](README.md) - Framework overview
- [`CHANGELOG.md`](CHANGELOG.md) - Framework history
- [`CONTRIBUTING.md`](CONTRIBUTING.md) - Contribution guidelines
- [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) - Community standards
- [`LICENSE`](LICENSE) - License
- [`GETTINGSTARTED.md`](GETTINGSTARTED.md) - Environment setup and first steps

## Framework Principles

- **Hardware-first**: All explanations start from hardware behavior, not abstractions
- **Learning-focused**: Documentation provides clear learning paths from fundamentals to advanced topics
- **Development-ready**: Templates and examples are production-ready starting points
- **Assembly-aware**: Assembly language is the foundation; higher-level concepts build from there
- **Deterministic**: Cycle counts, timing, and hardware constraints are precisely documented
- **System isolation**: Each system's documentation, templates, and examples are completely self-contained

## Framework Components

This framework consists of four integrated components:

1. **Comprehensive Documentation** - Complete learning paths for each system with hardware-accurate explanations
2. **Development Templates** - Production-ready starting points for new projects with proper hardware initialization
3. **Working Examples** - Reference implementations demonstrating correct patterns and hardware usage
4. **Test ROMs** - Authoritative test suites for hardware verification and emulator validation

## Current Status

### NES
- ✅ Complete documentation structure
- ✅ Production-ready template (matches hello_world pattern)
- ✅ 6 working examples
- ✅ 64+ test ROM directories
- ✅ Comprehensive Makefile build system

### SNES
- ✅ Complete documentation structure (three-processor architecture)
- ✅ Production-ready template with DMA utilities and SPC700 boot
- ✅ 4 working examples (including modular sprite examples)
- ✅ 12+ test demos (CPU, PPU, DMA, audio, Mode 7, graphics)
- ✅ Comprehensive Makefile build system

### Game Boy
- ✅ Documentation structure
- ✅ Basic template structure
- ✅ 1 working example
- ⏳ Test ROMs (directory structure ready)

For contribution details, see [`CONTRIBUTING.md`](CONTRIBUTING.md). For external references, see the per-system `docs/<system>/REFERENCES.md` files.
