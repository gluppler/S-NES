# Mode 7 Math

## Overview

Mode 7 provides **real-time affine transformation** (rotation, scaling, shearing) - unique to SNES.

## Mode 7 Matrix

Mode 7 uses a 2×2 transformation matrix:

```
[ A  B ]   [ X ]   [ X' ]
[ C  D ] × [ Y ] = [ Y' ]
```

Where:
- **A, B, C, D**: Matrix coefficients (16-bit signed)
- **X, Y**: Source coordinates
- **X', Y'**: Transformed coordinates

## Mode 7 Registers

- **M7A** ($211B): Matrix A (dual-write)
- **M7B** ($211C): Matrix B (dual-write)
- **M7C** ($211D): Matrix C (dual-write)
- **M7D** ($211E): Matrix D (dual-write)
- **M7X** ($211F): Center X (dual-write)
- **M7Y** ($2120): Center Y (dual-write)

## Common Transformations

### Identity (No Transformation)

```asm
; [1.0  0.0]
; [0.0  1.0]
stz M7A
lda #$01
sta M7A     ; A = 1.0
stz M7B     ; B = 0.0
stz M7C     ; C = 0.0
stz M7D
lda #$01
sta M7D     ; D = 1.0
```

### Rotation

```asm
; Rotate by angle θ
; A = cos(θ), B = -sin(θ)
; C = sin(θ), D = cos(θ)
; (Use lookup table for cos/sin values)
```

### Scaling

```asm
; Scale by factor S
; A = S, B = 0
; C = 0, D = S
lda #scale_low
sta M7A
lda #scale_high
sta M7A     ; A = scale
stz M7B     ; B = 0
stz M7C     ; C = 0
lda #scale_low
sta M7D
lda #scale_high
sta M7D     ; D = scale
```

## Mode 7 Setup

```asm
LDA #$07
STA BGMODE  ; Mode 7

; Set matrix (identity)
STZ M7A
LDA #$01
STA M7A
STZ M7B
STZ M7B
STZ M7C
STZ M7C
STZ M7D
LDA #$01
STA M7D

; Set center
STZ M7X
STZ M7X
STZ M7Y
STZ M7Y
```

## Cross-References

- [Background Modes](background-modes.md) - Mode 7 overview
- [Mode 7 Techniques](../../techniques/mode-7/) - Mode 7 programming techniques
