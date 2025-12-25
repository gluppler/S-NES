# 65816 Native vs Emulation Mode

## Critical SNES Concept

The 65816 processor has **two modes**:
- **Emulation Mode**: 6502-compatible (default on reset)
- **Native Mode**: Full 65816 functionality (required for SNES)

**You MUST switch to native mode for SNES development.**

## Emulation Mode (Default)

On reset, the 65816 starts in emulation mode:
- 8-bit accumulator and index registers
- 16-bit addressing (64 KB)
- 6502-compatible behavior
- **Limited functionality** - not suitable for SNES

### Emulation Mode Limitations
- No 16-bit operations
- No 24-bit addressing
- No direct page register
- No MVN/MVP instructions
- Limited stack operations

## Native Mode (Required)

Native mode provides full 65816 functionality:
- 8-bit or 16-bit accumulator and index registers (selectable)
- 24-bit addressing (16 MB)
- Direct page register
- MVN/MVP block moves
- Full instruction set

### Switching to Native Mode

```asm
reset:
    CLC      ; Clear carry flag
    XCE      ; Exchange carry with emulation flag
    ; Now in native mode
```

**The XCE instruction switches between modes:**
- If carry is clear and emulation flag is set → switch to native mode
- If carry is set and emulation flag is clear → switch to emulation mode

## Register Width Control

In native mode, you control register widths:

```asm
SEP #$20   ; 8-bit accumulator (bit 5 of status register)
REP #$20   ; 16-bit accumulator

SEP #$10   ; 8-bit index registers (bit 4)
REP #$10   ; 16-bit index registers

SEP #$30   ; 8-bit A, X, Y
REP #$30   ; 16-bit A, X, Y
```

### Common Pattern

```asm
reset:
    CLC
    XCE          ; Switch to native mode
    REP #$10     ; 16-bit X, Y
    SEP #$20     ; 8-bit A
    ; Most SNES code uses 8-bit A, 16-bit X/Y
```

## Direct Page Register

Native mode provides a **direct page register** (D register):
- Similar to zero page on 6502, but 64 KB page
- Fast addressing (3 cycles vs 4-5 cycles)
- Set with TCD instruction

```asm
LDA #$0000
TCD      ; Set direct page to $0000
; Now $00-$FF addresses use direct page addressing
```

## Bank Registers

Native mode provides **bank registers**:
- **DB (Data Bank)**: Default bank for data access
- **PB (Program Bank)**: Current program bank

```asm
PHK      ; Push program bank
PLB      ; Pull to data bank (set DB = PB)
```

## Complete Native Mode Entry

```asm
reset:
    ; Switch to native mode
    CLC
    XCE
    
    ; Set register widths
    REP #$10     ; 16-bit X, Y
    SEP #$20     ; 8-bit A
    
    ; Initialize stack
    LDX #$01FF
    TXS          ; Stack pointer = $01FF
    
    ; Initialize direct page
    LDA #$0000
    TCD          ; Direct page = $0000
    
    ; Set data bank to program bank
    PHK
    PLB          ; DB = PB
    
    ; Continue initialization...
```

## Why Native Mode is Required

SNES development requires:
- 24-bit addressing (for WRAM, ROM banks)
- Direct page (for fast variable access)
- 16-bit index registers (for efficient loops)
- Full instruction set (MVN/MVP for DMA setup)

**Emulation mode cannot access SNES hardware properly.**

## Common Mistakes

### Forgetting XCE
```asm
; ❌ BAD: Still in emulation mode
reset:
    LDA #$80
    STA INIDISP  ; May not work correctly
```

### Wrong Register Widths
```asm
; ❌ BAD: 16-bit A when 8-bit needed
REP #$30
LDA #$80
STA INIDISP  ; Writes 2 bytes (wrong!)
```

### Correct Pattern
```asm
; ✅ GOOD: Native mode, correct widths
reset:
    CLC
    XCE
    REP #$10
    SEP #$20
    LDA #$80
    STA INIDISP  ; Correct 8-bit write
```

## Cross-References

- [Register Width Control](register-widths.md) - Detailed register width management
- [Addressing Modes](addressing-modes.md) - Direct page, banked addressing
- [CPU Initialization](../../programming/initialization/cpu-init.md) - Complete initialization sequence
