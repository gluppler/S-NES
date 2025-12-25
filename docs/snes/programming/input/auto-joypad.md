# Auto-Joypad Reading

## Overview

SNES has **hardware automatic controller polling**. The CPU enables auto-joypad, and the hardware automatically reads controllers during VBlank.

## Enabling Auto-Joypad

```asm
LDA #$81        ; Bit 7 = NMI enable, bit 0 = auto-joypad enable
STA NMITIMEN    ; $4200
```

## Reading Controller Data

### Wait for Completion

```asm
.proc read_joypad
    ; Wait for auto-joypad to complete
wait_ready:
    lda HVBJOY   ; $4212
    and #$01     ; Bit 0 = auto-joypad ready (0 = in progress, 1 = complete)
    beq wait_ready
    
    ; Read controller 1 data
    rep #$20     ; 16-bit accumulator
    lda STDCNTRL1L ; $4218: Controller 1 data (low byte)
    sta joypad1_data
    lda STDCNTRL1H ; $4219: Controller 1 data (high byte)
    sta joypad1_data+1
    sep #$20
    
    rts
.endproc
```

## Button Mapping

### 16-Bit Format

```
STDCNTRL1L ($4218):
  Bit 15: B
  Bit 14: Y
  Bit 13: Select
  Bit 12: Start
  Bit 11: Up
  Bit 10: Down
  Bit 9:  Left
  Bit 8:  Right

STDCNTRL1H ($4219):
  Bit 7:  A
  Bit 6:  X
  Bit 5:  L
  Bit 4:  R
  Bit 3-0: Unused
```

**Note**: Buttons are **active-low** (0 = pressed, 1 = not pressed)

## Button Constants

```asm
; Button masks (active-low, so 0 = pressed)
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
```

## Button State Tracking

### Triggered vs Held

```asm
.segment "ZEROPAGE"
joypad1_current:  .res 2  ; Current frame button state
joypad1_previous: .res 2  ; Previous frame button state
joypad1_triggered: .res 2 ; Newly pressed buttons
joypad1_held:     .res 2  ; Held buttons

.proc update_joypad_state
    ; Read current state
    rep #$20
    lda STDCNTRL1L
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
```

## Usage Example

```asm
.proc move_player
  ; Read controller using JOY1CUR_HI (upper 8 bits)
  ; This matches NES controller layout for easier porting
  setaxy8
  lda JOY1CUR_HI      ; $4219: Upper 8 bits of controller 1
  
  ; Check for right button
  and #KEY_HI_RIGHT   ; KEY_HI_RIGHT = .hibyte(KEY_RIGHT)
  beq notRight
  lda player_dxlo
  bmi notRight
  
    ; Right is pressed. Add to velocity
    clc
    adc #WALK_ACCEL
    cmp #WALK_SPD
    bcc :+
      lda #WALK_SPD
    :
    sta player_dxlo
    bra doneRight
  notRight:
    ; Right not pressed. Apply braking
    lda player_dxlo
    beq doneRight
    bmi :+
      sec
      sbc #WALK_BRAKE
      bcs :++
    :
      clc
      adc #WALK_BRAKE
    :
    sta player_dxlo
  doneRight:
  
  ; Similar logic for left button...
  
  rtl
.endproc
```

### Button Constants

```asm
KEY_B      = $8000
KEY_Y      = $4000
KEY_SELECT = $2000
KEY_START  = $1000
KEY_UP     = $0800
KEY_DOWN   = $0400
KEY_LEFT   = $0200
KEY_RIGHT  = $0100
KEY_A      = $0080
KEY_X      = $0040
KEY_L      = $0020
KEY_R      = $0010

; For 8-bit reads (JOY1CUR_HI):
KEY_HI_B      = .hibyte(KEY_B)
KEY_HI_Y      = .hibyte(KEY_Y)
KEY_HI_SELECT = .hibyte(KEY_SELECT)
KEY_HI_START  = .hibyte(KEY_START)
KEY_HI_UP     = .hibyte(KEY_UP)
KEY_HI_DOWN   = .hibyte(KEY_DOWN)
KEY_HI_LEFT   = .hibyte(KEY_LEFT)
KEY_HI_RIGHT  = .hibyte(KEY_RIGHT)
```

## Auto-Joypad Timing

- **Starts**: At beginning of VBlank
- **Duration**: ~422 CPU cycles
- **Completes**: Before end of VBlank
- **Read Window**: After bit 0 of HVBJOY is set

## Common Mistakes

### Not Waiting for Ready
```asm
; ❌ BAD: Reading before ready
lda STDCNTRL1L  ; May read incomplete data
```

### Wrong Register
```asm
; ❌ BAD: Using old-style registers
lda $4016       ; Old-style, not auto-joypad
```

### Correct Pattern
```asm
; ✅ GOOD: Wait, then read
wait_ready:
    lda HVBJOY
    and #$01
    beq wait_ready
    lda STDCNTRL1L  ; Now safe to read
```

## Cross-References

- [Button State Tracking](button-state-tracking.md) - Triggered vs held buttons
- [Controller I/O](../../hardware/ppu/controller-io.md) - Hardware details
- [Input Pipeline](../../programming/input/input-pipeline.md) - Complete input system
