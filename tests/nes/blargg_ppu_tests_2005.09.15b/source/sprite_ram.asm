; Tests sprite RAM access via $3, $4, and $4

      .include "prefix_ppu.asm"

sprites = $200

reset:
      lda   #50
      jsr   delay_msec
      
      jsr   wait_vbl
      lda   #0
      sta   $0
      sta   $1
      
      lda   #2;) Basic read/write doesn't work
      sta   result
      lda   #0
      sta   $3
      lda   #$12
      sta   $4
      lda   #0
      sta   $3
      lda   $4
      cmp   #$12
      jsr   error_if_ne
      
      lda   #3;) Address should increment on $4 write
      sta   result
      lda   #0
      sta   $3
      lda   #$12
      sta   $4
      lda   #$34
      sta   $4
      lda   #1
      sta   $3
      lda   $4
      cmp   #$34
      jsr   error_if_ne
      
      lda   #4;) Address should not increment on $4 read
      sta   result
      lda   #0
      sta   $3
      lda   #$12
      sta   $4
      lda   #$34
      sta   $4
      lda   #0
      sta   $3
      lda   $4
      lda   $4
      cmp   #$34
      jsr   error_if_eq
      
      lda   #5;) Third sprite bytes should be masked with $e3 on read 
      sta   result
      lda   #3
      sta   $3
      lda   #$ff
      sta   $4
      lda   #3
      sta   $3
      lda   $4
      cmp   #$e3
      jsr   error_if_eq
      
      lda   #6;) $4 DMA copy doesn't work at all
      sta   result
      ldx   #0          ; set up data to copy from
:     lda   test_data,x
      sta   sprites,x
      inx
      cpx   #4
      bne   -
      lda   #0          ; dma copy
      sta   $3
      lda   #$02
      sta   $4
      ldx   #0          ; set up data to copy from
:     stx   $3
      lda   $4
      cmp   test_data,x
      jsr   error_if_ne
      inx
      cpx   #4
      bne   -
      
      lda   #7;) $4 DMA copy should start at value in $3 and wrap
      sta   result
      ldx   #0          ; set up data to copy from
:     lda   test_data,x
      sta   sprites,x
      inx
      cpx   #4
      bne   -
      lda   #1          ; dma copy
      sta   $3
      lda   #$02
      sta   $4
      ldx   #1          ; set up data to copy from
:     stx   $3
      lda   $4
      cmp   sprites - 1,x
      jsr   error_if_ne
      inx
      cpx   #5
      bne   -
      
      lda   #8;) $4 DMA copy should leave value in $3 intact
      sta   result
      lda   #1          ; dma copy
      sta   $3
      lda   #$02
      sta   $4
      lda   #$ff
      sta   $4
      lda   #1
      sta   $3
      lda   $4
      cmp   #$ff
      jsr   error_if_ne
      
      lda   #1;) Tests passed
      sta   result
      jmp   report_final_result
      
test_data:
      ..byte $12,$82,$e3,$78
      