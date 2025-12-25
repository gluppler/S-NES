# ExHiROM Mapping

## Overview

ExHiROM (Extended HiROM) extends HiROM to support ROMs larger than 4 MB.

## ExHiROM Address Space

ExHiROM maps ROM in two ranges:
- **$C00000-$FFFFFF**: First 4 MB (like HiROM)
- **$400000-$7FFFFF**: Additional 4 MB

**Total**: Up to 8 MB

## ExHiROM Features

- **Large ROM support**: Up to 48 MB total
- **Complex mapping**: Multiple address ranges
- **Rare**: Used by very large games

## Usage

ExHiROM is used by:
- **Tales of Phantasia**: Large RPG
- **Street Fighter Alpha 2**: Large fighting game
- **Other large games**: Games requiring >4 MB ROM

## Cross-References

- [HiROM Mapping](rom-mapping-hirom.md) - Standard HiROM
- [LoROM Mapping](rom-mapping-lorom.md) - Most common mapping
