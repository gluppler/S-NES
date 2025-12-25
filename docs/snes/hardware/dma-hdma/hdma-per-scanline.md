# HDMA Per-Scanline Effects

## Overview

HDMA (H-Blank DMA) transfers data during H-Blank (between scanlines), enabling per-scanline effects like color changes, windowing, and Mode 7 transformations.

## HDMA vs General DMA

- **General DMA**: One-time transfer, completes immediately
- **HDMA**: Per-scanline transfer, runs automatically during rendering

## HDMA Setup

```asm
; Configure HDMA channel
lda #%00000000      ; Mode 0: fixed transfer
sta DMAP1           ; $4310
lda #$32            ; COLDATA ($2132)
sta BBAD1           ; $4311
lda #<hdma_table
sta A2A1L           ; $4317
lda #>hdma_table
sta A2A1H           ; $4318
lda #^hdma_table
sta A2B1             ; $4319
lda #$02            ; Enable channel 1
sta HDMAEN          ; $420C
```

## HDMA Table Format

### Fixed Transfer

```asm
hdma_table:
    .byte 8, $E0      ; 8 scanlines: value $E0
    .byte 16, $1C     ; 16 scanlines: value $1C
    .byte $00         ; End marker
```

### Indirect Transfer

```asm
hdma_table:
    .byte 8, <data1, >data1    ; 8 scanlines: pointer to data1
    .byte 16, <data2, >data2    ; 16 scanlines: pointer to data2
    .byte $00                   ; End marker
```

## Common HDMA Effects

### Per-Scanline Color Changes

```asm
; Change COLDATA every scanline
hdma_color_table:
    .byte 224, $E0    ; 224 scanlines: red component
    .byte $00         ; End marker
```

### Window Effects

```asm
; Change window position per scanline
hdma_window_table:
    .byte 112, $00, $80  ; 112 scanlines: window left=0, right=128
    .byte 112, $80, $FF  ; 112 scanlines: window left=128, right=255
    .byte $00
```

## HDMA Timing

- **Per-scanline overhead**: 8-24 cycles
- **Frame overhead**: 1,792-5,376 cycles (NTSC)
- **Runs during**: H-Blank (between scanlines)

## Cross-References

- [General DMA](general-dma.md) - One-time DMA transfers
- [DMA Channels](dma-channels.md) - Channel configuration
- [HDMA Effects](../../techniques/hdma-effects/) - Per-scanline effect techniques
