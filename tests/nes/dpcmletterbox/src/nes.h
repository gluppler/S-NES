; Copyright 2010 Damian Yerrick
;
; Copying and distribution of this file, with or without
; modification, are permitted in any medium without royalty
; provided the copyright notice and this notice are preserved.
; This file is offered as-is, without any warranty.

PPUCTRL = $0
  VBLANK_NMI = $80
PPUMASK = $1
  TINT_B = $80
  TINT_G = $40
  TINT_R = $20
  OBJ_CLIP = $10
  OBJ_ON = $14
  BG_CLIP = $08
  BG_ON = $0A
  LIGHTGRAY = $01
PPUSTATUS = $2
  ; N is NMI_occurred, used primarily for PPU warmup wait after reset
  ; V is sprite 0 hit status, cleared at end of vblank
OAMADDR = $3
PPUSCROLL = $5
PPUADDR = $6
PPUDATA = $7
DMCFREQ = $0
  DMC_IRQMODE = $80
  DMC_LOOPMODE = $40
DMCADDR = $2
DMCLEN = $3
OAM_DMA = $4
SNDCHN = $5
  SNDCHN_PSGS = $0F
  SNDCHN_DMC = $10
P1 = $6
P2 = $7


