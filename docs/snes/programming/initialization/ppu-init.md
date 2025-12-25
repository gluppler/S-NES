# PPU Initialization

## Complete S-PPU Initialization Sequence

The SNES PPU (S-PPU) must be initialized before rendering. All PPU registers must be written to establish a known state.

## Initialization Requirements

> A valid Super NES program must write to all writable ports in the S-CPU I/O and S-PPU at the start of a program. This way, the machine starts in a known state.

## Step-by-Step Initialization

### 1. Enable Forced Blanking

```asm
    LDA #$80     ; Bit 7 = forced blanking, brightness = 0
    STA INIDISP  ; $2100
```

**Critical**: PPU must be disabled (forced blanking) before VRAM/CGRAM/OAM access.

### 2. Initialize Sprite System

```asm
    STZ OBSEL    ; $2101: Sprites 8x8/16x16, patterns at $0000
    STZ OAMADDL  ; $2102: OAM address low
    STZ OAMADDH  ; $2103: OAM address high
```

### 3. Set Background Mode

```asm
    STZ BGMODE   ; $2105: Mode 0, 8x8 tiles, no mosaic
```

**Mode 0**: 4 backgrounds, 2bpp (4 colors per tile)

### 4. Initialize Background Tilemaps

```asm
    STZ NTADDR+0 ; $2107: BG1 nametable at $0000, 1x1 screen
    STZ NTADDR+1 ; $2108: BG2 nametable at $0000, 1x1 screen
    STZ NTADDR+2 ; $2109: BG3 nametable at $0000, 1x1 screen
    STZ NTADDR+3 ; $210A: BG4 nametable at $0000, 1x1 screen
```

### 5. Initialize Background Tiles

```asm
    STZ BGCHRADDR ; $210B: BG1/BG2 tiles at $0000
    STZ BGCHRADDR+1 ; $210C: BG3/BG4 tiles at $0000
```

### 6. Initialize Scroll Registers

```asm
    ; BG1 scroll (double-write registers)
    STZ BGSCROLLX+0 ; $210D: BG1 X scroll low
    STZ BGSCROLLX+0 ; $210D: BG1 X scroll high (write twice)
    STZ BGSCROLLY+0 ; $210E: BG1 Y scroll low
    STZ BGSCROLLY+0 ; $210E: BG1 Y scroll high (write twice)
    
    ; Repeat for BG2, BG3, BG4 ($210F-$2114)
```

**Note**: Scroll registers are double-write (low byte, then high byte).

### 7. Initialize VRAM Address

```asm
    LDA #$80     ; Increment by 1 word after high byte write
    STA VMAINC   ; $2115
    STZ VMADDL   ; $2116: VRAM address low
    STZ VMADDH   ; $2117: VRAM address high
```

### 8. Initialize Mode 7 Matrix

```asm
    ; Set to identity matrix [1.0 0.0; 0.0 1.0]
    STZ M7A      ; $211B: Matrix A low
    LDA #$01
    STA M7A      ; $211B: Matrix A high (write twice)
    STZ M7B      ; $211C: Matrix B (write twice)
    STZ M7C      ; $211D: Matrix C (write twice)
    STZ M7D      ; $211E: Matrix D low
    LDA #$01
    STA M7D      ; $211E: Matrix D high (write twice)
    STZ M7X      ; $211F: Scroll X (write twice)
    STZ M7Y      ; $2120: Scroll Y (write twice)
```

### 9. Initialize CGRAM

```asm
    STZ CGADD    ; $2121: CGRAM address = 0
```

### 10. Initialize Windowing

```asm
    STZ BG12WINDOW ; $2123: Disable windows on BG1/BG2
    STZ BG34WINDOW ; $2124: Disable windows on BG3/BG4
    STZ OBJWINDOW  ; $2125: Disable windows on sprites
    STZ W12SEL     ; $2126: Window 1 left = 0
    STZ W12SEL+1   ; $2127: Window 1 right = 0
    STZ W34SEL     ; $2128: Window 2 left = 0
    STZ W34SEL+1   ; $2129: Window 2 right = 0
    STZ WOBJSEL    ; $212A: Window logic
    STZ WOBJSEL+1  ; $212B: Window logic
```

### 11. Initialize Layer Enables

```asm
    STZ TM       ; $212C: Enable no layers on main screen
    STZ TS       ; $212D: Enable no layers on sub screen
    STZ TMW      ; $212E: Window main screen
    STZ TSW      ; $212F: Window sub screen
```

### 12. Initialize Color Math

```asm
    LDA #$30     ; Disable color math, disable direct color
    STA CGWSEL   ; $2130
    STZ CGADSUB  ; $2131: No color math for any layer
    LDA #$E0     ; Set COLDATA to 0 (all components)
    STA COLDATA  ; $2132
```

### 13. Initialize Display Settings

```asm
    STZ SETINI   ; $2133: Disable interlace, pseudo-hires, 224 lines
```

## Complete Initialization Example

```asm
.proc init_ppu
    ; Enable forced blanking
    LDA #$80
    STA INIDISP  ; $2100: Forced blank, brightness 0
    
    ; Initialize sprite system
    STZ OBSEL    ; $2101: Sprites 8x8/16x16, patterns at $0000
    STZ OAMADDL  ; $2102: OAM address low
    STZ OAMADDH  ; $2103: OAM address high
    
    ; Set background mode
    STZ BGMODE   ; $2105: Mode 0, 8x8 tiles, no mosaic
    
    ; Initialize background tilemaps
    STZ NTADDR+0 ; $2107: BG1 nametable at $0000, 1x1 screen
    STZ NTADDR+1 ; $2108: BG2 nametable at $0000, 1x1 screen
    STZ NTADDR+2 ; $2109: BG3 nametable at $0000, 1x1 screen
    STZ NTADDR+3 ; $210A: BG4 nametable at $0000, 1x1 screen
    
    ; Initialize background tiles
    STZ BGCHRADDR   ; $210B: BG1/BG2 tiles at $0000
    STZ BGCHRADDR+1 ; $210C: BG3/BG4 tiles at $0000
    
    ; Initialize scroll registers (double-write)
    ; BG1 scroll at (0, 1) - PPU skips first line
    STZ BGSCROLLX+0 ; $210D: BG1 X scroll low
    STZ BGSCROLLX+0 ; $210D: BG1 X scroll high (write twice)
    STZ BGSCROLLY+0 ; $210E: BG1 Y scroll low
    STZ BGSCROLLY+0 ; $210E: BG1 Y scroll high (write twice)
    
    ; Repeat for BG2, BG3, BG4 ($210F-$2114)
    .repeat 6, I
        STZ $210F+I
        STZ $210F+I
    .endrepeat
    
    ; Initialize VRAM address
    LDA #$80     ; Increment by 1 word after high byte write
    STA VMAINC   ; $2115
    STZ VMADDL   ; $2116: VRAM address low
    STZ VMADDH   ; $2117: VRAM address high
    
    ; Initialize Mode 7 matrix (identity matrix)
    ; [ 1.0  0.0 ]
    ; [ 0.0  1.0 ]
    STZ M7A      ; $211B: Matrix A low
    LDA #$01
    STA M7A      ; $211B: Matrix A high (write twice)
    STZ M7B      ; $211C: Matrix B (write twice)
    STZ M7B
    STZ M7C      ; $211D: Matrix C (write twice)
    STZ M7C
    STZ M7D      ; $211E: Matrix D low
    LDA #$01
    STA M7D      ; $211E: Matrix D high (write twice)
    STZ M7X      ; $211F: Scroll X (write twice)
    STZ M7X
    STZ M7Y      ; $2120: Scroll Y (write twice)
    STZ M7Y
    STZ M7SEL    ; $211A: Mode 7 settings
    
    ; Initialize CGRAM
    STZ CGADD    ; $2121: CGRAM address = 0
    
    ; Initialize windowing
    STZ BG12WINDOW ; $2123: Disable windows on BG1/BG2
    STZ BG34WINDOW ; $2124: Disable windows on BG3/BG4
    STZ OBJWINDOW  ; $2125: Disable windows on sprites
    STZ WINDOW1L   ; $2126: Window 1 left = 0
    STZ WINDOW1R   ; $2127: Window 1 right = 0
    STZ WINDOW2L   ; $2128: Window 2 left = 0
    STZ WINDOW2R   ; $2129: Window 2 right = 0
    STZ BGWINDOP   ; $212A: Window logic
    STZ OBJWINDOP  ; $212B: Window logic
    
    ; Initialize layer enables
    STZ BLENDMAIN  ; $212C: Enable no layers on main screen
    STZ BLENDSUB   ; $212D: Enable no layers on sub screen
    STZ WINDOWMAIN  ; $212E: Window main screen
    STZ WINDOWSUB   ; $212F: Window sub screen
    
    ; Initialize color math
    LDA #$30     ; Disable color math, disable direct color
    STA CGWSEL   ; $2130
    STZ CGADSUB  ; $2131: No color math for any layer
    LDA #$E0     ; Set COLDATA to 0 (all RGB components)
    STA COLDATA  ; $2132
    
    ; Initialize display settings
    STZ SETINI   ; $2133: Disable interlace, pseudo-hires, 224 lines
    
    ; PPU initialization complete
    RTS
.endproc
```


## Initialization Order

1. **Enable forced blanking** (INIDISP bit 7)
2. **Initialize all PPU registers** (establish known state)
3. **Load VRAM/CGRAM/OAM data** (during forced blanking)
4. **Configure display** (background mode, layers, etc.)
5. **Disable forced blanking** (after all setup complete)

## Critical Rules

- **Forced blanking must be enabled** before VRAM/CGRAM/OAM access
- **All writable registers must be written** to establish known state
- **Scroll registers are double-write** (low byte, then high byte)
- **Mode 7 matrix must be initialized** even if not using Mode 7

## Cross-References

- [CPU Initialization](cpu-init.md) - Must complete before PPU init
- [Background Modes](../../hardware/ppu/background-modes.md) - Understanding BGMODE
- [VRAM Management](../../programming/rendering/vram-management.md) - Loading tile data
- [OAM System](../../hardware/ppu/oam-system.md) - Sprite setup
