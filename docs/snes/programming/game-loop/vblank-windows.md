# VBlank Windows

## Overview

VBlank (Vertical Blanking) is the period when the PPU is not rendering. This is the **only safe time** to access VRAM, CGRAM, and OAM.

## VBlank Timing

### NTSC
- **Start**: Scanline 225
- **Duration**: 38 scanlines
- **CPU Cycles**: ~1,364 cycles
- **End**: Before scanline 1 (next frame)

### PAL
- **Start**: Scanline 240
- **Duration**: 73 scanlines
- **CPU Cycles**: ~2,620 cycles
- **End**: Before scanline 1 (next frame)

## Safe Operations During VBlank

### VRAM Access
- **Reading**: Safe during VBlank
- **Writing**: Safe during VBlank (or forced blanking)
- **DMA**: Safe during VBlank

### CGRAM Access
- **Reading**: Safe during VBlank
- **Writing**: Safe during VBlank (or forced blanking)
- **DMA**: Safe during VBlank

### OAM Access
- **Reading**: Safe during VBlank
- **Writing**: Safe during VBlank (or forced blanking)
- **DMA**: Safe during VBlank (standard method)

### PPU Registers
- **Most registers**: Safe during VBlank or H-Blank
- **Scroll registers**: Safe during VBlank or H-Blank
- **Mode 7 registers**: Safe during VBlank or H-Blank

## Unsafe Operations During Rendering

**DO NOT** access VRAM/CGRAM/OAM during rendering:
- Causes visual corruption
- Incorrect data
- Hardware glitches

## Forced Blanking

You can disable rendering to access PPU memory anytime:

```asm
; Enable forced blanking
lda #$80        ; Bit 7 = forced blanking
sta INIDISP     ; $2100

; Now safe to access VRAM/CGRAM/OAM
; ... VRAM/CGRAM/OAM access ...

; Disable forced blanking
lda #$0F        ; Brightness = 15, forced blank off
sta INIDISP
```

## VBlank Detection

### Using NMI

```asm
; NMI fires at start of VBlank
.proc nmi_handler
    lda RDNMI    ; Acknowledge NMI
    ; Now in VBlank - safe to access PPU
    rti
.endproc
```

### Using HVBJOY

```asm
; Check VBlank flag
wait_vblank:
    lda HVBJOY   ; $4212
    and #$80     ; Bit 7 = VBlank flag
    beq wait_vblank
    ; Now in VBlank
```

## VBlank Budget

### NTSC VBlank Budget
- **Total**: ~1,364 cycles
- **OAM DMA**: ~1,090 cycles (544 bytes)
- **Remaining**: ~274 cycles for other tasks

### Common VBlank Tasks
1. **OAM DMA**: ~1,090 cycles (required)
2. **Scroll updates**: ~20-40 cycles
3. **PPU register updates**: ~10-20 cycles
4. **Other updates**: Remaining cycles

## Cross-References

- [NMI Handler](nmi-handler.md) - VBlank interrupt handling
- [Frame Synchronization](frame-synchronization.md) - Frame timing
- [PPU Rendering Rules](../../hardware/ppu/ppu-rendering-rules.md) - Detailed PPU access rules
