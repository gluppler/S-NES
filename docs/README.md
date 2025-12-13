# NES Programming Knowledge Base - Documentation

A comprehensive, hardware-accurate guide to NES programming, from fundamentals to advanced patterns.

## Structure

This knowledge base is organized into seven primary sections:

### 1. Fundamentals

Establish correct mental models and non-negotiable concepts.

- [1.1 NES System Overview](01-fundamentals/1.1-nes-system-overview.md) - Hardware overview, NTSC vs PAL, VBlank
- [1.2 6502 CPU Fundamentals](01-fundamentals/1.2-6502-cpu-fundamentals.md) - Registers, addressing modes, instructions
- [1.3 Memory Fundamentals](01-fundamentals/1.3-memory-fundamentals.md) - CPU memory map, zero page, stack
- [1.4 PPU Fundamentals](01-fundamentals/1.4-ppu-fundamentals.md) - Tiles, pattern tables, name tables, sprites
- [1.5 ROM Fundamentals](01-fundamentals/1.5-rom-fundamentals.md) - iNES header, PRG/CHR ROM, Mapper 0

### 2. Advanced Fundamentals

Move from "it works" to "it is correct on real hardware".

- [2.1 CPU Timing & Cycles](02-advanced-fundamentals/2.1-cpu-timing-cycles.md) - Cycle counts, branch penalties, timing
- [2.2 NMI & VBlank Discipline](02-advanced-fundamentals/2.2-nmi-vblank-discipline.md) - NMI handling, VBlank windows
- [2.3 PPU Rendering Rules](02-advanced-fundamentals/2.3-ppu-rendering-rules.md) - VRAM access, scroll registers, sprite evaluation
- [2.4 Controller I/O](02-advanced-fundamentals/2.4-controller-io.md) - Shift register, strobing, button reading
- [2.5 Audio Fundamentals](02-advanced-fundamentals/2.5-audio-fundamentals.md) - APU channels, frame counter, timing

### 3. Core Concepts

Learn how subsystems interact and work together.

- [3.1 The Game Loop](03-core-concepts/3.1-the-game-loop.md) - Main loop, NMI handler, frame synchronization
- [3.2 Data-Oriented Design (NES Style)](03-core-concepts/3.2-data-oriented-design.md) - Memory layout, zero page, struct-of-arrays
- [3.3 Rendering Architecture](03-core-concepts/3.3-rendering-architecture.md) - OAM buffering, VRAM updates, rendering pipeline
- [3.4 Input → State → Output Pipeline](03-core-concepts/3.4-input-state-output-pipeline.md) - Controller input, game state, rendering output
- [3.5 Map & Level Systems](03-core-concepts/3.5-map-level-systems.md) - Metatiles, compression, attribute encoding

### 4. Cheatsheets

Fast reference for active coding.

- [4.1 CPU Cheatsheets](04-cheatsheets/4.1-cpu-cheatsheets.md) - Instruction reference, addressing modes, flags
- [4.2 PPU Cheatsheets](04-cheatsheets/4.2-ppu-cheatsheets.md) - Register reference, sprite attributes, palettes
- [4.3 Memory Cheatsheets](04-cheatsheets/4.3-memory-cheatsheets.md) - Memory maps, zero page, APU registers
- [4.4 Timing Cheatsheets](04-cheatsheets/4.4-timing-cheatsheets.md) - Frame timing, VBlank windows, cycle budgets
- [4.5 Audio Cheatsheets](04-cheatsheets/4.5-audio-cheatsheets.md) - APU register map, channel control, frame counter

### 5. Applied Patterns & Systems

Reusable, proven solutions for common problems.

- [5.1 Sprite Engine Patterns](05-applied-patterns/5.1-sprite-engine-patterns.md) - Fixed slots, dynamic allocation, flicker prevention
- [5.2 Scrolling Patterns](05-applied-patterns/5.2-scrolling-patterns.md) - Horizontal, vertical, four-way scrolling
- [5.3 Collision Systems](05-applied-patterns/5.3-collision-systems.md) - Tile-based, bounding box, hybrid collision
- [5.4 Animation Systems](05-applied-patterns/5.4-animation-systems.md) - Frame tables, timers, state-driven animation
- [5.5 Audio Integration](05-applied-patterns/5.5-audio-integration.md) - FamiTone2, music vs SFX priority, direct APU control

### 6. Tooling & Debugging

Tools and techniques for development.

- [6.1 Toolchain (Linux-first)](06-tooling-debugging/6.1-toolchain.md) - ca65/ld65, asm6f, Makefiles
- [6.2 Emulators & Debuggers](06-tooling-debugging/6.2-emulators-debuggers.md) - Mesen2 workflow, breakpoints, PPU viewers
- [6.3 Test ROMs](06-tooling-debugging/6.3-test-roms.md) - CPU tests, PPU tests, APU tests

### 7. Real Hardware Considerations

What you need to know for real NES hardware.

- [Real Hardware Considerations](07-real-hardware/real-hardware-considerations.md) - Flashcarts, power-on state, emulator mismatches

## Philosophy

This knowledge base follows these principles:

- **Hardware-first**: No abstractions until justified
- **Assembly-aware**: C is treated as a convenience layer, not the truth
- **Deterministic**: Cycle counts, registers, memory maps matter
- **Cross-linked**: Concepts reference each other, not isolated chapters
- **Cheatsheet-driven**: Fast recall is a first-class feature

## Getting Started

1. **Start with Fundamentals**: Read sections 1.1–1.5 to establish correct mental models
2. **Move to Advanced Fundamentals**: Read sections 2.1–2.5 to understand timing and constraints
3. **Learn Core Concepts**: Read sections 3.1–3.5 to understand system interactions
4. **Use Cheatsheets**: Keep sections 4.1–4.5 open while coding
5. **Apply Patterns**: Reference sections 5.1–5.5 when implementing features
6. **Set Up Tooling**: Follow section 6.1 to set up your development environment
7. **Test on Hardware**: Read section 7 before finalizing your game

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

## Related Resources

- [Main README](../README.md) - Project overview and contribution guidelines
- [References](../REFERENCES.md) - External resources and authoritative links
- [Contributing Guide](../CONTRIBUTING.md) - How to contribute to this project
- [Code of Conduct](../CODE_OF_CONDUCT.md) - Community standards

## External Resources

- [NES Dev Wiki](https://www.nesdev.org/) - Comprehensive NES development resources
- [6502.org](http://www.6502.org/) - 6502 processor documentation
- [Open Source Guide](https://opensource.guide/) - Open source best practices

## Cross-References

- INSTRUCTIONS.md → Complete project structure and organization
- [Main README](../README.md) - Project overview and contribution guidelines
- [References](../REFERENCES.md) - External resources and authoritative links
- [Contributing Guide](../CONTRIBUTING.md) - How to contribute to this project
- [Code of Conduct](../CODE_OF_CONDUCT.md) - Community standards

---

**Note**: This documentation is maintained as part of an open source project. Contributions are welcome! See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.
