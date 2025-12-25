; ============================================================================
; Sprite DMA
; ============================================================================
; OAM DMA utilities for sprite updates
; ============================================================================

.p816
.export sprite_dma_update
.import oam_dma_update
.include "../headers/snes_registers.inc"
.include "../headers/memory/wram_map.inc"

.segment "CODE"

; ============================================================================
; Sprite DMA Update
; ============================================================================
; Updates OAM via DMA (wrapper for oam_dma_update)
; ============================================================================
.proc sprite_dma_update
    ; This is a wrapper - actual DMA is in dma/oam_dma.asm
    jsr oam_dma_update
    rts
.endproc
