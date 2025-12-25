; ============================================================================
; Tilemap Loader
; ============================================================================
; SNES hardware behavior: Load tilemap to name table
; ============================================================================

.include "memory/zeropage.inc"
.include "constants/ppu.inc"
.include "tilemap/tilemap_defs.inc"

; ============================================================================
; Load Tilemap
; ============================================================================
; Input: A = high byte of tilemap address, X = low byte
; ============================================================================
load_tilemap:
    PHA
    TXA
    PHA
    LDA PPUSTATUS
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    PLA
    STA zp_ptr
    PLA
    STA zp_ptr+1
    LDY #0
    LDX #0
tilemap_loop:
    LDA (zp_ptr),Y
    STA PPUDATA
    INY
    BNE tilemap_loop
    INC zp_ptr+1
    INX
    CPX #3
    BNE tilemap_loop
    LDY #0
tilemap_remaining:
    LDA (zp_ptr),Y
    STA PPUDATA
    INY
    CPY #192
    BNE tilemap_remaining
    RTS
