# Understanding the 65816 CPU

## Critical SNES Concept

The SNES uses the **65816 processor**, which is fundamentally different from the 6502 used in NES. Understanding 65816 is essential for SNES development.

## Key Differences from 6502

| Feature | 6502 (NES) | 65816 (SNES) |
|---------|------------|--------------|
| Address Space | 16-bit (64 KB) | 24-bit (16 MB) |
| Registers | Always 8-bit | 8-bit or 16-bit (selectable) |
| Mode | Single mode | Native or Emulation |
| Direct Page | Zero page (256 bytes) | Direct page (64 KB) |
| Stack | Fixed location | Configurable |
| Instructions | 6502 set | Extended set (MVN/MVP, etc.) |

## Native vs Emulation Mode

### Emulation Mode (Default)
- 6502-compatible
- 8-bit registers
- 16-bit addressing
- **Not suitable for SNES**

### Native Mode (Required)
- Full 65816 functionality
- 8-bit or 16-bit registers
- 24-bit addressing
- **Required for SNES**

### Switching Modes

```asm
; Switch to native mode
CLC      ; Clear carry
XCE      ; Exchange carry with emulation flag
; Now in native mode
```

## Register Width Control

In native mode, you control register widths:

```asm
SEP #$20   ; 8-bit accumulator (bit 5)
REP #$20   ; 16-bit accumulator

SEP #$10   ; 8-bit index registers (bit 4)
REP #$10   ; 16-bit index registers

SEP #$30   ; 8-bit A, X, Y
REP #$30   ; 16-bit A, X, Y
```

## Addressing Modes

65816 adds new addressing modes:

### Direct Page
```asm
LDA #$0300
TCD         ; Set direct page to $0300
LDA $00     ; Now accesses $0300 (fast!)
```

### Absolute Long
```asm
LDA $7E0300  ; 24-bit address (3 bytes)
```

### Bank Registers
```asm
PHK          ; Push program bank
PLB          ; Pull to data bank
; Now DB = PB
```

## Common SNES Pattern

```asm
reset:
    ; Switch to native mode
    clc
    xce
    
    ; Set register widths (8-bit A, 16-bit X/Y)
    rep #$10
    sep #$20
    
    ; Initialize stack
    ldx #$01FF
    txs
    
    ; Initialize direct page
    lda #$0000
    tcd
    
    ; Set data bank
    phk
    plb
    
    ; Continue initialization...
```

## Why This Matters

SNES hardware requires:
- **24-bit addressing** (for WRAM, ROM banks)
- **Direct page** (for fast variable access)
- **16-bit index registers** (for efficient loops)
- **Full instruction set** (MVN/MVP for DMA setup)

**Emulation mode cannot access SNES hardware properly.**

## Next Steps

- [Native vs Emulation Mode](../hardware/cpu-65816/native-vs-emulation.md) - Detailed mode switching
- [CPU Initialization](../programming/initialization/cpu-init.md) - Complete initialization
- [Hardware Overview](01-hardware-overview.md) - System architecture
