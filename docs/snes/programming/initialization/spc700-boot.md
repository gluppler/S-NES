# SPC700 Boot Programming Guide

## Overview

This guide explains how to boot the SPC700 audio processor in your SNES program, using blargg's SPC700 bootloader implementation.

## Boot Sequence

1. **Wait for SPC700 ready** (`spc_wait_boot`)
2. **Upload SPC700 program** (`spc_begin_upload` + `spc_upload_byte`)
3. **Start execution** (`spc_execute`)

## Complete Implementation (blargg's Bootloader)

```asm
; High-level interface to SPC-700 bootloader
; Originally by "blargg" (Shay Green)
; https://wiki.superfamicom.org/how-to-write-to-dsp-registers-without-any-spc-700-code

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

.proc spc_begin_upload
  ; Y = SPC700 destination address
  seta8
  sty APUIO2

  ; Tell the SPC to set the start address. The first value written
  ; to APU0 must be $CC, and each subsequent value must be nonzero
  ; and at least $02 above the index LSB previously written to $00.
  ; Adding $22 always works because APU0 starts at $AA.
  lda APUIO0
  clc
  adc #$22
  bne @skip  ; ensure nonzero, as zero means start execution
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

.proc spc_upload_byte
  ; A = byte to upload
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

## Complete Boot Example

```asm
.import spc_entry
.import __SPCIMAGE_RUN__, __SPCIMAGE_LOAD__, __SPCIMAGE_SIZE__

.proc spc_boot_apu
  jsr spc_wait_boot

  ; Upload sample to SPC at $200
  ldy #__SPCIMAGE_RUN__
  jsr spc_begin_upload
:
  tyx
  lda f:__SPCIMAGE_LOAD__,x
  jsr spc_upload_byte
  cpy #__SPCIMAGE_SIZE__
  bne :-
  ldy #spc_entry
  jsr spc_execute
  rtl
.endproc
```

## SPC700 Program Format

SPC700 programs are 65C02 assembly targeting SPC700:
- **Architecture**: 8-bit CPU, 64 KB address space
- **Registers**: A, X, Y (8-bit), SP, PC (16-bit)
- **Instructions**: 65C02-compatible
- **Assembler**: wla-dx (wla-spc700), asar, bass

## Common SPC700 Programs

### Minimal Sound Driver

Plays a single sound effect or music track.

### Full Music Driver

Complete music and sound effect system with:
- BRR sample playback
- Music sequence handling
- Sound effect management
- Voice allocation

## Timing Considerations

- **Boot Time**: ~1000-2000 CPU cycles
- **Upload Speed**: ~10-20 cycles per byte
- **Communication**: Asynchronous (SPC700 may be busy)

## References

- [blargg's SPC700 Bootloader](https://wiki.superfamicom.org/how-to-write-to-dsp-registers-without-any-spc-700-code) - Original implementation by Shay Green

## Cross-References

- [SPC700 Boot](../../hardware/audio-spc700/spc700-boot.md) - Hardware boot protocol details
- [CPU-APU Protocol](../../hardware/audio-spc700/cpu-apu-protocol.md) - Communication after boot
- [DSP Registers](../../hardware/audio-spc700/dsp-registers.md) - S-DSP register map
- [BRR Format](../../hardware/audio-spc700/brr-format.md) - Audio sample format
