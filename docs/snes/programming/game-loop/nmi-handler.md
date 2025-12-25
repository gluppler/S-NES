# NMI Handler

## Overview

The NMI (Non-Maskable Interrupt) handler is called every VBlank (60 times per second NTSC). It's where you update OAM, scroll registers, and other PPU-related data.

## NMI Timing

- **Triggered**: At start of VBlank (scanline 225 NTSC)
- **Duration**: ~1,364 cycles available (NTSC)
- **Frequency**: 60.098 times per second (NTSC)

## Basic NMI Handler

```asm
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
  inc a:nmis       ; Increase NMI count to notify main thread
  bit a:NMISTATUS  ; Acknowledge NMI ($4210)

  ; And restore the previous data bank value.
  plb
  rti
.endproc
```

### Minimal NMI Pattern

For minimal programs, NMI can be very simple:

```asm
.proc nmi_handler
  phb
  phk
  plb
  seta8
  inc nmis          ; Signal to main thread
  bit NMISTATUS     ; Acknowledge NMI
  plb
  rti
.endproc
```

## Critical NMI Tasks

### 1. Acknowledge NMI

```asm
lda RDNMI    ; Must read $4210 to acknowledge NMI
```

**Critical**: Must read RDNMI to clear NMI flag.

### 2. Update OAM via DMA

```asm
jsr update_oam_dma  ; Transfer OAM mirror to hardware OAM
```

**Timing**: ~1,090 cycles for 544 bytes

### 3. Update Scroll Registers

```asm
; Update BG1 scroll (dual-write)
rep #$20
lda scroll_x
sta BG1HOFS
sep #$20
lda scroll_y
sta BG1VOFS
sta BG1VOFS  ; Dual-write
```

## NMI Handler Rules

1. **Must acknowledge NMI**: Read RDNMI ($4210)
2. **Must complete quickly**: <1,364 cycles (NTSC)
3. **Can modify PPU registers**: During VBlank only
4. **Can use DMA**: For OAM, VRAM, CGRAM updates
5. **Must restore registers**: Save/restore A, X, Y, D, B

## Common Mistakes

### Not Acknowledging NMI
```asm
; ❌ BAD: NMI not acknowledged
nmi_handler:
    jsr update_oam
    rti  ; NMI flag still set!
```

### Too Long
```asm
; ❌ BAD: NMI handler too long
nmi_handler:
    ; ... 2000+ cycles ...
    rti  ; Delays main loop
```

### Correct Pattern
```asm
; ✅ GOOD: Quick, acknowledges NMI
nmi_handler:
    pha
    phx
    lda RDNMI        ; Acknowledge
    jsr update_oam   ; Quick update
    plx
    pla
    rti
```

## Cross-References

- [Frame Synchronization](frame-synchronization.md) - WAI and frame timing
- [VBlank Windows](vblank-windows.md) - Safe PPU access periods
- [DMA OAM Updates](../rendering/dma-oam-updates.md) - OAM DMA code
