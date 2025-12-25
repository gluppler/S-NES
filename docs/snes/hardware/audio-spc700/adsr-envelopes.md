# ADSR Envelopes

## Overview

S-DSP uses **ADSR (Attack, Decay, Sustain, Release)** envelopes for volume control. Each voice has independent envelope control.

## ADSR Phases

1. **Attack**: Volume increases from 0 to peak
2. **Decay**: Volume decreases from peak to sustain level
3. **Sustain**: Volume held at sustain level
4. **Release**: Volume decreases from sustain to 0

## ADSR Registers

### VxADSR1 ($05-$13)

```
Bit 7: ADSR mode (0 = ADSR, 1 = GAIN mode)
Bits 6-4: Attack rate (0-7, if ADSR mode)
Bits 3-0: Decay rate (0-15, if ADSR mode)
```

### VxADSR2 ($06-$14)

```
Bits 7-5: Sustain level (0-7)
Bits 4-0: Release rate (0-31)
```

### VxGAIN ($07-$15)

When ADSR1 bit 7 = 1 (GAIN mode):
```
Bits 7: Gain mode type (0 = direct, 1 = decrease)
Bits 6-0: Gain value (0-127)
```

## Gain Mode

Alternatively, use **Gain mode** (VxGAIN register):
- **Direct gain**: Linear volume control
- **Bent line**: Exponential gain curve

## Envelope Timing

- **Counter rates**: Determined by ADSR values
- **Update frequency**: Every sample (32 kHz)
- **Resolution**: 8-bit envelope value

## Cross-References

- [DSP Registers](dsp-registers.md) - S-DSP register map
- [Echo System](echo-system.md) - Echo/reverb system
