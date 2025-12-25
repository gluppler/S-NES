# SPC700/DSP Quick Reference

## SPC700 Communication Registers

- **$2140 (APUIO0)**: Communication port 0
- **$2141 (APUIO1)**: Communication port 1
- **$2142 (APUIO2)**: Communication port 2
- **$2143 (APUIO3)**: Communication port 3

## SPC700 Boot Sequence

```asm
; Wait for ready
spc_wait_boot:
    stz APUIO0
    lda #$BBAA
wait: cmp APUIO0
    bne wait

; Begin upload
spc_begin_upload:
    sty APUIO2
    lda APUIO0
    clc
    adc #$22
    sta APUIO1
    sta APUIO0
wait2: cmp APUIO0
    bne wait2
    ldy #0

; Upload byte
spc_upload_byte:
    sta APUIO1
    tya
    sta APUIO0
    iny
wait3: cmp APUIO0
    bne wait3

; Execute
spc_execute:
    sty APUIO2
    stz APUIO1
    lda APUIO0
    clc
    adc #$22
    sta APUIO0
wait4: cmp APUIO0
    bne wait4
```

## S-DSP Registers (via SPC700)

S-DSP registers are accessed via SPC700 $00F2/$00F3:
- **$00F2**: Register address
- **$00F3**: Register data

### Voice Registers (per voice)
- **VxVOLL/H**: Voice volume (left/right)
- **VxPITCHL/H**: Voice pitch
- **VxSRCN**: Sample number
- **VxADSR1/2**: ADSR envelope
- **VxGAIN**: Gain envelope

### Global Registers
- **FLG**: DSP flags
- **MVOLL/H**: Main volume (left/right)
- **EVOLL/H**: Echo volume (left/right)
- **EFB**: Echo feedback
- **ESA**: Echo start address
- **EDL**: Echo delay

## Cross-References

- [SPC700 Boot](../hardware/audio-spc700/spc700-boot.md) - Complete boot protocol
- [DSP Registers](../hardware/audio-spc700/dsp-registers.md) - S-DSP register map
- [BRR Format](../hardware/audio-spc700/brr-format.md) - Audio sample format
