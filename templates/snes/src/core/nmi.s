; ============================================================================
; NMI Handler
; ============================================================================
; VBlank interrupt handler
; See ../../docs/snes/programming/game-loop/nmi-handler.md
; ============================================================================

.p816
.export nmi_handler
.smart
.import oam_dma_update
.include "../headers/snes_registers.inc"

.segment "ZEROPAGE"
nmis: .res 1

.segment "CODE"

; ============================================================================
; NMI Handler
; ============================================================================
; Minimalist NMI handler that only acknowledges NMI and signals
; to the main thread that NMI has occurred.
; See ../../docs/snes/programming/game-loop/nmi-handler.md
; ============================================================================
.proc nmi_handler
    ; Because the INC and BIT instructions can't use 24-bit (f:)
    ; addresses, set the data bank to one that can access low RAM
    ; ($0000-$1FFF) and the PPU ($2100-$213F) with a 16-bit address.
    ; Only banks $00-$3F and $80-$BF can do this, not $40-$7D or
    ; $C0-$FF. ($7E can access low RAM but not the PPU.) But in a
    ; LoROM program no larger than 16 Mbit, the CODE segment is in a
    ; bank that can, so point the data bank at the program bank.
    phb
    phk
    plb
    
    seta8
    inc a:nmis         ; Increase NMI count to notify main thread
    bit a:RDNMI        ; Acknowledge NMI ($4210)
    
    ; Update OAM via DMA (if needed)
    ; jsl ppu_copy_oam
    
    ; And restore the previous data bank value.
    plb
    rti
.endproc
