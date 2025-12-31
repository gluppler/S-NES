;
; PRNG Example for NES
; Demonstrates all three PRNG widths: 16, 24, and 32-bit
; Based on prng_6502 by Brad Smith (rainwarrior)
;

.import galois16, galois16o
.import galois24, galois24o
.import galois32, galois32o
.importzp seed16, seed24, seed32, rng_value_16, rng_value_24, rng_value_32

.segment "CODE"

PPUCTRL = $2000
PPUMASK = $2001
PPUSTATUS = $2002
PPUADDR = $2006
PPUDATA = $2007
PPUSCROLL = $2005

; Display positions (nametable addresses)
; Row 10: 16-bit value at column 10
DISPLAY_16 = $2000 + (10 * 32) + 10
; Row 12: 24-bit value at column 10
DISPLAY_24 = $2000 + (12 * 32) + 10
; Row 14: 32-bit value at column 10
DISPLAY_32 = $2000 + (14 * 32) + 10

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
	
	; Initialize seeds (must be non-zero)
	; 16-bit seed
	lda #$42
	sta seed16+0
	lda #$10
	sta seed16+1
	
	; 24-bit seed
	lda #$42
	sta seed24+0
	lda #$10
	sta seed24+1
	lda #$AB
	sta seed24+2
	
	; 32-bit seed
	lda #$42
	sta seed32+0
	lda #$10
	sta seed32+1
	lda #$AB
	sta seed32+2
	lda #$CD
	sta seed32+3
	
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
	lda #%10000000	; Enable NMI
	sta PPUCTRL
	lda #%00001010	; Show background
	sta PPUMASK
	
main_loop:
	; Wait for VBlank (must wait before PPU writes during rendering)
	:
	bit PPUSTATUS
	bpl :-
	
	; Generate random numbers with all three widths
	; Using simple versions for demonstration
	
	; 16-bit PRNG
	jsr galois16
	sta rng_value_16
	
	; 24-bit PRNG
	jsr galois24
	sta rng_value_24
	
	; 32-bit PRNG
	jsr galois32
	sta rng_value_32
	
	; Display 16-bit value (hex)
	PPU_LATCH DISPLAY_16
	; High nibble
	lda rng_value_16
	lsr
	lsr
	lsr
	lsr
	clc
	adc #$A0	; Tile $A0-$AF for hex digits 0-F
	sta PPUDATA
	; Low nibble
	lda rng_value_16
	and #$0F
	clc
	adc #$A0
	sta PPUDATA
	
	; Display 24-bit value (hex)
	PPU_LATCH DISPLAY_24
	; High nibble
	lda rng_value_24
	lsr
	lsr
	lsr
	lsr
	clc
	adc #$A0
	sta PPUDATA
	; Low nibble
	lda rng_value_24
	and #$0F
	clc
	adc #$A0
	sta PPUDATA
	
	; Display 32-bit value (hex)
	PPU_LATCH DISPLAY_32
	; High nibble
	lda rng_value_32
	lsr
	lsr
	lsr
	lsr
	clc
	adc #$A0
	sta PPUDATA
	; Low nibble
	lda rng_value_32
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
