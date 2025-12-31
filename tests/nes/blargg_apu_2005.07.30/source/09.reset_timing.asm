; After reset or power-up, APU acts as if $7 were written with
; $00 from 9 to 12 clocks before first instruction begins.

      .include "prefix_apu.asm"

; This is only run when used with devcart loader
main: 
      ; Comment out to simulate reset behavior
      jsr   patch_reset_then_wait
      
      ; Simulate reset behavior with delay of 10
      jsr   sync_apu
      lda   #$00
      sta   $7       ; 1
      lda   <0          ; 3
      nop               ; 6
      nop
      nop

; Test ROM begins here
reset:
      ldx   $5
      lda   #2   $5 didn't read back as $00 at power-up
      sta   <result
      cpx   #0
      bne   error
      
      ldy   #25         ; 29797 delay
      lda   #237        
      jsr   delay_ya5
      
      ; An extra delay of 1-3 causes failure sometimes, 4 always
      
      lda   #3  ; Fourth step occurs too soon
      sta   <result
      lda   $5       ; read at 29818
      nop
      ldx   $5       ; read at 29824
      ldy   $5
      cmp   #$00
      bne   error
      
      lda   #4  ; Fourth step occurs too late
      sta   <result
      cpx   #$40
      bne   error
      cpy   #$00
      bne   error
      
      lda   #1  ; Success
      sta   result
error:
      jmp   report_final_result
