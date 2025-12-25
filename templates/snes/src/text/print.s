; ============================================================================
; Text Printing
; ============================================================================
; SNES text rendering to background nametable
; ============================================================================

.p816
.export write_text
.include "../headers/snes_registers.inc"
.include "../headers/memory/direct_page.inc"
.include "font_map.inc"

.segment "CODE"

; ============================================================================
; Write Text String
; ============================================================================
; Writes text string to VRAM nametable
; Input: X = VRAM nametable address, A = text pointer bank, Y = text pointer (low)
; ============================================================================
.proc write_text
    ; Set VRAM address
    stx VMADDL       ; $2116-$2117: Set VRAM address
    
    ; Set VMAINC for word increment
    lda #$80
    sta VMAINC      ; $2115: Increment by 1 word after high byte write
    
    ; Write text characters
    ldy #0
write_text_loop:
    lda (text_ptr),Y
    beq write_text_done
    jsr char_to_tile
    sta VMDATAL     ; $2118: Write tile index (low byte)
    stz VMDATAH     ; $2119: Write attributes (high byte, palette 0)
    iny
    cpy #32         ; Max 32 characters
    bcc write_text_loop
write_text_done:
    rts
.endproc

; ============================================================================
; Character to Tile Index
; ============================================================================
; Converts ASCII character to tile index
; Input: A = ASCII character
; Output: A = tile index
; ============================================================================
.proc char_to_tile
    cmp #32
    bcc char_invalid
    cmp #123
    bcs char_invalid
    sec
    sbc #32
    tax
    lda char_to_tile_table,x
    rts
char_invalid:
    lda #0
    rts
.endproc
