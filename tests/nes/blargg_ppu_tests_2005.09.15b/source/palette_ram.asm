; PPU palette RAM read/write and mirroring test
; to do: check that upper two bits aren't stored

      .include "prefix_ppu.asm"

; Set VRAM address to $3f00 + X
; Preserved: A, X, Y
set_pal_addr:
      pha
      bit   $2
      lda   #$3f
      sta   $6
      txa
      sta   $6
      pla
      rts

; Set palette entry X to A
; Preserved: A, X, Y
set_pal_entry:
      jsr   set_pal_addr
      sta   $7
      rts

; Read palette entry X into A
; Preserved: X, Y
get_pal_entry:
      jsr   set_pal_addr
      lda   $7
      and   #$3f
      rts

reset:
      lda   #50
      jsr   delay_msec
      
      jsr   wait_vbl
      lda   #0
      sta   $0
      sta   $1
      
      lda   #2;) Palette read shouldn't be buffered like other VRAM
      sta   result
      ldx   #$00
      lda   #$12
      jsr   set_pal_entry
      lda   #$34
      sta   $7
      jsr   get_pal_entry
      lda   $7
      cmp   #$12
      jsr   error_if_eq
      
      lda   #3;) Palette write/read doesn't work
      sta   result
      ldx   #$00
      lda   #$34
      jsr   set_pal_entry
      jsr   get_pal_entry
      lda   $7
      cmp   #$34
      jsr   error_if_ne
      
      lda   #4;) Palette should be mirrored within $3f00-$3fff
      sta   result
      ldx   #$00
      lda   #$12
      jsr   set_pal_entry
      ldx   #$e0
      lda   #$34
      jsr   set_pal_entry
      ldx   #$00
      jsr   get_pal_entry
      cmp   #$34
      jsr   error_if_ne
      
      lda   #5;) Write to $10 should be mirrored at $00
      sta   result
      ldx   #$00
      lda   #$12
      jsr   set_pal_entry
      ldx   #$10
      lda   #$34
      jsr   set_pal_entry
      ldx   #$00
      jsr   get_pal_entry
      cmp   #$34
      jsr   error_if_ne
      
      lda   #6;) Write to $00 should be mirrored at $10
      sta   result
      ldx   #$10
      lda   #$12
      jsr   set_pal_entry
      ldx   #$00
      lda   #$34
      jsr   set_pal_entry
      ldx   #$10
      jsr   get_pal_entry
      cmp   #$34
      jsr   error_if_ne
      
      lda   #1;) Tests passed
      sta   result
      jmp   report_final_result
      
