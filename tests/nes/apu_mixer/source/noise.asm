; Verifies noise DAC and non-linear mixing
;
; Makes tone by running noise at maximum frequency to get
; soft noise, then toggling its volume between 0 and some
; other value. Cancels this to silence with inverse wave
; generated using DMC DAC.

CUSTOM_TEXT = 1
.include "vol_shell.inc"

text:   .byte "2. Should fade noise in,",newline
	.byte "and out, without any tone.",0

test_main:
	jsr test_atten
	jsr test_vols
	rts

; Tests each noise volume
test_vols:
	loop_n_times test,16
	rts

test:
	tay
	eor #$3F        ; x = noise volume
	tax
	lda vols,y      ; y = DMC DAC value
	tay
	setb $5,$08  ; enable
	setb $E,0    ; min period
	setb $F,0    ; start
	
	setw temp,700
:       lda #0
	stx $C
	sta $1
	delay 896-10
	
	lda #$30
	sta $C
	sty $1
	delay 896-10-21
	
	dec_tempw
	bne :-
	
	rts
	
vols:
	.byte 13,12,11,10,9,9,8,7,6,5,4,4,3,2,1,0

.align 256

; Tests volume 15 over range of DMC DAC, starting
; at high end where it's most attenuated.
test_atten:
	setb $5,$08  ; enable
	setb $C,$3F  ; max volume
	setb $E,0    ; min period
	setb $F,0    ; start
	
	wait = 60
	ldx #127
	ldy #127-13
	
	setb temp,wait
	extra = 14-1
@1:     delay extra
@2:     lda #$30
	sta $C
	stx $1
	delay 896-10
	
	lda #$3F
	sta $C
	sty $1
	delay 896-10-8-extra
	
	dec temp
	bne @1
	
	setb temp,wait
	dex
	dey
	bpl @2
	
	rts
