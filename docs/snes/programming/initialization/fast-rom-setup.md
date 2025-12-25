# Fast ROM Setup

## Overview

SNES supports **fast ROM** which runs at 100% CPU speed (3.58 MHz) instead of 75% (2.68 MHz).

## Fast ROM Banks

- **Slow ROM**: Banks $00-$3F, $80-$BF (2.68 MHz)
- **Fast ROM**: Banks $40-$7D, $C0-$FF (3.58 MHz, if enabled)

## Enabling Fast ROM

### Check Header Bit

```asm
; Check if fast ROM is requested in header
lda $00FFD5         ; ROM header byte
and #$10            ; Bit 4 = fast ROM request
beq no_fast_rom
```

### Enable Fast ROM

```asm
    lda #$01
    sta MEMSEL       ; $420D: Enable fast ROM
no_fast_rom:
```

## Complete Setup

```asm
.proc enable_fast_rom
    ; Check header bit
    lda $00FFD5      ; Header byte
    and #$10         ; Bit 4
    beq @done
    
    ; Enable fast ROM
    lda #$01
    sta MEMSEL        ; $420D
    
@done:
    rts
.endproc
```

## Performance Impact

- **Slow ROM**: 75% CPU speed
- **Fast ROM**: 100% CPU speed
- **Improvement**: 25% faster code execution

## Cross-References

- [LoROM Mapping](../../hardware/memory/rom-mapping-lorom.md) - LoROM fast ROM
- [CPU Timing](../../hardware/cpu-65816/cpu-timing.md) - CPU speed details
