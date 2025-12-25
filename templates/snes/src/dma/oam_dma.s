; ============================================================================
; OAM DMA Update
; ============================================================================
; Updates OAM via DMA channel 0
; See ../../docs/snes/programming/rendering/dma-oam-updates.md
; ============================================================================

.p816
.export ppu_copy_oam, ppu_copy, ppu_clear_oam, ppu_pack_oamhi, ppu_vsync
.smart
.i16
.include "../headers/snes_registers.inc"
.include "../headers/snes_constants.inc"
.include "../headers/memory/wram_map.inc"

.segment "BSS"
OAM:   .res 512
OAMHI: .res 512

.segment "CODE"

; ============================================================================
; Copy OAM to PPU
; ============================================================================
; Copies packed OAM data to the S-PPU using DMA channel 0.
; See ../../docs/snes/programming/rendering/dma-oam-updates.md
; ============================================================================
.proc ppu_copy_oam
    setaxy16
    lda #DMAMODE_OAMDATA
    ldx #OAM
    ldy #544
    ; Falls through to ppu_copy
.endproc

; ============================================================================
; Copy Data to PPU
; ============================================================================
; Copies data to the S-PPU using DMA channel 0.
; @param X source address
; @param DBR source bank
; @param Y number of bytes to copy
; @param A 15-8: destination PPU register; 7-0: DMA mode
;        useful constants: DMAMODE_PPUDATA, DMAMODE_CGDATA, DMAMODE_OAMDATA
; See ../../docs/snes/programming/rendering/dma-oam-updates.md
; ============================================================================
.proc ppu_copy
    php
    setaxy16
    sta DMAMODE
    stx DMAADDR
    sty DMALEN
    seta8
    phb
    pla
    sta DMAADDRBANK
    lda #%00000001
    sta COPYSTART
    plp
    rtl
.endproc

; ============================================================================
; Clear OAM
; ============================================================================
; Moves remaining entries in the CPU's local copy of OAM to
; (-128, 225) to get them offscreen.
; @param X index of first sprite in OAM (0-508)
; See ../../docs/snes/programming/rendering/dma-oam-updates.md
; ============================================================================
.proc ppu_clear_oam
    setaxy16
lowoamloop:
    lda #(225 << 8) | <-128
    sta OAM,x
    lda #$0100  ; Bit 8: offscreen
    sta OAMHI,x
    inx
    inx
    inx
    inx
    cpx #512  ; 128 sprites times 4 bytes per sprite
    bcc lowoamloop
    rtl
.endproc

; ============================================================================
; Pack OAM High Table
; ============================================================================
; Converts high OAM (sizes and X sign bits) to the packed format
; expected by the S-PPU.
; See ../../docs/snes/programming/rendering/dma-oam-updates.md
; ============================================================================
.proc ppu_pack_oamhi
    setxy16
    ldx #0
    txy
packloop:
    ; Pack four sprites' size+xhi bits from OAMHI
    sep #$20
    lda OAMHI+13,y
    asl a
    asl a
    ora OAMHI+9,y
    asl a
    asl a
    ora OAMHI+5,y
    asl a
    asl a
    ora OAMHI+1,y
    sta OAMHI,x
    rep #$21  ; seta16 + clc for following addition
    
    ; Move to the next set of 4 OAM entries
    inx
    tya
    adc #16
    tay
    
    ; Done yet?
    cpx #32  ; 128 sprites divided by 4 sprites per byte
    bcc packloop
    rtl
.endproc

; ============================================================================
; Wait for VBlank
; ============================================================================
; Waits for the start of vertical blanking.
; See ../../docs/snes/programming/game-loop/frame-synchronization.md
; ============================================================================
.proc ppu_vsync
    php
    seta8
loop1:
    bit VBLSTATUS  ; Wait for leaving previous vblank
    bmi loop1
loop2:
    bit VBLSTATUS  ; Wait for start of this vblank
    bpl loop2
    plp
    rtl
.endproc
