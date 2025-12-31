# NES Documentation

Comprehensive documentation for Nintendo Entertainment System development.

## 📚 Documentation Sections

### 🎯 [Fundamentals](fundamentals/)
Core concepts every NES developer needs to know:
- System architecture overview
- Memory map and addressing
- 6502 CPU basics
- PPU (graphics) fundamentals
- APU (audio) basics
- Program structure and flow

### 🔧 [Concepts](concepts/)
Important NES-specific concepts:
- Scanline timing and rendering
- Sprite evaluation and limitations
- Nametables and pattern tables
- Scrolling mechanics
- Bank switching
- Mappers

### 🚀 [Advanced Fundamentals](advanced_fundamentals/)
Deep dives into hardware behavior:
- Cycle-accurate timing
- PPU edge cases and quirks
- Open bus behavior
- Hardware limitations and workarounds
- Optimization techniques
- Advanced mapper features

### 💡 [Techniques](techniques/)
Practical programming techniques:
- Sprite multiplexing
- Metatiles and compression
- Smooth scrolling
- Status bar implementation
- Music and sound effects
- Controller input handling

### 🗺️ [Mappers](mappers/)
Memory mapper (cartridge) documentation:
- NROM (Mapper 0) - Basic, no banking
- MMC1 (Mapper 1) - Bank switching, common
- MMC3 (Mapper 4) - Advanced features, very common
- Other mappers (see [mappers/](mappers/) directory for comprehensive mapper documentation)

### 📊 [Cheatsheets](cheatsheets/)
Quick reference materials:
- PPU register reference
- APU register reference
- 6502 instruction set
- Memory map diagrams
- Timing diagrams
- Common code patterns

### 🛠️ [Tooling & Debugging](06-tooling-debugging/)
Development tools and techniques:
- cc65 assembler setup and usage
- Emulator selection and features
- Debugging techniques
- Build systems
- ROM analysis tools

### 🔌 [Real Hardware](07-real-hardware/)
Working with actual NES consoles:
- Flashcart options (Everdrive N8, PowerPak)
- Hardware differences between revisions
- Famicom vs NES differences
- PAL vs NTSC considerations
- Testing on real hardware

### 📖 [References](references/)
External resources and citations:
- NESdev Wiki links
- Academic papers
- Hardware schematics
- Component datasheets
- Community forums and discussions

## 🎓 Learning Path

### Beginners
1. Start with [Fundamentals](fundamentals/)
2. Read [Concepts](concepts/)
3. Study [examples/nes/hello_world](../../examples/nes/hello_world/)
4. Build [templates/nes](../../templates/nes/)
5. Read [Tooling & Debugging](06-tooling-debugging/)

### Intermediate
1. Read [Advanced Fundamentals](advanced_fundamentals/)
2. Study [Techniques](techniques/)
3. Explore different [Mappers](mappers/)
4. Review [examples/nes](../../examples/nes/) for patterns
5. Test on [Real Hardware](07-real-hardware/)

### Advanced
1. Study hardware test ROMs in [tests/nes](../../tests/nes/)
2. Read mapper documentation in detail
3. Understand cycle-accurate timing
4. Optimize for real hardware constraints
5. Contribute to emulator accuracy

## 📝 Key Topics

### CPU (RP2A03/RP2A07)
- 6502 instruction set with disabled BCD mode
- 1.79 MHz (NTSC) or 1.66 MHz (PAL)
- IRQ and NMI interrupt handling
- DMA for sprite copying

### PPU (RP2C02/RP2C07)  
- 256x240 pixel display
- 8x8 pixel tiles
- 64 sprites maximum (8 per scanline)
- 4 background palettes, 4 sprite palettes
- Hardware scrolling

### APU
- 2 square wave channels
- 1 triangle wave channel
- 1 noise channel
- 1 DMC (sample playback) channel

### Memory
- 2KB internal RAM
- 2KB Video RAM (VRAM)
- Cartridge ROM/RAM via mappers

## 🔗 Essential Resources

### Official Documentation
- [NESdev Wiki](https://www.nesdev.org/) - Primary reference
- [6502 Reference](http://www.6502.org/) - CPU documentation
- [Visual 6502](http://visual6502.org/) - Visual CPU simulator

### Community
- [NESdev Forums](https://forums.nesdev.org/) - Active community
- [NESdev Discord](https://discord.gg/nesdev) - Real-time help

### Tools
- [cc65](https://cc65.github.io/) - C and assembler toolchain
- [FCEUX](http://fceux.com/) - Emulator with debugging
- [Mesen](https://www.mesen.ca/) - Accuracy-focused emulator

### Tutorials
- [Nerdy Nights](https://nerdy-nights.nes.science/) - Beginner series
- [NES Starter Kit](https://nes-starter-kit.nes.science/) - Quick start
- [NESdoug](https://nesdoug.com/) - C programming for NES

## 🚧 Work in Progress

This documentation is continuously being improved. Areas needing expansion:

- [ ] Complete PPU timing documentation
- [ ] APU channel details and code examples
- [x] Mapper reference (integrated from NES-UPDATE/mapper_docs)
- [ ] More code examples in each section
- [ ] Cross-references between topics
- [ ] Illustrated hardware diagrams
- [ ] Video tutorials

## 🤝 Contributing

To improve this documentation:

1. Check existing content for gaps
2. Add code examples to illustrate concepts
3. Cross-reference related topics
4. Cite sources (NESdev Wiki, forums, papers)
5. Keep explanations clear and concise
6. Test code examples before adding

## 📋 Documentation Standards

- Use markdown formatting
- Include code examples with syntax highlighting
- Cite sources with links
- Use diagrams where helpful
- Keep files focused on single topics
- Cross-link related documentation

## 🎮 Practical Examples

All concepts in this documentation are demonstrated in:
- [examples/nes/](../../examples/nes/) - Working examples
- [templates/nes/](../../templates/nes/) - Starting template
- [tests/nes/](../../tests/nes/) - Validation tests

## 📞 Getting Help

- Check [NESdev Wiki](https://www.nesdev.org/) first
- Search [NESdev Forums](https://forums.nesdev.org/)
- Ask in [NESdev Discord](https://discord.gg/nesdev)
- Review example code in this repository

## 📄 License

This documentation is provided for educational purposes.
Code examples are free to use without attribution unless otherwise noted.

## 🔄 Last Updated

See git history for detailed change log.
Major updates tracked in [CHANGELOG.md](../../CHANGELOG.md).
