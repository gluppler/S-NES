; At power and reset, length counters are enabled.

CUSTOM_RESET=1
.include "shell.inc"
.include "run_at_reset.asm"

nv_res log

reset:
	; Begin mode 0 and enable channels
	setb $7,$00
	setb $5,$0F
	
	; Try to load length counters
	
	setb $1,$7F
	setb $2,$FF
	setb $3,$18
	
	setb $5,$7F
	setb $6,$FF
	setb $7,$18
	
	setb $A,$FF
	setb $B,$18
	
	setb $C,$00
	setb $E,$00
	setb $F,$18
	
	; Delay and see whether they decremented to zero
	delay 29830*2
	
	lda $5
	sta log
	
	jmp std_reset

main:   jsr num_resets
	bne first_reset
	
power:  set_test 2,"At power, length counters should be enabled"
	lda log
	and #$0F
	jne test_failed
	
	jsr prompt_to_reset
	setb $0,$00
	setb $4,$00
	setb $8,$FF  ; disable triangle's counter
	setb $B,$FF
	setb $C,$00
	jmp wait_reset

first_reset:
	set_test 3,"At reset, length counters should be enabled, triangle unaffected"
	lda log
	and #$0F
	cmp #$04
	jne test_failed
	
	jmp tests_passed
