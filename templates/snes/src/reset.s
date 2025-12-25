; ============================================================================
; Reset Handler
; ============================================================================
; SNES hardware initialization sequence
; See ../../docs/snes/programming/initialization/cpu-init.md
; See ../../docs/snes/programming/initialization/ppu-init.md
; ============================================================================

.p816
.export reset_handler
.import main
.import cpu_init, ppu_init, spc700_init
.include "headers/snes_registers.inc"
.include "headers/snes_constants.inc"

.segment "CODE"

; ============================================================================
; Reset Handler
; ============================================================================
; Entry point from SNES reset vector
; ============================================================================
.proc reset_handler
    ; Switch to native mode
    clc
    xce              ; Exchange carry with emulation flag
    
    ; Set register widths
    rep #$10         ; 16-bit X, Y
    sep #$20         ; 8-bit A
    
    ; Initialize CPU
    jsr cpu_init
    
    ; Initialize PPU (with forced blanking)
    jsr ppu_init
    
    ; Clear WRAM (optional, but recommended)
    ; ... WRAM clearing code ...
    
    ; Clear VRAM/CGRAM/OAM (during forced blanking)
    ; ... VRAM/CGRAM/OAM clearing code ...
    
    ; Boot SPC700 (if using audio)
    ; jsr spc700_init
    
    ; Load game assets (VRAM, CGRAM, etc.)
    ; ... asset loading code ...
    
    ; Enable display
    lda #TM_BG1      ; Enable BG1
    sta TM
    lda #$0F         ; Full brightness
    sta INIDISP      ; Disable forced blanking
    
    ; Enable NMI and auto-joypad
    lda #$81         ; NMI enable (bit 7) + auto-joypad (bit 0)
    sta NMITIMEN
    
    ; Jump to main game loop
    jmp main
.endproc
