# 65816 Register Width Control

## Overview

The 65816 allows you to control whether registers are 8-bit or 16-bit. This is a critical SNES concept.

## Register Width Flags

The status register (P) controls register widths:
- **Bit 5**: Accumulator width (0 = 16-bit, 1 = 8-bit)
- **Bit 4**: Index register width (0 = 16-bit, 1 = 8-bit)

## Setting Register Widths

### 8-Bit Mode

```asm
SEP #$20   ; Set bit 5 → 8-bit accumulator
SEP #$10   ; Set bit 4 → 8-bit X, Y
SEP #$30   ; Set bits 4 and 5 → 8-bit A, X, Y
```

### 16-Bit Mode

```asm
REP #$20   ; Clear bit 5 → 16-bit accumulator
REP #$10   ; Clear bit 4 → 16-bit X, Y
REP #$30   ; Clear bits 4 and 5 → 16-bit A, X, Y
```

## Common SNES Pattern

Most SNES code uses:
- **8-bit accumulator** (for register writes)
- **16-bit index registers** (for addressing and loops)

```asm
REP #$10   ; 16-bit X, Y
SEP #$20   ; 8-bit A
```

## Why 8-Bit Accumulator?

SNES registers are 8-bit:
- PPU registers ($2100-$213F) are 8-bit
- CPU I/O registers ($4200-$43FF) are 8-bit
- Writing with 16-bit accumulator writes 2 bytes (wrong!)

```asm
; ❌ BAD: 16-bit accumulator
REP #$20
LDA #$0080
STA INIDISP  ; Writes $80 to $2100 AND $00 to $2101 (wrong!)

; ✅ GOOD: 8-bit accumulator
SEP #$20
LDA #$80
STA INIDISP  ; Writes $80 to $2100 only (correct)
```

## Why 16-Bit Index Registers?

16-bit X/Y enable:
- Efficient loops (up to 65536 iterations)
- 16-bit addressing (for WRAM, VRAM addresses)
- Better code generation

```asm
; ✅ GOOD: 16-bit X for loop
REP #$10
LDX #$0000
loop:
    LDA data,X
    STA dest,X
    INX
    CPX #$0100
    BNE loop
```

## Switching Widths

You can switch widths as needed:

```asm
SEP #$20        ; 8-bit A
LDA #$80
STA INIDISP     ; 8-bit write

REP #$20        ; 16-bit A
LDA player_x    ; 16-bit read
CLC
ADC #$0100      ; 16-bit math
STA player_x    ; 16-bit write

SEP #$20        ; Back to 8-bit A
```

## Cycle Impact

Register width affects cycle counts:
- **8-bit operations**: Generally faster (fewer cycles)
- **16-bit operations**: More cycles, but handle larger values

## Cross-References

- [Native vs Emulation Mode](native-vs-emulation.md) - Mode switching
- [Addressing Modes](addressing-modes.md) - Direct page, banked addressing
- [CPU Initialization](../../programming/initialization/cpu-init.md) - Initialization sequence
