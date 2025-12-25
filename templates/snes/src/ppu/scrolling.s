; ============================================================================
; Background Scrolling
; ============================================================================
; SNES background scroll register management
; See ../../docs/snes/programming/rendering/background-layers.md
; ============================================================================

.p816
.export update_scroll
.include "../headers/snes_registers.inc"
.include "../headers/snes_constants.inc"
.include "../headers/memory/direct_page.inc"

.segment "CODE"

; ============================================================================
; Update Scroll
; ============================================================================
; Updates BG1 scroll registers
; Scroll registers are dual-write (low byte, then high byte)
; ============================================================================
.proc update_scroll
    ; Update BG1 horizontal scroll (dual-write)
    rep #$20
    lda scroll_x
    sta BG1HOFS       ; $210D: Write low byte
    sep #$20
    sta BG1HOFS       ; $210D: Write high byte (dual-write)
    
    ; Update BG1 vertical scroll (dual-write)
    rep #$20
    lda scroll_y
    sta BG1VOFS       ; $210E: Write low byte
    sep #$20
    sta BG1VOFS       ; $210E: Write high byte (dual-write)
    
    rts
.endproc
