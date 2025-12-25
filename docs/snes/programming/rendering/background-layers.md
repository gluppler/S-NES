# Background Layers

## Overview

SNES supports up to **4 background layers** (depending on mode). Each layer can be independently configured.

## Background Configuration

### Tilemap Address

```asm
lda #$60            ; Nametable at $6000
sta BG1SC           ; $2107: BG1 tilemap address
```

### Tile Address

```asm
lda #$00            ; Tiles at $0000
sta BG12NBA         ; $210B: BG1/BG2 tile address
```

### Scroll Position

```asm
; Set BG1 scroll (dual-write)
rep #$20
lda scroll_x
sta BG1HOFS         ; $210D: Write low byte
sep #$20
sta BG1HOFS         ; $210D: Write high byte (dual-write)
rep #$20
lda scroll_y
sta BG1VOFS         ; $210E: Write low byte
sep #$20
sta BG1VOFS         ; $210E: Write high byte (dual-write)
```

## Layer Priority

Backgrounds have priority order:
- **BG4**: Highest priority (if enabled)
- **BG3**: High priority
- **BG2**: Medium priority
- **BG1**: Low priority

## Layer Enables

```asm
lda #TM_BG1 | TM_BG2  ; Enable BG1 and BG2
sta TM                 ; $212C: Main screen
```

## Cross-References

- [Background Modes](../../hardware/ppu/background-modes.md) - Background mode details
- [PPU Initialization](../initialization/ppu-init.md) - PPU setup
