; ============================================================================
; WRAM Memory Definitions
; ============================================================================
; SNES WRAM organization ($7E0000-$7FFFFF, 128 KB)
; See ../../docs/snes/hardware/memory/wram-organization.md
; ============================================================================

.ifndef SNES_RAM_INC
SNES_RAM_INC = 1

; WRAM Base
WRAM_BASE = $7E0000
WRAM_SIZE = $20000        ; 128 KB

; Game state variables (in WRAM)
game_state = $7E1000      ; Current game state
level_number = $7E1001    ; Current level number
lives = $7E1002           ; Player lives
score = $7E1003           ; Score (low byte)
score_high = $7E1004      ; Score (high byte)

; ADD CODE HERE: Your WRAM variables
; Recommended: Use $7E1000-$7EFFFF for game data

.endif ; SNES_RAM_INC
