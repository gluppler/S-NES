# SNES Hardware Schematics

Hardware schematics and circuit diagrams for Super Nintendo Entertainment System.

## Available Schematics

### Console Schematics
Located in `pdfs/`:
- **PAL SNES Schematic** (`PAL-SNES_Schematic.pdf`) - Complete PAL SNES console schematic
- **SNES Color Schematic** (`snes_schematic_color.pdf`) - Color-coded SNES schematic

### Component Datasheets
Located in `pdfs/`:
- **BA6592F** (`BA6592F.pdf`) - Audio processor (S-DSP) datasheet
- **WDC 65C816** (`w65c816s.pdf`) - 65816 CPU datasheet
- **SHVC Sound Connector** (`pinout_shvc-sound_connector.pdf`) - Audio connector pinout

### Development Manuals
Located in `pdfs/`:
- **SNES Development Manual 1** (`snes-dev1.pdf`) - Official SNES development manual part 1
- **SNES Development Manual 2** (`snes-dev2.pdf`) - Official SNES development manual part 2

### KiCad Schematics
Located in `kicad/`:
- **S-CPU KiCad Project** (`S-CPU_kicad/`) - KiCad schematic project for SNES CPU board
  - Multiple revision outputs (0.1, 0.2, etc.)
  - Complete PCB layouts and schematics

## Directory Structure

```
schematics/snes/
├── pdfs/              # PDF schematics and datasheets
│   ├── PAL-SNES_Schematic.pdf
│   ├── snes_schematic_color.pdf
│   ├── BA6592F.pdf
│   ├── w65c816s.pdf
│   ├── pinout_shvc-sound_connector.pdf
│   ├── snes-dev1.pdf
│   └── snes-dev2.pdf
└── kicad/             # KiCad schematic projects
    └── S-CPU_kicad/    # SNES CPU board KiCad project
```

## Source and Credits

### PDF Schematics
- **PAL SNES Schematic** - Official Nintendo development documentation / Hardware reverse engineering
- **SNES Color Schematic** - Community documentation
- **BA6592F.pdf** - Ricoh BA6592F (S-DSP) datasheet
- **w65c816s.pdf** - Western Design Center 65C816 CPU datasheet
- **pinout_shvc-sound_connector.pdf** - SHVC sound connector pinout documentation
- **snes-dev1.pdf, snes-dev2.pdf** - Official Nintendo SNES development manuals

### KiCad Schematics
- **S-CPU KiCad Project** - [SNES S-CPU Schematics](https://github.com/SmellyGhost/SNES_S-CPU_Schematics) by SmellyGhost
  - Complete KiCad schematic project for SNES CPU board
  - Multiple revision outputs (0.1, 0.2, etc.)

## Related Documentation

- [SNES Documentation](../../docs/snes/README.md) - Complete SNES documentation
- [Hardware Overview](../../docs/snes/getting-started/01-hardware-overview.md) - System architecture
- [CPU Documentation](../../docs/snes/hardware/cpu-65816/) - 65816 processor details
- [Audio Documentation](../../docs/snes/hardware/audio-spc700/) - SPC700/S-DSP details

## Note

This directory serves as an index and reference point for SNES hardware schematics. PDFs are ready to view, and KiCad projects can be opened in KiCad for editing.
