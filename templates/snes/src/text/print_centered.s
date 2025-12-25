; ============================================================================
; Centered Text Printing
; ============================================================================
; Print text centered on screen
; ============================================================================

.include "memory/zeropage.inc"
.include "constants/ppu.inc"
.include "text/font_map.inc"
.include "text/print.s"

; ============================================================================
; Write Text at Position
; ============================================================================
; Input: A = row (0-29), X = column (0-31), text_ptr = text string
; ============================================================================
write_text_at:
    PHA
    TXA
    PHA
    PLA
    STA zp_temp
    PLA
    TAY
    LDA row_address_table,Y
    CLC
    ADC zp_temp
    TAX
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    TXA
    STA PPUADDR
    JSR write_text
    RTS
