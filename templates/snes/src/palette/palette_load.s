; ============================================================================
; Palette Loading
; ============================================================================
; Load palette data to SNES CGRAM
; See ../../docs/snes/programming/rendering/vram-management.md (CGRAM section)
; ============================================================================

.p816
.export load_palette
.include "../headers/snes_registers.inc"
.include "palette_data.s"

.segment "CODE"

; ============================================================================
; Load Palette
; ============================================================================
; Loads palette data to CGRAM
; Must be called during VBlank or forced blanking
; ============================================================================
.proc load_palette
    ; Set CGRAM address
    stz CGADD         ; $2121: CGRAM address = 0
    
    ; Load palette data (dual-write: low byte, then high byte)
    ldx #0
palette_loop:
    lda palette_data,x    ; Low byte
    sta CGDATA            ; $2122: Write low byte
    inx
    lda palette_data,x    ; High byte
    sta CGDATA            ; $2122: Write high byte (dual-write)
    inx
    cpx #32               ; 16 colors × 2 bytes = 32 bytes
    bne palette_loop
    
    rts
.endproc
