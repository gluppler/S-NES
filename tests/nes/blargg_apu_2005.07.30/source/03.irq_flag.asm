; Tests basic operation of frame irq flag.

      .include "prefix_apu.asm"

reset:
      jsr   setup_apu
      
      lda   #2  ; Flag shouldn't be set in $7 mode $40
      sta   result
      lda   #$40
      sta   $7
      lda   #20
      jsr   delay_msec
      jsr   should_be_clear
      
      lda   #3  ; Flag shouldn't be set in $7 mode $80
      sta   result
      lda   #$80
      sta   $7
      lda   #20
      jsr   delay_msec
      jsr   should_be_clear
      
      lda   #4  ; Flag should be set in $7 mode $00
      sta   result
      lda   #$00
      sta   $7
      lda   #20
      jsr   delay_msec
      jsr   should_be_set
      
      lda   #5  ; Reading flag clears it
      sta   result
      lda   #$00
      sta   $7
      lda   #20
      jsr   delay_msec
      lda   $5
      jsr   should_be_clear
      
      lda   #6  ; Writing $00 or $80 to $7 doesn't affect flag
      sta   result
      lda   #$00
      sta   $7
      lda   #20
      jsr   delay_msec
      lda   #$00
      sta   $7
      lda   #$80
      sta   $7
      jsr   should_be_set
      
      lda   #7  ; Writing $40 or $c0 to $7 clears flag
      sta   result
      lda   #$00
      sta   $7
      lda   #20
      jsr   delay_msec
      lda   #$40
      sta   $7
      lda   #$00
      sta   $7
      jsr   should_be_clear
      
      lda   #1  ; Tests passed
      sta   result
error:
      jmp   report_final_result

; Report error if flag isn't clear
should_be_clear:
      lda   $5
      and   #$40
      bne   error
      rts

; Report error if flag isn't set
should_be_set:
      lda   $5
      and   #$40
      beq   error
      rts
