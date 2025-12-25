; ============================================================================
; Sprite Buffer Definitions
; ============================================================================
; SNES sprite buffer state definitions
; ============================================================================

.ifndef SNES_SPRITE_BUFFER_INC
SNES_SPRITE_BUFFER_INC = 1

; Sprite state arrays are defined in memory/oam.inc
; sprite_x, sprite_y, sprite_tile, sprite_attr, sprite_active

; OAM mirror location
OAM_MIRROR = $7E0400      ; 512 bytes sprite data
OAM_HI_MIRROR = $7E0600   ; 32 bytes size/priority table

.endif ; SNES_SPRITE_BUFFER_INC
