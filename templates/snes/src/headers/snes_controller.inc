; ============================================================================
; SNES Controller Constants
; ============================================================================
; SNES auto-joypad and button definitions
; ============================================================================

.ifndef SNES_CONTROLLER_INC
SNES_CONTROLLER_INC = 1

; Auto-Joypad Registers
HVBJOY     = $4212   ; H/V blank and joypad status
JOY1L      = $4218   ; Joypad 1 data (low)
JOY1H      = $4219   ; Joypad 1 data (high)
JOY2L      = $421A   ; Joypad 2 data (low)
JOY2H      = $421B   ; Joypad 2 data (high)

; Button Masks (Active-Low: 0 = pressed, 1 = not pressed)
BUTTON_B      = %1000000000000000
BUTTON_Y      = %0100000000000000
BUTTON_SELECT = %0010000000000000
BUTTON_START  = %0001000000000000
BUTTON_UP     = %0000100000000000
BUTTON_DOWN   = %0000010000000000
BUTTON_LEFT   = %0000001000000000
BUTTON_RIGHT  = %0000000100000000
BUTTON_A      = %0000000010000000
BUTTON_X      = %0000000001000000
BUTTON_L      = %0000000000100000
BUTTON_R      = %0000000000010000

.endif ; SNES_CONTROLLER_INC
