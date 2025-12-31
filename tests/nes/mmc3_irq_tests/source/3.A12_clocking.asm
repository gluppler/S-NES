; Tests MMC3 IRQ clocking via bit 12 of VRAM address

      .include "prefix_mmc3_validation.a"
      
test_name:
      ..byte "MMC3 IRQ COUNTER A12",0

reset:
      jsr   begin_mmc3_tests
      
      lda   #0          ; disable PPU, sprites and bg use $0xxx patterns
      sta   $0
      sta   $1
      
      lda   #2;) Shouldn't be clocked when A12 doesn't change
      ldx   #1
      jsr   begin_counter_test
      lda   #$00              ; transition everything but A12
      ldx   #$ef
      ldy   #$ff
      sta   $6
      sta   $6
      stx   $6
      sty   $6
      sta   $6
      sta   $6
      stx   $6
      sty   $6
      sta   $6
      sta   $6
      jsr   should_be_clear
      
      lda   #3;) Shouldn't be clocked when A12 changes to 0
      ldx   #1
      jsr   begin_counter_test
      jsr   clock_counter     ; avoid pathological behavior
      lda   #$10
      sta   $6
      sta   $6
      jsr   clear_counter
      jsr   clear_irq
      ldx   #$00
      ldy   #$10
      stx   $6
      stx   $6
      sty   $6             ; counter = 1
      stx   $6
      stx   $6             ; second 1 to 0 transition
      stx   $6
      jsr   should_be_clear
      
      lda   #4;) Should be clocked when A12 changes to 1 via $6 write
      ldx   #1
      jsr   begin_counter_test
      jsr   clock_counter
      lda   #$00              ; transition A12 from 0 to 1
      sta   $6
      sta   $6
      lda   #$10
      sta   $6
      sta   $6
      jsr   should_be_set
      
      lda   #5;) Should be clocked when A12 changes to 1 via $7 read
      ldx   #1
      jsr   begin_counter_test
      jsr   clock_counter
      lda   #$0f              ; vaddr = $0fff
      sta   $6
      lda   #$ff
      sta   $6
      jsr   should_be_clear
      bit   $7
      jsr   should_be_set
      
      lda   #6;) Should be clocked when A12 changes to 1 via $7 write
      ldx   #1
      jsr   begin_counter_test
      jsr   clock_counter
      lda   #$0f              ; vaddr = $0fff
      sta   $6
      lda   #$ff
      sta   $6
      jsr   should_be_clear
      sta   $7
      jsr   should_be_set
      
      jmp   tests_passed
