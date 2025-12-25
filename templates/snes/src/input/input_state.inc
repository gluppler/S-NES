; ============================================================================
; Input State Definitions
; ============================================================================
; SNES controller state variables
; ============================================================================

.ifndef SNES_INPUT_STATE_INC
SNES_INPUT_STATE_INC = 1

.segment "ZEROPAGE"
joypad1_current:  .res 2  ; Current frame button state (16-bit)
joypad1_previous: .res 2  ; Previous frame button state (16-bit)
joypad1_triggered: .res 2 ; Newly pressed buttons (16-bit)
joypad1_held:     .res 2  ; Held buttons (16-bit)

.endif ; SNES_INPUT_STATE_INC
