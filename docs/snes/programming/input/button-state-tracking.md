# Button State Tracking

## Overview

SNES games typically track three button states: current, triggered (newly pressed), and held (continuously pressed).

## Button States

### Current State
- **Current frame**: What buttons are pressed now
- **Read from**: STDCNTRL1L/H ($4218/$4219)

### Triggered State
- **Newly pressed**: Buttons pressed this frame, not last frame
- **Use for**: One-time actions (jump, select menu item)

### Held State
- **Continuously pressed**: Buttons pressed both this frame and last frame
- **Use for**: Continuous actions (movement, rapid fire)

## Implementation

```asm
.segment "ZEROPAGE"
joypad1_current:  .res 2  ; Current frame
joypad1_previous: .res 2  ; Previous frame
joypad1_triggered: .res 2 ; Newly pressed
joypad1_held:     .res 2  ; Held buttons

.proc update_button_states
    ; Read current
    rep #$20
    lda STDCNTRL1L
    sta joypad1_current
    
    ; Calculate triggered (pressed this frame, not last)
    lda joypad1_previous
    eor joypad1_current    ; Changed buttons
    and joypad1_current    ; Only newly pressed
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
```

## Usage

```asm
; Check for jump (triggered)
rep #$20
lda joypad1_triggered
and #BUTTON_A
beq no_jump
    jsr player_jump
no_jump:

; Check for movement (held)
lda joypad1_held
and #BUTTON_RIGHT
beq no_move_right
    jsr move_right
no_move_right:
sep #$20
```

## Cross-References

- [Auto-Joypad](auto-joypad.md) - Reading controller data
- [Input Pipeline](../input-pipeline.md) - Complete input system
