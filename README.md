# NES Programming Knowledge Base

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive, hardware-accurate guide to NES programming, from fundamentals to advanced patterns. This knowledge base provides everything you need to understand and program for the Nintendo Entertainment System, with a focus on real hardware accuracy and practical implementation.

## Overview

This project is a complete reference for NES programming, covering:

- **Fundamentals**: Core concepts and hardware understanding
- **Advanced Fundamentals**: Timing, constraints, and hardware-specific details
- **Core Concepts**: System interactions and architectural patterns
- **Cheatsheets**: Quick reference tables for active coding
- **Applied Patterns**: Reusable solutions for common problems
- **Tooling & Debugging**: Development tools and techniques
- **Real Hardware**: Considerations for actual NES hardware

## Quick Start

1. **Start with Fundamentals**: Read sections 1.1–1.5 to establish correct mental models
2. **Move to Advanced Fundamentals**: Read sections 2.1–2.5 to understand timing and constraints
3. **Learn Core Concepts**: Read sections 3.1–3.5 to understand system interactions
4. **Use Cheatsheets**: Keep sections 4.1–4.5 open while coding
5. **Apply Patterns**: Reference sections 5.1–5.5 when implementing features
6. **Set Up Tooling**: Follow section 6.1 to set up your development environment
7. **Test on Hardware**: Read section 7 before finalizing your game

## Documentation

The complete documentation is located in the [`docs/`](docs/) directory. Start with [`docs/README.md`](docs/README.md) for a complete overview.

### Documentation Structure

```
docs/
├── 01-fundamentals/          # Core concepts and hardware basics
├── 02-advanced-fundamentals/  # Timing, constraints, advanced topics
├── 03-core-concepts/          # System interactions and architecture
├── 04-cheatsheets/            # Quick reference tables
├── 05-applied-patterns/       # Reusable solutions
├── 06-tooling-debugging/      # Development tools
└── 07-real-hardware/          # Hardware considerations
```

## Philosophy

This knowledge base follows these principles:

- **Hardware-first**: No abstractions until justified
- **Assembly-aware**: C is treated as a convenience layer, not the truth
- **Deterministic**: Cycle counts, registers, memory maps matter
- **Cross-linked**: Concepts reference each other, not isolated chapters
- **Cheatsheet-driven**: Fast recall is a first-class feature

## Requirements

- Basic programming knowledge
- Understanding of assembly language (helpful but not required)
- Interest in retro game development and hardware programming

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

### Ways to Contribute

- Report bugs or inaccuracies
- Suggest documentation improvements
- Add new sections or expand existing content
- Improve code examples
- Enhance cheatsheets
- Share real hardware experiences

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Code of Conduct

This project adheres to a Code of Conduct. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## Resources

- [NES Documentation](docs/README.md) - Complete documentation
- [References](REFERENCES.md) - External resources and links
- [Contributing Guide](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Project history

## Target Audience

- **Technically competent**: Assumes programming knowledge
- **New to NES**: No NES-specific intuition required
- **6502 literate**: Basic assembly understanding helpful but not required

## Non-Goals

This knowledge base does **not** cover:

- General programming fundamentals
- Abstract game design theory
- High-level engines or frameworks
- Emulator-only tricks without hardware justification

## Acknowledgments

This project follows best practices from the [Open Source Guide](https://opensource.guide/).

## Support

- **Issues**: Use GitHub Issues for bug reports and feature requests
- **Questions**: Use the question template in `.github/ISSUE_TEMPLATE/`

## Template

A minimal NES program template is available in the [`template/`](template/) directory:

```bash
cd template
make          # Build bootstrap.nes
make run      # Run in emulator
make clean    # Clean build files
```

See [`template/README.md`](template/README.md) for complete documentation.

## Project Structure

```
.
├── template/              # NES program template
├── docs/                  # Complete documentation
├── .github/               # GitHub templates and workflows
├── CONTRIBUTING.md        # Contribution guidelines
├── CODE_OF_CONDUCT.md     # Community standards
├── LICENSE                # MIT License
├── CHANGELOG.md          # Project history
├── REFERENCES.md         # External resources
└── README.md             # This file
```

---

**Note**: This is a documentation project focused on NES programming. For actual NES game development, you'll also need:
- An assembler (ca65, asm6f, etc.)
- An emulator (Mesen2, FCEUX, etc.)
- A flashcart (for testing on real hardware)
