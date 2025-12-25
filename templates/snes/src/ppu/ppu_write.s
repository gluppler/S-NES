; ============================================================================
; PPU Write Utilities
; ============================================================================
; SNES VRAM write utilities
; See ../../docs/snes/programming/rendering/vram-management.md
; ============================================================================

.p816
.export set_vram_address, write_vram_tile
.include "../headers/snes_registers.inc"

.segment "CODE"

; ============================================================================
; Set VRAM Address
; ============================================================================
; Sets VRAM address for subsequent writes
; Input: X = VRAM address (16-bit)
; ============================================================================
.proc set_vram_address
    stx VMADDL       ; $2116-$2117: Set VRAM address
    rts
.endproc

; ============================================================================
; Write Tile to VRAM
; ============================================================================
; Writes tile data to VRAM
; Input: A = tile data (low byte), X = tile data (high byte)
; Note: VMAINC must be set appropriately
; ============================================================================
.proc write_vram_tile
    sta VMDATAL      ; $2118: Write low byte
    txa
    sta VMDATAH      ; $2119: Write high byte (auto-increments if VMAINC bit 7 set)
    rts
.endproc
