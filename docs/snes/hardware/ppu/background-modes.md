# SNES Background Modes

## Overview

The SNES PPU supports **8 background modes** (0-7), each with different tile formats, layer counts, and capabilities.

## Mode Comparison

| Mode | Layers | Tile Formats | Colors | Notes |
|------|--------|--------------|--------|-------|
| 0 | 4 BGs | 2bpp | 4 per BG | Standard mode |
| 1 | 3 BGs | 4bpp + 2bpp | 16 + 4 | Mixed formats |
| 2 | 2 BGs | 4bpp | 16 per BG | High color |
| 3 | 2 BGs | 8bpp + 4bpp | 256 + 16 | High color + standard |
| 4 | 2 BGs | 8bpp + 2bpp | 256 + 4 | High color + standard |
| 5 | 2 BGs | 4bpp | 16 per BG | 512×448 resolution |
| 6 | 1 BG | 4bpp | 16 | 512×448 resolution |
| 7 | 1 BG | 8bpp | 256 | Affine transformation |

## Mode 0: 4 Backgrounds, 2bpp

**Most Common Mode**

- **Layers**: 4 backgrounds
- **Tile Format**: 2 bits per pixel (4 colors per tile)
- **Palettes**: 8 palettes per BG (32 colors total per BG)
- **Use Case**: Standard platformers, RPGs

### Configuration

```asm
STZ BGMODE  ; Mode 0
LDA #$00    ; 8x8 tiles for all layers
STA BGMODE
```

## Mode 1: 3 Backgrounds, Mixed Formats

- **Layers**: 3 backgrounds
- **BG1/BG2**: 4bpp (16 colors)
- **BG3**: 2bpp (4 colors)
- **Use Case**: Games needing more colors on some layers

## Mode 2: 2 Backgrounds, 4bpp

- **Layers**: 2 backgrounds
- **Tile Format**: 4 bits per pixel (16 colors per tile)
- **Use Case**: High-color backgrounds

## Mode 3: 2 Backgrounds, 8bpp + 4bpp

- **Layers**: 2 backgrounds
- **BG1**: 8bpp (256 colors)
- **BG2**: 4bpp (16 colors)
- **Use Case**: Mode 7-like effects with additional layer

## Mode 4: 2 Backgrounds, 8bpp + 2bpp

- **Layers**: 2 backgrounds
- **BG1**: 8bpp (256 colors)
- **BG2**: 2bpp (4 colors)
- **Use Case**: High-color main BG with simple overlay

## Mode 5: 2 Backgrounds, 512×448 Resolution

- **Layers**: 2 backgrounds
- **Tile Format**: 4bpp (16 colors)
- **Resolution**: 512×448 (interlaced)
- **Use Case**: High-resolution games

## Mode 6: 1 Background, 512×448 Resolution

- **Layers**: 1 background
- **Tile Format**: 4bpp (16 colors)
- **Resolution**: 512×448 (interlaced)
- **Use Case**: High-resolution single-layer games

## Mode 7: Affine Transformation

**Unique SNES Feature**

- **Layers**: 1 background
- **Tile Format**: 8bpp (256 colors)
- **Special**: Real-time rotation, scaling, shearing
- **Use Case**: Mode 7 games (F-Zero, Super Mario Kart)

### Mode 7 Matrix

Mode 7 uses a 2×2 transformation matrix:

```
[ A  B ]   [ X ]   [ X' ]
[ C  D ] × [ Y ] = [ Y' ]
```

Registers:
- **M7A** ($211B): Matrix A (dual-write)
- **M7B** ($211C): Matrix B (dual-write)
- **M7C** ($211D): Matrix C (dual-write)
- **M7D** ($211E): Matrix D (dual-write)
- **M7X** ($211F): Scroll X (dual-write)
- **M7Y** ($2120): Scroll Y (dual-write)

### Mode 7 Setup

```asm
LDA #$07
STA BGMODE  ; Mode 7

; Set identity matrix [1.0 0.0; 0.0 1.0]
STZ M7A
LDA #$01
STA M7A     ; A = 1.0 (dual-write)
STZ M7B
STZ M7B     ; B = 0.0
STZ M7C
STZ M7C     ; C = 0.0
STZ M7D
LDA #$01
STA M7D     ; D = 1.0 (dual-write)
```

## Tile Size Control

Each mode supports different tile sizes:
- **8×8 pixels**: Standard tiles
- **16×16 pixels**: Large tiles (modes 0-6)
- **8×8 pixels**: Mode 7 always uses 8×8

### Setting Tile Size

```asm
LDA BGMODE
AND #%11111000  ; Clear tile size bits
ORA #%00000100  ; Set BG1 to 16×16
STA BGMODE
```

## Background Priority

Backgrounds have priority order:
- **BG4**: Highest priority (if enabled)
- **BG3**: High priority
- **BG2**: Medium priority
- **BG1**: Low priority
- **Sprites**: Variable priority

## Cross-References

- [Mode 7 Math](mode-7-math.md) - Detailed Mode 7 mathematics
- [Tile Formats](tile-formats.md) - 2bpp, 4bpp, 8bpp encoding
- [PPU Initialization](../../programming/initialization/ppu-init.md) - Setting up backgrounds
