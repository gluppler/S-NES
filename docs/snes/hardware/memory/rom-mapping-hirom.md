# HiROM Mapping

## Overview

HiROM (High ROM) is an alternative SNES ROM mapping mode, less common than LoROM.

## HiROM Address Space

HiROM maps ROM in 64 KB banks:

### Bank Structure
- **Banks $40-$7D**: Slow ROM (2.68 MHz)
- **Banks $C0-$FF**: Fast ROM (3.58 MHz) - if fast ROM enabled
- **Bank Size**: 64 KB ($10000 bytes)
- **Total Capacity**: Up to 4 MB (64 banks × 64 KB)

### Address Mapping

```
Bank $40: $400000-$40FFFF (mirrored at $C00000-$C0FFFF)
Bank $41: $410000-$41FFFF (mirrored at $C10000-$C1FFFF)
...
Bank $7D: $7D0000-$7DFFFF (mirrored at $FD0000-$FDFFFF)
```

**Note**: HiROM uses linear addressing (no bit skipping).

## ROM Header Location

HiROM header is at **$C0FFB0-$C0FFFF** in the ROM file.

## Fast ROM Support

HiROM supports fast ROM:
- **Header Bit**: $C0FFD5 bit 4
- **Fast ROM Banks**: $C0-$FF (if enabled)
- **Speed**: 3.58 MHz (100% CPU speed)

## Advantages

- **Larger banks**: 64 KB vs 32 KB (LoROM)
- **Linear addressing**: No bit skipping
- **Better for large games**: Easier bank management

## Disadvantages

- **Less common**: Most games use LoROM
- **More complex**: Larger bank management

## Cross-References

- [LoROM Mapping](rom-mapping-lorom.md) - More common mapping
- [ExHiROM Mapping](rom-mapping-exhirom.md) - Extended mapping
