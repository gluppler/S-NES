# DMA/HDMA Quick Reference

## DMA Channel 0 (OAM)

```asm
lda #%00000010      ; Mode 2: 1 register write twice
sta DMAP0           ; $4300
lda #$04            ; OAMDATA ($2104)
sta BBAD0           ; $4301
lda #<OAM_MIRROR
sta A1T0L           ; $4302
lda #>OAM_MIRROR
sta A1T0H           ; $4303
stz A1T0B           ; $4304
ldx #544            ; 544 bytes
stx DAS0L           ; $4305-$4306
lda #$01            ; Enable channel 0
sta MDMAEN          ; $420B
```

## DMA Channel 1 (VRAM)

```asm
lda #%00000001      ; Mode 1: 2 registers write once
sta DMAP1           ; $4310
lda #$18            ; VMDATAL ($2118)
sta BBAD1           ; $4311
lda #<vram_data
sta A1T1L           ; $4312
lda #>vram_data
sta A1T1H           ; $4313
lda #^vram_data
sta A1B1             ; $4314
ldx #size
stx DAS1L           ; $4315-$4306
lda #$02            ; Enable channel 1
sta MDMAEN          ; $420B
```

## HDMA Setup

```asm
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
    .byte $00         ; End marker
```

### Indirect Transfer
```asm
hdma_table:
    .byte 8, <data1, >data1    ; 8 scanlines: pointer to data1
    .byte $00                 ; End marker
```

## Cross-References

- [DMA/HDMA Documentation](../hardware/dma-hdma/) - Complete DMA/HDMA docs
- [DMA OAM Updates](../programming/rendering/dma-oam-updates.md) - OAM DMA patterns
