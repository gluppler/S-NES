# 65816 CPU Quick Reference

## Register Width Control

```asm
SEP #$20   ; 8-bit accumulator
REP #$20   ; 16-bit accumulator
SEP #$10   ; 8-bit X, Y
REP #$10   ; 16-bit X, Y
SEP #$30   ; 8-bit A, X, Y
REP #$30   ; 16-bit A, X, Y
```

## Mode Switching

```asm
CLC        ; Clear carry
XCE        ; Switch to native mode
```

## Stack Operations

```asm
LDX #$01FF
TXS        ; Set stack pointer
```

## Direct Page

```asm
LDA #$0000
TCD        ; Set direct page
```

## Bank Registers

```asm
PHK        ; Push program bank
PLB        ; Pull to data bank (DB = PB)
```

## Common SNES Pattern

```asm
reset:
    clc
    xce              ; Native mode
    rep #$10         ; 16-bit X, Y
    sep #$20         ; 8-bit A
    ldx #$01FF
    txs              ; Stack = $01FF
    lda #$0000
    tcd              ; Direct page = $0000
    phk
    plb              ; DB = PB
```

## Cross-References

- [Native vs Emulation Mode](../hardware/cpu-65816/native-vs-emulation.md)
- [Register Width Control](../hardware/cpu-65816/register-widths.md)
- [CPU Initialization](../programming/initialization/cpu-init.md)
