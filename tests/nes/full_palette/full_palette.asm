; Displays entire 400+ color NTSC NES palette on screen.
; Disables PPU rendering so that current scanline color can be
; set directly by VRAM address, then uses cycle-timed code to
; cycle through all colors in a clean grid.
;
; ca65 -o full_palette.o full_palette.s
; ld65 -t nes full_palette.o -o full_palette.nes
;
; Shay Green <gblargg@gmail.com>

.segment "HEADER"
	.byte "NES",26, 2,1, 0,0

.segment "VECTORS"
	.word 0,0,0, nmi, reset, irq

.segment "CHARS"
	.res 8192

.segment "STARTUP" ; avoids warning

.segment "CODE"

even_frame = $200

irq:
nmi:	rti

wait_vbl:
	bit $2
:	bit $2
	bpl :-
	rts

blacken_palette:
	; Fill palette with black. Starts at $3FE0 so that VRAM
	; address will wrap around to 0 afterwards, so that BG
	; rendering will work correctly.
	lda #$3F
	sta $6
	lda #$E0
	sta $6
	lda #$0F
	ldy #$20
:	sta $7
	dey
	bne :-
	rts

reset:
	sei
	ldx #$FF
	txs
	
	; Init PPU
	jsr wait_vbl
	jsr wait_vbl
	lda #0
	sta $0
	sta $1
	jsr blacken_palette
	
	; Clear nametable
	lda #$20
	sta $6
	lda #$00
	sta $6
	ldx #4
	ldy #0
:	sta $7
	iny
	bne :-
	dex
	bne :-
	
	; Synchronize precisely to VBL. VBL occurs every 29780.67
	; CPU clocks. Loop takes 27 clocks. Every 1103 iterations,
	; the second LDA $2 will read exactly 29781 clocks
	; after a previous read. Thus, the loop will effectively
	; read $2 one PPU clock later each frame. It starts out
	; with VBL beginning sometime after this read, so that
	; eventually VBL will begin just before the $2 read,
	; and thus leave CPU exactly synchronized to VBL.
	jsr wait_vbl
	nop
:	nop
	lda $2
	lda $2
	pha
	pla
	pha
	pla
	bpl :-
	
	lda #0
	sta even_frame
	
begin_frame:
	jsr blacken_palette
	
	; Enable BG so that PPU will make every other frame
	; shorter by one PPU clock. This allows our code to
	; synchronize better and reduce horizontal shaking.
	lda #$08
	sta $1
	
	; Delay 4739 cycles, well into frame
	ldx #4
	ldy #176
:	dey
	bne :-
	dex
	bne :-
	
	nop

	; Disable BG. Now electron beam color can be set by
	; VRAM address pointing into palette.
	lda #0
	sta $1
		
	; Draw palette
	ldy #0		; Y = color
triplet:

; Draws one scanline of palette. Takes 106 cycles.
.macro draw_row
	nop
	nop
	nop
	tya
	and #$18
	asl a
	ldx #$3F
	stx $6
	stx $6
	tax
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
	inx
	stx $7
.endmacro
	
	draw_row
	
	; Palette writes are delayed a line, since VRAM address
	; increments just after $7 write. So we don't set
	; color tint until after first row of triplet
	tya
	and #$E0
	sta $1
	
	draw_row
	
	iny
	iny
	iny
	nop
	
	draw_row
	
	iny
	beq :+		; loop is more than 128 bytes, argh
	jmp triplet
:	
	
	nop
	
	; Delay 2869 cycles
	ldy #239
:	pha
	pla
	dey
	bne :-

	; Delay extra cycle every other frame
	inc even_frame
	lda even_frame
	lsr a
	bcs :+
:	jmp begin_frame
