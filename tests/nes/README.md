# NES Test ROMs

Comprehensive test suite for validating NES emulator accuracy and hardware behavior.

## Overview

This directory contains test ROMs that verify correct implementation of:
- CPU (6502) instruction set and timing
- PPU (Picture Processing Unit) rendering
- APU (Audio Processing Unit) sound generation
- Mapper implementations
- Input/controller handling
- Memory behavior

## Directory Structure

### CPU Tests
- `cpu_dummy_writes/` - CPU dummy write behavior
- `cpu_exec_space/` - Code execution from different memory regions  
- `cpu_interrupts_v2/` - IRQ and NMI interrupt handling
- `cpu_reset/` - CPU reset behavior
- `instr_misc/` - Miscellaneous instruction tests
- `instr_test-v5/` - Comprehensive instruction set test
- `instr_timing/` - Instruction cycle timing

### PPU Tests  
- `ppu_vbl_nmi/` - VBlank and NMI timing
- `ppu_sprite_hit/` - Sprite 0 hit detection
- `ppu_sprite_overflow/` - Sprite overflow flag
- `ppu_read_buffer/` - PPU read buffer behavior
- `ppu_open_bus/` - Open bus behavior

### APU Tests
- `apu_mixer/` - Audio channel mixing
- `apu_reset/` - APU reset state
- `apu_test/` - General APU functionality
- `dmc_tests/` - Delta Modulation Channel (DMC)
- `square_timer_div2/` - Square wave timer divider

### Mapper Tests
- Various mapper-specific tests (MMC1, MMC3, etc.)

### Other Tests
- `blargg_nes_cpu_test5/` - Blargg's CPU test suite
- `branch_timing_tests/` - Branch instruction timing
- `oam_read/` - OAM (sprite) memory read
- `oam_stress/` - OAM DMA stress test

## Usage

### For Emulator Developers

Run these tests against your emulator to verify correctness:

```bash
# Run a specific test
fceux tests/nes/cpu_exec_space/test.nes

# Check for PASS/FAIL output
# Tests typically display results on screen or via status code
```

### For Hardware Verification

Flash to a flashcart (Everdrive N8, PowerPak, etc.) and run on real NES hardware to verify test ROM correctness.

### Expected Results

Most tests output:
- ✅ **PASS** - Test completed successfully
- ❌ **FAIL** - Test failed with error code
- Error codes are test-specific (check README in each test directory)

## Test Categories

### Accuracy Tests
Verify exact hardware behavior including edge cases:
- Cycle-accurate timing
- Open bus behavior  
- Hardware quirks and bugs
- Power-up state

### Compatibility Tests
Check basic functionality for games:
- Standard instruction execution
- Normal rendering
- Common mapper features
- Controller input

### Stress Tests
Push hardware to limits:
- Maximum sprite count
- Rapid bank switching
- Extreme scroll values
- Heavy APU usage

## Test Collection Status

The test collection includes comprehensive NES hardware validation tests. Additional test ROMs from external sources have been integrated and verified for compatibility with the S-NES-BOY framework.
Review and add high-value tests that aren't already covered.

## Running Test Suites

### Automated Testing

Create a test runner script:

```bash
#!/bin/bash
# run_tests.sh
for test in tests/nes/*/test.nes; do
    echo "Running: $test"
    fceux "$test" --headless --exit-after-test
done
```

### Manual Testing

1. Open test ROM in emulator
2. Check on-screen output
3. Compare against expected results
4. Note any failures for debugging

## Common Test Frameworks

### Blargg's Test ROMs
- Comprehensive CPU tests
- PPU timing tests
- APU functionality tests
- Standard format: displays "Passed" or error number

### Kevtris Tests
- Low-level hardware behavior
- Edge case coverage
- Often requires analysis of specific bytes

### Community Tests
- Focus on specific issues or games
- May test undocumented behavior
- Varying output formats

## Test Result Interpretation

### Error Codes

Most tests use numeric error codes:
- `00` - All tests passed
- `01-FF` - Specific test failed (check test documentation)

### Visual Output

Some tests display:
- Color patterns (specific colors indicate pass/fail)
- Text messages on screen
- Sprite patterns

### Memory Values

Advanced tests may require checking specific memory locations after execution.

## Contributing

When adding new tests:

1. Create subdirectory with descriptive name
2. Include README explaining:
   - What is being tested
   - Expected results
   - Known issues on real hardware
3. Add source code if available
4. Document any special setup needed

## Known Issues

### Emulator-Specific

Some tests may fail on emulators due to:
- Imperfect accuracy (acceptable for gameplay)
- Unimplemented edge cases
- Timing approximations

### Hardware Variations

Different NES hardware revisions may:
- Have slightly different timing
- Exhibit different edge case behavior
- Show variation in analog components (APU)

## References

- [NESdev Test ROMs](https://www.nesdev.org/wiki/Emulator_tests)
- [Blargg's Test ROMs](http://blargg.8bitalley.com/nes-tests/)
- [NES Test Cart Database](https://www.nesdev.org/wiki/Emulator_tests)

## License

Test ROMs have varying licenses. Check individual test directories for specifics.
Generally free to use for emulator development and testing.
