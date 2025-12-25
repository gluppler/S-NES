; ============================================================================
; Text Printing
; ============================================================================
; Per NES documentation: Text rendering to name table
; ============================================================================

.include "memory/zeropage.inc"
.include "constants/ppu.inc"
.include "text/font_map.inc"

text_ptr = $02          ; 16-bit pointer for text data

; ============================================================================
; Write Text String
; ============================================================================
.export write_text
write_text:
    LDY #0
write_text_loop:
    LDA (text_ptr),Y
    BEQ write_text_done
    JSR char_to_tile
    STA PPUDATA
    INY
    CPY #32
    BCC write_text_loop
write_text_done:
    RTS

; ============================================================================
; Character to Tile Index Conversion
; ============================================================================
.export char_to_tile
char_to_tile:
    CMP #32
    BCC char_invalid
    CMP #123
    BCS char_invalid
    SEC
    SBC #32
    TAX
    LDA char_to_tile_table,X
    RTS

char_invalid:
    LDA #0
    RTS
