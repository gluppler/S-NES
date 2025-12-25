# SNES Tile Formats

## Overview

SNES supports multiple tile formats depending on background mode: 2bpp, 4bpp, and 8bpp.

## 2bpp Format (4 colors per tile)

Used in Mode 0:
- **8×8 pixels**: 64 pixels per tile
- **2 bits per pixel**: 4 colors per tile
- **16 bytes per tile**: 64 pixels × 2 bits = 128 bits = 16 bytes

### Bitplane Organization

```
Byte 0: Bitplane 0, row 0
Byte 1: Bitplane 1, row 0
Byte 2: Bitplane 0, row 1
Byte 3: Bitplane 1, row 1
...
```

## 4bpp Format (16 colors per tile)

Used in Modes 1, 2, 5, 6:
- **8×8 pixels**: 64 pixels per tile
- **4 bits per pixel**: 16 colors per tile
- **32 bytes per tile**: 64 pixels × 4 bits = 256 bits = 32 bytes

### Bitplane Organization

```
Bytes 0-7:   Bitplanes 0,1 (rows 0-7)
Bytes 8-15:  Bitplanes 2,3 (rows 0-7)
```

## 8bpp Format (256 colors per tile)

Used in Modes 3, 4, 7:
- **8×8 pixels**: 64 pixels per tile
- **8 bits per pixel**: 256 colors per tile
- **64 bytes per tile**: 64 pixels × 8 bits = 512 bits = 64 bytes

### Bitplane Organization

```
Bytes 0-7:   Bitplanes 0,1 (rows 0-7)
Bytes 8-15:  Bitplanes 2,3 (rows 0-7)
Bytes 16-23: Bitplanes 4,5 (rows 0-7)
Bytes 24-31: Bitplanes 6,7 (rows 0-7)
```

## Sprite Tiles

Sprites always use **4bpp** (16 colors per tile):
- **8×8 or 16×16 or 32×32 or 64×64**: Configurable sizes
- **32 bytes per 8×8 tile**: Same as 4bpp background tiles

## Cross-References

- [Background Modes](background-modes.md) - Which modes use which formats
- [OAM System](oam-system.md) - Sprite tile format
