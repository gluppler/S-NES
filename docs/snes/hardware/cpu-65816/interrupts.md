# 65816 Interrupts

## Overview

65816 supports multiple interrupt types: NMI, IRQ, COP, and BRK.

## Interrupt Types

### NMI (Non-Maskable Interrupt)
- **Triggered**: By PPU at start of VBlank
- **Maskable**: No (always fires if enabled)
- **Handler**: NMI handler
- **Use**: VBlank processing

### IRQ (Interrupt Request)
- **Triggered**: By H/V count timers or external
- **Maskable**: Yes (I flag)
- **Handler**: IRQ handler
- **Use**: Per-scanline effects, timers

### COP (Coprocessor)
- **Triggered**: COP instruction
- **Use**: Coprocessor communication

### BRK (Break)
- **Triggered**: BRK instruction
- **Use**: Debugging

## Interrupt Vectors

### Native Mode Vectors ($00FFE4-$00FFEB)

```
$FFE4: COP
$FFE6: BRK
$FFE8: ABT
$FFEA: NMI
$FFEC: (unused)
$FFEE: IRQ
```

### Emulation Mode Vectors ($00FFF4-$00FFFB)

```
$FFF4: COP
$FFF6: (unused)
$FFF8: ABT
$FFFA: NMI
$FFFC: RST (reset)
$FFFE: IRQ
```

## NMI Setup

```asm
; Enable NMI
lda #$80         ; Bit 7 = NMI enable
sta NMITIMEN      ; $4200

; NMI handler
.proc nmi_handler
    lda RDNMI     ; $4210: Acknowledge NMI
    ; ... VBlank tasks ...
    rti
.endproc
```

## IRQ Setup

```asm
; Enable H-count IRQ
lda #$30         ; H-count IRQ enable
sta NMITIMEN     ; $4200
lda #$00
sta HTIMEL       ; $4207: H-count = 0
lda #$80
sta HTIMEH       ; $4208: H-count = 128

; IRQ handler
.proc irq_handler
    ; ... IRQ tasks ...
    rti
.endproc
```

## Cross-References

- [NMI Handler](../../programming/game-loop/nmi-handler.md) - VBlank handling
- [Frame Synchronization](../../programming/game-loop/frame-synchronization.md) - Frame timing
