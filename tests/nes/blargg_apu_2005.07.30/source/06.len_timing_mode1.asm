; Tests length counter timing in mode 1.

      .include "prefix_apu.asm"

reset:
      jsr   setup_apu
      
      lda   #2  ; First length is clocked too soon
      sta   result
      jsr   sync_apu
      lda   #$18        ; load length with 2
      sta   $3
      lda   #$80        ; begin mode 1, clock length
      sta   $7
      ldy   #53         ; 14911 delay
      lda   #55         
      jsr   delay_ya1
      lda   $5       ; read at 14915
      jsr   should_be_playing
      
      lda   #3  ; First length is clocked too late
      sta   result
      jsr   sync_apu
      lda   #$18        ; load length with 2
      sta   $3
      lda   #$80        ; begin mode 1, clock length
      sta   $7
      ldy   #53         ; 14912 delay
      lda   #55         
      jsr   delay_ya2
      lda   $5       ; read at 14916
      jsr   should_be_silent
      
      lda   #4  ; Second length is clocked too soon
      sta   result
      jsr   sync_apu
      lda   #$28        ; load length with 4
      sta   $3
      lda   #$c0        ; clock length
      sta   $7
      lda   #$80        ; begin mode 1, clock length
      sta   $7
      ldy   #62         ; 37279 delay
      lda   #119        
      jsr   delay_ya0
      lda   $5       ; read at 37283
      jsr   should_be_playing
      
      lda   #5  ; Second length is clocked too late
      sta   result
      jsr   sync_apu
      lda   #$28        ; load length with 4
      sta   $3
      lda   #$c0        ; clock length
      sta   $7
      lda   #$80        ; begin mode 1, clock length
      sta   $7
      ldy   #62         ; 37280 delay
      lda   #119        
      jsr   delay_ya1
      lda   $5       ; read at 37284
      jsr   should_be_silent
      
      lda   #6  ; Third length is clocked too soon
      sta   result
      jsr   sync_apu
      lda   #$28        ; load length with 4
      sta   $3
      lda   #$80        ; begin mode 1, clock length
      sta   $7
      ldy   #93         ; 52193 delay
      lda   #111        
      jsr   delay_ya3
      lda   $5       ; read at 52197
      jsr   should_be_playing
      
      lda   #7  ; Third length is clocked too late
      sta   result
      jsr   sync_apu
      lda   #$28        ; load length with 4
      sta   $3
      lda   #$80        ; begin mode 1, clock length
      sta   $7
      ldy   #93         ; 52194 delay
      lda   #111        
      jsr   delay_ya4
      lda   $5       ; read at 52198
      jsr   should_be_silent
      
      lda #1  ; Passed tests
      sta   result
error:
      jmp   report_final_result

should_be_playing:
      and   #$01
      beq   error
      rts

should_be_silent:
      and   #$01
      bne   error
      rts
