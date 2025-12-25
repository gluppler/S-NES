; ============================================================================
; WRAM Memory Map
; ============================================================================
; SNES Work RAM (128 KB) organization
; WRAM is located at $7E0000-$7FFFFF
; See ../../docs/snes/hardware/memory/wram-organization.md
; ============================================================================

.ifndef SNES_WRAM_MAP_INC
SNES_WRAM_MAP_INC = 1

; WRAM Base
WRAM_BASE = $7E0000
WRAM_SIZE = $20000      ; 128 KB

; OAM Mirror (for sprite data)
OAM_MIRROR = $7E0400    ; 512 bytes sprite data
OAM_HI_MIRROR = $7E0600 ; 32 bytes size/priority table

; Game Variables
GAME_VARS = $7E1000     ; Game-specific variables

; Sprite Buffer
SPRITE_BUFFER = $7E2000 ; Sprite rendering buffer

; Background Buffer
BG_BUFFER = $7E3000     ; Background rendering buffer

; ADD CODE HERE: Your WRAM variables
; Recommended: Use $7E1000-$7EFFFF for game data

.endif ; SNES_WRAM_MAP_INC
