; ============================================================================
; Interrupt Vectors
; ============================================================================
; SNES interrupt vectors at $00FFE4-$00FFFF
; See ../../docs/snes/hardware/cpu-65816/interrupts.md
; ============================================================================

.p816
.import reset_handler, nmi_handler, irq_handler

.segment "VECTORS"

; Native mode vectors
.addr $0000, $0000, $0000     ; COP, BRK, ABT
.addr nmi_handler, $0000, irq_handler ; NMI, RST, IRQ

.word $0000, $0000           ; Four unused bytes

; Emulation mode vectors
.addr $0000, $0000, $0000     ; COP, BRK, ABT
.addr $0000, reset_handler, $0000 ; NMI, RST, IRQ
