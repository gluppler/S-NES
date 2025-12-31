text_loc:
text_lo:	.block 1
text_hi:	.block 1

vramaddy:	.block 1
scanline:	.block 1
carry:		.block 1
ctr:		.block 1
tmp:		.block 1

.org $C000
text:
..byte "                                "
..byte " This is a test for    | Stars  "
..byte " proper mid-scanline   | Below  "
..byte " PPU write emulation   | Denote "
..byte "                       | Errors "
..byte "                                "
..byte " This first area       | ****** "
..byte " toggles D3 of $1   | ****** "
..byte " to toggle background  | ****** "
..byte " rendering at the      | ****** "
..byte " appropriate times     | ****** "
..byte " and locations.        | ****** "
..byte "                                "
..byte "                                "
..byte "                                "
..byte " This second area      | ****** "
..byte " toggles D4 of $0   | ****** "
..byte " to toggle the address | ****** "
..byte " of the background     | ****** "
..byte " pattern table at the  | ****** "
..byte " proper locations.     | ****** "
..byte "                                "
..byte "                                "
..byte "                                "
..byte " This third area uses  | ****** "
..byte " $5/$6 to update | ****** "
..byte " the VRAM address at   | ****** "
..byte " the proper locations. | ****** "
..byte "                                "
..byte "                                "
..byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
..byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

waitframe:	JMP waitframe

reset:		SEI
		CLD
		LDX #$00
		STX $0
		STX $1
		INX
ppuinit:	LDA $2
		BPL ppuinit
		DEX
		BPL ppuinit
		TXS

		LDA #$80
		STA text_hi
		LDA #$00
		STA text_lo
		LDA $2
		LDX #$20
		STX $6
		LDY #$00
		STY $6
init_vram1:	LDA (text_loc),y
		STA $7
		CLC
		LDA text_lo
		ADC #$01
		STA text_lo
		LDA text_hi
		ADC #$00
		STA text_hi
		CMP #$84
		BNE init_vram1

		LDY #$04
		LDX #$00
		LDA #$00
init_vram2:	STA $7
		DEX
		BNE init_vram2
		DEY
		BNE init_vram2		;clear 2nd nametable

		LDA #$FF
init_spr:	STA $0200,X
		DEX
		BNE init_spr		;clear sprite buffer
		
		LDA #$3F
		STA $6
		LDA #$00
		STA $6
		LDA #$00
		STA $7		;palette 0 color 0 == $00
		LDA #$30
		STA $7		;palette 0 color 1 == $30
		STA $7		;palette 0 color 2 == $30
		STA $7		;palette 0 color 3 == $30

		LDA #$00
		STA $5		;kill sound
                LDA #$C0
                STA $7               ;disable frame IRQs
		LDA #$90
		STA $0
		LDA #$00
		STA $5
		STA $5		;clear scroll regs
		JMP waitframe

.fill $C500-*,$FF			;wait 21 scanlines for vblank, 48 scanlines for title text
					;counter: 7833 (69 scanlines - 7 cycles for NMI - 3 latency)
nmi:		LDA #$90		;2
		STA $0		;4
		LDA $2		;4
		LDX #$00		;2
		STX $5		;4
		STX $5		;4
		STX $3		;4
		LDA #$1E		;2
		STA $1		;4
		LDA #$02		;2
		STA $4		;4+512

wait1:		DEX			;512
		BNE wait1		;767
wait2:		DEX			;512
		BNE wait2		;767
wait3:		DEX			;512
		BNE wait3		;767
wait4:		DEX			;512
		BNE wait4		;767
wait5:		DEX			;512
		BNE wait5		;767
					;counter: 890
		LDX #$B0		;2 (num: 176)
wait6:		DEX			;352
		BNE wait6		;527
		STX carry		;3
		SEC			;2
		LDA #$1E		;2 - written to $1, XORed with $08
		LDY #$30		;2 - 48 scanlines worth of stuff here
					;counter: 0

test1:					;counter += 64
					;counter == 64
		LDX #$0B		;2
t1a:		DEX			;22
		BNE t1a			;31
		NOP			;2
		EOR #$08		;2
		STA $1		;4
					;counter: 0
					;counter += 22
					;counter == 22
		LDX #$03		;2
t1b:		DEX			;6
		BNE t1b			;8
		EOR #$08		;2
		STA $1		;4
					;counter: 0
					;counter += 27+2/3
					;counter == 27+2/3
		NOP			;2
		PHA			;3
		LDA carry		;3
		LDA carry		;3
		ADC #$55		;2
		BCC t1c			;2+2/3
t1c:		STA carry		;3
		PLA			;4

		DEY			;2
		BNE test1		;3[/2]
					;counter: 0

					;counter: 1
					;counter += 2728 (24 scanlines minus 1 cycle)
					;counter == 2729
		LDX #$00		;2
m1_1:		DEX			;512
		BNE m1_1		;767
m1_2:		DEX			;512
		BNE m1_2		;767
					;counter: 169
		LDX #$20		;2 (num: 32)
m1_3:		DEX			;64
		BNE m1_3		;95
		NOP			;2
		NOP			;2

		LDA #$90		;2 - written to $0, XORed with #$10 in various places
		LDY #$30		;2 - 48 scanlines worth of stuff here

test2:					;counter += 58+2/3
					;counter == 58+2/3
		LDX #$09		;2
t2a:		DEX			;18
		BNE t2a			;26
		NOP			;2
		NOP			;2
		NOP			;2
		EOR #$10		;2
		STA $0		;4
					;counter: 2/3
					;counter += 26+2/3
					;counter == 27+1/3
		LDX #$04		;2
t2b:		DEX			;8
		BNE t2b			;11
		EOR #$10		;2
		STA $0		;4
					;counter: 1/3
					;counter += 28+1/3
					;counter == 28+2/3
		NOP			;2
		NOP			;2
		NOP			;2

		PHA			;3
		LDA carry		;3
		ADC #$55		;2
		BCC t2c			;2+2/3
t2c:		STA carry		;3
		PLA			;4

		DEY			;2
		BNE test2		;3[/2]
					;counter: 0

					;counter: 1
					;counter += 2728 (24 scanlines)
					;counter == 2729
m2:		LDX #$00		;2
m2_1:		DEX			;512
		BNE m2_1		;767
m2_2:		DEX			;512
		BNE m2_2		;767
					;counter: 169
		LDX #$1D		;2 (num: 29; eff: 30)
m2_3:		DEX			;62
		BPL m2_3		;92
		STX carry		;3
		LDA #$C1		;2
		STA scanline		;3
		LDA #$20		;2 - 32 scanlines worth of stuff here
		STA ctr			;3
		LDA #$55		;2
		STA tmp			;3

					;counter: 0
test3:					;counter += 58+2/3
					;counter == 58+2/3
		LDX #$09		;2
t3a:		DEX			;18
		BNE t3a			;26
		NOP			;2
		LDA #$04		;2
		STA $6		;4
		STA $6		;4
					;counter: 2/3
					;counter += 29
					;counter == 29+2/3
		LDY scanline		;3
		TYA			;2
		ASL A			;2
		ASL A			;2
		AND #$E0		;2
		NOP			;2
		STX $6		;4
		STY $5		;4
		STX $5		;4
		STA $6		;4
					;counter: 2/3
					;counter += 26
					;counter == 26+2/3
		INC scanline		;5
		LDA carry		;3
		CLC			;2
		ADC tmp			;3
		BCC t3b			;2+2/3
t3b:		STA carry		;3
		DEC ctr			;5
		BNE test3		;3[/2]
					;counter: 0
irq:		RTI			;done!

.fill $FFFA-*,$00
.org $FFFA                              ;interrupt vectors
..word nmi, reset, irq
.end
