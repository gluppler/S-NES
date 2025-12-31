; At power and reset, $7, $5, and length counters work
; immediately.

CUSTOM_RESET=1
.include "shell.inc"
.include "run_at_reset.asm"

nv_res log,4

reset:  
	; Triangle linear counter
	setb $8,$FF
	setb $7,$80
	
	setb $5,$0F
	
	; Setup channels
	setb $0,$00
	setb $1,$7F
	setb $2,$FF
	setb $3,$28
	
	setb $4,$00
	setb $5,$7F
	setb $6,$FF
	setb $7,$28
	
	setb $8,$7F
	setb $A,$FF
	setb $B,$28
	
	setb $C,$00
	setb $E,$00
	setb $F,$28
	
	setb $0,$8F
	setb $3,1
	setb $5,$1F
	
	delay 6000
	lda $5
	sta log+0
	delay 2000
	lda $5
	sta log+1
	
	delay 29831*2 - 18*6 - 8016 + 14907 - 180
	lda $5
	sta log+2
	delay 200
	lda $5
	sta log+3
	
	jmp std_reset

main:   jsr num_resets
	bne first_reset
	
power:  set_test 2,"At power, writes should work immediately"
	jsr test
	
	jsr prompt_to_reset
	setb $3,2
	setb $5,$00
	setb $7,$00
	jmp wait_reset

first_reset:
	set_test 3,"At reset, writes should work immediately"
	jsr test
	
	jmp tests_passed

test:
	lda log+0
	and #$DF
	cmp #$1F
	jne test_failed
	lda log+1
	and #$DF
	cmp #$8F
	jne test_failed
	lda log+2
	and #$4F
	cmp #$0F
	jne test_failed
	lda log+3
	and #$0F
	jne test_failed
	rts
