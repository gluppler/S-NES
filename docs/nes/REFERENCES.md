# NES Documentation References

Authoritative documentation and resources for NES hardware and programming.

---

## 🧩 6502 / CPU / Assembly

### Assembly Optimization & Techniques
- [6502 Assembly Optimisations](https://www.nesdev.org/wiki/6502_assembly_optimisations) - Optimization techniques for 6502 code
- [Synthetic Instructions](https://www.nesdev.org/wiki/Synthetic_instructions) - Common instruction patterns that act like single operations
- [Cycle Counting](https://www.nesdev.org/wiki/Cycle_counting) - How to count CPU cycles accurately
- [Delay Code](https://www.nesdev.org/wiki/Delay_code) - Techniques for creating precise delays
- [Fixed Cycle Delay](https://www.nesdev.org/wiki/Fixed_cycle_delay) - Exact cycle delay patterns
- [NES Delay Calculator](https://bisqwit.iki.fi/utils/nesdelay.php) - Online tool for calculating delay loops
- [RTS Trick](https://www.nesdev.org/wiki/RTS_Trick) - Using RTS for indirect jumps
- [Programming with Unofficial Opcodes](https://www.nesdev.org/wiki/Programming_with_unofficial_opcodes) - Undocumented 6502 opcodes (use with caution)
- [Jump Table](https://www.nesdev.org/wiki/Jump_table) - Implementing jump tables in 6502
- [Pointer Table](https://www.nesdev.org/wiki/Pointer_table) - Using pointer tables for data access
- [Scanning Tables](https://www.nesdev.org/wiki/Scanning_tables) - Linear search techniques
- [Scanning Large Tables](https://www.nesdev.org/wiki/Scanning_large_tables) - Efficient large table searches
- [Multibyte Constant](https://www.nesdev.org/wiki/Multibyte_constant) - Working with multi-byte values
- [Fixed Bit Length Encoding](https://www.nesdev.org/wiki/Fixed_Bit_Length_Encoding) - Data compression techniques
- [Hex Words](https://nedbatchelder.com/text/hexwords.html) - Hexadecimal word patterns

### CPU Core Documentation
- [CPU](https://www.nesdev.org/wiki/CPU) - Complete CPU documentation
- [CPU_ALL](https://www.nesdev.org/wiki/CPU_ALL) - Comprehensive CPU reference
- [Cycle Reference Chart](https://www.nesdev.org/wiki/Cycle_reference_chart) - Complete cycle timing reference
- [Clock Rates](https://www.nesdev.org/wiki/Cycle_reference_chart#Clock_rates) - CPU and PPU clock frequencies
- [CPU Power-Up State](https://www.nesdev.org/wiki/CPU_power_up_state) - Register and memory state at power-on
- [CPU Variants](https://www.nesdev.org/wiki/CPU_variants) - 2A03 (NTSC) vs 2A07 (PAL) differences
- [CPU Forum Discussion](https://forums.nesdev.org/viewtopic.php?p=64224#p64224) - CPU behavior discussion

---

## 🧱 System Constraints & Limits

- [Limitations](https://www.nesdev.org/wiki/Limitations) - NES hardware limitations and constraints
- [Limitations Forum Discussion 1](https://forums.nesdev.org/viewtopic.php?p=26438#p26438) - System limits discussion
- [Limitations Forum Discussion 2](https://forums.nesdev.org/viewtopic.php?p=44710#p44710) - Additional constraints
- [Limitations Forum Discussion 3](https://forums.nesdev.org/viewtopic.php?p=53873#p53873) - Hardware limitations

---

## 🎮 PPU / Rendering / Timing

### PPU Fundamentals
- [Sample RAM Map](https://www.nesdev.org/wiki/Sample_RAM_map) - Example memory layout
- [PPU Scrolling](https://www.nesdev.org/wiki/PPU_scrolling) - Background scrolling techniques
- [Sprite Size](https://www.nesdev.org/wiki/Sprite_size) - 8×8 vs 8×16 sprite modes
- [The Frame and NMIs](https://www.nesdev.org/wiki/The_frame_and_NMIs) - Frame timing and NMI relationship
- [Frame Timing (Archive)](https://web.archive.org/web/20090714010738/http://nesdevhandbook.googlepages.com/theframe.html) - Historical frame timing documentation
- [NMI Thread](https://www.nesdev.org/wiki/NMI_thread) - NMI handling patterns
- [NES Raster Effects](https://story.monoroch.net/nes_raster.html) - Raster effect techniques
- [Palette Change Mid-Frame](https://www.nesdev.org/wiki/Palette_change_mid_frame) - Changing palettes during rendering
- [Don't Hardcode OAM Addresses](https://www.nesdev.org/wiki/Don%27t_hardcode_OAM_addresses) - OAM management best practices
- [Sprite Cel Streaming](https://www.nesdev.org/wiki/Sprite_cel_streaming) - Dynamic sprite loading
- [Drawing Terrain](https://www.nesdev.org/wiki/Drawing_terrain) - Terrain rendering techniques

### PPU Core Documentation
- [PPU](https://www.nesdev.org/wiki/PPU) - Complete PPU documentation
- [PPU Programmer Reference](https://www.nesdev.org/wiki/PPU_programmer_reference) - PPU register and behavior reference
- [PPU Memory Map](https://www.nesdev.org/wiki/PPU_memory_map) - PPU address space layout
- [PPU Frame Timing](https://www.nesdev.org/wiki/PPU_frame_timing) - Frame timing details
- [PPU Rendering](https://www.nesdev.org/wiki/PPU_rendering) - Rendering pipeline documentation
- [PPU Power-Up State](https://www.nesdev.org/wiki/PPU_power_up_state) - PPU register state at power-on
- [PPU Pinout](https://www.nesdev.org/wiki/PPU_pinout) - Hardware pin connections
- [PPU Variants](https://www.nesdev.org/wiki/PPU_variants) - 2C02 (NTSC) vs 2C07 (PAL) differences

### PPU Memory Structures
- [PPU Pattern Tables](https://www.nesdev.org/wiki/PPU_pattern_tables) - Tile graphics storage
- [PPU Nametables](https://www.nesdev.org/wiki/PPU_nametables) - Background tile mapping
- [PPU Attribute Tables](https://www.nesdev.org/wiki/PPU_attribute_tables) - Palette assignment for tiles
- [PPU OAM](https://www.nesdev.org/wiki/PPU_OAM) - Object Attribute Memory (sprite data)
- [PPU Sprite Evaluation](https://www.nesdev.org/wiki/PPU_sprite_evaluation) - How sprites are evaluated per scanline
- [PPU Sprite Priority](https://www.nesdev.org/wiki/PPU_sprite_priority) - Sprite rendering order
- [Sprite Overflow Games](https://www.nesdev.org/wiki/Sprite_overflow_games) - Games that use sprite overflow
- [PPU Palettes](https://www.nesdev.org/wiki/PPU_palettes) - Color palette system
- [Category: Palettes](https://www.nesdev.org/wiki/Category:Palettes) - Palette-related articles
- [RGB PPU](https://www.nesdev.org/rgbppu/) - RGB PPU information

### Video Standards & Display
- [NTSC Video](https://www.nesdev.org/wiki/NTSC_video) - NTSC video standard details
- [PAL Video](https://www.nesdev.org/wiki/PAL_video) - PAL video standard details
- [Overscan](https://www.nesdev.org/wiki/Overscan) - Safe rendering area
- [Overscan Forum Discussion](https://forums.nesdev.org/viewtopic.php?t=13264) - Overscan discussion

---

## 🔔 Interrupts & Timing

- [NMI](https://www.nesdev.org/wiki/NMI) - Non-Maskable Interrupt documentation
- [Interrupt Forwarding](https://www.nesdev.org/wiki/Interrupt_forwarding) - Interrupt handling patterns

---

## 🎮 Controllers & Input

- [Init Code](https://www.nesdev.org/wiki/Init_code) - System initialization code
- [Controller Reading](https://www.nesdev.org/wiki/Controller_reading) - Controller input reading
- [Controller Reading Code](https://www.nesdev.org/wiki/Controller_reading_code) - Controller reading implementation
- [Standard Controller](https://www.nesdev.org/wiki/Standard_controller) - NES controller hardware
- [Controller Detection](https://www.nesdev.org/wiki/Controller_detection) - Detecting connected controllers
- [Controller Port Pinout](https://www.nesdev.org/wiki/Controller_port_pinout) - Hardware pin connections
- [Expansion Port](https://www.nesdev.org/wiki/Expansion_port) - NES expansion port
- [Input Devices](https://www.nesdev.org/wiki/Input_devices) - All NES input devices
- [Detect TV System](https://www.nesdev.org/wiki/Detect_TV_system) - Detecting NTSC vs PAL
- [TV System Detection Forum Discussion](https://forums.nesdev.org/viewtopic.php?p=142703#p142703) - TV system detection discussion

---

## 🔊 APU / Audio

- [Nerdy Nights Sound](https://www.nesdev.org/wiki/Nerdy_Nights_sound) - APU tutorial series
- [APU Basics](https://www.nesdev.org/wiki/APU_basics) - Audio Processing Unit fundamentals

### Audio Tables & Drivers
- [APU Period Table](https://www.nesdev.org/wiki/APU_period_table) - Frequency period lookup table
- [Celius NTSC Table](https://www.nesdev.org/wiki/Celius_NTSC_table) - NTSC frequency table
- [Celius PAL Table](https://www.nesdev.org/wiki/Celius_PAL_table) - PAL frequency table
- [Audio Drivers](https://www.nesdev.org/wiki/Audio_drivers) - Audio driver implementations
- [Nerdtracker Player in NESASM](https://www.nesdev.org/wiki/Nerdtracker_player_in_NESASM) - Music player implementation
- [Audio Driver Forum Discussion](https://forums.nesdev.org/viewtopic.php?p=194826#p194826) - Audio driver discussion

---

## 🧪 Emulation Accuracy & Testing

- [Emulation Tutorials](https://www.nesdev.org/wiki/Emulation_tutorials) - Emulator development guides
- [Accuracy](https://www.nesdev.org/wiki/Accuracy) - Emulation accuracy requirements
- [Catch-up](https://www.nesdev.org/wiki/Catch-up) - Frame timing catch-up mechanisms
- [Enhancement](https://www.nesdev.org/wiki/Enhancement) - Emulator enhancements vs accuracy
- [Game Bugs](https://www.nesdev.org/wiki/Game_bugs) - Known game bugs and quirks
- [Tricky-to-Emulate Games](https://www.nesdev.org/wiki/Tricky-to-emulate_games) - Games that test emulator accuracy
- [Emulator Tests](https://www.nesdev.org/wiki/Emulator_tests) - Test ROMs for emulator validation
- [Emulator Tests Forum Discussion 1](https://forums.nesdev.org/viewtopic.php?t=599) - Test ROM discussion
- [Emulator Tests Forum Discussion 2](https://forums.nesdev.org/viewtopic.php?t=505) - Testing methodology
- [Emulator Tests Forum Discussion 3](https://forums.nesdev.org/viewtopic.php?t=711) - Accuracy testing
- [Emulator Tests Forum Discussion 4](https://forums.nesdev.org/viewtopic.php?t=511) - Test suite discussion
- [Emulator Tests Forum Discussion 5](https://forums.nesdev.org/viewtopic.php?p=19655#p19655) - Test ROM development
- [Emulator Tests Forum Discussion 6](https://forums.nesdev.org/viewtopic.php?t=547) - Emulation accuracy

---

## 🗺️ Mappers & Banking

- [Programming Mappers](https://www.nesdev.org/wiki/Programming_mappers) - General mapper programming guide
- [Programming NROM](https://www.nesdev.org/wiki/Programming_NROM) - Mapper 0 (NROM) programming
- [Programming UNROM](https://www.nesdev.org/wiki/Programming_UNROM) - Mapper 2 (UNROM) programming
- [UxROM](https://www.nesdev.org/wiki/UxROM) - UxROM mapper details
- [CHR ROM vs CHR RAM](https://www.nesdev.org/wiki/CHR_ROM_vs._CHR_RAM#Switching_to_CHR_RAM) - CHR memory switching
- [Programming MMC1](https://www.nesdev.org/wiki/Programming_MMC1) - Mapper 1 (MMC1) programming
- [MMC1](https://www.nesdev.org/wiki/MMC1) - MMC1 mapper hardware details
- [MMC5](https://www.nesdev.org/wiki/MMC5) - Mapper 5 (MMC5) hardware details

---

## 🧱 Compression Techniques

- [Compression](https://www.nesdev.org/wiki/Compression) - General compression techniques
- [Tile Compression](https://www.nesdev.org/wiki/Tile_compression) - Compressing tile graphics
- [Text Compression](https://www.nesdev.org/wiki/Text_compression) - Compressing text data
- [Level Compression](https://www.nesdev.org/wiki/Level_compression) - Compressing level data

---

## 🧮 Math & Arithmetic

### Multiplication
- [Multiplication by a Constant Integer](https://www.nesdev.org/wiki/Multiplication_by_a_constant_integer) - Constant multiplication optimization
- [Fast Signed Multiply](https://www.nesdev.org/wiki/Fast_signed_multiply) - Signed multiplication techniques
- [8-bit Multiply](https://www.nesdev.org/wiki/8-bit_Multiply) - 8-bit multiplication algorithms

### Division
- [8-bit Divide](https://www.nesdev.org/wiki/8-bit_Divide) - 8-bit division algorithms
- [Division by a Constant Integer](https://www.nesdev.org/wiki/Division_by_a_constant_integer) - Constant division optimization
- [Divide by 3](https://www.nesdev.org/wiki/Divide_by_3) - Special case: dividing by 3
- [Division Forum Discussion](https://forums.nesdev.org/viewtopic.php?t=11336) - Division techniques discussion
- [Division Forum Discussion 2](https://forums.nesdev.org/viewtopic.php?p=74242#p74242) - Additional division methods

### Number Conversion
- [16-bit BCD](https://www.nesdev.org/wiki/16-bit_BCD) - Binary-coded decimal conversion
- [Hex to Decimal](https://www.nesdev.org/wiki/HexToDecimal.8) - Hexadecimal to decimal conversion
- [Base 100](https://www.nesdev.org/wiki/Base_100) - Base-100 number system

---

## 🎲 Random Number Generation

- [Random Number Generator](https://www.nesdev.org/wiki/Random_number_generator) - RNG implementations
- [Least Recently Used](https://www.nesdev.org/wiki/Least_recently_used) - LRU algorithm for RNG
- [Linear Feedback Shift Register (Advanced)](https://www.nesdev.org/wiki/Random_number_generator/Linear_feedback_shift_register_(advanced)) - Advanced LFSR RNG

---

## 🔧 Utilities & Algorithms

- [Calculate CRC32](https://www.nesdev.org/wiki/Calculate_CRC32) - CRC32 checksum calculation
- [CRC32 Reference (MDFS)](https://mdfs.net/Info/Comp/Comms/CRC32.htm) - CRC32 algorithm reference
- [CRC32 6502 Source](http://www.6502.org/source/integers/crc.htm) - 6502 CRC32 implementation
- [6502 Source Archive](https://www.zophar.net/fileuploads/2/10532krzvs/6502.txt) - 6502 code archive

---

## 🧠 Case Studies / Deep Dives

- [Animal Crossing NES Game](https://pineight.com/mw/page/Animal_Crossing__NES_game_.xhtml) - Deep dive into Animal Crossing NES implementation

---

## Documentation Structure Mapping

### Core Hardware Documentation

| Topic | Documentation Location |
|-------|------------------------|
| CPU Fundamentals | `fundamentals/1.2-6502-cpu-fundamentals.md` |
| CPU Timing & Cycles | `advanced_fundamentals/2.1-cpu-timing-cycles.md` |
| Memory Fundamentals | `fundamentals/1.3-memory-fundamentals.md` |
| PPU Fundamentals | `fundamentals/1.4-ppu-fundamentals.md` |
| PPU Rendering Rules | `advanced_fundamentals/2.3-ppu-rendering-rules.md` |
| APU Fundamentals | `advanced_fundamentals/2.5-audio-fundamentals.md` |
| ROM & Mappers | `fundamentals/1.5-rom-fundamentals.md` |

### System Behavior Documentation

| Topic | Documentation Location |
|-------|------------------------|
| System Overview | `fundamentals/1.1-nes-system-overview.md` (CPU ↔ PPU ↔ APU timing) |
| NMI & VBlank | `advanced_fundamentals/2.2-nmi-vblank-discipline.md` |
| Controller I/O | `advanced_fundamentals/2.4-controller-io.md` |
| Optimization | `advanced_fundamentals/2.6-optimization-techniques.md` |
| Graphics | `advanced_fundamentals/2.7-graphics-pixel-art.md` |

### Applied Patterns & Tools

| Topic | Documentation Location |
|-------|------------------------|
| Game Loop | `concepts/3.1-the-game-loop.md` |
| Data-Oriented Design | `concepts/3.2-data-oriented-design.md` |
| Rendering Architecture | `concepts/3.3-rendering-architecture.md` |
| Input Pipeline | `concepts/3.4-input-state-output-pipeline.md` |
| Map Systems | `concepts/3.5-map-level-systems.md` |
| Tooling | `06-tooling-debugging/` |
| Real Hardware | `07-real-hardware/` |

---

## Quick Reference by Topic

### Power-Up & Reset States
- CPU: [CPU Power-Up State](https://www.nesdev.org/wiki/CPU_power_up_state)
- PPU: [PPU Power-Up State](https://www.nesdev.org/wiki/PPU_power_up_state)

### Timing & Cycles
- [Cycle Reference Chart](https://www.nesdev.org/wiki/Cycle_reference_chart)
- [Clock Rates](https://www.nesdev.org/wiki/Cycle_reference_chart#Clock_rates)
- [The Frame and NMIs](https://www.nesdev.org/wiki/The_frame_and_NMIs)
- [PPU Frame Timing](https://www.nesdev.org/wiki/PPU_frame_timing)

### Hardware Variants
- [CPU Variants](https://www.nesdev.org/wiki/CPU_variants)
- [PPU Variants](https://www.nesdev.org/wiki/PPU_variants)

### Video Standards
- [NTSC Video](https://www.nesdev.org/wiki/NTSC_video)
- [PAL Video](https://www.nesdev.org/wiki/PAL_video)

### Mappers
- [Programming Mappers](https://www.nesdev.org/wiki/Programming_mappers)
- [Programming NROM](https://www.nesdev.org/wiki/Programming_NROM)
- [Programming MMC1](https://www.nesdev.org/wiki/Programming_MMC1)

---

## Related Documentation

- [NES Documentation Index](README.md) - Main NES documentation index
- [Fundamentals](fundamentals/) - Core hardware concepts
- [Advanced Fundamentals](advanced_fundamentals/) - Timing, constraints, and hardware behavior
- [Core Concepts](concepts/) - System interaction patterns
- [Cheatsheets](cheatsheets/04-cheatsheets/) - Quick reference tables
- [Applied Patterns](techniques/05-applied-patterns/) - Reusable implementation patterns
- [Tooling & Debugging](06-tooling-debugging/) - Development tools
- [Real Hardware](07-real-hardware/) - Hardware considerations

---

## Reference Statistics

**Total**: 105+ authoritative source URLs organized by topic:

- **6502/CPU/Assembly**: 19 URLs (optimization, cycle counting, techniques)
- **System Constraints**: 4 URLs (hardware limitations)
- **PPU/Rendering/Timing**: 30 URLs (rendering pipeline, memory structures, timing)
- **APU/Audio**: 8 URLs (audio fundamentals, tables, drivers)
- **Controllers & Input**: 10 URLs (controller reading, detection, TV system)
- **Math & Arithmetic**: 9 URLs (multiplication, division, conversion)
- **Random Number Generation**: 3 URLs (RNG algorithms)
- **Mappers & Banking**: 8 URLs (mapper programming, bank switching)
- **Compression**: 4 URLs (data compression techniques)
- **Emulation & Testing**: 13 URLs (accuracy, test ROMs)
- **Utilities**: 4 URLs (CRC32, algorithms)
- **Case Studies**: 1 URL (game deep dives)

All URLs are verified and organized according to NES hardware documentation best practices.
