; ============================================================================
; Direct Page Memory Definitions
; ============================================================================
; SNES direct page ($0000-$FFFF) for frequently accessed data
; Direct page access is faster (3 cycles vs 4-5 cycles for absolute addressing)
; 
; Note: SNES uses "direct page" (64 KB) instead of "zero page" (256 bytes)
; See ../../docs/snes/hardware/cpu-65816/addressing-modes.md
; ============================================================================

.ifndef SNES_DIRECT_PAGE_INC
SNES_DIRECT_PAGE_INC = 1

; Direct page base (set with TCD instruction)
; Common: $0000, $0300, $7E0000 (WRAM base)

; Temporary variables
dp_temp = $00           ; Temporary variable
dp_temp2 = $01          ; Second temporary variable
dp_ptr = $02            ; 16-bit pointer (low byte at $02, high byte at $03)

; Frame synchronization
frame_counter = $04     ; Frame counter
frame_ready = $05       ; Frame synchronization flag

; Scrolling
scroll_x = $06          ; Horizontal scroll position (low)
scroll_x_hi = $07       ; Horizontal scroll position (high)
scroll_y = $08          ; Vertical scroll position (low)
scroll_y_hi = $09       ; Vertical scroll position (high)

; PPU control
ppu_brightness = $0A    ; INIDISP brightness value

; ADD CODE HERE: Your direct page variables
; Recommended locations: $0B-$FF (avoid $00-$0A which are used by template)
; Example:
;   player_x = $0B      ; Player X position
;   player_y = $0C      ; Player Y position
;   score = $0D          ; Score (low byte)
;   score_high = $0E    ; Score (high byte)

.endif ; SNES_DIRECT_PAGE_INC
