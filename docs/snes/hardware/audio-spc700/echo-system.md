# Echo System

## Overview

S-DSP has a built-in **echo/reverb system** using a ring buffer and FIR (Finite Impulse Response) filter.

## Echo Components

1. **Ring Buffer**: Stores echo samples
2. **FIR Filter**: 8-tap filter for echo processing
3. **Echo Volume**: EVOLL/EVOLR registers
4. **Echo Feedback**: EFB register

## Echo Registers

- **ESA** ($0E): Echo start address (in SPC700 RAM)
- **EDL** ($0D): Echo delay (0-15, determines buffer size)
- **EFB** ($0D): Echo feedback (-128 to +127)
- **EVOLL** ($2C): Echo volume left
- **EVOLR** ($3C): Echo volume right
- **EON** ($4D): Echo on (bit per voice)
- **FIR0-FIR7** ($0F-$7F): FIR filter coefficients

## Echo Buffer Size

```
Buffer size = (EDL + 1) × 512 bytes
Maximum: 16 × 512 = 8,192 bytes
```

## FIR Filter

8-tap FIR filter with coefficients FIR0-FIR7:
- **Default**: [127, 0, 0, 0, 0, 0, 0, 0] (no filtering)
- **Custom**: Set FIR0-FIR7 for reverb effect

## Echo Processing

1. **Mix voices** selected in EON
2. **Apply FIR filter** to echo buffer
3. **Add feedback** (EFB)
4. **Write to echo buffer**
5. **Mix echo** into main output (EVOLL/EVOLR)

## Cross-References

- [DSP Registers](dsp-registers.md) - S-DSP register map
- [ADSR Envelopes](adsr-envelopes.md) - Volume envelopes
