; ============================================================================
; OAM (Object Attribute Memory) Definitions
; ============================================================================
; SNES OAM structure: 128 sprites, 544 bytes total
; See ../../docs/snes/hardware/ppu/oam-system.md
; See ../../docs/snes/programming/rendering/oam-mirror.md
; ============================================================================

.ifndef SNES_OAM_INC
SNES_OAM_INC = 1

; OAM Mirror in WRAM
OAM_MIRROR = $7E0400      ; OAM mirror (512 bytes sprite data)
OAM_HI_MIRROR = $7E0600   ; OAM size/priority table (32 bytes)
OAM_SIZE = 544            ; Total OAM size (512 + 32)

; Sprite structure (4 bytes per sprite)
SPRITE_SIZE = 4           ; 4 bytes per sprite
MAX_SPRITES = 128         ; Maximum number of sprites (SNES has 128)

; Sprite attribute bits
SPRITE_PALETTE_MASK = %00000011
SPRITE_PRIORITY = %00100000  ; Behind background
SPRITE_FLIP_H = %01000000    ; Flip horizontally
SPRITE_FLIP_V = %10000000    ; Flip vertically

; Sprite state arrays (struct-of-arrays pattern)
sprite_x = $7E1000        ; Sprite X positions (128 bytes)
sprite_y = $7E1080        ; Sprite Y positions (128 bytes)
sprite_tile = $7E1100     ; Sprite tile indices (128 bytes)
sprite_attr = $7E1180     ; Sprite attributes (128 bytes)
sprite_active = $7E1200   ; Sprite active flags (128 bytes)

.endif ; SNES_OAM_INC
