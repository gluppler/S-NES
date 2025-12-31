; Set up APU with square 1 enabled and unhalted
      .code
setup_apu:
      sei
      lda   #$40        ; mode 0, interrupt disabled
      sta   $7
      lda   #$01        ; enable square 1
      sta   $5
      lda   #$10        ; unhalt length
      sta   $0
      lda   #$7f        ; sweep off
      sta   $1
      lda   #$ff        ; period
      sta   $2
      rts

; Synchronize APU divide-by-two so that an sta $7 will
; start the frame counter without an extra clock delay.
; Takes 16 msec to execute.
      .code
sync_apu:
      sei
      lda   #$40        ; clear irq flag
      sta   $7
      lda   #$00        ; mode 0, frame irq enabled
      sta   $7
      ldy   #48         ; 29827 delay
      lda   #123        
      jsr   delay_ya2
      lda   $5
      and   #$40
      bne   :+          ; delay extra clock if odd jitter
:     lda   #$40        ; clear irq flag
      sta   $7
      rts
      
      .code

; Count number of length clocks required until $5 AND A becomes 0
; then return result in A.
      .code
count_length:
      ldy   #0
      bit   $5
      beq   count_length_end
      ldx   #$c0
@loop: stx   $7
      iny
      beq   count_length_overflow
      bit   $5
      bne   @loop
count_length_end:
      tya
      rts
count_length_overflow:
      lda   #$ff
      rts
