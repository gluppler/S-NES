; ============================================================================
; String Data
; ============================================================================
; Text strings for the game
; ============================================================================

.segment "RODATA"

; Template display strings
.export template_str, ready_str
template_str:
    .byte "NES TEMPLATE", 0

ready_str:
    .byte "READY TO CODE", 0
