# SNES Hardware Overview

## Three-Processor Architecture

The Super Nintendo Entertainment System uses a **three-processor architecture**:

1. **Ricoh 5A22 (WDC 65C816)**: Main CPU
   - 3.58 MHz (NTSC) / 3.55 MHz (PAL)
   - 16-bit processor with 8-bit compatibility mode
   - 24-bit addressing (16 MB address space)
   - Native mode vs emulation mode

2. **S-PPU (Picture Processing Unit)**: Graphics processor
   - 8 background modes (0-7)
   - Mode 7 with real-time affine transformation
   - Windowing system
   - Color math (add/sub blending)
   - 64 KB VRAM, 512 bytes CGRAM, 544 bytes OAM

3. **SPC700 + S-DSP**: Audio processor
   - Separate 8-bit CPU (1.024 MHz)
   - Dedicated DSP for sample playback
   - 8 voices, BRR compression
   - Echo/reverb system
   - 64 KB RAM shared with SPC700

## System Components

### CPU (5A22 / 65816)
- **Clock**: 3.58 MHz (NTSC) / 3.55 MHz (PAL)
- **Registers**: A, X, Y (8-bit or 16-bit), S (stack), D (direct page), P (status), DB (data bank), PB (program bank)
- **Modes**: Native (16-bit) or Emulation (6502-compatible)
- **Addressing**: 24-bit (16 MB), banked memory access
- **Hardware**: MUL/DIV registers, MVN/MVP block moves

### Memory
- **WRAM**: 128 KB work RAM ($7E0000-$7FFFFF)
- **VRAM**: 64 KB video RAM (accessed via PPU registers)
- **CGRAM**: 512 bytes color palette (256 colors, 15-bit RGB)
- **OAM**: 544 bytes sprite attribute memory (128 sprites)
- **ROM**: Cartridge ROM (LoROM/HiROM/ExHiROM mapping)

### PPU (S-PPU)
- **Background Modes**: 0-7 (different tile formats and layer counts)
- **Mode 7**: Unique affine transformation mode
- **Sprites**: Up to 128 sprites, 32 per scanline
- **Windowing**: Two windows with masking
- **Color Math**: Add/sub blending, fixed color

### Audio (SPC700 + S-DSP)
- **SPC700**: 8-bit CPU running at 1.024 MHz
- **S-DSP**: Sound generator with 8 voices
- **BRR**: Bit Rate Reduction audio compression
- **Echo**: FIR filter with ring buffer
- **Communication**: CPU ↔ SPC700 via $2140-$2143

## Key Differences from NES

| Feature | NES | SNES |
|---------|-----|------|
| CPU | 6502 (8-bit) | 65816 (16-bit, 8-bit compatible) |
| Audio | APU (5 channels) | SPC700 + S-DSP (8 voices, samples) |
| Backgrounds | 1-2 layers | 1-4 layers, Mode 7 |
| Sprites | 64 sprites, 8 per scanline | 128 sprites, 32 per scanline |
| Memory | 2 KB WRAM | 128 KB WRAM |
| DMA | OAM only | 8 channels, HDMA per-scanline |
| Windowing | None | Two windows with masking |
| Color Math | None | Add/sub blending |

## System Timing

### NTSC (North America/Japan)
- **CPU Clock**: 3.58 MHz
- **Frame Rate**: 60.098 Hz
- **Scanlines**: 262 total (224 visible, 38 VBlank)
- **VBlank Duration**: ~1,364 CPU cycles

### PAL (Europe)
- **CPU Clock**: 3.55 MHz
- **Frame Rate**: 50.007 Hz
- **Scanlines**: 312 total (239 visible, 73 VBlank)
- **VBlank Duration**: ~2,620 CPU cycles

## ROM Mapping Modes

### LoROM
- Banks $00-$7F, $80-$FF
- 32 KB banks
- Most common mapping

### HiROM
- Banks $40-$7D, $C0-$FF
- 64 KB banks
- Linear addressing

### ExHiROM
- Extended HiROM
- Up to 48 MB ROM support
- Rare, used by large games

## Fast ROM vs Slow ROM

- **Slow ROM**: 2.68 MHz access (75% CPU speed)
- **Fast ROM**: 3.58 MHz access (100% CPU speed)
- Fast ROM requires special hardware and header bit
- Code in fast ROM runs 25% faster

## Next Steps

- [Toolchain Setup](02-toolchain-setup.md) - Install assemblers and tools
- [First SNES Program](03-first-program.md) - Write your first SNES program
- [Understanding 65816](04-understanding-65816.md) - Learn native vs emulation mode
