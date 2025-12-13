# NES Programming - Complete Reference List

Official and authoritative resources for NES programming and development.

## Core NES Documentation (Essential)

### Primary Sources

- **NesDev Wiki (Primary Source of Truth)**
  - URL: https://www.nesdev.org/wiki/Nesdev_Wiki
  - Description: The definitive NES technical reference. Hardware registers, timing, PPU, APU, mappers, quirks.

- **NES Programming Guide (Official NesDev)**
  - URL: https://www.nesdev.org/wiki/Programming_guide
  - Description: Step-by-step conceptual overview of NES programming.

- **NES Memory Map**
  - URL: https://www.nesdev.org/wiki/CPU_memory_map
  - Description: Full CPU address map including RAM, PPU, APU, I/O.

- **PPU Documentation**
  - URL: https://www.nesdev.org/wiki/PPU
  - Description: Rendering, nametables, attributes, scrolling, sprite evaluation.

- **APU Documentation**
  - URL: https://www.nesdev.org/wiki/APU
  - Description: Audio channels, registers, timing, envelopes.

- **Controller Input**
  - URL: https://www.nesdev.org/wiki/Standard_controller
  - Description: How $4016/$4017 controller reading works.

## CPU & Assembly References

### 6502 Documentation

- **6502 Instruction Set Reference**
  - URL: http://www.obelisk.me.uk/6502/reference.html
  - Description: Canonical 6502 opcode documentation.

- **6502 Addressing Modes**
  - URL: https://www.nesdev.org/wiki/Addressing_modes
  - Description: NES-specific behavior and quirks.

- **Programming the 6502 (Book – Free HTML Mirror)**
  - URL: https://archive.org/details/Programming_the_6502
  - Description: Classic and still relevant.

- **6502 Timing & Cycles**
  - URL: https://www.nesdev.org/wiki/CPU_cycle_reference
  - Description: Critical for raster effects and stable code.

- **6502.org**
  - URL: http://www.6502.org/
  - Description: Comprehensive 6502 processor documentation and resources.

## ROM Format & Mappers

### File Formats

- **iNES File Format Specification**
  - URL: https://www.nesdev.org/wiki/INES
  - Description: ROM header format used by most emulators.

- **NES 2.0 Header Format**
  - URL: https://www.nesdev.org/wiki/NES_2.0
  - Description: Modern replacement for iNES.

### Mapper Documentation

- **Mapper Reference (All Mappers)**
  - URL: https://www.nesdev.org/wiki/Mapper
  - Description: Bank switching hardware documentation.

- **NROM (Mapper 0)**
  - URL: https://www.nesdev.org/wiki/NROM
  - Description: Beginner-friendly, no bank switching.

## PPU, Graphics & Rendering

### Graphics Systems

- **Nametables & Attribute Tables**
  - URL: https://www.nesdev.org/wiki/Name_table
  - URL: https://www.nesdev.org/wiki/Attribute_table
  - Description: Background tile mapping and palette assignment.

- **Sprites (OAM)**
  - URL: https://www.nesdev.org/wiki/Sprite
  - Description: Sprite limits, priority, flipping, overflow.

- **PPU Registers ($2000–$2007)**
  - URL: https://www.nesdev.org/wiki/PPU_registers
  - Description: Complete PPU register reference.

- **Scrolling Techniques**
  - URL: https://www.nesdev.org/wiki/Scrolling
  - Description: Horizontal, vertical, four-way scrolling.

- **CHR ROM vs CHR RAM**
  - URL: https://www.nesdev.org/wiki/CHR_ROM_vs_CHR_RAM
  - Description: Pattern table storage options.

## Input, Timing & Game Loop

### System Timing

- **NMI & VBlank**
  - URL: https://www.nesdev.org/wiki/NMI
  - Description: Why everything happens in NMI.

- **Frame Timing (NTSC/PAL)**
  - URL: https://www.nesdev.org/wiki/Frame_timing
  - Description: Frame rate and timing specifications.

- **Sprite DMA ($4014)**
  - URL: https://www.nesdev.org/wiki/OAM_DMA
  - Description: Object Attribute Memory DMA transfer.

## Audio & Music

### Audio Systems

- **APU Register Reference**
  - URL: https://www.nesdev.org/wiki/APU_registers
  - Description: Complete APU register documentation.

- **NES Sound Hardware Explained**
  - URL: https://www.nesdev.org/wiki/Sound
  - Description: Audio channel architecture and capabilities.

### Audio Tools

- **FamiTracker (Official)**
  - URL: https://github.com/Dn-Programming-Core-Management/0CC-FamiTracker
  - Description: Music tracker for NES.

- **FamiTone2 (Standard NES Sound Engine)**
  - URL: https://github.com/nesdoug/FamiTone2
  - Description: Standard NES sound engine for assembly projects.

## Linux-Compatible Toolchains

### Assemblers & Compilers

- **cc65 (C Compiler + ca65 Assembler)**
  - URL: https://cc65.github.io/
  - Repository: https://github.com/cc65/cc65
  - Description: C compiler and 6502 assembler toolchain.

- **ca65 Assembler Documentation**
  - URL: https://cc65.github.io/doc/ca65.html
  - Description: Complete ca65 assembler reference.

- **ld65 Linker Documentation**
  - URL: https://cc65.github.io/doc/ld65.html
  - Description: Complete ld65 linker reference.

- **asm6f (Lightweight Assembler)**
  - URL: https://github.com/freem/asm6f
  - Description: Single-pass 6502 assembler.

## Emulators with Debugging (Linux)

### Development Emulators

- **Mesen2 (Best Debugger)**
  - URL: https://github.com/SourMesen/Mesen2
  - Description: Cycle-accurate NES emulator with advanced debugging.

- **FCEUX**
  - URL: https://github.com/TASVideos/fceux
  - Description: NES/Famicom emulator with debugging tools.

- **Nestopia UE**
  - URL: https://github.com/0ldsk00l/nestopia
  - Description: Accurate NES emulator.

## Graphics Tools

### Tile & Sprite Editors

- **YY-CHR (Tile Editor)**
  - URL: https://w.atwiki.jp/yychr/
  - Description: NES tile editor.

- **NES Screen Tool (NESst)**
  - URL: https://shiru.untergrund.net/software.shtml
  - Description: NES screen and tile editor.

- **Aseprite (Sprite Editor)**
  - URL: https://www.aseprite.org/
  - Description: Professional sprite editor (supports NES palette).

## Testing & Hardware Accuracy

### Test ROMs

- **NES Test ROMs (Blargg)**
  - URL: https://www.nesdev.org/wiki/Emulator_tests
  - Description: Comprehensive test ROM collection.

- **PPU Test ROMs**
  - URL: https://github.com/christopherpow/nes-test-roms
  - Description: PPU-specific test ROMs.

- **CPU Test ROMs**
  - URL: https://github.com/TASVideos/fceux/tree/master/test_roms
  - Description: CPU instruction and timing tests.

## Tutorials & Learning Series

### Educational Resources

- **Nerdy Nights NES Tutorial**
  - URL: https://www.nesdev.org/wiki/Nerdy_Nights
  - Description: Step-by-step NES programming tutorial series.

- **NESDoug Tutorials (Assembly & C)**
  - URL: https://nesdoug.com/
  - Description: Comprehensive NES programming tutorials.

- **Making Games for the NES (Book Site)**
  - URL: https://www.manning.com/books/making-games-for-the-nes
  - Description: Book on NES game development.

## Codebases & Templates

### Example Projects

- **NESLib**
  - URL: https://github.com/clbr/neslib
  - Description: NES development library.

- **NESDoug Example Projects**
  - URL: https://github.com/nesdoug
  - Description: Collection of NES example projects.

- **FamiTone2 Examples**
  - URL: https://github.com/nesdoug/FamiTone2/tree/master/examples
  - Description: Audio integration examples.

## Community & Discussion

### Forums & Communities

- **NesDev Forums**
  - URL: https://forums.nesdev.org/
  - Description: Official NES development forums.

- **NESDev Discord**
  - URL: https://discord.gg/nesdev
  - Description: Real-time NES development community.

- **r/nesdev (Reddit)**
  - URL: https://www.reddit.com/r/nesdev/
  - Description: Reddit community for NES developers.

## Archival & Historical Documentation

### Historical Resources

- **Nintendo Patent Documents (PPU/APU behavior)**
  - URL: https://patents.google.com/
  - Description: Official hardware patent documentation.

- **Visual 2A03 (CPU Transistor-Level Analysis)**
  - URL: http://visual6502.org/JSSim/expert.html
  - Description: Transistor-level CPU simulation and analysis.

## License

This reference list is maintained as part of the NES Programming Knowledge Base project. All external links are provided for educational purposes. Please verify link validity and respect the terms of use for each resource.

---

**Last Updated**: 2024
**Maintained By**: NES Programming Knowledge Base Contributors
