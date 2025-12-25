; ============================================================================
; NMI Handler
; ============================================================================
; EXACTLY matches hello_world example NMI handler
; ============================================================================

.include "constants/ppu.inc"

; Constants (matching hello_world)
DEFMASK        = %00001000 ; background enabled

.export nmi
nmi:
    ; EXACTLY like hello_world
    pha

    ; refresh scroll position to 0,0
    lda #0
    sta PPUSCROLL
    sta PPUSCROLL

    ; keep default PPU config
    sta PPUCTRL
    lda #DEFMASK
    sta PPUMASK

    pla

    ; Interrupt exit
irq:
    rti
