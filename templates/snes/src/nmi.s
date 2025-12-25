; ============================================================================
; NMI Handler
; ============================================================================
; SNES VBlank interrupt handler
; Based on snes-hello NMI patterns
; ============================================================================

.p816   ; 65816 processor
.i16    ; X/Y are 16 bits
.a8     ; A is 8 bits

.include "../headers/constants/snes.inc"

nmi:
   rep #$10        ; X/Y 16-bit
   sep #$20        ; A 8-bit
   phd
   pha
   phx
   phy
   ; Do stuff that needs to be done during V-Blank
   lda RDNMI ; reset NMI flag
   ply
   plx
   pla
   pld
return_int:
   rti
