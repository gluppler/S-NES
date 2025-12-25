# MUL/DIV Hardware

## Overview

65816 has **hardware multiply and divide** registers for fast math operations.

## Multiply Registers

- **WRMPYA** ($4202): Multiplicand A (8-bit)
- **WRMPYB** ($4203): Multiplicand B (8-bit)
- **RDMPYL** ($4216): Result (low byte, read-only)
- **RDMPYH** ($4217): Result (high byte, read-only)

### 8×8 Multiply

```asm
lda #$42         ; Multiplicand A
sta WRMPYA        ; $4202
lda #$03          ; Multiplicand B
sta WRMPYB        ; $4203
; Result available after 8 cycles
lda RDMPYL        ; $4216: Low byte
lda RDMPYH        ; $4217: High byte
```

**Result**: A × B (16-bit result)

## Divide Registers

- **WRDIVL** ($4204): Dividend (low byte)
- **WRDIVH** ($4205): Dividend (high byte)
- **WRDIVB** ($4206): Divisor (8-bit)
- **RDDIVL** ($4214): Quotient (low byte, read-only)
- **RDDIVH** ($4215): Quotient (high byte, read-only)

### 16÷8 Divide

```asm
lda #$34         ; Dividend low
sta WRDIVL        ; $4204
lda #$12          ; Dividend high
sta WRDIVH        ; $4205
lda #$03          ; Divisor
sta WRDIVB        ; $4206
; Result available after 16 cycles
lda RDDIVL        ; $4214: Quotient low
lda RDDIVH        ; $4215: Quotient high
```

**Result**: Dividend ÷ Divisor (16-bit quotient)

## Timing

- **Multiply**: 8 cycles
- **Divide**: 16 cycles
- **Much faster**: Than software multiply/divide

## Cross-References

- [CPU Timing](cpu-timing.md) - Cycle timing details
- [Optimization](../../advanced_fundamentals/2.6-optimization-techniques.md) - Performance optimization
