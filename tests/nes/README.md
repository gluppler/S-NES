# NES Test ROMs

Comprehensive collection of test ROMs for verifying NES hardware behavior, emulator accuracy, and code correctness.

## Overview

This directory contains authoritative test ROMs from the NES development community. These tests are essential tools for:

- **Hardware behavior verification**: Validate that code matches real NES hardware behavior
- **Emulator accuracy testing**: Verify emulator implementations match hardware
- **Code correctness validation**: Ensure implementations follow NES specifications
- **Timing edge case discovery**: Identify and test timing-critical behaviors

## Test Categories

### CPU Tests

Tests for 6502 CPU instruction behavior, timing, and edge cases:

- **blargg_nes_cpu_test5** - Comprehensive 6502 instruction tests
- **cpu_timing_test6** - Cycle-accurate timing tests
- **cpu_interrupts_v2** - NMI and IRQ handling tests
- **cpu_reset** - Reset vector and power-up state verification
- **cpu_dummy_reads** - Dummy read behavior tests
- **cpu_dummy_writes** - Dummy write behavior tests
- **cpu_exec_space** - Execution space tests (ROM/RAM execution)
- **instr_test-v5** - Comprehensive instruction test suite
- **instr_timing** - Instruction timing tests
- **branch_timing_tests** - Branch instruction timing
- **instr_misc** - Miscellaneous instruction tests
- **nes_instr_test** - NES-specific instruction tests

### PPU Tests

Tests for PPU rendering, VRAM access, and PPU register behavior:

- **blargg_ppu_tests_2005.09.15b** - PPU rendering tests
- **ppu_vbl_nmi** - VBlank timing and NMI tests
- **ppu_read_buffer** - PPU read buffer tests ($2007 read behavior)
- **ppu_open_bus** - Open bus behavior tests
- **sprite_hit_tests_2005.10.05** - Sprite 0 hit tests
- **sprite_overflow_tests** - Sprite overflow behavior
- **oam_read** - OAM read tests
- **oam_stress** - OAM stress tests

### APU Tests

Tests for APU channels, frame counter, and audio behavior:

- **apu_test** - APU channel tests
- **apu_reset** - APU reset behavior
- **apu_mixer** - APU mixing tests
- **blargg_apu_2005.07.30** - Comprehensive APU tests
- **pal_apu_tests** - PAL APU timing tests
- **volume_tests** - Volume control tests

### Mapper Tests

Tests for cartridge mapper behavior:

- **mmc3_test** - MMC3 mapper tests
- **mmc3_irq_tests** - MMC3 IRQ tests
- **mmc3_test_2** - Additional MMC3 tests
- **mmc5test_v2** - MMC5 mapper tests
- **MMC1_A12** - MMC1 A12 tests

### Timing Tests

Tests for frame timing, NMI synchronization, and scanline timing:

- **nmi_sync** - NMI synchronization tests
- **vbl_nmi_timing** - VBlank/NMI timing tests
- **scanline** - Scanline timing tests
- **scanline-a1** - Alternative scanline tests

### Specialized Tests

- **dmc_dma_during_read4** - DMC DMA timing tests
- **dpcmletterbox** - DMC sample tests
- **full_palette** - Palette tests
- **read_joy3** - Controller reading tests

## File Structure

All test ROMs have been converted to use `.asm` file extensions (6502 assembly standard). Test directories typically contain:

- `source/` - Source code directory
  - `common/` - Shared library code (shell, console, delay, etc.)
  - Test-specific source files
- `readme.txt` - Test-specific documentation
- Build configuration files (`.cfg`, `Makefile`, etc.)

## Building Tests

### Building All Tests

A main `Makefile` is provided to build all tests that have their own Makefiles:

```bash
cd tests/nes
make              # Build all tests with Makefiles
make <test_name>  # Build specific test
make clean        # Clean all tests
make help         # Show help
```

The Makefile automatically installs dependencies (cc65, python3) if missing.

### Building Individual Tests

Most tests use the ca65 assembler. Example build process:

```bash
cd tests/nes/<test_name>/source
ca65 -I common -o test.o test_file.asm
ld65 -C nes.cfg test.o -o test.nes
```

Some tests include `Makefile` or `makefile` for automated building. Tests without Makefiles may require manual building - see individual test directories for instructions.

## Using Test ROMs

### Running Tests

1. **Build the test ROM** following the test's build instructions
2. **Load in emulator** (Mesen2, FCEUX, Nestopia, etc.)
3. **Observe results**: Test ROMs display pass/fail status
4. **Verify on hardware**: Test on real NES hardware for final validation

### Interpreting Results

- **Pass**: Test ROM displays "PASS" or shows expected behavior
- **Fail**: Test ROM displays "FAIL" or shows unexpected behavior
- **Hang**: Test ROM freezes (indicates critical failure)

Some tests report results audibly with tones (low = 0, high = 1 in binary).

## Test Framework

Most tests use a common framework that provides:

- **Shell initialization**: Hardware setup, RAM clearing, console initialization
- **Console output**: Text display for test results
- **CRC-32 checksum**: Validates all output matches expected results
- **Delay routines**: Cycle-accurate timing functions
- **Testing utilities**: Common test patterns and assertions

## Clock Rates and Timing

Tests use correct NES clock rates:

- **NTSC**: 1,789,773 Hz (CPU), 5,369,318 Hz (PPU)
- **PAL**: 1,662,607 Hz (CPU), 5,320,545 Hz (PPU)

Frame timing values:
- **NTSC frame**: ~89,400 CPU cycles (262 scanlines)
- **PAL frame**: ~106,500 CPU cycles (312 scanlines)
- **VBlank duration (NTSC)**: ~2,270 CPU cycles (scanlines 241-260)

## Cross-References

- [NES Documentation](../../docs/nes/README.md) - Complete NES learning path
- [Test ROMs Documentation](../../docs/nes/06-tooling-debugging/6.3-test-roms.md) - Detailed test ROM catalog
- [NES References](../../docs/nes/REFERENCES.md) - Authoritative NES development resources

## Notes

- All source files use `.asm` extension (6502 assembly standard)
- Tests are organized by category (CPU, PPU, APU, Mapper, Timing)
- Each test is self-contained with its own build system
- Tests follow hardware-accurate NES specifications
- Some tests may turn the screen off/on during execution (this is normal)

## Test ROM Sources

These test ROMs are from authoritative NES development sources:

- blargg's test suites (CPU, PPU, APU tests)
- Various NES development community contributors
- Hardware-accurate reference implementations

For detailed information about each test, see the `readme.txt` file in each test directory.
