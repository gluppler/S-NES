# SPC700 Boot Protocol

## Overview

The SNES audio system uses a **separate 8-bit CPU** (SPC700) that must be booted before use. The SPC700 runs its own program (IPL) that receives data from the main CPU.

## Boot Sequence

1. **SPC700 IPL Running**: On reset, SPC700 runs IPL (Initial Program Load)
2. **CPU Uploads Program**: Main CPU uploads SPC700 program via $2140-$2143
3. **SPC700 Executes**: SPC700 runs uploaded program
4. **Communication**: CPU and SPC700 communicate via $2140-$2143

## Communication Registers

- **$2140 (APUIO0)**: Communication port 0
- **$2141 (APUIO1)**: Communication port 1
- **$2142 (APUIO2)**: Communication port 2
- **$2143 (APUIO3)**: Communication port 3

## IPL Protocol

The SPC700 IPL waits for a specific handshake:

1. **CPU clears $2140**
2. **SPC700 signals ready**: $2140=$AA, $2141=$BB
3. **CPU uploads program**: Byte-by-byte via $2140-$2143
4. **SPC700 executes**: Jumps to uploaded program

## Boot Code (blargg's SPC700 Bootloader)

```asm
.proc spc_wait_boot
    ; Clear command port
    seta8
    stz APUIO0
    
    ; Wait for SPC700 ready signal ($AA, $BB)
    seta16
    lda #$BBAA
wait_ready:
    cmp APUIO0
    bne wait_ready
    seta8
    rts
.endproc

.proc spc_begin_upload
    ; Y = SPC700 destination address
    seta8
    sty APUIO2
    
    ; Send upload command
    lda APUIO0
    clc
    adc #$22
    bne @skip
        inc a
    @skip:
    sta APUIO1
    sta APUIO0
    
    ; Wait for acknowledgement
    @wait:
        cmp APUIO0
        bne @wait
    
    ; Initialize index
    ldy #0
    rts
.endproc

.proc spc_upload_byte
    ; A = byte to upload
    sta APUIO1
    
    ; Signal ready
    tya
    sta APUIO0
    iny
    
    ; Wait for acknowledgement
    @wait:
        cmp APUIO0
        bne @wait
    rts
.endproc

.proc spc_execute
    ; Y = execution address
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
```

## Complete Boot Sequence

```asm
.proc boot_spc700
    ; Wait for SPC700 ready
    jsr spc_wait_boot
    
    ; Upload SPC700 program
    ldy #$0200  ; Destination address in SPC700 RAM
    jsr spc_begin_upload
    
    ; Upload program bytes
    ldx #0
upload_loop:
    lda spc700_program,x
    jsr spc_upload_byte
    inx
    cpx #spc700_program_size
    bne upload_loop
    
    ; Start execution
    ldy #$0200  ; Execution address
    jsr spc_execute
    
    ; SPC700 is now running
    rts
.endproc
```

## SPC700 Program Format

SPC700 programs are 65816 assembly targeting SPC700:
- **Architecture**: 8-bit CPU, 64 KB address space
- **Registers**: A, X, Y (8-bit), SP, PC (16-bit)
- **Instructions**: Similar to 6502, but SPC700-specific

## Common SPC700 Programs

### Minimal Sound Driver

```asm
; SPC700 program (assembled separately)
.proc spc700_init
    ; Initialize S-DSP
    ; Set up voices
    ; Play sound
    rts
.endproc
```

### Music Driver

Most SNES games use a music driver running on SPC700:
- Receives commands from main CPU
- Plays music sequences
- Handles sound effects
- Manages voice allocation

## Timing Considerations

- **Boot Time**: ~1000-2000 CPU cycles
- **Upload Speed**: ~10-20 cycles per byte
- **Communication**: Asynchronous (SPC700 may be busy)

## Common Mistakes

### Not Waiting for Ready
```asm
; ❌ BAD: Uploading before SPC700 ready
stz APUIO0
lda #$AA
sta APUIO1  ; SPC700 not ready yet!
```

### Wrong Upload Protocol
```asm
; ❌ BAD: Direct write (doesn't work)
lda data_byte
sta APUIO1  ; Must use upload protocol
```

### Correct Upload
```asm
; ✅ GOOD: Proper protocol
jsr spc_wait_boot
ldy #dest_addr
jsr spc_begin_upload
lda data_byte
jsr spc_upload_byte
```

## Cross-References

- [CPU-APU Protocol](cpu-apu-protocol.md) - Communication after boot
- [DSP Registers](dsp-registers.md) - S-DSP register map
- [BRR Format](brr-format.md) - Audio sample format
- [SPC700 Boot](../../programming/initialization/spc700-boot.md) - Programming guide
