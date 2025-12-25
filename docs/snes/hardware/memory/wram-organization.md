# WRAM Organization

## Overview

SNES has **128 KB of Work RAM** (WRAM) located at $7E0000-$7FFFFF. This is the main RAM for game variables and data.

## WRAM Address Space

```
$7E0000-$7E1FFF: Low WRAM (8 KB)
$7E2000-$7FFFFF: High WRAM (120 KB)
```

**Total**: 128 KB ($20000 bytes)

## Common WRAM Layout

### Direct Page Area
- **$7E0000-$7E00FF**: Direct page (if DP = $7E0000)
- Fast access (3 cycles)

### OAM Mirror
- **$7E0400-$7E05FF**: OAM mirror (512 bytes sprite data)
- **$7E0600-$7E061F**: OAM size/priority table (32 bytes)
- **Total**: 544 bytes

### Game Variables
- **$7E1000-$7EFFFF**: Game-specific variables
- Entity data, game state, etc.

### Buffers
- **$7E2000-$7EFFFF**: Rendering buffers, tilemaps, etc.

## Direct Page Strategy

You can set direct page to WRAM base:

```asm
LDA #$7E0000
TCD      ; Direct page = $7E0000
; Now $00-$FF addresses access $7E0000-$7E00FF (fast!)
```

## WRAM Access Speed

- **Direct Page Access**: 3 cycles (fast)
- **Absolute Access**: 4-5 cycles
- **Absolute Long Access**: 5 cycles

## Memory Organization Patterns

### Struct-of-Arrays

```asm
; All X positions together
entity_x = $7E1000      ; 10 entities × 1 byte = 10 bytes
entity_y = $7E100A      ; 10 entities × 1 byte = 10 bytes
entity_vx = $7E1014     ; 10 entities × 1 byte = 10 bytes
```

### Array-of-Structs

```asm
; Each entity is a struct
entity_size = 8
entity_data = $7E1000   ; 10 entities × 8 bytes = 80 bytes
; Entity 0: X(1), Y(1), VX(1), VY(1), Type(1), State(1), Timer(1), Flags(1)
```

## Cross-References

- [Direct Page Usage](../../programming/initialization/cpu-init.md) - Direct page setup
- [Memory Map Reference](../../references/memory-map-reference.md) - Complete memory map
- [Data-Oriented Design](../../programming/memory-organization.md) - Memory layout strategies
