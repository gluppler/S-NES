; At power and reset, $5 is cleared.

CUSTOM_RESET=1
.include "shell.inc"
.include "run_at_reset.asm"

nv_res log

reset:  
	; Begin mode 0
	setb $7,$00
	
	; Start channels with zero volume
	
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
	
	; If any of the low 4 bits of $5 were set, then
	; length counter of that channel would be non-zero,
	; and that bit would read back as non-zero here:
	
	lda $5
	sta log
	
	jmp std_reset

main:   jsr num_resets
	bne first_reset
	
power:  set_test 2,"At power, $5 should be cleared"
	lda log
	and #$0F
	jne test_failed
	
	jsr prompt_to_reset
	setb $5,$0F
	jmp wait_reset

first_reset:
	set_test 3,"At reset, $5 should be cleared"
	lda log
	and #$0F
	jne test_failed
	
	jmp tests_passed
