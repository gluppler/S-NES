; ============================================================================
; Direct Page Memory Definitions (Legacy Zero Page)
; ============================================================================
; SNES uses direct page ($0000-$FFFF, 64 KB) instead of zero page (256 bytes)
; Direct page access is faster (3 cycles vs 4-5 cycles for absolute addressing)
; 
; Note: This file uses "zeropage" name for compatibility, but SNES uses
; direct page. See direct_page.inc for proper SNES direct page definitions.
; See ../../docs/snes/hardware/cpu-65816/addressing-modes.md
; ============================================================================

.ifndef SNES_ZEROPAGE_INC
SNES_ZEROPAGE_INC = 1

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
;   player_x = $09      ; Player X position
;   player_y = $0A       ; Player Y position
;   score = $0B          ; Score (low byte)
;   score_high = $0C    ; Score (high byte)

.endif ; SNES_ZEROPAGE_INC
