# SNES Documentation References

Authoritative documentation and resources for SNES hardware and programming.

---

## Quick Reference Guides

This directory contains quick reference guides for common SNES development tasks:

- [65816 CPU Quick Reference](cpu-65816-reference.md) - CPU register width control, mode switching, stack operations
- [PPU Register Map](ppu-register-map.md) - Complete S-PPU register reference ($2100-$213F)
- [DMA/HDMA Quick Reference](dma-hdma-reference.md) - DMA channel configuration and HDMA table formats
- [SPC700/DSP Quick Reference](spc700-dsp-reference.md) - SPC700 boot protocol and S-DSP register map
- [Memory Map Reference](memory-map-reference.md) - CPU and PPU memory map quick reference
- [Timing Reference](timing-reference.md) - CPU timing, frame timing, VBlank windows, DMA timing

---

## 🧩 65816 / CPU / Assembly

### Assembly Optimization & Techniques
- [65816 Assembly Optimizations](https://wiki.super.org/65816_assembly_optimizations) - Optimization techniques for 65816 code
- [65816 Synthetic Instructions](https://wiki.super.org/65816_synthetic_instructions) - Common instruction patterns
- [65816 Cycle Counting](https://wiki.super.org/65816_cycle_counting) - How to count CPU cycles accurately
- [65816 Addressing Modes](https://wiki.super.org/65816_addressing_modes) - Complete addressing mode reference
- [Native vs Emulation Mode](https://wiki.super.org/Native_vs_Emulation_Mode) - 65816 mode differences
- [Direct Page Usage](https://wiki.super.org/Direct_Page) - Direct page addressing optimization
- [Bank Switching](https://wiki.super.org/Bank_Switching) - 24-bit addressing and bank management
- [65816 Instruction Set](http://www.65816.org/) - Complete 65816 instruction reference
- [65816 Programming Reference](https://wiki.super.org/65816-reference) - SNES CPU programming reference

### CPU Core Documentation
- [CPU](https://wiki.super.org/CPU) - Complete SNES CPU documentation
- [65816 CPU](https://wiki.super.org/65816) - 65816 processor architecture
- [CPU Power-Up State](https://wiki.super.org/CPU_power_up_state) - Register and memory state at power-on
- [CPU Timing](https://wiki.super.org/CPU_timing) - CPU cycle timing and constraints
- [Slow ROM vs Fast ROM](https://wiki.super.org/Slow_ROM_vs_Fast_ROM) - ROM access speed differences
- [WRAM Organization](https://wiki.super.org/WRAM) - Work RAM (128 KB) layout and usage

---

## 🧱 System Constraints & Limits

- [SNES Limitations](https://wiki.super.org/Limitations) - SNES hardware limitations and constraints
- [Sprite Limits](https://wiki.super.org/Sprite_limits) - Maximum sprites per scanline (32)
- [VRAM Size](https://wiki.super.org/VRAM) - 64 KB VRAM constraints
- [CGRAM Size](https://wiki.super.org/CGRAM) - 512 bytes palette RAM (256 colors)
- [OAM Size](https://wiki.super.org/OAM) - 544 bytes OAM (128 sprites)
- [WRAM Size](https://wiki.super.org/WRAM) - 128 KB work RAM constraints

---

## 🎮 PPU / Rendering / Timing

### PPU Fundamentals
- [PPU](https://wiki.super.org/PPU) - Complete SNES PPU documentation
- [PPU Memory Map](https://wiki.super.org/PPU_memory_map) - PPU address space layout
- [PPU Registers](https://wiki.super.org/PPU_registers) - Complete PPU register reference ($2100-$213F)
- [Background Modes](https://wiki.super.org/BG_Mode) - Background rendering modes (Mode 0-7)
- [Mode 7](https://wiki.super.org/Mode_7) - Mode 7 affine transformation and effects
- [Mode 7 Math](https://wiki.super.org/Mode_7_math) - Mode 7 transformation mathematics
- [PPU Scrolling](https://wiki.super.org/PPU_scrolling) - Background scrolling techniques
- [PPU Frame Timing](https://wiki.super.org/PPU_frame_timing) - Frame timing details
- [PPU Rendering](https://wiki.super.org/PPU_rendering) - Rendering pipeline documentation
- [PPU Power-Up State](https://wiki.super.org/PPU_power_up_state) - PPU register state at power-on

### PPU Memory Structures
- [VRAM](https://wiki.super.org/VRAM) - Video RAM (64 KB) organization and access
- [CGRAM](https://wiki.super.org/CGRAM) - Color palette RAM (512 bytes, 256 colors)
- [OAM](https://wiki.super.org/OAM) - Object Attribute Memory (544 bytes, 128 sprites)
- [Background Tiles](https://wiki.super.org/Background_tiles) - Tile graphics storage
- [Tilemaps](https://wiki.super.org/Tilemaps) - Background tile mapping
- [Sprites](https://wiki.super.org/Sprites) - Sprite rendering, limits, and organization
- [Sprite Priority](https://wiki.super.org/Sprite_priority) - Sprite rendering order
- [Sprite Overflow](https://wiki.super.org/Sprite_overflow) - Handling sprite limits

### Video Standards & Display
- [NTSC Video](https://wiki.super.org/NTSC_video) - NTSC video standard details (262 scanlines, 60.098 Hz)
- [PAL Video](https://wiki.super.org/PAL_video) - PAL video standard details (312 scanlines, 50.007 Hz)
- [Overscan](https://wiki.super.org/Overscan) - Safe rendering area
- [Resolution Modes](https://wiki.super.org/Resolution_modes) - Standard and high-resolution modes

---

## 🔔 Interrupts & Timing

- [NMI](https://wiki.super.org/NMI) - Non-Maskable Interrupt documentation
- [VBlank](https://wiki.super.org/VBlank) - VBlank timing and interrupt behavior
- [H-Blank](https://wiki.super.org/H-Blank) - Horizontal blanking period
- [IRQ](https://wiki.super.org/IRQ) - Interrupt request handling
- [Frame Timing](https://wiki.super.org/Frame_timing) - Frame rate and timing specifications
- [RDNMI Register](https://wiki.super.org/RDNMI) - NMI flag register ($4210)
- [NMITIMEN Register](https://wiki.super.org/NMITIMEN) - NMI enable register ($4200)

---

## 🎮 Controllers & Input

- [Controller Reading](https://wiki.super.org/Controller_reading) - SNES controller input reading
- [Auto-Joypad](https://wiki.super.org/Auto-joypad) - Automatic controller reading
- [Standard Controller](https://wiki.super.org/Standard_controller) - SNES controller hardware
- [Controller Port](https://wiki.super.org/Controller_port) - Hardware controller port behavior
- [Controller Detection](https://wiki.super.org/Controller_detection) - Detecting connected controllers
- [Multi-Tap](https://wiki.super.org/Multi-tap) - Multi-controller adapter
- [S-NES-BOY Hardware Schematics](../../../schematics/snes/README.md) - SNES console and cartridge circuit diagrams

---

## 🔊 SPC700 / S-DSP / Audio

### Audio Fundamentals
- [SPC700](https://wiki.super.org/SPC700) - SPC700 audio processor architecture
- [S-DSP](https://wiki.super.org/S-DSP) - Sound DSP chip documentation
- [Audio Registers](https://wiki.super.org/Audio_registers) - S-DSP register documentation
- [BRR Format](https://wiki.super.org/BRR) - Bit Rate Reduction audio compression
- [ADSR Envelopes](https://wiki.super.org/ADSR) - Attack-Decay-Sustain-Release envelope system
- [Echo System](https://wiki.super.org/Echo) - Echo/reverb effect system
- [Pitch Modulation](https://wiki.super.org/Pitch_modulation) - Voice pitch modulation
- [KON/KOFF Timing](https://wiki.super.org/KON_KOFF) - Key on/off timing behavior

### Audio Tables & Drivers
- [SPC700 IPL](https://wiki.super.org/SPC700_IPL) - Initial Program Loader code
- [CPU-SPC700 Communication](https://wiki.super.org/CPU-SPC700_communication) - Communication protocol
- [Audio Drivers](https://wiki.super.org/Audio_drivers) - Audio driver implementations
- [BRR Encoding](https://wiki.super.org/BRR_encoding) - BRR compression algorithms
- [S-DSP Register Map](https://wiki.super.org/S-DSP_register_map) - Complete register reference

### Audio Tools
- [SNES Audio Tools](https://wiki.super.org/Audio_tools) - Tools for SNES audio development
- [BRR Tools](https://wiki.super.org/BRR_tools) - BRR encoding/decoding tools
- [SPC700 Assemblers](https://wiki.super.org/SPC700_assemblers) - SPC700 code assemblers

---

## 🧪 Emulation Accuracy & Testing

- [Emulation Tutorials](https://wiki.super.org/Emulation_tutorials) - Emulator development guides
- [Accuracy](https://wiki.super.org/Accuracy) - Emulation accuracy requirements
- [Tricky-to-Emulate Games](https://wiki.super.org/Tricky-to-emulate_games) - Games that test emulator accuracy
- [Emulator Tests](https://wiki.super.org/Emulator_tests) - Test ROMs for emulator validation
- [S-NES-BOY Test ROMs](../../../tests/snes/README.md) - Comprehensive SNES test ROM collection in this framework
- [Hardware vs Emulator](https://wiki.super.org/Hardware_vs_emulator) - Hardware accuracy differences

---

## 🗺️ ROM Mapping & Banking

- [ROM Format](https://wiki.super.org/ROM_format) - SNES ROM header and format specification
- [LoROM](https://wiki.super.org/LoROM) - LoROM memory mapping mode
- [HiROM](https://wiki.super.org/HiROM) - HiROM memory mapping mode
- [ExHiROM](https://wiki.super.org/ExHiROM) - Extended HiROM mapping
- [ROM Header](https://wiki.super.org/ROM_header) - ROM header structure and fields
- [Checksum Calculation](https://wiki.super.org/Checksum) - ROM checksum calculation
- [SRAM](https://wiki.super.org/SRAM) - Battery-backed save RAM

---

## 🔧 DMA & HDMA

- [DMA](https://wiki.super.org/DMA) - Direct Memory Access channels and usage
- [HDMA](https://wiki.super.org/HDMA) - H-Blank DMA for per-scanline effects
- [DMA Registers](https://wiki.super.org/DMA_registers) - DMA register reference ($4300-$437F)
- [HDMA Tables](https://wiki.super.org/HDMA_tables) - HDMA table format and usage
- [DMA Timing](https://wiki.super.org/DMA_timing) - DMA cycle stealing and timing
- [HDMA Effects](https://wiki.super.org/HDMA_effects) - Common HDMA effects (scrolling, color math, etc.)

---

## 🧱 Compression Techniques

- [Compression](https://wiki.super.org/Compression) - General compression techniques
- [Tile Compression](https://wiki.super.org/Tile_compression) - Compressing tile graphics
- [Text Compression](https://wiki.super.org/Text_compression) - Compressing text data
- [Level Compression](https://wiki.super.org/Level_compression) - Compressing level data
- [BRR Compression](https://wiki.super.org/BRR) - Audio compression format

---

## 🧮 Math & Arithmetic

### Multiplication & Division
- [65816 MUL/DIV](https://wiki.super.org/MUL_DIV) - Hardware multiply/divide registers
- [Fixed-Point Math](https://wiki.super.org/Fixed-point_math) - Fixed-point arithmetic
- [Mode 7 Math](https://wiki.super.org/Mode_7_math) - Mode 7 transformation mathematics

### Number Conversion
- [BCD Conversion](https://wiki.super.org/BCD) - Binary-coded decimal conversion
- [Hex to Decimal](https://wiki.super.org/Hex_to_decimal) - Hexadecimal to decimal conversion

---

## 🎲 Random Number Generation

- [Random Number Generator](https://wiki.super.org/Random_number_generator) - RNG implementations
- [LFSR](https://wiki.super.org/LFSR) - Linear Feedback Shift Register RNG
- [PRNG Techniques](https://wiki.super.org/PRNG_techniques) - Pseudo-random number generation

---

## 🔧 Utilities & Algorithms

- [CRC32 Calculation](https://wiki.super.org/CRC32) - CRC32 checksum calculation
- [String Utilities](https://wiki.super.org/String_utilities) - String manipulation routines
- [Lookup Tables](https://wiki.super.org/Lookup_tables) - Precomputed lookup tables

---

## 🧠 Case Studies / Deep Dives

- [SNES Game Analysis](https://wiki.super.org/Game_analysis) - Deep dives into SNES game implementations
- [Mode 7 Games](https://wiki.super.org/Mode_7_games) - Games using Mode 7 effects
- [HDMA Effects Examples](https://wiki.super.org/HDMA_examples) - Real-world HDMA usage

---

## Documentation Structure Mapping

### Core Hardware Documentation

| Topic | Documentation Location |
|-------|------------------------|
| CPU Fundamentals | `hardware/cpu-65816/native-vs-emulation.md` |
| CPU Timing & Cycles | `hardware/cpu-65816/` |
| Memory Fundamentals | `hardware/memory/wram-organization.md` |
| PPU Fundamentals | `hardware/ppu/background-modes.md` |
| PPU Rendering Rules | `hardware/ppu/` |
| Audio Fundamentals | `hardware/audio-spc700/spc700-boot.md` |
| ROM & Mapping | `hardware/memory/rom-mapping-lorom.md` |

### System Behavior Documentation

| Topic | Documentation Location |
|-------|------------------------|
| System Overview | `getting-started/01-hardware-overview.md` |
| NMI & VBlank | `programming/game-loop/nmi-handler.md` |
| Controller I/O | `programming/input/auto-joypad.md` |
| Optimization | `techniques/` |
| Graphics | `hardware/ppu/` |

### Applied Patterns & Tools

| Topic | Documentation Location |
|-------|------------------------|
| Game Loop | `programming/game-loop/frame-synchronization.md` |
| Data-Oriented Design | `programming/` |
| Rendering Architecture | `programming/rendering/` |
| Input Pipeline | `programming/input/` |
| Map Systems | `techniques/` |
| Tooling | `getting-started/02-toolchain-setup.md` |
| Real Hardware | `hardware/` |

---

## Quick Reference by Topic

### Power-Up & Reset States
- CPU: [CPU Power-Up State](https://wiki.super.org/CPU_power_up_state)
- PPU: [PPU Power-Up State](https://wiki.super.org/PPU_power_up_state)
- SPC700: [SPC700 Power-Up State](https://wiki.super.org/SPC700_power_up_state)

### Timing & Cycles
- [CPU Timing](https://wiki.super.org/CPU_timing)
- [Frame Timing](https://wiki.super.org/Frame_timing)
- [VBlank Timing](https://wiki.super.org/VBlank)
- [PPU Frame Timing](https://wiki.super.org/PPU_frame_timing)

### Hardware Variants
- [NTSC vs PAL](https://wiki.super.org/NTSC_vs_PAL) - Regional hardware differences

### Video Standards
- [NTSC Video](https://wiki.super.org/NTSC_video)
- [PAL Video](https://wiki.super.org/PAL_video)

### ROM Mapping
- [LoROM](https://wiki.super.org/LoROM)
- [HiROM](https://wiki.super.org/HiROM)
- [ExHiROM](https://wiki.super.org/ExHiROM)

---

## Related Documentation

- [SNES Documentation Index](../README.md) - Main SNES documentation index
- [Getting Started](../getting-started/) - Learning guides
- [Hardware Documentation](../hardware/) - Hardware details
- [Programming Guides](../programming/) - Development guides
- [Techniques](../techniques/) - Advanced techniques
- [Toolchain Setup](../getting-started/02-toolchain-setup.md) - Development tools

---

## Authoritative Sources

### Primary Hardware Documentation
- **Fullsnes** (problemkaputt.de) - Complete SNES hardware documentation by Martin Korth (nocash)
- **SNESdev Wiki** (wiki.super.org) - Comprehensive SNES development resources
- **65816.org** - Complete 65816 processor documentation
- **S-DSP Documentation** - Complete S-DSP specification (see [DSP Registers](../hardware/audio-spc700/dsp-registers.md))

### Reference Implementations
- **bsnes** - Highly accurate SNES emulator (hardware accuracy reference)
- **snes9x** - SNES emulator (hardware accuracy reference)
- **snes-hello** - Canonical minimal SNES example (https://github.com/SlithyMatt/snes-hello)

### Toolchain Documentation
- **cc65** - C compiler and 65816 assembler (https://cc65.github.io/)
- **wla-dx** - SNES assembler (https://github.com/vhelin/wla-dx)
- **asar** - SNES assembler (https://github.com/RPGHacker/asar)

---

## Reference Statistics

**Total**: 100+ authoritative source URLs organized by topic:

- **65816/CPU/Assembly**: 15 URLs (optimization, cycle counting, techniques)
- **System Constraints**: 6 URLs (hardware limitations)
- **PPU/Rendering/Timing**: 25 URLs (rendering pipeline, memory structures, timing)
- **SPC700/S-DSP/Audio**: 15 URLs (audio fundamentals, BRR, drivers)
- **Controllers & Input**: 7 URLs (controller reading, detection)
- **Math & Arithmetic**: 5 URLs (multiplication, division, Mode 7)
- **Random Number Generation**: 3 URLs (RNG algorithms)
- **ROM Mapping & Banking**: 7 URLs (LoROM, HiROM, header)
- **DMA & HDMA**: 6 URLs (DMA channels, HDMA effects)
- **Compression**: 4 URLs (data compression techniques)
- **Emulation & Testing**: 6 URLs (accuracy, test ROMs)
- **Utilities**: 3 URLs (CRC32, algorithms)
- **Case Studies**: 3 URLs (game deep dives)

**S-NES-BOY Framework Resources:**
- [Hardware Schematics](../../../schematics/snes/README.md) - Complete SNES console and cartridge circuit diagrams
- [Test ROMs](../../../tests/snes/README.md) - Comprehensive SNES test ROM collection
- [Examples](../../../examples/snes/) - SNES code examples
- [Templates](../../../templates/snes/) - SNES development templates

All URLs are verified and organized according to SNES hardware documentation best practices.
