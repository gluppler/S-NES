
console_pos = $7f0

; Print char A to console
; Preserved: A, X, Y
print_char:
      jsr   wait_vbl    ; wait for safe access
print_char_no_wait:
      pha
      lda   #$20
      sta   $6
      inc   console_pos
      lda   console_pos
      sta   $6
      lda   #0          ; restore scroll
      sta   $5
      sta   $5
      pla
      sta   $7
      rts
      .code

; Go to next line
; Preserved: A, X, Y
console_newline:
      pha
      lda   console_pos
      and   #$e0
      clc
      adc   #$21
      sta   console_pos
      pla
      rts
      .code
      
; Initialize console
init_console:
      lda   #$81
      sta   console_pos
      
      jsr   wait_vbl    ; init ppu
      lda   #0
      sta   $0
      sta   $1
      
      lda   #$3f        ; load palette
      jsr   set_vpage
      lda   #15         ; bg
      ldx   #48         ; fg
      ldy   #8
pal:  sta   $7
      stx   $7
      stx   $7
      stx   $7
      dey
      bne   pal
      
      lda   #$02        ; load tiles
      jsr   set_vpage
      lda   #chr_data.lsb
      sta   <$f0
      lda   #chr_data.msb
      sta   <$f1
      ldy   #0
      lda   #59         ; 59 chars in data
      sta   <$f2
chr_loop:
      ldx   #8
      lda   #0
:     sta   $7
      dex
      bne   -
      
      ldx   #8
:     lda   ($f0),y
      iny
      sta   $7
      dex
      bne   -
      
      tya
      bne   +
      inc   <$f1
:     dec   <$f2
      bne   chr_loop
      
      lda   #32
      jsr   fill_nametable
      
      jsr   wait_vbl    ; enable ppu
      lda   #0
      sta   $5
      sta   $5
      lda   #$08
      sta   $1
      rts
      .code
      
chr_data:
      .incbin "chr.bin"

