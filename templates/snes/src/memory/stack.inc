; ============================================================================
; Stack Memory Definitions
; ============================================================================
; SNES stack is at $000100-$0001FF (256 bytes)
; Stack pointer initialized to $01FF (grows downward)
; See ../../docs/snes/programming/initialization/cpu-init.md
; ============================================================================

.ifndef SNES_STACK_INC
SNES_STACK_INC = 1

STACK_BASE = $0100        ; Stack base address
STACK_TOP = $01FF         ; Stack top (initial SP value)
STACK_SIZE = 256          ; Stack size (256 bytes)

; Stack usage notes:
; - Stack is used for subroutine calls (JSR/RTS)
; - Stack is used for interrupt handling (PHA, PLA, etc.)
; - Stack grows downward (decrements on push, increments on pop)
; - Stack pointer wraps around (SP=$00 after 256 pushes from $FF)

.endif ; SNES_STACK_INC
