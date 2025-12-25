# LoROM Mapping

## SNES ROM Mapping Mode

LoROM (Low ROM) is the most common SNES ROM mapping mode, used by the majority of SNES games.

## LoROM Address Space

LoROM maps ROM in 32 KB banks:

### Bank Structure
- **Banks $00-$7F**: Slow ROM (2.68 MHz)
- **Banks $80-$FF**: Fast ROM (3.58 MHz) - if fast ROM enabled
- **Bank Size**: 32 KB ($8000 bytes)
- **Total Capacity**: Up to 4 MB (128 banks × 32 KB)

### Address Mapping

```
Bank $00: $008000-$00FFFF (mirrored at $808000-$80FFFF)
Bank $01: $018000-$01FFFF (mirrored at $818000-$81FFFF)
Bank $02: $028000-$02FFFF (mirrored at $828000-$82FFFF)
...
Bank $7F: $7F8000-$7FFFFF (mirrored at $FF8000-$FFFFFF)
```

**Note**: Address bit 15 is skipped in LoROM mapping.

## ROM Header Location

LoROM header is at **$00FFB0-$00FFFF** in the ROM file:
- **$00FFB0-$00FFD4**: ROM name, mapping info, ROM size
- **$00FFD5**: Fast ROM bit (bit 4)
- **$00FFD6-$00FFD9**: Expansion RAM info
- **$00FFDA-$00FFDB**: Region
- **$00FFDC-$00FFDD**: Publisher
- **$00FFDE**: Version
- **$00FFDF-$00FFE0**: Checksum complement
- **$00FFE1-$00FFE2**: Checksum
- **$00FFE3-$00FFFF**: Vectors

## Fast ROM Support

LoROM supports fast ROM:
- **Header Bit**: $00FFD5 bit 4
- **Fast ROM Banks**: $40-$7D, $C0-$FF (if enabled)
- **Speed**: 3.58 MHz (100% CPU speed)
- **Slow ROM Banks**: $00-$3F, $80-$BF
- **Speed**: 2.68 MHz (75% CPU speed)

### Enabling Fast ROM

```asm
; Check header bit
LDA $00FFD5
AND #$10        ; Bit 4 = fast ROM request
BEQ no_fast_rom
    LDA #$01
    STA MEMSEL  ; $420D: Enable fast ROM
no_fast_rom:
```

## Linker Configuration

### ca65 (cc65)

```cfg
MEMORY {
    ROM0: start = $808000, size = $8000, fill = yes;
    ROM1: start = $818000, size = $8000, fill = yes;
    ...
}

SEGMENTS {
    CODE: load = ROM0, type = ro;
    SNESHEADER: load = ROM0, start = $80FFB0;
}
```

### wla-dx

```asm
.MEMORYMAP
SLOTSIZE $8000
DEFAULTSLOT 0
SLOT 0 $8000
.ENDME

.ROMBANKSIZE $8000
.ROMBANKS 1
```

## Common LoROM Layout

```
Bank $00 ($008000-$00FFFF):
  $008000-$00FFAF: Code/data
  $00FFB0-$00FFFF: ROM header and vectors

Bank $01-$7F:
  $XX8000-$XXFFFF: Code/data (32 KB per bank)
```

## Advantages

- **Simple**: Easy to understand and implement
- **Compatible**: Works with all SNES hardware
- **Standard**: Most SNES games use LoROM
- **Fast ROM**: Supports fast ROM for performance

## Limitations

- **32 KB Banks**: Code/data must fit in 32 KB chunks
- **Bank Switching**: May need to switch banks for large functions
- **Address Space**: Limited to 4 MB without bank switching tricks

## Cross-References

- [HiROM Mapping](rom-mapping-hirom.md) - Alternative mapping mode
- [ExHiROM Mapping](rom-mapping-exhirom.md) - Extended mapping
- [Fast ROM Setup](../../programming/initialization/fast-rom-setup.md) - Enabling fast ROM
