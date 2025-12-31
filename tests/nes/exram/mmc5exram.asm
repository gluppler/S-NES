;NES Copper Bars demo
;Run program for description
;Quietust, 2004/10/06

.org $0000
ptr:		.block 2	;for initializing VRAM
vbflag:		.block 1	;signal when we've gotten an NMI
overflow:	.block 1	;1/3 cycle counter

rbars:	.block $06	;this holds the position of each bar
ctabl:	.block $02	;(padding)
	.block $C0	;this stores the colour of each scanline

.org $C000
.fill $E000-*,$FF
text:
..byte "                                "
..byte "   MMC5 Executable ExRAM Test   "
..byte "________________________________"
..byte "                                "
..byte "  This is basically just my     "
..byte "  'copper bars' test program,   "
..byte "  except I've modified it so    "
..byte "  the code that determines      "
..byte "  where each color bar should   "
..byte "  be displayed during each      "
..byte "  frame is not executed from    "
..byte "  ROM, but is copied into the   "
..byte "  MMC5's ExRAM during startup   "
..byte "  and then executed from there  "
..byte "  during each VBLANK.           "
..byte "                                "
..byte "  A proper emulator will be     "
..byte "  able to handle this without   "
..byte "  any problems, including both  "
..byte "  Nintendulator and Nestopia.   "
..byte "  In Nintendulator, though,     "
..byte "  the debugger will display FF  "
..byte "  even though it's executing    "
..byte "  real code, since it thinks    "
..byte "  the region contains I/O       "
..byte "  registers rather than RAM.    "
..byte "________________________________"
..byte "                                "
..byte "      Written by Quietust       "
..byte "                                "
..byte $00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$00,$00,$00


rast_start1:
.org $5C00
rast_start2:
		;Raster bar table generator
		;written by Kevin Horton

do_rast:	LDX #$00	;updates the raster buffer
		TXA

clrast:		STA ctabl,x	;clear out all rasters
		INX
		CPX #$C2
		BNE clrast

		CLC		;only have to do this once here
		LDX #$05	;# of raster bars to do (minus 1)

dr_loop:	LDA rbars,x 
		INC rbars,x	;get & inc raster bar
		TAY
		LDA sinetab,y	;get position
		TAY
		LDA coltab,x	;get starting colour
		ORA #$80
		STA ctabl+0,y	;store the 1s
		STA ctabl+4,y
		ORA #$40
		STA ctabl+1,y	;then the 2s
		STA ctabl+3,y
		ORA #$20
		STA ctabl+2,y	;then 3, for "12321"
		DEX
		BPL dr_loop
		RTS

rast_init:	LDX #$05	;initalizes the raster bar positions
ri1:		TXA
		ASL A
		ASL A
		ASL A
		ASL A
		STA rbars,x
		DEX
		BPL ri1

		LDX #$00
		TXA

ri2:		STA ctabl,x	;clear out all raster bars
		INX
		BPL ri2
		RTS
rast_end2:
.org rast_start1 + (rast_end2 - rast_start2)
rast_end1:

coltab:
..byte $14,$10,$18,$08,$0C,$04

sinetab:     
..byte $5F,$61,$64,$66,$68,$6B,$6D,$6F,$72,$74,$76,$78,$7B,$7D,$7F,$81
..byte $83,$85,$88,$8A,$8C,$8E,$90,$92,$94,$96,$98,$99,$9B,$9D,$9F,$A1
..byte $A2,$A4,$A5,$A7,$A8,$AA,$AB,$AD,$AE,$AF,$B0,$B2,$B3,$B4,$B5,$B6
..byte $B7,$B8,$B8,$B9,$BA,$BB,$BB,$BC,$BC,$BD,$BD,$BD,$BE,$BE,$BE,$BE
..byte $BE,$BE,$BE,$BE,$BE,$BD,$BD,$BD,$BC,$BC,$BB,$BB,$BA,$B9,$B8,$B8
..byte $B7,$B6,$B5,$B4,$B3,$B2,$B0,$AF,$AE,$AD,$AB,$AA,$A8,$A7,$A5,$A4
..byte $A2,$A1,$9F,$9D,$9B,$99,$98,$96,$94,$92,$90,$8E,$8C,$8A,$88,$85
..byte $83,$81,$7F,$7D,$7B,$78,$76,$74,$72,$6F,$6D,$6B,$68,$66,$64,$61
..byte $5F,$5D,$5A,$58,$56,$53,$51,$4F,$4C,$4A,$48,$46,$43,$41,$3F,$3D
..byte $3B,$39,$36,$34,$32,$30,$2E,$2C,$2A,$28,$26,$25,$23,$21,$1F,$1D
..byte $1C,$1A,$19,$17,$16,$14,$13,$11,$10,$0F,$0E,$0C,$0B,$0A,$09,$08
..byte $07,$06,$06,$05,$04,$03,$03,$02,$02,$01,$01,$01,$00,$00,$00,$00
..byte $00,$00,$00,$00,$00,$01,$01,$01,$02,$02,$03,$03,$04,$05,$06,$06
..byte $07,$08,$09,$0A,$0B,$0C,$0E,$0F,$10,$11,$13,$14,$16,$17,$19,$1A
..byte $1C,$1D,$1F,$21,$23,$25,$26,$28,$2A,$2C,$2E,$30,$32,$34,$36,$39
..byte $3B,$3D,$3F,$41,$43,$46,$48,$4A,$4C,$4F,$51,$53,$56,$58,$5A,$5D

nmi:		PHA
		TXA
		PHA
		TYA
		PHA
		LDA #$00
		STA $3
		LDA #$02
		STA $4
		LDA #$01
		STA vbflag
		LDA #$98
		STA $0
		LDA #$1E
		STA $1
		LDA #$00
		STA $5
		STA $5
		JSR do_rast
		PLA
		TAY
		PLA
		TAX
		PLA
irq:		RTI

reset:		SEI
		CLD
		LDA #$00
		STA $0
		STA $1
		LDX #$02
waitframe:	LDA $2
		BPL waitframe
		DEX
		BPL waitframe
		TXS

		LDA #$00
		TAX
clr_ram:	STA $00,X
		STA $0200,X
		STA $0300,X
		STA $0400,X
		STA $0500,X
		STA $0600,X
		STA $0700,X
		INX
		BNE clr_ram

		LDA #$03
		STA $5100
		LDA #$00
		STA $5101
		LDA #$02
		STA $5104
		LDA #$44
		STA $5105
		LDA #$00
		STA $5127
		STA $512B
		STA $5200
		STA $5204

		LDX #0
exram_init:	LDA rast_start1,X
		STA rast_start2,X
		INX
		CPX #rast_end2-rast_start2
		BNE exram_init

		LDX #$20
		STX $6
		LDY #$00
		STY $6

		LDA #text & $FF
		STA ptr
		LDA #text >> 8
		STA ptr+1

		LDX #$04
init_vram1:	LDA (ptr),Y	;load text for primary NT
		STA $7
		INY
		BNE init_vram1
		INC ptr+1
		DEX
		BNE init_vram1

		LDX #$04
		LDA #$FF
init_vram2:	STA $7	;load white for secondary NT
		INY
		BNE init_vram2
		DEX
		BNE init_vram2

		LDX #$00
		LDA #$F8
spr_init:	STA $0200,X	;move all sprites offscreen
		INX
		INX
		INX
		INX
		BNE spr_init

		LDA #$0F	;except sprite 0, which we'll be using for hit
		STA $0200
		LDA #'_'
		STA $0201	;$0202 and $0203 are already zero, which is just the way I want them

		LDX #$3F
		LDY #$00
		STX $6
		STY $6

		LDX #$08
palloop:	LDA #$1F
		STA $7
		LDA #$1F
		STA $7
		LDY #$00
		STY $7
		LDY #$30
		STY $7
		DEX
		BNE palloop

		LDA #$3F
		STA $6
		LDA #$00
		STA $6
		STA $6
		STA $6

		STA $5
		STA $5		;clear scroll regs
		STA $5		;kill sound
		STA vbflag
                LDA #$C0
                STA $7               ;disable frame IRQs
		JSR rast_init
		LDA #$98
		STA $0
		CLI

loop:		LDA vbflag
		BEQ loop
		LDA #$00
		STA vbflag

spr0off:	BIT $2
		BVS spr0off
spr0on:		BIT $2
		BVC spr0on
		LDX #$FF
		STX overflow
		INX
		LDY #$13
sync:		DEY
		BNE sync
scanloop:	LDA ctabl+2,x		;4
					;cut 6 cycles
		ASL A			;12
		BCC color0		;14
		ASL A			;16
		BCC color1		;18
		ASL A			;20
		BCC color2		;22
		NOP			;24
		NOP			;26
		NOP			;28
		ORA #$01		;30
		NOP			;32
		NOP			;34
		LDY #$0A		;36
c3w:		DEY			;56
		BNE c3w			;85
		LDY #$99		;insert them
		STY $0		;here
		JMP endloop		;88

color2:					;23
		ORA #$01		;25
		NOP			;27
		NOP			;29
		LDY #$0B		;31
c2w:		DEY			;53
		BNE c2w			;85
		LDY #$98		;and
		STY $0		;here
		JMP endloop		;88

color1:					;19
		ASL A			;21
		NOP			;23
		NOP			;25
		NOP			;27
		NOP			;29
		LDY #$0B		;31
c1w:		DEY			;53
		BNE c1w			;85
		LDY #$80		;and
		STY $0		;here
		JMP endloop		;88

color0:					;15
		LDA #$00		;17
		LDY #$0E		;19
c0w:		DEY			;47
		BNE c0w			;88
		LDY #$98		;and
		STY $0		;here

endloop:			;88
		ORA #$1E	;90
		STA $1	;94

		CLC		;96
		LDA overflow	;99
		ADC #$55	;101
		STA overflow	;104
		BCC skip	;106+2/3
skip:		

		INX		;108+2/3
		CPX #$BF	;110+2/3
		BNE scanloop	;113+2/3

		LDY #$11
endw:		DEY
		BNE endw

		LDX #$1E
		LDY #$98
		STX $1
		STY $0
		JMP loop

.fill $FFFA-*,$FF
.org $FFFA
..word nmi
..word reset
..word irq
.end
