; ============================================================================
; NMI Handler
; ============================================================================
; EXACTLY matches hello_world example NMI handler
; Also sets frame_ready flag for main_loop synchronization
; ============================================================================

.include "constants/ppu.inc"
.include "memory/zeropage.inc"

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

    ; keep default PPU config (NMI enabled, background from pattern table 0)
    lda #%10001000
    sta PPUCTRL
    lda #DEFMASK
    sta PPUMASK

    pla

    ; Interrupt exit
irq:
    rti
