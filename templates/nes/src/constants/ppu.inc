; ============================================================================
; PPU Constants
; ============================================================================
; Per NES documentation: PPU register addresses and constants
; ============================================================================

.ifndef PPU_CONSTANTS_INC
PPU_CONSTANTS_INC = 1

; PPU registers (NES hardware addresses: $2000-$2007)
PPUCTRL = $2000      ; PPU control register
PPUMASK = $2001      ; PPU mask register
PPUSTATUS = $2002    ; PPU status register
OAMADDR = $2003       ; OAM address register
OAMDATA = $2004       ; OAM data register
PPUSCROLL = $2005    ; PPU scroll register
PPUADDR = $2006       ; PPU address register
PPUDATA = $2007       ; PPU data register

; PPUCTRL bits
PPUCTRL_NMI_ENABLE = %10000000
PPUCTRL_PPU_MASTER = %00000000
PPUCTRL_SPRITE_8X16 = %00100000
PPUCTRL_BG_TABLE = %00010000
PPUCTRL_SPRITE_TABLE = %00001000
PPUCTRL_VRAM_INC = %00000100
PPUCTRL_NAMETABLE_0 = %00000000
PPUCTRL_NAMETABLE_1 = %00000001
PPUCTRL_NAMETABLE_2 = %00000010
PPUCTRL_NAMETABLE_3 = %00000011

; PPUMASK bits
PPUMASK_GRAYSCALE = %00000001
PPUMASK_SHOW_BG_LEFT = %00000010
PPUMASK_SHOW_SPRITES_LEFT = %00000100
PPUMASK_SHOW_BG = %00001000
PPUMASK_SHOW_SPRITES = %00010000
PPUMASK_EMPHASIZE_RED = %00100000
PPUMASK_EMPHASIZE_GREEN = %01000000
PPUMASK_EMPHASIZE_BLUE = %10000000

; PPUSTATUS bits
PPUSTATUS_VBLANK = %10000000
PPUSTATUS_SPRITE_0_HIT = %01000000
PPUSTATUS_SPRITE_OVERFLOW = %00100000

; Name table addresses
NAMETABLE_0 = $2000
NAMETABLE_1 = $2400
NAMETABLE_2 = $2800
NAMETABLE_3 = $2C00

; Attribute table addresses
ATTRTABLE_0 = $23C0
ATTRTABLE_1 = $27C0
ATTRTABLE_2 = $2BC0
ATTRTABLE_3 = $2FC0

; Palette addresses
PALETTE_BG_START = $3F00
PALETTE_SPRITE_START = $3F10
PALETTE_SIZE = 32       ; 32 bytes total (8 palettes × 4 colors)
BG_COLOR    = $3F00

; Color constants (matching hello_world exactly)
; NES palette uses 6-bit color values directly, not bitwise OR
BLACK       = $1D
WHITE_DARK  = $30  ; White with dark shade
WHITE_NEUTRAL = $30  ; White with neutral shade (same as dark for simplicity)
WHITE_LIGHT = $30  ; White with light shade (same as dark for simplicity)
; For hello_world compatibility, keep the OR syntax but use direct values
WHITE       = $30
DARK        = $00
NEUTRAL     = $10
LIGHT       = $20

; Name table dimensions
NAMETABLE_WIDTH = 32    ; 32 tiles wide
NAMETABLE_HEIGHT = 30   ; 30 tiles tall
NAMETABLE_SIZE = 960    ; 960 bytes (32 × 30)
ATTRTABLE_SIZE = 64     ; 64 bytes

.endif ; PPU_CONSTANTS_INC
