; ============================================================================
; SPC700 Initialization
; ============================================================================
; Boots and initializes the SPC700 audio processor
; ============================================================================

.p816
.export spc700_init
.import spc700_boot
.include "../headers/snes_registers.inc"

.segment "CODE"

; ============================================================================
; SPC700 Initialization
; ============================================================================
; Boots the SPC700 and uploads audio program
; ============================================================================
.proc spc700_init
    ; Boot SPC700 (upload program and start execution)
    jsr spc700_boot
    
    ; SPC700 is now running
    ; Additional initialization can be done via CPU-APU communication
    ; (e.g., upload BRR samples, set DSP registers, etc.)
    
    rts
.endproc
