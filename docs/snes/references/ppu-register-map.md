# SNES PPU Register Map

## S-PPU Registers ($2100-$213F)

| Address | Name | Description |
|---------|------|-------------|
| $2100 | INIDISP | Screen display (forced blank, brightness) |
| $2101 | OBSEL | Object size and character size |
| $2102-$2103 | OAMADDL/H | OAM address |
| $2104 | OAMDATA | OAM data write |
| $2105 | BGMODE | BG mode and character size |
| $2106 | MOSAIC | Mosaic register |
| $2107-$210A | BG1SC-BG4SC | BG tilemap addresses |
| $210B-$210C | BG12NBA, BG34NBA | BG character addresses |
| $210D-$2114 | BG1HOFS-BG4VOFS | BG scroll registers (dual-write) |
| $2115 | VMAINC | VRAM address increment |
| $2116-$2117 | VMADDL/H | VRAM address |
| $2118-$2119 | VMDATAL/H | VRAM data write |
| $211A | M7SEL | Mode 7 settings |
| $211B-$2120 | M7A-M7Y | Mode 7 matrix (dual-write) |
| $2121 | CGADD | CGRAM address |
| $2122 | CGDATA | CGRAM data write (dual-write) |
| $2123-$2125 | W12SEL, W34SEL, WOBJSEL | Window mask settings |
| $2126-$2129 | WH0-WH3 | Window positions |
| $212A-$212B | WBGLOG, WOBJLOG | Window mask logic |
| $212C-$212F | TM, TS, TMW, TSW | Layer enables |
| $2130-$2132 | CGWSEL, CGADSUB, COLDATA | Color math |
| $2133 | SETINI | Screen mode select |
| $2134-$213F | Status/read registers | PPU status registers |

## Common Register Values

### INIDISP
```asm
LDA #$80    ; Forced blanking
STA INIDISP
LDA #$0F    ; Full brightness, no forced blank
STA INIDISP
```

### BGMODE
```asm
STZ BGMODE  ; Mode 0, 8x8 tiles
LDA #$07
STA BGMODE  ; Mode 7
```

### VMAINC
```asm
LDA #$80    ; Increment by 1 word after high byte write
STA VMAINC
```

## Cross-References

- [PPU Documentation](../hardware/ppu/) - Detailed PPU documentation
- [Background Modes](../hardware/ppu/background-modes.md) - Background mode details
