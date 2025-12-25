; ============================================================================
; Controller Input
; ============================================================================
; SNES auto-joypad reading
; See ../../docs/snes/programming/input/auto-joypad.md
; ============================================================================

.p816
.export read_controllers
.smart
.include "../headers/snes_registers.inc"
.include "../headers/snes_controller.inc"
.include "input_state.inc"

.segment "CODE"

; ============================================================================
; Read Controllers
; ============================================================================
; Reads controllers using SNES auto-joypad feature
; See ../../docs/snes/programming/input/auto-joypad.md
; ============================================================================
.proc read_controllers
    ; Wait for auto-joypad to complete
wait_ready:
    lda HVBJOY       ; $4212: H/V blank and joypad status
    and #$01         ; Bit 0 = auto-joypad ready (0 = in progress, 1 = complete)
    beq wait_ready
    
    ; Read controller 1 data
    rep #$20         ; 16-bit accumulator
    lda JOY1L        ; $4218: Controller 1 data (low byte)
    sta joypad1_current
    
    ; Calculate triggered (pressed this frame, not last frame)
    lda joypad1_previous
    eor joypad1_current    ; XOR: changed buttons
    and joypad1_current     ; AND: only newly pressed
    sta joypad1_triggered
    
    ; Calculate held (pressed both frames)
    lda joypad1_previous
    and joypad1_current
    sta joypad1_held
    
    ; Update previous
    lda joypad1_current
    sta joypad1_previous
    sep #$20
    
    rts
.endproc
