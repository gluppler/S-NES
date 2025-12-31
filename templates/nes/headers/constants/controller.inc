; ============================================================================
; Controller Constants
; ============================================================================
; Per NES documentation: Controller register addresses and constants
; ============================================================================

; Controller registers
CONTROLLER1 = $6     ; Controller 1 shift register
CONTROLLER2 = $7     ; Controller 2 shift register

; Button indices (for accessing controller arrays)
BUTTON_A = 0
BUTTON_B = 1
BUTTON_SELECT = 2
BUTTON_START = 3
BUTTON_UP = 4
BUTTON_DOWN = 5
BUTTON_LEFT = 6
BUTTON_RIGHT = 7

; Controller state addresses
controller1_buttons = $0300      ; Controller 1 button states (8 bytes)
controller1_pressed = $0308     ; Controller 1 pressed this frame (8 bytes)
controller1_released = $0310    ; Controller 1 released this frame (8 bytes)
controller1_prev = $0318        ; Controller 1 previous frame state (8 bytes)
