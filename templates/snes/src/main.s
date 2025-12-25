; ============================================================================
; SNES Template - Main Entry Point
; ============================================================================
; Minimal working SNES template that displays text
; Based on hello_world example and SNES documentation
; ============================================================================

.p816   ; 65816 processor
.i16    ; X/Y are 16 bits
.a8     ; A is 8 bits

.include "../headers/constants/snes.inc"
.include "../headers/charmap.inc"

.segment "HEADER"
.byte "SNES TEMPLATE GAME  "  ; ROM name (21 bytes)

.segment "ROMINFO"
.byte $30            ; LoROM, fast-capable
.byte 0              ; no battery RAM
.byte $07            ; 128K ROM
.byte 0,0,0,0
.word $AAAA,$5555    ; dummy checksum and complement

; VRAM address constants
VRAM_CHARSET   = $0000 ; must be at $1000 boundary
VRAM_BG1       = $1000 ; must be at $0400 boundary
START_X        = 9
START_Y        = 14
START_TM_ADDR  = VRAM_BG1 + 32*START_Y + START_X

.segment "CODE"
; Text strings
hello_str:     .asciiz "SNES TEMPLATE"
ready_str:     .asciiz "READY TO CODE"
start:
   clc             ; native mode
   xce
   rep #$10        ; X/Y 16-bit
   sep #$20        ; A 8-bit

   ; Force blanking
   lda #$8F
   sta INIDISP
   stz NMITIMEN

   ; Clear VRAM
   jsr ClearVRAM

   ; Clear PPU registers (match hello_world exactly)
   ldx #$33
@loop:
   stz INIDISP,x
   stz NMITIMEN,x
   dex
   bpl @loop

   ; Fix INIDISP (the loop accidentally cleared it)
   lda #128
   sta INIDISP ; undo the accidental stz to 2100h due to BPL actually being a branch on nonnegative

   ; Set up VRAM increment
   lda #$80
   sta VMAIN

   ; Set palette to black background and white text
   stz CGADD ; start with color 0 (background)
   stz CGDATA ; Black (low byte)
   stz CGDATA ; Black (high byte)
   lda #$3F ; Color 1: light gray (R=15, G=15, B=15) - low byte
   sta CGDATA
   lda #$3E ; Color 1: light gray - high byte
   sta CGDATA
   lda #$7F ; Color 2: white (R=31, G=31, B=31) - low byte
   sta CGDATA
   lda #$7F ; Color 2: white - high byte
   sta CGDATA
   lda #$7F  ; Color 3: bright white (R=31, G=31, B=31) - low byte
   sta CGDATA
   lda #$7F ; Color 3: bright white - high byte
   sta CGDATA

   ; Setup Graphics Mode 0, 8x8 tiles all layers
   stz BGMODE
   ; BG1SC: bits 0-1 = nametable base (bits 10-11 of VRAM), bits 2-3 = screen size
   ; VRAM_BG1 = $1000, bits 10-11 = 1, screen size 0 (32x32)
   ; Value = (0 << 2) | 1 = $01
   ; But hello_world uses: lda #>VRAM_BG1 = $10, which works
   ; So let's match hello_world exactly
   lda #>VRAM_BG1
   sta BG1SC ; BG1 at VRAM_BG1, only single 32x32 map (4-way mirror)
   ; BG12NBA: bits 7-4 = BG2 CHR base, bits 3-0 = BG1 CHR base
   ; VRAM_CHARSET = $0000, so >VRAM_CHARSET = $00
   ; For $00: ((0 >> 4) | (0 & $F0)) = 0
   ; But hello_world uses: ((>VRAM_CHARSET >> 4) | (>VRAM_CHARSET & $F0))
   ; For $00: ((0 >> 4) | (0 & $F0)) = (0 | 0) = 0
   ; So stz is correct, but let's match hello_world exactly
   lda #((>VRAM_CHARSET >> 4) | (>VRAM_CHARSET & $F0))
   sta BG12NBA ; BG 1 and 2 both use char tiles
   
   ; Initialize scroll registers (dual-write)
   stz BG1HOFS
   stz BG1HOFS
   lda #$FF
   sta BG1VOFS
   sta BG1VOFS

   ; Load character set into VRAM (simplified - load first 64 chars only)
   lda #$80
   sta VMAIN   ; VRAM stride of 1 word
   ldx #VRAM_CHARSET
   stx VMADDL
   ldx #0
@charset_loop:
   lda NESfont,x
   stz VMDATAL ; Write low byte (tile data bit 0)
   sta VMDATAH ; Write high byte (tile data bits 1-7, sets color 2)
   inx
   cpx #(128*8)
   bne @charset_loop

   ; Place "SNES TEMPLATE" string
   ; Set VRAM increment mode (word increment after high byte)
   lda #$80
   sta VMAIN
   ldx #START_TM_ADDR
   stx VMADDL
   ldx #0
@hello_loop:
   lda hello_str,x
   beq @ready_line
   sta VMDATAL ; Tile number (character code)
   lda #$20 ; priority bit 5, palette 0 (bits 0-2), character bank 0
   sta VMDATAH
   inx
   bra @hello_loop

@ready_line:
   ; Place "READY TO CODE" on next line
   ; VMAIN is already set to $80 from above
   ldx #(VRAM_BG1 + 32*(START_Y + 1) + START_X)
   stx VMADDL
   ldx #0
@ready_loop:
   lda ready_str,x
   beq @enable_display
   sta VMDATAL ; Tile number (character code)
   lda #$20 ; priority bit 5, palette 0 (bits 0-2), character bank 0
   sta VMDATAH
   inx
   bra @ready_loop

@enable_display:
   ; Show BG1
   lda #$01
   sta TM
   ; Maximum screen brightness
   lda #$0F
   sta INIDISP

   ; enable NMI for Vertical Blank
   lda #$80
   sta NMITIMEN

game_loop:
   wai ; Pause until next interrupt complete (i.e. V-blank processing is done)
   ; Do something
   jmp game_loop

nmi:
   rep #$10        ; X/Y 16-bit
   sep #$20        ; A 8-bit
   phd
   pha
   phx
   phy
   ; Do stuff that needs to be done during V-Blank
   lda RDNMI ; reset NMI flag
   ply
   plx
   pla
   pld
return_int:
   rti

;----------------------------------------------------------------------------
; ClearVRAM -- Sets every byte of VRAM to zero
;----------------------------------------------------------------------------
ClearVRAM:
   pha
   phx
   php

   REP #$30		; mem/A = 8 bit, X/Y = 16 bit
   SEP #$20

   LDA #$80
   STA VMAIN         ;Set VRAM port to word access
   LDX #$1809
   STX $4300         ;Set DMA mode to fixed source, WORD to $2118/9
   LDX #$0000
   STX $2116         ;Set VRAM port address to $0000
   STX $0000         ;Set $00:0000 to $0000 (assumes scratchpad ram)
   STX $4302         ;Set source address to $xx:0000
   LDA #$00
   STA $4304         ;Set source bank to $00
   LDX #$FFFF
   STX $4305         ;Set transfer size to 64k-1 bytes
   LDA #$01
   STA $420B         ;Initiate transfer

   STZ VMDATAH       ;clear the last byte of the VRAM

   plp
   plx
   pla
   RTS

.include "assets/data/charset.s"

.segment "VECTORS"
.word 0, 0        ;Native mode vectors
.word return_int  ;COP
.word return_int  ;BRK
.word return_int  ;ABORT
.word nmi         ;NMI
.word start       ;RST
.word return_int  ;IRQ

.word 0, 0        ;Emulation mode vectors
.word return_int  ;COP
.word 0
.word return_int  ;ABORT
.word nmi         ;NMI
.word start       ;RST
.word return_int  ;IRQ
