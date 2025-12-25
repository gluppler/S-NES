; ============================================================================
; State Machine
; ============================================================================
; SNES hardware behavior: Game state management
; ============================================================================

.include "memory/zeropage.inc"
.include "memory/ram.inc"
.include "state/state_ids.inc"

; ============================================================================
; Initialize Game State
; ============================================================================
init_game_state:
    LDA #STATE_TITLE
    STA game_state
    LDA #1
    STA level_number
    LDA #3
    STA lives
    LDA #0
    STA score
    STA score_high
    STA score_mid
    STA score_highest
    STA frame_counter
    STA frame_ready
    STA scroll_x
    STA scroll_y
    LDA #%10000000
    STA ppu_ctrl
    RTS

; ============================================================================
; Update Game State
; ============================================================================
update_game_state:
    LDA game_state
    CMP #STATE_TITLE
    BEQ update_title_state
    CMP #STATE_PLAYING
    BEQ update_playing_state
    CMP #STATE_PAUSED
    BEQ update_paused_state
    CMP #STATE_GAME_OVER
    BEQ update_game_over_state
    LDA #STATE_TITLE
    STA game_state
    RTS

update_title_state:
    RTS

update_playing_state:
    RTS

update_paused_state:
    RTS

update_game_over_state:
    RTS
