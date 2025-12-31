# NES CPU (RP2A03 / RP2A07)

> **Status**: This is a stub. For complete CPU documentation, see [NESdev Wiki - CPU](https://www.nesdev.org/wiki/CPU).

## Overview

The NES CPU is based on the MOS 6502 with modified addressing and integrated APU.

### Key Specifications

- **Clock Speed**: 
  - NTSC (RP2A03): ~1.789773 MHz
  - PAL (RP2A07): ~1.662607 MHz
- **Architecture**: 8-bit accumulator, 16-bit address bus
- **Registers**: A, X, Y, SP, PC, P (status)

## Registers

### Accumulator (A)
8-bit register for arithmetic and logic operations.

### Index Registers (X, Y)
8-bit registers for indexing and counting.

### Stack Pointer (SP)
8-bit pointer to stack ($0100-$01FF).

### Program Counter (PC)
16-bit register pointing to next instruction.

### Status Register (P)
```
NV-BDIZC
|||||||└─ Carry
||||||└── Zero
|||||└─── IRQ Disable
||||└──── Decimal (unused on NES)
|||└───── Break
||└────── Unused
|└─────── Overflow
└──────── Negative
```

## Addressing Modes

See [NESdev Wiki - CPU Addressing Modes](https://www.nesdev.org/wiki/CPU_addressing_modes)

## Instruction Set

For complete instruction reference, see:
- [NESdev Wiki - 6502 Instructions](https://www.nesdev.org/wiki/6502_instructions)
- [6502.org Reference](http://www.6502.org/tutorials/6502opcodes.html)

## Cycle Timing

Each instruction takes 2-7 cycles. See [NESdev Wiki - Cycle Reference Chart](https://www.nesdev.org/wiki/Cycle_reference_chart)

## Resources

- [NESdev Wiki - CPU](https://www.nesdev.org/wiki/CPU)
- [6502.org](http://www.6502.org/)
- [Visual 6502](http://www.visual6502.org/)
