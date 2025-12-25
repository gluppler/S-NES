; ============================================================================
; IRQ Handler
; ============================================================================
; SNES IRQ handler (rarely used, but required)
; See ../../docs/snes/hardware/cpu-65816/interrupts.md
; ============================================================================

.p816
.export irq_handler
.include "../headers/snes_registers.inc"

.segment "CODE"

; ============================================================================
; IRQ Handler
; ============================================================================
; IRQ is rarely used on SNES, but handler is required
; ============================================================================
.proc irq_handler
    rti                 ; Return from interrupt
.endproc
