# OAM System

## Overview

OAM (Object Attribute Memory) stores sprite data. SNES supports **128 sprites** with a **32 per scanline limit**.

## OAM Structure

### Sprite Data (512 bytes)

128 sprites × 4 bytes each:
- **Byte 0**: Y position (0-255, 255 = off-screen)
- **Byte 1**: Tile index (0-255)
- **Byte 2**: Attributes (palette, priority, flip)
- **Byte 3**: X position (0-255, bit 9 in size table)

### Size/Priority Table (32 bytes)

4 sprites per byte:
- **Bits 0-1**: Sprite 0 size bit
- **Bits 2-3**: Sprite 1 size bit
- **Bits 4-5**: Sprite 2 size bit
- **Bits 6-7**: Sprite 3 size bit

**Total**: 544 bytes (512 + 32)

## Sprite Attributes (Byte 2)

```
Bit 7: Vertical flip (1 = flipped)
Bit 6: Horizontal flip (1 = flipped)
Bit 5: Priority (1 = behind background)
Bits 3-4: Unused
Bits 0-2: Palette (0-7)
```

## Sprite Limits

- **Total sprites**: 128
- **Per scanline**: 32 maximum
- **Overflow**: Sprites beyond 32 are not rendered

## OAM Access

- **During rendering**: Read-only
- **During VBlank**: Read/write
- **Update method**: DMA (channel 0, 544 bytes)

## OAM Mirror

Maintain OAM data in WRAM:
- **OAM_MIRROR**: 512 bytes sprite data
- **OAM_HI_MIRROR**: 32 bytes size/priority table
- **Update via DMA**: During VBlank

## Cross-References

- [OAM Mirror](../../programming/rendering/oam-mirror.md) - WRAM sprite buffer
- [DMA OAM Updates](../../programming/rendering/dma-oam-updates.md) - DMA transfer code
