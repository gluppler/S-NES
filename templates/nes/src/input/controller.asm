; ============================================================================
; Controller Input Library
; ============================================================================
; Per NES documentation: Controller reading via shift register
; Follows established patterns from hello-world example
; ============================================================================

.include "constants/controller.inc"
.include "input/input_state.inc"

; ============================================================================
; Read Controllers
; ============================================================================
; Per NES documentation: Controller reading via shift register
; Reads both controllers and calculates pressed/released states
; ============================================================================
.export read_controllers

read_controllers:
    ; Save registers
    PHA
    TXA
    PHA
    
    ; Strobe controller 1
    ; Per NES documentation: Set then clear strobe
    LDA #$01
    STA CONTROLLER1     ; Set strobe
    LDA #$00
    STA CONTROLLER1     ; Clear strobe
    
    ; Read 8 buttons for controller 1
    ; Per NES documentation: Read button state from bit 0
    LDX #0              ; Button index
read_controller1_loop:
    LDA CONTROLLER1     ; Read button state
    AND #$01            ; Isolate bit 0
    STA controller1_buttons,X  ; Store in RAM
    
    ; Calculate pressed/released states
    ; Pressed = current AND NOT previous
    ; Released = NOT current AND previous
    LDA controller1_prev,X  ; Previous state
    EOR #$01            ; Invert (for comparison)
    AND controller1_buttons,X  ; AND with current = pressed
    STA controller1_pressed,X
    
    LDA controller1_buttons,X  ; Current state
    EOR #$01            ; Invert
    AND controller1_prev,X  ; AND with previous = released
    STA controller1_released,X
    
    ; Update previous state
    LDA controller1_buttons,X
    STA controller1_prev,X
    
    INX
    CPX #8              ; 8 buttons total
    BNE read_controller1_loop
    
    ; Restore registers
    PLA
    TAX
    PLA
    RTS

; ============================================================================
; Check Button Pressed
; ============================================================================
; Check if button was pressed this frame
; Input: A = button index (BUTTON_A, BUTTON_B, etc.)
; Output: A = 1 if pressed, 0 if not
; ============================================================================
.export check_button_pressed
check_button_pressed:
    TAX                 ; Use X as index
    LDA controller1_pressed,X  ; Load pressed state
    RTS

; ============================================================================
; Check Button Held
; ============================================================================
; Check if button is currently held
; Input: A = button index (BUTTON_A, BUTTON_B, etc.)
; Output: A = 1 if held, 0 if not
; ============================================================================
.export check_button_held
check_button_held:
    TAX                 ; Use X as index
    LDA controller1_buttons,X  ; Load current state
    RTS

; ============================================================================
; Check Button Released
; ============================================================================
; Check if button was released this frame
; Input: A = button index (BUTTON_A, BUTTON_B, etc.)
; Output: A = 1 if released, 0 if not
; ============================================================================
.export check_button_released
check_button_released:
    TAX                 ; Use X as index
    LDA controller1_released,X  ; Load released state
    RTS
