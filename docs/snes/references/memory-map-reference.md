# SNES Memory Map Quick Reference

## CPU Memory Map

### WRAM
- **$7E0000-$7FFFFF**: Work RAM (128 KB)

### ROM
- **$008000-$00FFFF**: Bank $00 (LoROM)
- **$808000-$80FFFF**: Bank $80 (LoROM, fast ROM)
- **Banks $00-$7F**: Slow ROM (2.68 MHz)
- **Banks $40-$7D, $C0-$FF**: Fast ROM (3.58 MHz, if enabled)

### I/O Registers
- **$2100-$213F**: S-PPU registers
- **$2140-$2143**: SPC700 communication
- **$2180-$2183**: WRAM data port
- **$4200-$421F**: S-CPU I/O registers
- **$4300-$43FF**: DMA registers

## PPU Memory Map

### VRAM
- **64 KB**: Accessed via $2116-$2119
- **Word-addressed**: Write to VMDATAL, then VMDATAH

### CGRAM
- **512 bytes**: 256 colors × 2 bytes
- **Accessed via**: $2121-$2122
- **Dual-write**: Low byte, then high byte

### OAM
- **544 bytes**: 512 bytes sprite data + 32 bytes size table
- **Accessed via**: $2102-$2104
- **128 sprites**: 4 bytes per sprite

## Direct Page

- **64 KB page**: Set with TCD instruction
- **Common**: $0000, $0300, $7E0000
- **Fast access**: 3 cycles vs 4-5 cycles

## Stack

- **Location**: $000100-$0001FF (256 bytes)
- **Top**: $01FF
- **Set with**: `ldx #$01FF; txs`

## Cross-References

- [WRAM Organization](../hardware/memory/wram-organization.md) - WRAM layout
- [LoROM Mapping](../hardware/memory/rom-mapping-lorom.md) - ROM mapping
- [MMIO Registers](../hardware/memory/mmio-registers.md) - I/O register details
