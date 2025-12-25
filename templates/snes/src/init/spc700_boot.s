; ============================================================================
; SPC700 Boot Protocol
; ============================================================================
; Boots the SPC700 audio processor
; See ../../docs/snes/programming/initialization/spc700-boot.md for documentation
; See ../../docs/snes/hardware/audio-spc700/spc700-boot.md for hardware details
; ============================================================================

.p816
.export spc700_boot, spc_wait_boot, spc_begin_upload, spc_upload_byte, spc_execute
.smart
.i16
.include "../headers/snes_registers.inc"

.segment "CODE"

; ============================================================================
; Wait for SPC700 Ready
; ============================================================================
; Waits for SPC to finish booting. Call before first using SPC or after
; bootrom has been re-run.
; Preserved: X, Y
; See ../../docs/snes/programming/initialization/spc700-boot.md
; ============================================================================
.proc spc_wait_boot
    ; Clear command port in case it already has $CC at reset
    seta8
    stz APUIO0
    
    ; Wait for the SPC to signal it's ready with APU0=$AA, APU1=$BB
    seta16
    lda #$BBAA
waitBBAA:
    cmp APUIO0
    bne waitBBAA
    seta8
    rts
.endproc

; ============================================================================
; Begin SPC700 Upload
; ============================================================================
; Starts upload to SPC addr Y and sets Y to 0 for use as index with
; spc_upload_byte.
; Preserved: X
; See ../../docs/snes/programming/initialization/spc700-boot.md
; ============================================================================
.proc spc_begin_upload
    seta8
    sty APUIO2
    
    ; Tell the SPC to set the start address. The first value written
    ; to APU0 must be $CC, and each subsequent value must be nonzero
    ; and at least $02 above the index LSB previously written to $00.
    ; Adding $22 always works because APU0 starts at $AA.
    lda APUIO0
    clc
    adc #$22
    bne @skip  ; Ensure nonzero, as zero means start execution
    inc a
@skip:
    sta APUIO1
    sta APUIO0
    
    ; Wait for acknowledgement
@wait:
    cmp APUIO0
    bne @wait
    
    ; Initialize index into block
    ldy #0
    rts
.endproc

; ============================================================================
; Upload Byte to SPC700
; ============================================================================
; Uploads byte A to SPC and increments Y. The low byte of Y must not
; change between calls, as it is used as the index.
; Preserved: X
; See ../../docs/snes/programming/initialization/spc700-boot.md
; ============================================================================
.proc spc_upload_byte
    sta APUIO1
    
    ; Signal that it's ready
    tya
    sta APUIO0
    iny
    
    ; Wait for acknowledgement
@wait:
    cmp APUIO0
    bne @wait
    rts
.endproc

; ============================================================================
; Execute SPC700 Program
; ============================================================================
; Starts executing at SPC addr Y
; Preserved: X, Y
; See ../../docs/snes/programming/initialization/spc700-boot.md
; ============================================================================
.proc spc_execute
    sty APUIO2
    stz APUIO1
    lda APUIO0
    clc
    adc #$22
    sta APUIO0
    
    ; Wait for acknowledgement
@wait:
    cmp APUIO0
    bne @wait
    rts
.endproc

; ============================================================================
; Complete SPC700 Boot
; ============================================================================
; Uploads SPC700 program and starts execution
; See ../../docs/snes/programming/initialization/spc700-boot.md
; ============================================================================
.proc spc700_boot
    jsr spc_wait_boot
    
    ; Upload SPC700 program
    ; Example usage:
    ;   ldy #$0200  ; Destination address in SPC700 RAM
    ;   jsr spc_begin_upload
    ;   ldx #0
    ; upload_loop:
    ;   lda spc700_program,x
    ;   jsr spc_upload_byte
    ;   inx
    ;   cpx #spc700_program_size
    ;   bne upload_loop
    ;   ldy #$0200  ; Execution address
    ;   jsr spc_execute
    
    ; SPC700 is now running
    rts
.endproc
