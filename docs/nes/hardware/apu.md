# NES APU (Audio Processing Unit)

> **Status**: This is a stub. For complete APU documentation, see [NESdev Wiki - APU](https://www.nesdev.org/wiki/APU).

## Overview

The APU is integrated into the RP2A03/RP2A07 CPU and handles all audio generation.

## Channels

### Pulse 1 ($4000-$4003)
- Square wave with duty cycle control
- Sweep unit, envelope, length counter

### Pulse 2 ($4004-$4007)
- Identical to Pulse 1

### Triangle ($4008-$400B)
- Triangle wave
- Linear counter, length counter

### Noise ($400C-$400F)
- Pseudo-random noise generator
- Envelope, length counter

### DMC ($4010-$4013)
- Delta Modulation Channel
- Sample playback

## Registers

```
$4000-$4003: Pulse 1
$4004-$4007: Pulse 2
$4008-$400B: Triangle
$400C-$400F: Noise
$4010-$4013: DMC
$4015: Status/Enable
$4017: Frame Counter
```

## Frame Counter

Two modes:
- **4-step**: 4 frames, 60 Hz IRQ
- **5-step**: 5 frames, no IRQ

## Timing

- **Clock rate**: CPU / 2 (~894.886 kHz NTSC)
- **Frame rate**: ~240 Hz (4-step), ~192 Hz (5-step)

## Resources

- [NESdev Wiki - APU](https://www.nesdev.org/wiki/APU)
- [NESdev Wiki - APU Basics](https://www.nesdev.org/wiki/APU_basics)
- [APU Reference](https://www.nesdev.org/apu_ref.txt)
