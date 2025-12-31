; At power, $7 = $00.
; At reset, $7 mode is unchanged, but IRQ inhibit
; flag is sometimes cleared.

CUSTOM_RESET=1
.include "shell.inc"
.include "run_at_reset.asm"

nv_res log,4

reset:  
	setb $5,$01
	setb $0,0
	setb $1,$7F
	setb $2,$FF
	setb $3,$28
	
	delay 29831*2-5*6-9-7
	lda $5
	sta log+0
	lda $5
	sta log+1
	
	delay 14887
	lda $5
	sta log+2
	lda $5
	sta log+3
	
	jmp std_reset

main:   jsr num_resets
	bne first_reset
	
power:
	set_test 2,"At power, $7 should be written with $00"
	lda log+0
	and #$41
	cmp #$41
	jne test_failed
	lda log+1
	and #$01
	jne test_failed
	
	jsr prompt_to_reset
	setb $7,$40
	jmp wait_reset

first_reset:
	set_test 3,"At reset, $7 should should be rewritten with last value written"
	cmp #2
	beq second_reset
	
	lda log+0
	and #$01
	jeq test_failed
	lda log+1
	and #$01
	jne test_failed
	
	jsr prompt_to_reset
	setb $7,$80  ; put in other mode this time
	jmp wait_reset

second_reset:
	lda log+2
	and #$01
	jeq test_failed
	lda log+3
	and #$01
	jne test_failed
	
	jmp tests_passed
