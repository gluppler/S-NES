# Windowing System

## Overview

SNES has a **windowing system** that can mask layers, sprites, and color math on a per-pixel basis.

## Window Components

- **Two windows**: Window 1 and Window 2
- **Per-layer masking**: Each background and sprite layer can use windows
- **Window logic**: OR, AND, XOR, XNOR

## Window Registers

### Window Positions

- **WH0** ($2126): Window 1 left position
- **WH1** ($2127): Window 1 right position
- **WH2** ($2128): Window 2 left position
- **WH3** ($2129): Window 2 right position

### Window Masks

- **W12SEL** ($2123): Window mask settings (BG1/BG2)
- **W34SEL** ($2124): Window mask settings (BG3/BG4)
- **WOBJSEL** ($2125): Window mask settings (sprites)

### Window Logic

- **WBGLOG** ($212A): Window logic (backgrounds)
- **WOBJLOG** ($212B): Window logic (sprites)

## Window Logic Modes

| Value | Logic |
|-------|-------|
| 0 | OR (inside window 1 OR window 2) |
| 1 | AND (inside window 1 AND window 2) |
| 2 | XOR (inside window 1 XOR window 2) |
| 3 | XNOR (inside window 1 XNOR window 2) |

## Window Usage

### Enable Window on Layer

```asm
; Enable window on BG1
lda #%00000010      ; Window 1 on BG1
sta W12SEL          ; $2123
lda #%00000010      ; Enable window on BG1
sta TMW              ; $212E: Window main screen
```

### Set Window Position

```asm
lda #$10            ; Left = 16
sta WH0             ; $2126
lda #$F0            ; Right = 240
sta WH1             ; $2127
```

## Cross-References

- [PPU Registers](../../references/ppu-register-map.md) - Window register map
- [HDMA Effects](../../techniques/hdma-effects/window-effects.md) - Per-scanline windowing
