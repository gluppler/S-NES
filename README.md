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

- `docs/nes/` - Complete NES learning path: fundamentals, advanced topics, core concepts, techniques, cheatsheets, and references
- `docs/snes/` - Complete SNES learning path: fundamentals, advanced topics, core concepts, techniques, cheatsheets, and references
- `docs/gameboy/` - Complete Game Boy learning path: fundamentals, advanced topics, core concepts, cheatsheets, references, and gold-standard examples

Each system documentation tree is written in hardware terms, is self-contained, and provides a complete learning path from basics to advanced development.

## Development Templates

Production-ready development templates live under `templates/`:

- `templates/nes/` - Complete NES development template that builds valid iNES ROMs with proper hardware initialization
- `templates/snes/` - Complete SNES development template that boots correctly on real hardware with proper 65816 mode setup
- `templates/gb/` - Complete Game Boy development template that builds valid `.gb` ROMs with correct cartridge headers

Each template provides a complete, hardware-accurate starting point for development with a consistent structure: `build`, `src`, `assets`, `linker`, `headers`, `macros`, `tools`, `config`, and `rom` directories.

## Learning Examples

Working example projects live under `examples/`:

### NES Examples

- `examples/nes/hello_world` - NES text rendering example demonstrating hardware initialization and PPU usage
- `examples/nes/vdelay_example` - Variable delay routine demonstrating cycle-accurate timing (29-65535 cycles)
- `examples/nes/prng_example` - Random number generator example demonstrating 16-bit LFSR PRNG (galois16)
- `examples/nes/nrom_example` - Complete NROM template with sprite system, DMC-safe controller reading, and game loop
- `examples/nes/snrom_example` - Complete SNROM/MMC1 template with bank switching and inter-bank function calls

### SNES Examples

- `examples/snes/hello_world` - SNES text rendering example demonstrating native mode entry and PPU setup

### Game Boy Examples

- `examples/gameboy/hello_world` - Game Boy text rendering example demonstrating LCD initialization and tile rendering

These examples serve as learning resources, demonstrating correct hardware initialization, text rendering, timing patterns, and basic program structure for each system.

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

This framework consists of three integrated components:

1. **Comprehensive Documentation** - Complete learning paths for each system
2. **Development Templates** - Production-ready starting points for new projects
3. **Working Examples** - Reference implementations demonstrating correct patterns

For contribution details, see [`CONTRIBUTING.md`](CONTRIBUTING.md). For external references, see the per-system `docs/<system>/REFERENCES.md` files.
