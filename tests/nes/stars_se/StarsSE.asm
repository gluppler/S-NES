;Stars Demo *SE*
;-------------------
;Binary created using DAsm 2.12 running on an Amiga.

   PROCESSOR   6502

SPRITEMAP = #$0600    ;Region in Memory to copy sprites.
SPRITEHARD = #$C000    ;Format: Y-pos,Tile#,Attr,X-Pos
SPRITEDIR = #$C100    ;Format: DY,D2Y,D2X,DX

NMIPASS = #$0001    ;NMI has passed flag.
NMIODD = #$0000    ;Odd NMIs

XSCROLL = #$0002    ;Scroll values.
YSCROLL = #$0003
TEXTLO = #$04      ;Zero-Page pointers for the text.
TEXTHI = #$05
SCRLO = #$0006    ;Place to put the text.
SCRHI = #$0007
NMICOUNT = #$0008
SPRITEHIT = #$0009
FREEZEROL = #$0A
FREEZEROH = #$0B      ;In other words, free, always empty zero-page space.
XSCROLLSPEED = #$000C    ;Duh.
YSCROLLSPEED = #$000D
CHECKFORSPR = #$000E    ;Flag to check for sprites
RAINBOWPOS = #$000F    ;Position in rainbow-cycle.
TEXTHARDLO = #$10
TEXTHARDHI = #$11      ;Hard Copy of text

;-----------------Music-Playing Code----------------------------

;MUSIC IS NOT INCLUDED IN THE SOURCE BECAUSE IT IS NOT MINE TO GIVE OUT!!

;int_en EQU #$0100
;sng_ctr EQU #$0101
;pv_btn EQU #$0102
;
;INIT_ADD EQU #$8000
;PLAY_ADD EQU #$800E
;START_SONG EQU #$00           ;Although I played around with the order.
;MAX_SONG EQU #$0C
;---------------------------
.segment "CODE"
.org $C200

Reset_Routine  SUBROUTINE
   cld         ;Clear decimal flag
   sei         ;Disable interrupts
.WaitV   lda $2
   bpl .WaitV     ;Wait for vertical blanking interval
   ldx #$00
   stx $0
   stx $1      ;Screen display off, amongst other things
   dex
   txs         ;Top of stack at $1FF

;Clear (most of) the NES' WRAM. This routine is ripped from "Duck Hunt" - I should probably clear all
;$800 bytes.
   ldy #$06    ;To clear 7 x $100 bytes, from $000 to $6FF?
   sty $01        ;Store count value in $01
   ldy #$00
   sty $00
   lda #$00

.Clear   sta ($00),y    ;Clear $100 bytes
   dey
   bne .Clear

   dec $01        ;Decrement "banks" left counter
   bpl .Clear     ;Do next if >= 0


   lda   #$20
   sta   $6
   lda   #$00
   sta   $6

   ldx   #$00
   ldy   #$10
.ClearPPU sta $7        ;Clear the PPU space.  REALLY IMPORTANT for a real NES!
   dex
   bne   .ClearPPU
   dey
   bne   .ClearPPU

;------------------------------------------------------
;********* Set up Name & Attributes ******************

   lda   #<.NESDeck
   sta   FREEZEROL
   lda   #>.NESDeck
   sta   FREEZEROH

   lda   #$20        ;Load up entire name & attribute table for screen 0.
   sta   $6
   lda   #$00
   sta   $6
   ldx   #$00
   ldy   #$04

.LoadDeck
   txa
   pha

   ldx   #$00
   lda   (FREEZEROL),X     ;Load up NES image
   sta   $7

   pla
   tax

   inc   FREEZEROL
   bne   .NoDeck1
   inc   FREEZEROH

.NoDeck1
   dex
   bne   .LoadDeck
   dey
   bne   .LoadDeck

;--------------------------------------------------

;---------- Set up other bits ----------------

   lda   #$26                 ;Bars on screen 1.
   sta   $6
   lda   #$C0
   sta   $6

   jsr   DrawBits

   lda   #$27
   sta   $6
   lda   #$60
   sta   $6

   jsr   DrawBits

;----------------------------------------------

;********* Initialize Palette to colour table ********

   ldx   #$3F
   stx   $6
   ldx   #$00
   stx   $6

   ldx   #$00
   ldy   #$20     ;Save BG & Sprite palettes.
.InitPal lda .Palette,X
   sta $7
   inx
   dey
   bne   .InitPal
;------------------------------------------------------

;-------------------------------

   ldx   #$00
.CopySpr lda SPRITEHARD,X
   sta   SPRITEMAP,X            ;Copy sprite map.
   inx
   bne   .CopySpr

;-------------------------------

   lda   #$00
   sta   NMIPASS                 ;Flag for NMI Passed
   sta   NMIODD                  ;Even/OddVBs
   sta   NMICOUNT
   sta   SPRITEHIT
   sta   CHECKFORSPR
   sta   RAINBOWPOS              ;Position in rainbow

   lda   #<.text                 ;Start of text pointer
   sta   TEXTLO
   sta   TEXTHARDLO
   lda   #>.text
   sta   TEXTHI
   sta   TEXTHARDHI

   lda   #$23                    ;Where to place text on-screen
   sta   SCRHI
   lda   #$30
   sta   SCRLO

   lda   #$79
   sta   XSCROLL                 ;X-Y scroll values
   lda   #$00
   sta   YSCROLL

   lda   #$02
   sta   XSCROLLSPEED
   lda   #$01
   sta   YSCROLLSPEED            ;X-Y scrollspeeds

;------- MUSIC CODE ----------------
;   lda #START_SONG         ;Start Song
;   sta sng_ctr
;   jsr INIT_ADD     ;init tune
;   LDA #$01
;   sta int_en
;-------------------------------

   lda   #$00
   sta   $6
   sta   $6

;Enable vblank interrupts, etc.
   lda   #%10001000
   sta   $0
   lda   #%00011000  ;Screen on, sprites on, show leftmost 8 pixels, colour
   sta   $1
;   cli            ;Enable interrupts(?)  NO!!!!!!!!!!!!!!

.Loop

   lda   NMIPASS
   beq   .Loop

   lda   #$00
   sta   NMIPASS

   lda   NMIODD
   bne   .CheckSpr1


   ldx   #$00
.SprMov lda SPRITEMAP,X       ;Grab sprite Y-Position
   clc
   adc   SPRITEDIR,X          ;Add DY
   bcc   .NextMov1

   pha                        ;If it goes off-screen...
   inx
   lda   SPRITEDIR,X          ;Get D2Y...
   inx
   inx
   clc
   adc   SPRITEMAP,X          ;..Add to X-Position
   sta   SPRITEMAP,X
   dex
   dex
   dex
   pla

.NextMov1   sta   SPRITEMAP,X
   inx
   inx
   inx
   lda   SPRITEMAP,X          ;Grab sprite X-position
   clc
   adc   SPRITEDIR,X          ;Add DX
   bcc   .NextMov2

   pha                        ;If it goes off-screen...
   dex
   lda   SPRITEDIR,X          ;Get D2X
   dex
   dex
   clc
   adc   SPRITEMAP,X          ;Add to Y-Position
   sta   SPRITEMAP,X
   inx
   inx
   inx
   pla

.NextMov2   sta   SPRITEMAP,X
   inx
   bne   .SprMov

.CheckSpr1
   lda   $2
   and   #$40
   bne   .CheckSpr1

.CheckSpr2
   lda   $2
   and   #$40
   beq   .CheckSpr2

   lda   XSCROLL
   sta   $5
   lda   $2

;------- MUSIC CODE ---------------
;   jsr r_btn
;   and #$10
;   beq .Loop
;
;   inc sng_ctr
;   LDA #MAX_SONG         ;Max Song.
;   cmp sng_ctr
;   bne .no_scr
;   lda #$0
;   sta sng_ctr
;
;.no_scr   lda #$0
;   sta int_en
;   lda sng_ctr
;   jsr INIT_ADD
;   lda #$01
;   sta int_en        ;check button, if pressed inc song # and re-init
;-------------------------------------------------------------------------

   jmp   .Loop

.Palette dc.b #$0D,#$16,#$27,#$38,#$0D,#$00,#$10,#$30,#$0D,#$16,#$28,#$39,#$0D,#$2B,#$21,#$24
         dc.b #$0D,#$00,#$10,#$30,#$0D,#$16,#$26,#$16,#$0D,#$07,#$16,#$28,#$0D,#$00,#$00,#$00

.NESDeck
   .include starsnam.asm


.text
   .include scrolltext.bin
   dc.b #$00
   dc.b "Hello, all you hackers!"

IncText SUBROUTINE
   inc   TEXTLO
   bne   .nocarry
   inc   TEXTHI
.nocarry rts

IncScr SUBROUTINE
   inc   SCRLO
   lda   SCRLO
   and   #$1F
   bne   .nocarry2
   lda   SCRLO
   sec
   sbc   #$20
   sta   SCRLO
   lda   SCRHI
   clc
   sta   SCRHI
.nocarry2 rts

DrawBits SUBROUTINE
   ldy   #$20
   lda   #$04
.Bits1A sta  $7
   dey
   bne   .Bits1A
   ldy   #$20
   lda   #$05
.Bits1B sta $7
   dey
   bne   .Bits1B
   rts

;************* MUSIC CODE *******************
;r_btn SUBROUTINE
;           ldy #$08      ;read keypad
;           ldx #$01
;           stx $6
;           dex
;           stx $6
;
;.r_bit     lda $6
;           ROR
;           txa
;           ROL
;           tax
;           dey
;           bne .r_bit
;
;           cmp pv_btn
;           beq .no_chg
;           sta pv_btn
;           rts
;
;.no_chg    lda #$0
;           rts
;***********************************************

IncRainbow SUBROUTINE
   inc   RAINBOWPOS
   lda   RAINBOWPOS
   cmp   #$06
   bne   .RainEnd
   lda   #$00
   sta   RAINBOWPOS
.RainEnd
   rts

SaveRainbow SUBROUTINE
   ldx   RAINBOWPOS
   lda   .Rainbow,X
   sta   $7
   jsr   IncRainbow
   rts

.Rainbow dc.b #$16,#$28,#$39,#$2B,#$21,#$24

NMI_Routine SUBROUTINE
   php
   pha
   txa
   pha
   tya
   pha

   lda   XSCROLL
   clc
   adc   XSCROLLSPEED
   sta   XSCROLL

   lda   YSCROLL
   clc
   adc   YSCROLLSPEED
   sta   YSCROLL

   lda   #$00
   sta   $5
   sta   $5


   inc   NMICOUNT

   lda   NMICOUNT
   cmp   #$04
   bne   .NotThere

   lda   #$00
   sta   NMICOUNT

   lda   SCRHI
   sta   $6
   lda   SCRLO
   sta   $6

   ldx   #$00
   lda   (TEXTLO),X

   sta   $7

   lda   SCRHI
   eor   #$04
   sta   $6
   lda   SCRLO
   sta   $6

   lda   (TEXTLO),X
   sta   $7
   cmp   #$00
   bne   .NoTextWrap

   lda   TEXTHARDLO                 ;Start of text pointer
   sta   TEXTLO
   lda   TEXTHARDHI
   sta   TEXTHI

.NoTextWrap jsr   IncText
   jsr   IncScr

;---------------------------------------------
;   increase rainbow colours here.
   lda   #$3F
   sta   $6
   lda   #$09
   sta   $6

   jsr   SaveRainbow
   jsr   SaveRainbow
   jsr   SaveRainbow
   lda   #$0D
   sta   $7
   jsr   SaveRainbow
   jsr   SaveRainbow
   jsr   SaveRainbow
   jsr   IncRainbow
   jsr   IncRainbow
   jsr   IncRainbow
   jsr   IncRainbow
   jsr   IncRainbow
;-----------------------------------

.NotThere

   lda   #$01
   eor   NMIODD      ;Update Even/Odd NMIs
   sta   NMIODD

   lda   #$01
   sta   NMIPASS

   lda   #$00
   sta   $6
   sta   $6

   lda   #$00
   sta   $5
   sta   $5

   lda   #$01
   sta   CHECKFORSPR

   lda   #>SPRITEMAP        ;Point to SPRITEMAP
   sta   $4       ;Xfer sprites over

;----- MUSIC CODE -----------------------------
;   lda int_en
;   beq .no_ints
;   jsr PLAY_ADD    ;play tune
;
;.no_ints
;-------------------------------------


   pla
   tay
   pla
   tax
   pla
   plp
   rti

IRQ_Routine       ;Dummy label
   rti

;That's all the code. Now we just need to set the vector table approriately.

.segment "CODE"
.org $FFFA
   dc.w  NMI_Routine
   dc.w  Reset_Routine
   dc.w  IRQ_Routine    ;Not used, just points to RTI


;The end.
