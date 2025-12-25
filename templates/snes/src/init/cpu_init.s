; ============================================================================
; CPU Initialization
; ============================================================================
; Complete 65816 CPU initialization for SNES
; See ../../docs/snes/programming/initialization/cpu-init.md for documentation
; ============================================================================

.p816
.export cpu_init
.smart

; Stack configuration
STACK_BASE      := $0100
STACK_SIZE      = $0100
LAST_STACK_ADDR := STACK_BASE + STACK_SIZE - 1

CPUIO_BASE      := $4200

.segment "CODE"

; ============================================================================
; CPU Initialization
; ============================================================================
; Initializes 65816 CPU to native mode with proper register widths
; See ../../docs/snes/programming/initialization/cpu-init.md
; ============================================================================
.proc cpu_init
    ; Switch to native mode
    sei                ; Turn off IRQs
    clc
    xce                ; Turn off 6502 emulation mode
    cld                ; Turn off decimal ADC/SBC
    
    ; Set register widths
    rep #$30           ; 16-bit AXY
    ldx #LAST_STACK_ADDR
    txs                ; Set the stack pointer
    
    ; Initialize the CPU I/O registers to predictable values
    lda #CPUIO_BASE
    tad                ; Temporarily move direct page to S-CPU I/O area
    lda #$FF00
    sta $00            ; Disable NMI and HVIRQ; don't drive controller port pin 6
    stz $02            ; Clear multiplier factors
    stz $04            ; Clear dividend
    stz $06            ; Clear divisor and low byte of hcount
    stz $08            ; Clear high bit of hcount and low byte of vcount
    stz $0A            ; Clear high bit of vcount and disable DMA copy
    stz $0C            ; Disable HDMA and fast ROM
    
    ; Return direct page to zero page
    rep #$20
    lda #$0000
    tad                 ; Return direct page to real zero page
    
    ; Set data bank to program bank
    phk
    plb                 ; DB = PB
    
    ; CPU initialization complete
    rts
.endproc
