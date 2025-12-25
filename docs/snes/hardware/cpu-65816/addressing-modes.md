# 65816 Addressing Modes

## Overview

65816 supports many addressing modes, including new modes not available on 6502.

## Addressing Modes

### Immediate
```asm
LDA #$42        ; Load immediate value
```

### Direct Page
```asm
LDA $00         ; Direct page addressing (fast!)
```

### Direct Page Indexed
```asm
LDA $00,X       ; Direct page + X index
```

### Absolute
```asm
LDA $0300        ; 16-bit address
```

### Absolute Indexed
```asm
LDA $0300,X      ; Absolute + X index
LDA $0300,Y      ; Absolute + Y index
```

### Absolute Long
```asm
LDA $7E0300      ; 24-bit address (3 bytes)
```

### Absolute Long Indexed
```asm
LDA $7E0300,X    ; 24-bit address + index
```

### Indirect
```asm
LDA ($00)        ; Indirect (16-bit pointer)
```

### Indirect Indexed
```asm
LDA ($00),Y      ; Indirect + Y index
```

### Direct Page Indirect
```asm
LDA ($00)        ; Direct page indirect
```

### Direct Page Indirect Indexed
```asm
LDA ($00),Y      ; Direct page indirect + Y
```

### Stack Relative
```asm
LDA $00,S        ; Stack relative
```

### Stack Relative Indirect Indexed
```asm
LDA ($00,S),Y    ; Stack relative indirect + Y
```

## Direct Page Usage

Direct page provides fast addressing:

```asm
; Set direct page
LDA #$0300
TCD              ; Direct page = $0300

; Now $00-$FF addresses access $0300-$03FF
LDA $00          ; Accesses $0300 (fast!)
```

## Bank Registers

### Data Bank (DB)
- Used for absolute long addressing
- Set with PLB instruction

### Program Bank (PB)
- Current code bank
- Set automatically by JML, etc.

## Cross-References

- [Direct Page Usage](../../programming/initialization/cpu-init.md) - Direct page setup
- [Native vs Emulation Mode](native-vs-emulation.md) - Mode differences
