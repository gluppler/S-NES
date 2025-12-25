# CPU Initialization

## Complete 65816 Initialization Sequence

SNES programs must properly initialize the 65816 CPU before use.

## Step-by-Step Initialization

### 1. Switch to Native Mode

```asm
reset:
    CLC      ; Clear carry flag
    XCE      ; Exchange carry with emulation flag → native mode
```

**Critical**: The CPU starts in emulation mode. You MUST switch to native mode.

### 2. Set Register Widths

```asm
    REP #$10     ; 16-bit X, Y (for efficient loops and addressing)
    SEP #$20     ; 8-bit A (for most SNES register writes)
```

**Why**: SNES registers are 8-bit. 16-bit accumulator would write 2 bytes.

### 3. Initialize Stack Pointer

```asm
    LDX #$01FF   ; Stack top (16-bit value)
    TXS          ; Transfer X to stack pointer
```

**Stack Location**: $000100-$0001FF (256 bytes)
**Why**: Stack must be initialized before using PHA, PLA, JSR, RTS, etc.

### 4. Initialize Direct Page

```asm
    LDA #$0000   ; Direct page base address
    TCD          ; Transfer to direct page register
```

**Direct Page**: Provides fast addressing (3 cycles vs 4-5 cycles)
**Common Usage**: Hot variables, loop counters, pointers

### 5. Set Data Bank

```asm
    PHK          ; Push program bank (current code bank)
    PLB          ; Pull to data bank register
```

**Why**: Ensures data bank matches program bank for addressing

### 6. Disable Decimal Mode

```asm
    CLD          ; Clear decimal mode flag
```

**Why**: Decimal mode affects ADC/SBC. SNES code typically uses binary.

## Complete Initialization Example

```asm
.proc resetstub
  sei                ; turn off IRQs
  clc
  xce                ; turn off 6502 emulation mode
  cld                ; turn off decimal ADC/SBC
  jml reset_fastrom  ; Bank $00 is not fast, but its mirror $80 is
.endproc

.proc reset_fastrom
  rep #$30         ; 16-bit AXY
  ldx #LAST_STACK_ADDR  ; LAST_STACK_ADDR = $01FF
  txs              ; set the stack pointer

  ; Initialize the CPU I/O registers to predictable values
  lda #CPUIO_BASE  ; CPUIO_BASE = $4200
  tad              ; temporarily move direct page to S-CPU I/O area
  lda #$FF00
  sta $00     ; disable NMI and HVIRQ; don't drive controller port pin 6
  stz $02     ; clear multiplier factors
  stz $04     ; clear dividend
  stz $06     ; clear divisor and low byte of hcount
  stz $08     ; clear high bit of hcount and low byte of vcount
  stz $0A     ; clear high bit of vcount and disable DMA copy
  stz $0C     ; disable HDMA and fast ROM

  ; Initialize the PPU registers (see PPU initialization)
  ; ... PPU init code ...

  ; Set fast ROM if the internal header so requests
  lda f:map_mode   ; map_mode = $00FFD5
  and #$10
  beq not_fastrom
    inc a
  not_fastrom:
  sta MEMSEL       ; MEMSEL = $80420D

  rep #$20
  lda #ZEROPAGE_BASE  ; ZEROPAGE_BASE = __ZEROPAGE_RUN__ & $FF00
  tad                 ; return direct page to real zero page

  ; Continue with main program
  jml main
.endproc
```


## Initialization Order

1. **CPU initialization** (this document)
2. **PPU initialization** (forced blanking, register setup)
3. **WRAM clearing** (optional, but recommended)
4. **VRAM/CGRAM/OAM clearing** (during forced blanking)
5. **SPC700 boot** (if using audio)
6. **Enable NMI** (after all initialization complete)

## Common Mistakes

### Missing XCE
```asm
; ❌ BAD: Still in emulation mode
reset:
    REP #$10
    SEP #$20
    ; CPU is still in emulation mode!
```

### Wrong Stack Initialization
```asm
; ❌ BAD: 8-bit stack initialization
SEP #$20
LDA #$FF
TSX      ; Wrong! TSX reads, doesn't set
```

### Correct Stack Initialization
```asm
; ✅ GOOD: 16-bit stack initialization
REP #$10
LDX #$01FF
TXS      ; Correct: Transfer X to stack pointer
```

## Register States After Initialization

| Register | Value | Notes |
|----------|-------|-------|
| A | Undefined | 8-bit mode |
| X | $01FF | 16-bit mode |
| Y | Undefined | 16-bit mode |
| S | $01FF | Stack pointer |
| D | $0000 | Direct page |
| DB | Program bank | Data bank |
| PB | Reset vector bank | Program bank |
| P | Native mode, 8-bit A, 16-bit X/Y | Status register |

## Cross-References

- [Native vs Emulation Mode](../../hardware/cpu-65816/native-vs-emulation.md) - Understanding mode switching
- [Register Width Control](../../hardware/cpu-65816/register-widths.md) - Register width management
- [PPU Initialization](ppu-init.md) - Next step after CPU init
- [SPC700 Boot](spc700-boot.md) - Audio processor initialization
