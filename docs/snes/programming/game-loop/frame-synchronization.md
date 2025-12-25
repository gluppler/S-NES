# Frame Synchronization

## Overview

SNES games must synchronize with the video frame rate (60.098 Hz NTSC, 50.007 Hz PAL). This is done using the WAI instruction and NMI handler.

## Frame Timing

### NTSC
- **Frame Rate**: 60.098 Hz
- **Frame Duration**: ~21,477 CPU cycles
- **VBlank Duration**: ~1,364 cycles (38 scanlines)

### PAL
- **Frame Rate**: 50.007 Hz
- **Frame Duration**: ~21,200 CPU cycles
- **VBlank Duration**: ~2,620 cycles (73 scanlines)

## WAI Instruction

The **WAI** (Wait for Interrupt) instruction pauses the CPU until an interrupt occurs:

```asm
game_loop:
    wai              ; Wait for NMI (VBlank)
    ; Game logic here
    jmp game_loop
```

**WAI**:
- Pauses CPU execution
- Waits for NMI, IRQ, or reset
- Resumes after interrupt handler completes

## Frame Synchronization Pattern

```asm
.proc main
  ; ... initialization code ...

forever:
  ; Wait for NMI (VBlank)
  jsl ppu_vsync      ; Wait for start of vertical blanking

  ; Game logic (runs during visible period)
  jsl move_player
  jsl draw_player_sprite

  ; Update OAM during VBlank
  jsl ppu_copy_oam
  seta8
  lda #$0F
  sta PPUBRIGHT      ; turn on rendering

  ; Wait for control reading to finish
  lda #$01
padwait:
  bit VBLSTATUS      ; $4212: Check auto-joypad status
  bne padwait

  ; Update scroll position (during VBlank)
  stz BGSCROLLX
  stz BGSCROLLX      ; Write twice (dual-write register)

  jmp forever
.endproc
```

### VBlank Wait Pattern

```asm
.proc ppu_vsync
  php
  seta8
loop1:
  bit VBLSTATUS      ; Wait for leaving previous vblank
  bmi loop1
loop2:
  bit VBLSTATUS      ; Wait for start of this vblank
  bpl loop2
  plp
  rtl
.endproc
```

## NMI Handler

NMI fires at start of VBlank:

```asm
.proc nmi_handler
    ; Acknowledge NMI
    lda RDNMI        ; $4210: Read NMI status (acknowledges)
    
    ; VBlank tasks (must complete quickly)
    jsr update_oam_dma
    jsr update_scroll
    
    rti
.endproc
```

## Frame Budget

### Visible Period
- **Duration**: ~20,113 cycles (NTSC)
- **Available for**: Game logic, calculations, updates

### VBlank Period
- **Duration**: ~1,364 cycles (NTSC)
- **Available for**: OAM DMA, scroll updates, PPU register writes
- **Must complete**: Before rendering starts

## Common Mistakes

### Not Using WAI
```asm
; ❌ BAD: Busy loop (wastes CPU, no frame sync)
game_loop:
    jsr update_game
    jmp game_loop
```

### Long NMI Handler
```asm
; ❌ BAD: NMI handler too long
nmi_handler:
    ; ... 2000+ cycles of code ...
    rti  ; May delay main loop
```

### Correct Pattern
```asm
; ✅ GOOD: WAI for frame sync
game_loop:
    wai              ; Wait for VBlank
    jsr update_game  ; Game logic
    jmp game_loop

nmi_handler:
    lda RDNMI        ; Acknowledge
    jsr update_oam   ; Quick VBlank tasks
    rti
```

## Cross-References

- [NMI Handler](nmi-handler.md) - VBlank interrupt handling
- [VBlank Windows](vblank-windows.md) - Safe PPU access periods
- [CPU Timing](../../hardware/cpu-65816/cpu-timing.md) - Cycle timing details
