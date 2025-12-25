# SRAM & Save Formats

## Overview

SNES games can use **SRAM (Static RAM)** with battery backup for save data.

## SRAM Sizes

Common SRAM sizes:
- **2 KB**: Small saves
- **8 KB**: Medium saves
- **32 KB**: Large saves
- **128 KB**: Very large saves (rare)

## SRAM Access

SRAM is accessed via cartridge mapper:
- **LoROM**: SRAM at $700000-$7FFFFF
- **HiROM**: SRAM at $B00000-$BFFFFF

## Save File Format

SNES save files typically:
- **Header**: Game ID, checksum
- **Data**: Save data
- **Footer**: Checksum, validation

## ROM Header Settings

SRAM size is specified in ROM header:
- **$00FFD8**: SRAM size (log2(size) - 10)
- **$00FFD6**: Cart type (bit 1 = battery)

## Cross-References

- [LoROM Mapping](rom-mapping-lorom.md) - LoROM SRAM location
- [HiROM Mapping](rom-mapping-hirom.md) - HiROM SRAM location
