; -----------------------------------------------------------------------------
;   File: Physics.s
;   Description: Subroutines to handle sprite bouncing physics
; -----------------------------------------------------------------------------

;----- Export ------------------------------------------------------------------
.export     UpdateBouncingSprites
;-------------------------------------------------------------------------------

;----- Assembler Directives ----------------------------------------------------
.p816                           ; tell the assembler this is 65816 code
.a8
.i16
;-------------------------------------------------------------------------------

;----- Includes ----------------------------------------------------------------
.include "../common/GameConstants.inc"
.include "../common/MemoryMapWRAM.inc"
;-------------------------------------------------------------------------------

.segment "CODE"
;-------------------------------------------------------------------------------
;   Update sprite positions with bouncing physics
;-------------------------------------------------------------------------------
.proc   UpdateBouncingSprites
        sep #$20                ; set A to 8-bit
        
        ; move sprite 1 horizontally
        ; check collision left boundary
        lda HOR_SPEED
        bpl RightBoundaryCheck  ; if sprites are moving right, skip left boundary check
        lda OAMMIRROR
        clc
        adc HOR_SPEED
        bcs UpdateHorPosition
            ; else, reposition sprite 1 to horizontal position to zero
            stz OAMMIRROR           ; reposition sprite 1
            bra InvertHorSpeed      ; invert the horizontal speed
        ; check right boundary
RightBoundaryCheck:
        lda OAMMIRROR
        clc
        adc HOR_SPEED
        cmp #(SCREEN_RIGHT - 2 * SPRITE_SIZE)
        bcc UpdateHorPosition   ; if sprite 1 is two sprites-wide to the left of right boundary, no collision
            ; else, reposition sprite 1 horizontally
            lda #(SCREEN_RIGHT - 2 * SPRITE_SIZE)
            sta OAMMIRROR           ; reposition sprite 1 horizontally
            bra InvertHorSpeed      ; invert the horizontal speed
UpdateHorPosition:
        sta OAMMIRROR           ; if no collision happened, store new position
        bra VerticalCheck       ; check vertical collision
        ; invert the horizontal speed after bouncing of the left/right screen boundary
InvertHorSpeed:
        lda HOR_SPEED           ; load current horizontal speed
        eor #$ff                ; flip all bits
        clc                     ; add 1 to inverted speed
        adc #$01
        sta HOR_SPEED           ; store inverted speed

        ; move sprite 1 vertically
VerticalCheck:
        ; check collision upper boundary
        lda VER_SPEED
        bpl CheckLowerBoundary  ; if sprites are moving down, skip upper boundary check
        lda OAMMIRROR + $01
        clc
        adc VER_SPEED
        bcs UpdateVerPosition
            ; else, reposition sprite 1 to vertical position to zero
            stz OAMMIRROR + $01     ; reposition sprite 1
            bra InvertVerSpeed      ; invert the horizontal speed
        ; check lower boundary
CheckLowerBoundary:
        lda OAMMIRROR + $01
        clc
        adc VER_SPEED
        cmp #(SCREEN_BOTTOM - 2 * SPRITE_SIZE)
        bcc UpdateVerPosition
            ; else, reposition sprite 1 horizontally
            lda #(SCREEN_BOTTOM - 2 * SPRITE_SIZE)
            sta OAMMIRROR + $01     ; reposition sprite 1 horizontally
            bra InvertVerSpeed      ; invert the horizontal speed
UpdateVerPosition:
        sta OAMMIRROR + $01     ; if no collision happened, store new position
        bra UpdateOtherSprites  ; check vertical collision
        ; invert the horizontal speed after bouncing of the left/right screen boundary
InvertVerSpeed:
        lda VER_SPEED           ; load current horizontal speed
        eor #$ff                ; flip all bits
        clc                     ; add 1 to inverted speed
        adc #$01
        sta VER_SPEED           ; store inverted speed

UpdateOtherSprites:
        lda OAMMIRROR           ; get new horizontal position of sprite 1
        sta OAMMIRROR + $08     ; update sprite 3
        clc
        adc #SPRITE_SIZE
        sta OAMMIRROR + $04     ; update sprite 2
        sta OAMMIRROR + $0c     ; update sprite 4
        ; vertical position
        lda OAMMIRROR + $01     ; get new horizontal position of sprite 1
        sta OAMMIRROR + $05     ; update sprite 2
        clc
        adc #SPRITE_SIZE
        sta OAMMIRROR + $09     ; update sprite 3
        sta OAMMIRROR + $0d     ; update sprite 4

        rts
.endproc
;-------------------------------------------------------------------------------
