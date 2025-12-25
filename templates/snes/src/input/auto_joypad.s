; ============================================================================
; Auto-Joypad Reading
; ============================================================================
; SNES hardware automatic controller polling
; See ../../docs/snes/programming/input/auto-joypad.md
; ============================================================================

.p816
.export read_auto_joypad
.smart
.include "../headers/snes_registers.inc"
.include "../headers/snes_constants.inc"
.include "input_state.inc"

.segment "CODE"

; ============================================================================
; Read Auto-Joypad
; ============================================================================
; Reads controller data using SNES auto-joypad feature
; See ../../docs/snes/programming/input/auto-joypad.md
; ============================================================================
.proc read_auto_joypad
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
