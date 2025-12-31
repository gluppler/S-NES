;SMW Stomper
;A Demonstration of Smooth Mid-Screen Vertical Scrolling
;WITHOUT the need for an 8 scanline 'buffer' region
;Quietust, 2002/05/18
temp:
temp_l:		.block 1
temp_h:		.block 1

even_frame:	.block 1
shake_y:	.block 1
screen_x:	.block 1
screen_y:	.block 1
stomper_x:	.block 1
stomper_y:	.block 1
irq_num:	.block 1
stomper_mode:	.block 1
stomper_timer:	.block 1
stompershake_y:	.block 1

.org $8000
.include "smwstomp/smwnsf.dat"
.org $C000
stomper:
..byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$06,$0B,$0C,$0D
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$0F,$10,$11,$12,$13,$14,$0C,$15,$16,$09,$17,$18,$19,$1A
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$1B,$1C,$1D,$1E,$07,$08,$1F,$06,$0C,$20,$21,$22,$23,$24
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$25,$26,$27,$28,$29,$15,$2A,$2B,$2C,$2D,$15,$2E,$2F,$30
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$06,$0B,$0C,$0D
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$0F,$10,$11,$12,$13,$14,$0C,$15,$16,$09,$17,$18,$19,$1A
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$1B,$1C,$1D,$1E,$07,$08,$1F,$06,$0C,$20,$21,$22,$23,$24
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$25,$26,$27,$28,$29,$15,$2A,$2B,$2C,$2D,$15,$2E,$2F,$30
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$06,$0B,$0C,$0D
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$0F,$10,$11,$12,$13,$14,$0C,$15,$16,$09,$17,$18,$19,$1A
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$1B,$1C,$1D,$1E,$07,$08,$1F,$06,$0C,$20,$21,$22,$23,$24
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$25,$26,$27,$28,$29,$15,$2A,$2B,$2C,$2D,$15,$2E,$2F,$30
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$06,$0B,$0C,$0D
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$0F,$10,$11,$12,$13,$14,$0C,$15,$16,$09,$17,$18,$19,$1A
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$1B,$1C,$1D,$1E,$07,$08,$1F,$06,$0C,$20,$21,$22,$23,$24
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$25,$26,$27,$28,$29,$15,$2A,$2B,$2C,$2D,$15,$2E,$2F,$30
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$06,$0B,$0C,$0D
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$0F,$10,$11,$12,$13,$14,$0C,$15,$16,$09,$17,$18,$19,$1A
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$1B,$1C,$1D,$1E,$07,$08,$1F,$06,$0C,$20,$21,$22,$23,$24
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$25,$26,$27,$28,$29,$15,$2A,$2B,$2C,$2D,$15,$2E,$2F,$30
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$06,$0B,$0C,$0D
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$0F,$10,$11,$12,$13,$14,$0C,$15,$16,$09,$17,$18,$19,$1A
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$1B,$1C,$1D,$1E,$07,$08,$1F,$06,$0C,$20,$21,$22,$23,$24
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$25,$26,$27,$28,$29,$15,$2A,$2B,$2C,$2D,$15,$2E,$2F,$30
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$06,$0B,$0C,$0D
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$0F,$10,$11,$12,$13,$14,$0C,$15,$16,$09,$17,$18,$19,$1A
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$1B,$1C,$1D,$1E,$07,$08,$1F,$06,$0C,$20,$21,$22,$23,$24
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$00,$25,$26,$27,$28,$29,$15,$2A,$2B,$2C,$2D,$15,$2E,$2F,$30
..byte $0E,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
..byte $40,$41,$42,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $00,$43,$44,$45,$46,$47,$44,$45,$46,$47,$44,$45,$46,$47,$44,$45
..byte $46,$47,$48,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
..byte $44,$00,$00,$00,$00,$00,$00,$00,$44,$00,$00,$00,$00,$00,$00,$00
..byte $44,$00,$00,$00,$00,$00,$00,$00,$44,$00,$00,$00,$00,$00,$00,$00
..byte $44,$00,$00,$00,$00,$00,$00,$00,$44,$00,$00,$00,$00,$00,$00,$00
..byte $44,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
palette:
..byte $2D,$0F,$07,$17,$2D,$0F,$27,$17,$2D,$0F,$0C,$1C,$2D,$0F,$0F,$0F

.fill $E000-*,$00
reset:		SEI
		CLD
		LDX #$00
		STX $8000	;reset PRG/CHR swap
		STX $0
		STX $1
		INX
		STX $A000	;and mirroring
ppuinit:	LDA $2
		BPL ppuinit
		DEX
		BPL ppuinit
		TXS
		INX
		LDA $2
		LDY #$20
		STY $6
		STX $6

		LDY #$80	;init the 'playfield' nametable
		LDA #$4E
init_vram_1:	STA $7	;bricks (top)
		DEY
		BNE init_vram_1

		LDY #$10
init_vram_2:	LDA #$4C	;ceiling pattern
		STA $7
		LDA #$4D
		STA $7
		DEY
		BNE init_vram_2

		LDA #$00
		LDY #$80
		LDX #$03
init_vram_3:	STA $7	;the room
		DEY
		BNE init_vram_3
		DEX
		BNE init_vram_3

		LDY #$10
init_vram_5:	LDA #$49	;floor pattern
		STA $7
		LDA #$4A
		STA $7
		DEY
		BNE init_vram_5

		LDY #$80
		LDA #$4B
init_vram_6:	STA $7	;more bricks (bottom)
		DEY
		BNE init_vram_6

		LDY #$40
		LDA #$AA
init_vram_7:	STA $7	;and attrib table
		DEY
		BNE init_vram_7

		LDA #$28
		STA $6
		LDA #$00
		STA $6
		STA temp_l
		LDA #$C0
		STA temp_h
		LDY #$00
init_vram_8:	LDA (temp),y	;and now, the stomper
		STA $7
		INC temp_l
		BNE skip1
		INC temp_h
skip1:		LDA temp_h
		CMP #$C4
		BNE init_vram_8

		LDA #$3F
		STA $6
		STX $6
init_pal:	LDA palette,x	;load palette
		STA $7
		INX
		CPX #$10
		BNE init_pal

		LDX #$00
		LDY #$00
init_chr:	STX $8000	;setup CHR banks
		STY $8001
		INX
		INY
		CPX #$03
		BPL chr_not1k
		INY
chr_not1k:	CPX #$06
		BNE init_chr
		LDY #$00
		STX $8000
		STY $8001
		INX
		INY
		STX $8000
		STY $8001

		LDA #$C0
		STA $7
		JSR sound_reset	;init the sound code (stolen from SMW pirate)
		INC $0700
		LDA #$00
		STA shake_y
		STA screen_x
		STA screen_y
		STA stomper_mode
		STA stomper_timer
		STA stompershake_y
		LDA #$FF
		STA stomper_y
		LDA #$2C
		JSR sound_init	;start playing the castle tune
		LDA #$88
		STA $0
		CLI
		JMP waitframe

nmi:		CLC
		LDA even_frame
		ADC #$01
		AND #$03
		STA even_frame
		BNE no_scroll
		INC screen_x
		INC stomper_x
no_scroll:	LDA #$88
		STA $0
		LDA screen_x
		STA $5
		LDA shake_y
		STA $5
		LDA #$88
		STA $0
		LDA #$1E
		STA $1		;main screen turn on
		LDX stomper_mode	;okay, what are we doing?
		BEQ stomp_init
		DEX
		BEQ stomp_wait
		DEX
		BEQ stomp_creep
		DEX
		BEQ stomp_fall
		DEX
		BEQ stomp_shake
		DEX
		BEQ stomp_riseshake
		DEX
		BEQ stomp_rise
		JMP drawpipe

stomp_init:	INC stomper_mode	;setup, start a delay timer
		LDA #$80
		STA stomper_timer
		JMP drawpipe

stomp_wait:	DEC stomper_timer	;wait a bit before it appears
		BEQ wait_done
		JMP drawpipe

stomp_creep:	DEC stomper_timer	;creep down a little bit...
		BEQ creep_alldone
		LDA stomper_timer
		AND #$03
		CMP #$03
		BNE creep_done
		DEC stomper_y
creep_done:	JMP drawpipe

stomp_fall:	DEC stomper_timer	;and then fall down at full speed
		BEQ fall_alldone
		DEC stomper_y
		DEC stomper_y
		DEC stomper_y
		DEC stomper_y
		JMP drawpipe
stomp_shake:	DEC stomper_timer	;and slam into the floor
		BEQ shake_alldone
		LDA even_frame
		AND #$01
		BEQ shake_up
		LDA #$FE
		STA shake_y
		JMP shake_done
shake_up:	LDA #$02
		STA shake_y
shake_done:	JMP drawpipe

stomp_riseshake:DEC stomper_timer	;keep shaking the floor a bit
		BEQ riseshake_alldone	;while it's rising
		INC stomper_y
		INC stomper_y
		LDA even_frame
		AND #$01
		BEQ riseshake_up
		LDA #$FE
		STA shake_y
		JMP riseshake_done
riseshake_up:	LDA #$02
		STA shake_y
riseshake_done:	STA stompershake_y
		JMP drawpipe

stomp_rise:	DEC stomper_timer	;done shaking, rise back into the ceiling
		BEQ rise_alldone
		INC stomper_y
		INC stomper_y
		JMP drawpipe

wait_done:	INC stomper_mode
		LDA #$4C
		STA stomper_timer
		LDA #$A0
		STA stomper_x
		LDA #$EF
		STA stomper_y
		JMP drawpipe
creep_alldone:	INC stomper_mode
		LDA #$24
		STA stomper_timer
		DEC stomper_y
		JMP drawpipe
fall_alldone:	INC stomper_mode
		LDA #$40
		STA stomper_timer
		LDA #$1D
		JSR sound_init
		LDA #$0F
		JSR sound_init		;play a suitable sound
		JMP drawpipe
shake_alldone:	INC stomper_mode
		LDA #$20
		STA stomper_timer
		JMP drawpipe
riseshake_alldone:
		INC stomper_mode
		LDA #$32
		STA stomper_timer
		LDA #$00
		STA shake_y
		STA stompershake_y
		JMP drawpipe
rise_alldone:	LDA #$00
		STA stomper_mode
		JMP drawpipe

drawpipe:	LDA stomper_y	;set up MMC3 interrupts
		CMP #$80
		BPL maybe_pipe
		CMP #$4F
		BMI no_pipe
		BPL yes_pipe
maybe_pipe:	CMP #$EE
		BPL no_pipe
yes_pipe:	LDA #$27
		CLC
		ADC shake_y
		STA $C000
		STA $C001
		STA $E001
		LDA #$FF
		STA irq_num
no_pipe:	JSR sound_play	;play music
		RTI

irq:		INC irq_num	;where is it?
		BEQ first_irq	;(yeah, I *should* save regs)
		BNE second_irq	;(but this is timing-critical code)
		
first_irq:	LDA stomper_y	;top of pipe
		CLC
		ADC stompershake_y
		STA screen_y
		ASL A
		ASL A
		AND #$E0
		LDY #$8A
		STY $0
		LDY screen_y

		LDX #$08
spin1:		DEX
		BNE spin1

		LDX stomper_x
		STX $5
		STY $5
		STX $5
		STA $6
		STX $5
		STY $5
		LDA stomper_y
		CLC
		ADC #$12
		CLC
		ADC stompershake_y
		EOR #$FF
		STA $E000
		STA $C000
		STA $C001
		STA $E001
		JMP end_irq

second_irq:	LDX stomper_y	;bottom of pipe
		INX
		TXA
		CLC
		ADC #$10
		EOR #$FF
		CLC
		ADC #$28
		CLC
		ADC stompershake_y
		STA screen_y
		ASL A
		ASL A
		AND #$E0
		LDY #$88
		STY $0
		LDY screen_y

		LDX #$05
spin2:		DEX
		BNE spin2
		NOP
		NOP

		LDX screen_x
		STX $5
		STY $5
		STX $5
		STA $6
		STX $5
		STY $5
		STA $E000
end_irq:	RTI

waitframe:	JMP waitframe	;wait forever
sound_reset:	.= $85D6
sound_init:	.= $8E2F
sound_play:	.= $862A

.fill $FFFA-*,$00
.org $FFFA                              ;interrupt vectors
..word nmi
..word reset
..word irq

.end
