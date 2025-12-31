; Copyright 2010 Damian Yerrick
;
; Copying and distribution of this file, with or without
; modification, are permitted in any medium without royalty
; provided the copyright notice and this notice are preserved.
; This file is offered as-is, without any warranty.

PPUCTRL = $0
NT_2000 = $00
NT_2400 = $01
NT_2800 = $02
NT_2C00 = $03
VRAM_DOWN = $04
OBJ_0000 = $00
OBJ_1000 = $08
OBJ_8X16 = $20
BG_0000 = $00
BG_1000 = $10
VBLANK_NMI = $80

PPUMASK = $1
LIGHTGRAY = $01
BG_OFF = $00
BG_CLIP = $08
BG_ON = $0A
OBJ_OFF = $00
OBJ_CLIP = $10
OBJ_ON = $14
TINT_R = $20
TINT_G = $40
TINT_B = $80

PPUSTATUS = $2
OAMADDR = $3
PPUSCROLL = $5
PPUADDR = $6
PPUDATA = $7

OAM_DMA = $4
SNDCHN = $5
P1 = $6
P2 = $7

KEY_A      = %10000000
KEY_B      = %01000000
KEY_SELECT = %00100000
KEY_START  = %00010000
KEY_UP     = %00001000
KEY_DOWN   = %00000100
KEY_LEFT   = %00000010
KEY_RIGHT  = %00000001
