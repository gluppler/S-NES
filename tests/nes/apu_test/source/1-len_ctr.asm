; Tests length counter operation for the four main channels

.include "apu_shell.inc"

main:   test_main_chans test
	jmp tests_passed

test:
	set_test 2,"Problem with length counter load or $5"
	mov $5,chan_bit      ; enable channel
	setb {$3,x},len_2    ; load length
	jsr should_be_playing
	
	set_test 3,"Problem with length table, timing, or $5"
	delay_msec 30
	jsr should_be_silent    ; length should have reached 0 by now
	
	set_test 4,"Writing $80 to $7 should clock length immediately"
	setb $7,0
	setb {$3,x},len_2
	setb $7,$80          ; should clock length immediately
	setb $7,$80          ; should clock length immediately
	jsr should_be_silent
	
	set_test 5,"Writing 0 to $7 shouldn't clock length immediately"
	setb {$3,x},len_2
	setb $7,0            ; shouldn't clock length
	setb $7,0            ; shouldn't clock length
	jsr should_be_playing
	
	set_test 6,"Disabling via $5 should clear length counter"
	setb {$3,x},len_2
	setb $5,0            ; should clear length immediately
	jsr should_be_silent
	mov $5,chan_bit
	jsr should_be_silent    ; length should still be clear
	
	set_test 7,"When disabled via $5, length shouldn't allow reloading"
	setb $5,0
	setb {$3,x},len_2    ; shouldn't reload length
	jsr should_be_silent
	mov $5,chan_bit
	jsr should_be_silent    ; length should still be clear
	
	set_test 8,"Halt bit should suspend length clocking"
	setb {$0,x},halt     ; halt length
	setb {$3,x},len_2
	setb $7,$80          ; attempt to clock length twice
	setb $7,$80
	jsr should_be_playing
	
	rts
