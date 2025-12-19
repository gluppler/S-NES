;
; PRNG Example for NES
; Demonstrates galois16 random number generator usage
; Based on prng_6502 by Brad Smith (rainwarrior)
;

.import galois16
.importzp seed

.segment "ZEROPAGE"
rng_value: .res 1
display_ptr: .res 2

.segment "CODE"

PPUCTRL = $2000
PPUMASK = $2001
PPUSTATUS = $2002
PPUADDR = $2006
PPUDATA = $2007
PPUSCROLL = $2005
OAM_DMA = $4014
CONTROLLER1 = $4016

DISPLAY_START = $2000 + (10 * 32) + 10

; Macro to reset PPU address latch
.macro PPU_LATCH addr
	bit PPUSTATUS
	lda #>(addr)
	sta PPUADDR
	lda #<(addr)
	sta PPUADDR
.endmacro

reset:
	sei
	cld
	ldx #$FF
	txs
	
	; Disable PPU and APU
	lda #0
	sta PPUCTRL
	sta PPUMASK
	sta $4015
	
	; Wait for first VBlank (PPU stabilization)
	bit PPUSTATUS
:
	bit PPUSTATUS
	bpl :-
	
	; Wait for second VBlank (ensure PPU is ready)
:
	bit PPUSTATUS
	bpl :-
	
	; Initialize seed (must be non-zero)
	lda #$42
	sta seed+0
	lda #$10
	sta seed+1
	
	; Clear nametable (16 pages of 256 bytes = 4KB)
	PPU_LATCH $2000
	ldy #16
	ldx #0
	lda #0
:
	sta PPUDATA
	inx
	bne :-
	dey
	bne :-
	
	; Load palette (8 palettes * 4 colors = 32 bytes)
	PPU_LATCH $3F00
	ldx #8
:
	lda #$0F	; Universal background color (black)
	sta PPUDATA
	lda #$00	; Palette 0, color 0 (black)
	sta PPUDATA
	lda #$10	; Palette 0, color 1 (dark gray)
	sta PPUDATA
	lda #$30	; Palette 0, color 2 (white)
	sta PPUDATA
	dex
	bne :-
	
	; Enable PPU rendering
	lda #%00001010	; Show background
	sta PPUMASK
	lda #%10000000	; Enable NMI
	sta PPUCTRL
	
main_loop:
	; Wait for VBlank (must wait before PPU writes during rendering)
:
	bit PPUSTATUS
	bpl :-
	
	; Generate random number
	jsr galois16
	sta rng_value
	
	; Display random value (reset PPU address latch first)
	PPU_LATCH DISPLAY_START
	
	; Convert to hex and display
	; High nibble
	lda rng_value
	lsr
	lsr
	lsr
	lsr
	clc
	adc #$A0	; Tile $A0-$AF for hex digits 0-F
	sta PPUDATA
	
	; Low nibble
	lda rng_value
	and #$0F
	clc
	adc #$A0
	sta PPUDATA
	
	; Reset scroll (must be done after PPU writes)
	lda #0
	sta PPUSCROLL
	sta PPUSCROLL
	
	jmp main_loop

nmi:
	rti

irq:
	rti

.segment "HEADER"
.byte "NES", $1A
.byte $01 ; 16k PRG
.byte $01 ; 8k CHR
.byte $00 ; mapper 0, vertical mirroring
.byte $00
.res 8

.segment "VECTORS"
.word nmi
.word reset
.word irq

.segment "TILES"
.incbin "../assets/test_nes.chr"
.incbin "../assets/test_nes.chr"
