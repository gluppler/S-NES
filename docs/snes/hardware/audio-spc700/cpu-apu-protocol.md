# CPU-APU Communication Protocol

## Overview

The main CPU (65816) communicates with the SPC700 audio processor via **4 communication ports** ($2140-$2143).

## Communication Registers

- **$2140 (APUIO0)**: Communication port 0
- **$2141 (APUIO1)**: Communication port 1
- **$2142 (APUIO2)**: Communication port 2
- **$2143 (APUIO3)**: Communication port 3

## Communication Protocol

### Basic Pattern

1. **CPU writes** to APUIO ports
2. **SPC700 reads** from APUIO ports
3. **SPC700 processes** data
4. **SPC700 writes** response to APUIO ports
5. **CPU reads** response from APUIO ports

### Example: Send Command

```asm
; Send command to SPC700
lda #COMMAND_ID
sta APUIO0        ; Write command
; Wait for SPC700 to process
; Read response
lda APUIO0        ; Read response
```

## SPC700 Boot Protocol

See [SPC700 Boot](spc700-boot.md) for complete boot sequence.

## S-DSP Register Access

S-DSP registers are accessed via SPC700:

1. **CPU writes** register address to SPC700 $00F2
2. **CPU writes** register data to SPC700 $00F3
3. **SPC700** writes to S-DSP register

### Example: Set Voice Volume

```asm
; Set voice 0 volume left
lda #$00           ; Voice 0 VOLL register
sta APUIO2          ; Send to SPC700 $00F2
lda #$7F            ; Volume = $7F
sta APUIO3          ; Send to SPC700 $00F3
; SPC700 writes to S-DSP register
```

## Timing Considerations

- **Asynchronous**: SPC700 may be busy
- **Wait for ready**: Check APUIO ports before reading
- **Race conditions**: Avoid simultaneous reads/writes

## Cross-References

- [SPC700 Boot](spc700-boot.md) - Boot protocol
- [DSP Registers](dsp-registers.md) - S-DSP register map
- [SPC700 Boot](../../programming/initialization/spc700-boot.md) - Programming guide
