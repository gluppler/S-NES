; ============================================================================
; Palette Data
; ============================================================================
; Per NES documentation: Palette color data
; ============================================================================

palette_data:
    ; Background palettes - black background, white text
    .byte $0F, $0F, $0F, $0F  ; Background palette 0: black background, white text
    .byte $0F, $0F, $0F, $0F  ; Background palette 1: black background, white text
    .byte $0F, $0F, $0F, $0F  ; Background palette 2: black background, white text
    .byte $0F, $0F, $0F, $0F  ; Background palette 3: black background, white text
    ; Sprite palettes
    .byte $0F, $16, $27, $18  ; Sprite palette 0
    .byte $0F, $16, $27, $18  ; Sprite palette 1
    .byte $0F, $16, $27, $18  ; Sprite palette 2
    .byte $0F, $16, $27, $18  ; Sprite palette 3
