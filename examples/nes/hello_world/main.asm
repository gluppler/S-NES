; Minimal example of using ca65 to build NES ROM.
; Based on nes-hello canonical implementation

.include "headers/ppu.inc"
.include "headers/apu.inc"
.include "headers/neshdr.asm"

.segment "STARTUP"
.segment "CODE"

   jmp start

hello_str: .asciiz "Hello, World!"
alphabet_str: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
numbers_str: .asciiz "0123456789"
punctuation_str: .asciiz "!@#$%^&*()_+-=[]{}|;:,.<>?"

DEFMASK        = %00001000 ; background enabled

START_X        = 9
START_Y        = 14
START_NT_ADDR  = NAMETABLE_A + 32*START_Y + START_X

.macro WAIT_VBLANK
:  bit PPUSTATUS
   bpl :-
.endmacro

start:
   sei
   cld
   ldx #$40
   stx APU_FRAMECTR ; disable IRQ
   ldx #$FF
   txs ; init stack pointer
   inx ; reset X to zero to initialize PPU and APU registers
   stx PPUCTRL
   stx PPUMASK
   stx APU_MODCTRL

   WAIT_VBLANK

   ; while waiting for two frames for PPU to stabilize, reset RAM
   txa   ; still zero!
@clr_ram:
   sta $000,x
   sta $100,x
   sta $200,x
   sta $300,x
   sta $400,x
   sta $500,x
   sta $600,x
   sta $700,x
   inx
   bne @clr_ram

   WAIT_VBLANK

   ; start writing to palette, starting with background color
   ; Reset PPU address latch before writing
   bit PPUSTATUS
   lda #>BG_COLOR
   sta PPUADDR
   lda #<BG_COLOR
   sta PPUADDR
   lda #BLACK
   sta PPUDATA ; black background color
   sta PPUDATA ; palette 0, color 0 = black
   lda #(WHITE | DARK)
   sta PPUDATA ; color 1 = dark white
   lda #(WHITE | NEUTRAL)
   sta PPUDATA ; color 2 = neutral white
   lda #(WHITE | LIGHT)
   sta PPUDATA ; color 3 = light white

   ; place "Hello, World!" string
   ; Reset PPU address latch before writing
   bit PPUSTATUS
   lda #>START_NT_ADDR
   sta PPUADDR
   lda #<START_NT_ADDR
   sta PPUADDR
   ldx #0
@hello_loop:
   lda hello_str,x
   beq @alphabet_line
   sta PPUDATA
   inx
   jmp @hello_loop

@alphabet_line:
   ; Place alphabet on next line (START_Y + 1)
   ; Reset PPU address latch before writing
   bit PPUSTATUS
   lda #>(NAMETABLE_A + 32*(START_Y + 1) + START_X)
   sta PPUADDR
   lda #<(NAMETABLE_A + 32*(START_Y + 1) + START_X)
   sta PPUADDR
   ldx #0
@alphabet_loop:
   lda alphabet_str,x
   beq @numbers_line
   sta PPUDATA
   inx
   jmp @alphabet_loop

@numbers_line:
   ; Place numbers on next line (START_Y + 2)
   ; Reset PPU address latch before writing
   bit PPUSTATUS
   lda #>(NAMETABLE_A + 32*(START_Y + 2) + START_X)
   sta PPUADDR
   lda #<(NAMETABLE_A + 32*(START_Y + 2) + START_X)
   sta PPUADDR
   ldx #0
@numbers_loop:
   lda numbers_str,x
   beq @punctuation_line
   sta PPUDATA
   inx
   jmp @numbers_loop

@punctuation_line:
   ; Place punctuation on next line (START_Y + 3)
   ; Reset PPU address latch before writing
   bit PPUSTATUS
   lda #>(NAMETABLE_A + 32*(START_Y + 3) + START_X)
   sta PPUADDR
   lda #<(NAMETABLE_A + 32*(START_Y + 3) + START_X)
   sta PPUADDR
   ldx #0
@punctuation_loop:
   lda punctuation_str,x
   beq @setpal
   sta PPUDATA
   inx
   jmp @punctuation_loop

@setpal:
   ; set all table A tiles to palette 0
   ; Reset PPU address latch before writing
   bit PPUSTATUS
   lda #>ATTRTABLE_A
   sta PPUADDR
   lda #<ATTRTABLE_A
   sta PPUADDR
   lda #0
   ldx #64
@attr_loop:
   sta PPUDATA
   dex
   bne @attr_loop

   ; set scroll position to 0,0
   lda #0
   sta PPUSCROLL ; x = 0
   sta PPUSCROLL ; y = 0
   ; enable NMI and display
   lda #%10001000  ; NMI enabled, background from pattern table 0
   sta PPUCTRL
   lda #DEFMASK
   sta PPUMASK

@game_loop:
   WAIT_VBLANK
   ; do something
   jmp @game_loop


; ------------------------------------------------------------------------
; System V-Blank Interrupt
; ------------------------------------------------------------------------

nmi:
   pha

   ; refresh scroll position to 0,0
   lda #0
   sta PPUSCROLL
   sta PPUSCROLL

   ; keep default PPU config (NMI enabled, background from pattern table 0)
   lda #%10001000
   sta PPUCTRL
   lda #DEFMASK
   sta PPUMASK

   pla

   ; Interrupt exit
irq:
   rti


.include "assets/data/neschar.asm"

.segment "VECTORS"
.word   nmi         ; $fffa vblank nmi
.word   start       ; $fffc reset
.word   irq         ; $fffe irq / brk
