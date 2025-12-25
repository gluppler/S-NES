# Color Math

## Overview

SNES has **color math** (add/sub blending) that can blend layers, sprites, and fixed color.

## Color Math Modes

### Add Mode
- **Formula**: Result = Source + Destination
- **Use**: Brightening, glow effects

### Subtract Mode
- **Formula**: Result = Source - Destination
- **Use**: Darkening, shadow effects

## Color Math Registers

- **CGWSEL** ($2130): Color math window settings
- **CGADSUB** ($2131): Color math enable (per layer)
- **COLDATA** ($2132): Fixed color data

## CGADSUB Bits

```
Bit 7: Half color (divide by 2)
Bit 6: Add/sub mode (0 = add, 1 = subtract)
Bits 5-0: Enable color math (bit per layer/sprite)
```

## Fixed Color

COLDATA ($2132) provides a fixed color for color math:
- **Bits 0-4**: Blue component (0-31)
- **Bits 5-9**: Green component (0-31)
- **Bits 10-14**: Red component (0-31)

## Color Math Example

```asm
; Enable color math on BG1
lda #%00000001      ; Enable BG1
sta CGADSUB         ; $2131

; Set to add mode
lda #%00000000      ; Add mode (bit 6 = 0)
sta CGWSEL          ; $2130

; Set fixed color (white)
lda #$1F            ; Red = 31
sta COLDATA         ; $2132
lda #$E0            ; Green = 31, Blue = 31
sta COLDATA         ; $2132
```

## Cross-References

- [PPU Registers](../../references/ppu-register-map.md) - Color math register map
- [HDMA Effects](../../techniques/hdma-effects/per-scanline-colors.md) - Per-scanline color changes
