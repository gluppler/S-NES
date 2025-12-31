.ramsection "TimingVars" SLOT 0

FractionTiming  db
ScanlineCount   db
Temp        db
.ends

;X = $f8 = 248
;Y = $7f = 127
;Pixel = 341*Y + X = 43555
;N1 = (Pixel + 290) / 3 = 14615 (NTSC)
;N2 = (Pixel * 5 + 1444) / 16 = 13701.18 = 13701 (PAL)
.section "Win_Timing" ALIGN $100 FREE
Effect
.ifdef PAL
	lda #255            ;8 cycles (6 for jsr)
.else
	lda #85*2           ;8 cycles (6 for jsr)
.endif
	sta FractionTiming  ;11
	lda #$ff            ;13
	sta ScanlineCount   ;16

.ifdef PAL 
    DELAY 13666
.else 
    DELAY 14580

.endif

TimedCode
						;   Best
	jmp RAMTimedCode    ;   337
_timedLoop
	lda FractionTiming  ;   5
	clc                 ;   11
.ifndef PAL
	adc #$aa            ;   15
.else   adc #$90
.endif  sta FractionTiming  ;   24
	bcs +                   ;   33
+   inc ScanlineCount       ;   48 (add 3 cycles each 3 frames here, to compensate the effect)
	ldx ScanlineCount.w     ;   57
	lda ColorTable.w,X      ;   69
	bmi _noColorWrite       ;   75
	sta RAMTimedCode+3.w    ;   87  Write color
	lda PPUAdrLTable.w,X    ;   99
	sta RAMTimedCode+24.w   ;   111
	lda PPUAdrHTable.w,X    ;   123
	sta RAMTimedCode+5.w    ;   135
.ifndef PAL
	pha
	pla
.endif
	jmp TimedCode       ;   186 (one less than previous frame)

_noColorWrite               ;   78
	nop
	nop
	cmp #$ff                ;   84
	beq _windowColorEnd ;   90
	;lda #$00
	;sta $5
	;sta $5

	ldx #12                 ;   132
-   dex                     ;   (12*15=180 cycles -> 126+180=306)
	bne -                   ;   303 (3 less because the branch didn't happen last time)
.ifndef PAL
	pha
	pla
.endif  ldx FractionTiming
	ldx FractionTiming
	jmp _timedLoop          ;   339

_windowColorEnd             ;   93
	ldx #7
-   dex
	bne -
	bit $2
	ldx #$3f
	stx $6.w
	lda #$00
	ldx #$0f
	ldy #$1e
	sta $1
	sta $6
	stx $7.w
	sty $1.w
	lda ScanlineCount
	tax
	and #$03
	tay
	lda PPUAdrHTable.w,Y
	ora #$01
	sta $6.w
	lda PPUAdrLTable.w,X
	sta $6.w
	lda ScrollH
	sta $5
	lda M2000
	sta $0
	rts


;HBlank writes :

;$6:=$3f, $00
;$1:=$00
;$7:=$xx = 3
;$6:=$xx, $xx = 5, 27
;$1:=$1e         Best        Worst

VeryTimedCode
	lda #$3f    ;   187
	ldx #$00    ;   193
	ldy #$00    ;   199
	bit $2.w ;   205
	sta $6.w ;   217
	lda #$00    ;   229
	sta $1.w ;   235     214
	sta $6.w ;   247     226
				;   *** Begining of actual HBlank (on best case)
	sty $6.w ;   259     238
	lda #$00    ;   271     250 ; rewritten
				; Begining of the actual HBlank in worst case (glitches !)
	ldy #$1e    ;   277     256
	stx $7.w ;   283     262
	sta $6.w ;   295     274
	sty $1.w ;   307     286
.ifdef PAL
	lda #4      ;   319     298
.else
	lda #4      ;   319     298
.endif
	sta $5.w ;   325     304
	jmp _timedLoop  ;   337     316
.ends

.section "TuningTables" ALIGN $100 FREE
ColorTable
	..byte $2c, $3c, $2c, $3c, $f9, $f0, $f9, $fe
	..byte $2c, $2c, $3c, $31, $21, $21, $31, $21

	..byte $31, $21, $11, $21, $f8, $f0, $f8, $fe
	..byte $21, $11, $21, $22, $12, $22, $12, $12

	..byte $22, $13, $23, $13, $f7, $f0, $f7, $fe
	..byte $14, $04, $14, $04, $f7, $f0, $f7, $fe
	..byte $ff

PPUAdrHTable
	..byte $02, $12, $22, $32, $02, $12, $22, $32
	..byte $02, $12, $22, $32, $02, $12, $22, $32
	..byte $02, $12, $22, $32, $02, $12, $22, $32
	..byte $02, $12, $22, $32, $02, $12, $22, $32
	..byte $02, $12, $22, $32, $02, $12, $22, $32
	..byte $02, $12, $22, $32, $02, $12, $22, $32
	..byte $02, $12, $22, $32, $02, $12, $22, $32
	..byte $02, $12, $22, $32, $02, $12, $22, $32

PPUAdrLTable
	..byte $00, $00, $00, $00, $00, $00, $00, $00
	..byte $20, $20, $20, $20, $20, $20, $20, $20
	..byte $40, $40, $40, $40, $40, $40, $40, $40
	..byte $60, $60, $60, $60, $60, $60, $60, $60
	..byte $80, $80, $80, $80, $80, $80, $80, $80
	..byte $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0
.ends