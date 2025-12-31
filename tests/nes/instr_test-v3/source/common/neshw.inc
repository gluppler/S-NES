; NES I/O locations and masks

.ifndef BUILD_NSF

; PPU
PPUCTRL = $2000
PPUMASK = $2001
PPUSTATUS = $2002
SPRADDR   = $3
SPRDATA   = $4
PPUSCROLL = $2005
PPUADDR = $2006
PPUDATA = $2007
SPRDMA    = $4

PPUCTRL_NMI     = $80
PPUMASK_BG0     = $0A
PPUCTRL_8X8     = $00
PPUCTRL_8X16    = $20
PPUMASK_SPR     = $14
PPUMASK_BG0CLIP = $08

.endif

; APU
SNDCHN  = $5
JOY1    = $6
JOY2    = $7
SNDMODE = $7

SNDMODE_NOIRQ   = $40

.ifndef REGION_FREE
	.ifndef PAL_ONLY
		.ifndef NTSC_ONLY
			NTSC_ONLY = 1
		.endif
	.endif
.else
	.ifdef NTSC_ONLY
		.error "NTSC_ONLY and REGION_FREE defined"
	.endif
	.ifdef PAL_ONLY
		.error "PAL_ONLY and REGION_FREE defined"
	.endif
.endif

.ifdef NTSC_ONLY
	CLOCK_RATE = 1789773
	PPU_FRAMELEN = 29781
.endif

.ifdef PAL_ONLY
	CLOCK_RATE = 1662607
	PPU_FRAMELEN = 33248
.endif
