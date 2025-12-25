; ============================================================================
; Sprite Definitions
; ============================================================================
; SNES sprite constants and definitions
; ============================================================================

.ifndef SNES_SPRITE_DEFS_INC
SNES_SPRITE_DEFS_INC = 1

; Sprite structure (4 bytes per sprite in OAM)
SPRITE_BYTE_Y = 0       ; Y position
SPRITE_BYTE_TILE = 1    ; Tile index
SPRITE_BYTE_ATTR = 2    ; Attributes
SPRITE_BYTE_X = 3       ; X position

; Sprite attribute bits
SPRITE_PALETTE_MASK = %00000011
SPRITE_PRIORITY = %00100000      ; Behind background
SPRITE_FLIP_H = %01000000        ; Flip horizontally
SPRITE_FLIP_V = %10000000        ; Flip vertically

; Sprite sizes (set in OBSEL register)
SPRITE_SIZE_8_16 = %00000000     ; 8×8 and 16×16
SPRITE_SIZE_8_32 = %00100000     ; 8×8 and 32×32
SPRITE_SIZE_8_64 = %01000000     ; 8×8 and 64×64
SPRITE_SIZE_16_32 = %01100000    ; 16×16 and 32×32
SPRITE_SIZE_16_64 = %10000000    ; 16×16 and 64×64
SPRITE_SIZE_32_64 = %10100000    ; 32×32 and 64×64

.endif ; SNES_SPRITE_DEFS_INC
