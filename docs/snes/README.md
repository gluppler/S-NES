# Super Nintendo Entertainment System (SNES) Documentation

Hardware-accurate documentation for the Super Nintendo Entertainment System (SNES / Super Famicom).

## System Architecture

The SNES is a **three-processor system**:

- **Ricoh 5A22 (WDC 65C816)**: Main CPU at 3.58 MHz (NTSC) / 3.55 MHz (PAL)
- **S-PPU (Picture Processing Unit)**: Graphics processor with 8 background modes, Mode 7, windowing, color math
- **SPC700 + S-DSP**: Separate 8-bit audio CPU (1.024 MHz) with dedicated DSP for 8-voice sample playback

This architecture is fundamentally different from NES and requires SNES-specific documentation structure.

## Documentation Structure

This documentation is organized to reflect SNES hardware architecture:

### Getting Started
- [Hardware Overview](getting-started/01-hardware-overview.md) - Three-processor architecture, system components
- [Toolchain Setup](getting-started/02-toolchain-setup.md) - ca65, wla-dx, asar, bass assemblers
- [First SNES Program](getting-started/03-first-program.md) - Complete working example
- [Understanding 65816](getting-started/04-understanding-65816.md) - Native vs emulation mode, register widths

### Hardware Documentation

#### CPU (65816)
- [Native vs Emulation Mode](hardware/cpu-65816/native-vs-emulation.md) - Critical SNES concept
- [Register Width Control](hardware/cpu-65816/register-widths.md) - 8-bit vs 16-bit mode
- [Addressing Modes](hardware/cpu-65816/addressing-modes.md) - Direct page, banked addressing
- [Interrupts & Vectors](hardware/cpu-65816/interrupts.md) - NMI, IRQ, COP, BRK
- [MUL/DIV Hardware](hardware/cpu-65816/mul-div-hardware.md) - Hardware multiply/divide registers

#### Memory
- [WRAM Organization](hardware/memory/wram-organization.md) - 128 KB work RAM layout
- [LoROM Mapping](hardware/memory/rom-mapping-lorom.md) - Low ROM mapping mode
- [HiROM Mapping](hardware/memory/rom-mapping-hirom.md) - High ROM mapping mode
- [ExHiROM Mapping](hardware/memory/rom-mapping-exhirom.md) - Extended HiROM mapping
- [SRAM & Save Formats](hardware/memory/sram-save-formats.md) - Battery-backed RAM
- [MMIO Registers](hardware/memory/mmio-registers.md) - Memory-mapped I/O ($2100-$43FF)

#### PPU (S-PPU)
- [Background Modes](hardware/ppu/background-modes.md) - Modes 0-7, tile formats
- [Mode 7 Math](hardware/ppu/mode-7-math.md) - Affine transformation, rotation, scaling
- [Tile Formats](hardware/ppu/tile-formats.md) - 2bpp, 4bpp, 8bpp tile encoding
- [OAM System](hardware/ppu/oam-system.md) - Sprite attribute memory, 32 per scanline limit
- [Windowing](hardware/ppu/windowing.md) - Window system, masking
- [Color Math](hardware/ppu/color-math.md) - Add/sub blending, fixed color

#### DMA & HDMA
- [General DMA](hardware/dma-hdma/general-dma.md) - 8 DMA channels, transfer modes
- [HDMA Per-Scanline](hardware/dma-hdma/hdma-per-scanline.md) - H-Blank DMA, per-scanline effects
- [DMA Channels](hardware/dma-hdma/dma-channels.md) - Channel configuration, priorities
- [Cycle Stealing](hardware/dma-hdma/cycle-stealing.md) - DMA timing, CPU impact

#### Audio (SPC700 + S-DSP)
- [SPC700 Boot](hardware/audio-spc700/spc700-boot.md) - IPL, boot protocol, upload
- [CPU-APU Protocol](hardware/audio-spc700/cpu-apu-protocol.md) - Communication via $2140-$2143
- [DSP Registers](hardware/audio-spc700/dsp-registers.md) - S-DSP register map
- [BRR Format](hardware/audio-spc700/brr-format.md) - Bit Rate Reduction audio compression
- [ADSR Envelopes](hardware/audio-spc700/adsr-envelopes.md) - Volume envelope system
- [Echo System](hardware/audio-spc700/echo-system.md) - FIR filter, ring buffer, reverb

### Programming Guides

#### Initialization
- [CPU Initialization](programming/initialization/cpu-init.md) - Native mode entry, stack, direct page
- [PPU Initialization](programming/initialization/ppu-init.md) - Register setup, forced blanking
- [SPC700 Boot](programming/initialization/spc700-boot.md) - Audio processor boot sequence
- [Fast ROM Setup](programming/initialization/fast-rom-setup.md) - Enabling fast ROM access

#### Game Loop
- [Frame Synchronization](programming/game-loop/frame-synchronization.md) - WAI, frame timing
- [NMI Handler](programming/game-loop/nmi-handler.md) - VBlank interrupt handling
- [VBlank Windows](programming/game-loop/vblank-windows.md) - Safe PPU access periods

#### Rendering
- [OAM Mirror](programming/rendering/oam-mirror.md) - WRAM sprite buffer
- [DMA OAM Updates](programming/rendering/dma-oam-updates.md) - DMA channel 0 for OAM
- [VRAM Management](programming/rendering/vram-management.md) - Tile loading, DMA transfers
- [Background Layers](programming/rendering/background-layers.md) - Layer setup, scrolling

#### Input
- [Auto-Joypad](programming/input/auto-joypad.md) - Hardware automatic controller polling
- [Button State Tracking](programming/input/button-state-tracking.md) - Triggered vs held buttons

### Techniques

#### Mode 7
- [Mode 7 Setup](techniques/mode-7/setup.md) - Matrix initialization
- [Rotation & Scaling](techniques/mode-7/rotation-scaling.md) - Affine transformations
- [Matrix Math](techniques/mode-7/matrix-math.md) - Matrix operations

#### HDMA Effects
- [Per-Scanline Colors](techniques/hdma-effects/per-scanline-colors.md) - Color changes per scanline
- [Window Effects](techniques/hdma-effects/window-effects.md) - HDMA windowing
- [Mode 7 Transforms](techniques/hdma-effects/mode-7-transforms.md) - Per-scanline Mode 7 changes

### Reference

Quick lookup tables, register maps, and external resources:
- [Quick Reference Guides](references/) - CPU, PPU, DMA, SPC700, memory, timing
- [External References](references/REFERENCES.md) - 100+ authoritative SNES resources

## Key SNES Concepts

### Native vs Emulation Mode
The 65816 starts in emulation mode (6502-compatible). You **must** switch to native mode:
```asm
CLC
XCE  ; Switch to native mode
```

### Register Width Control
65816 registers can be 8-bit or 16-bit:
```asm
SEP #$20  ; 8-bit accumulator
REP #$20  ; 16-bit accumulator
```

### DMA is Essential
SNES uses DMA for all VRAM/CGRAM/OAM transfers. Manual writes are too slow.

### SPC700 Boot Required
Audio requires booting the SPC700 processor before use. It's a separate CPU.

### Mode 7 is Unique
SNES Mode 7 provides real-time affine transformation (rotation, scaling) - unique to SNES.

## Authoritative Sources

See [References](references/REFERENCES.md) for complete list of 100+ authoritative SNES resources including:
- **Fullsnes** (problemkaputt.de) - Complete SNES hardware documentation
- **SNESdev Wiki** (wiki.super.org) - SNES development resources
- **65816.org** - 65816 processor documentation
- **S-DSP Documentation** - Complete S-DSP specification

## Examples

SNES code examples are in [`examples/snes/`](../../examples/snes/):
- `hello_world/` - Minimal SNES program demonstrating text rendering
- `move_sprite/` - Sprite movement with controller input and DMA OAM updates
- `bounce_sprite/` - Bouncing sprite with automatic physics
- `lorom-template/` - Complete LoROM template with audio support

## Templates

SNES development templates are in [`templates/snes/`](../../templates/snes/):
- Complete SNES project structure
- Initialization code
- DMA utilities
- SPC700 boot code

## Schematics

SNES hardware schematics are in [`schematics/snes/`](../../../schematics/snes/):
- Console schematics
- Component datasheets
- Development manuals

---

**This documentation is SNES-specific and does not match NES structure.**
