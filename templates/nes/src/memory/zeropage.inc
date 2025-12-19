; ============================================================================
; Zero Page Memory Definitions
; ============================================================================
; Per NES documentation: Zero page ($0000-$00FF) for frequently accessed data
; Zero page access is faster (3 cycles vs 4 cycles for absolute addressing)
; 
; Memory layout follows data-oriented design principles
; ============================================================================

.ifndef ZEROPAGE_INC
ZEROPAGE_INC = 1

; Temporary variables
zp_temp = $00           ; Temporary variable
zp_temp2 = $01          ; Second temporary variable
zp_ptr = $02            ; 16-bit pointer (low byte at $02, high byte at $03)

; Frame synchronization
frame_counter = $04     ; Frame counter
frame_ready = $05       ; Frame synchronization flag

; Scrolling
scroll_x = $06          ; Horizontal scroll position
scroll_y = $07          ; Vertical scroll position

; PPU control
ppu_ctrl = $08          ; PPU control register value

; ADD CODE HERE: Your zero page variables
; Recommended locations: $09-$7F (avoid $00-$08 which are used by template)
; Example:
;   player_x = $0B      ; Player X position
;   player_y = $0C      ; Player Y position
;   score = $0D         ; Score (low byte)
;   score_high = $0E    ; Score (high byte)

.endif ; ZEROPAGE_INC
