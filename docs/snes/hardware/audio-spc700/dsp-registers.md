# S-DSP Register Map

## Overview

S-DSP (Sound DSP) registers are accessed via SPC700 $00F2/$00F3. The CPU cannot directly access S-DSP registers.

## Per-Voice Registers (8 voices)

Each voice has:
- **VxVOLL** ($00-$0E): Voice volume left
- **VxVOLR** ($01-$0F): Voice volume right
- **VxPITCHL** ($02-$10): Voice pitch (low byte)
- **VxPITCHH** ($03-$11): Voice pitch (high byte)
- **VxSRCN** ($04-$12): Sample number
- **VxADSR1** ($05-$13): ADSR envelope (attack, decay, sustain)
- **VxADSR2** ($06-$14): ADSR envelope (sustain level, release)
- **VxGAIN** ($07-$15): Gain envelope
- **VxENVX** ($08-$16): Current envelope value (read-only)
- **VxOUTX** ($09-$17): Voice output (read-only)

## Global Registers

- **MVOLL** ($0C): Main volume left
- **MVOLR** ($1C): Main volume right
- **EVOLL** ($2C): Echo volume left
- **EVOLR** ($3C): Echo volume right
- **KON** ($4C): Key on (bit per voice)
- **KOFF** ($5C): Key off (bit per voice)
- **FLG** ($6C): DSP flags
- **ENDX** ($7C): Voice end flags (read-only)
- **EFB** ($0D): Echo feedback
- **ESA** ($0E): Echo start address
- **EDL** ($0D): Echo delay
- **FIR0-FIR7** ($0F-$7F): FIR filter coefficients

## Register Access Pattern

```asm
.proc spc_write_dsp
  phx
  ; Just do a two-byte upload to $00F2-$00F3, so we
  ; set the DSP address, then write the byte into that.
  ldy #$00F2
  jsr spc_begin_upload
  pla
  jsr spc_upload_byte     ; low byte of X to $F2
  pla
  jsr spc_upload_byte     ; high byte of X to $F3
  rtl
.endproc
```

### Usage

```asm
; Write high byte of X to SPC-700 DSP register in low byte of X
; X = (register_address << 8) | register_value
ldx #($00 << 8) | $7F  ; Voice 0 VOLL = $7F
jsl spc_write_dsp
```

## Cross-References

- [CPU-APU Protocol](cpu-apu-protocol.md) - Communication method
- [BRR Format](brr-format.md) - Audio sample format
- [ADSR Envelopes](adsr-envelopes.md) - Envelope system
