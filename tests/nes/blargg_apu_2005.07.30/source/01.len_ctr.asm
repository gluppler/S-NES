; Tests basic length counter operation

      .include "prefix_apu.asm"

; to do: test triangle channel's differing halt bit position

reset:
      jsr   setup_apu
      
      lda #2  ; Problem with length counter load or $5
      sta   result
      lda   #$18        ; length = 2
      sta   $3
      jsr   should_be_playing
      
      lda #3  ; Problem with length table, timing, or $5
      sta   result
      lda   #250        ; delay 250 msec
      jsr   delay_msec
      jsr   should_be_silent
      
      lda #4  ; Writing $80 to $7 should clock length immediately
      sta   result
      lda   #$00        ; mode 0
      sta   $7
      lda   #$18        ; length = 2
      sta   $3
      lda   #$80        ; clock length twice
      sta   $7
      sta   $7
      jsr   should_be_silent
      
      lda #5  ; Writing $00 to $7 shouldn't clock length immediately
      sta   result
      lda   #$00        ; mode 0
      sta   $7
      lda   #$18        ; length = 2
      sta   $3
      lda   #$00        ; write mode twice
      sta   $7
      sta   $7
      jsr   should_be_playing
      
      lda #6  ; Clearing enable bit in $5 should clear length counter
      sta   result
      lda   #$18        ; length = 2
      sta   $3
      lda   #$00
      sta   $5
      lda   #$01
      sta   $5
      jsr   should_be_silent
      
      lda #7  ; When disabled via $5, length shouldn't allow reloading
      sta   result
      lda   #$00
      sta   $5
      lda   #$18        ; attempt to reload
      sta   $3
      lda   #$01
      sta   $5
      jsr   should_be_silent
      
      lda #8  ; Halt bit should suspend length clocking
      sta   result
      lda   #$30        ; halt length
      sta   $0
      lda   #$18        ; length = 2
      sta   $3
      lda   #$80        ; attempt to clock length twice
      sta   $7
      sta   $7
      jsr   should_be_playing
      
      lda #1  ; Passed tests
      sta   result
error:
      jmp   report_final_result

should_be_playing:
      lda   $5
      and   #$01
      beq   error
      rts

should_be_silent:
      lda   $5
      and   #$01
      bne   error
      rts
