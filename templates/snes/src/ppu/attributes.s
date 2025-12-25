; ============================================================================
; CGRAM (Palette) Management
; ============================================================================
; SNES uses CGRAM (Color Generator RAM) instead of NES attribute tables
; ============================================================================

.p816
.export set_cgram_address, write_cgram_color
.include "../headers/snes_registers.inc"

.segment "CODE"

; ============================================================================
; Set CGRAM Address
; ============================================================================
; Sets CGRAM address for subsequent writes
; Input: A = CGRAM address (0-255)
; ============================================================================
.proc set_cgram_address
    sta CGADD        ; $2121: Set CGRAM address
    rts
.endproc

; ============================================================================
; Write CGRAM Color
; ============================================================================
; Writes color to CGRAM (dual-write: low byte, then high byte)
; Input: A = color low byte, X = color high byte
; ============================================================================
.proc write_cgram_color
    sta CGDATA       ; $2122: Write low byte
    txa
    sta CGDATA       ; $2122: Write high byte (dual-write)
    rts
.endproc
