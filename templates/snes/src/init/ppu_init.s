; ============================================================================
; PPU Initialization
; ============================================================================
; Complete S-PPU initialization
; See ../../docs/snes/programming/initialization/ppu-init.md for documentation
; ============================================================================

.p816
.export ppu_init
.smart
.include "../headers/snes_registers.inc"
.include "../headers/snes_constants.inc"

PPU_BASE := $2100

.segment "CODE"

; ============================================================================
; PPU Initialization
; ============================================================================
; Initializes all S-PPU registers to known state
; See ../../docs/snes/programming/initialization/ppu-init.md
; ============================================================================
.proc ppu_init
    ; Temporarily move direct page to PPU I/O area
    lda #PPU_BASE
    tad
    
    ; First clear the regs that take a 16-bit write
    lda #$0080
    sta $00           ; Forced blank, brightness 0, sprite size 8/16 from VRAM $0000
    stz $02           ; OAM address = 0
    stz $05           ; BG mode 0, no mosaic
    stz $07           ; BG 1-2 map 32x32 from VRAM $0000
    stz $09           ; BG 3-4 map 32x32 from VRAM $0000
    stz $0B           ; BG tiles from $0000
    stz $16           ; VRAM address $0000
    stz $23           ; Disable BG window
    stz $26           ; Clear window 1 x range
    stz $28           ; Clear window 2 x range
    stz $2A           ; Clear window mask logic
    stz $2C           ; Disable all layers on main and sub
    stz $2E           ; Disable all layers on main and sub in window
    ldx #$0030
    stx $30           ; Disable color math and mode 3/4/7 direct color
    ldy #$00E0
    sty $32           ; Clear RGB components of COLDATA; disable interlace+pseudo hires
    
    ; Now clear the regs that need 8-bit writes
    sep #$20
    sta $15           ; Still $80: add 1 to VRAM pointer after high byte write
    stz $1A           ; Enable mode 7 wrapping and disable flipping
    stz $21           ; Set CGRAM address to color 0
    stz $25           ; Disable obj and math window
    
    ; The scroll registers $210D-$2114 need double 8-bit writes
    .repeat 8, I
        stz $0D+I
        stz $0D+I
    .endrepeat
    
    ; As do the mode 7 registers, which we set to the identity matrix
    ; [ $0100  $0000 ]
    ; [ $0000  $0100 ]
    lda #$01
    stz $1B
    sta $1B
    stz $1C
    stz $1C
    stz $1D
    stz $1D
    stz $1E
    sta $1E
    stz $1F
    stz $1F
    stz $20
    stz $20
    
    ; Return direct page to zero page
    rep #$20
    lda #$0000
    tad                 ; Return direct page to real zero page
    
    ; PPU initialization complete
    rts
.endproc
