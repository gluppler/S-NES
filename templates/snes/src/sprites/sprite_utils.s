; ============================================================================
; Sprite Utilities
; ============================================================================
; SNES sprite management utilities
; See ../../docs/snes/programming/rendering/oam-mirror.md
; See ../../docs/snes/hardware/ppu/oam-system.md
; ============================================================================

.p816
.export init_sprites, update_oam_buffer
.include "../headers/snes_registers.inc"
.include "../headers/memory/wram_map.inc"
.include "sprite_defs.inc"

.segment "CODE"

; ============================================================================
; Initialize Sprites
; ============================================================================
; Clears sprite state and OAM mirror
; ============================================================================
.proc init_sprites
    ; Clear OAM mirror (move all sprites off-screen)
    rep #$10         ; 16-bit X, Y
    ldx #0
    lda #$FF         ; Y = 255 (off-screen)
clear_oam:
    sta OAM_MIRROR,x    ; Y position
    inx
    sta OAM_MIRROR,x    ; Tile = $FF
    inx
    sta OAM_MIRROR,x    ; Attr = $FF
    inx
    sta OAM_MIRROR,x    ; X = $FF (off-screen)
    inx
    cpx #512            ; 128 sprites × 4 bytes
    bne clear_oam
    
    ; Clear sprite state arrays
    sep #$20
    ldx #0
clear_sprite_state:
    stz sprite_x,x
    stz sprite_y,x
    stz sprite_tile,x
    stz sprite_attr,x
    stz sprite_active,x
    inx
    cpx #128            ; 128 sprites
    bne clear_sprite_state
    
    rts
.endproc

; ============================================================================
; Update OAM Buffer
; ============================================================================
; Updates OAM mirror from sprite state arrays
; ============================================================================
.proc update_oam_buffer
    ldx #0
update_oam_loop:
    lda sprite_active,x
    beq sprite_inactive
    
    ; Calculate OAM offset (sprite index × 4)
    txa
    asl
    asl
    tay
    
    ; Write sprite data to OAM mirror
    lda sprite_y,x
    sta OAM_MIRROR,y    ; Y position
    iny
    lda sprite_tile,x
    sta OAM_MIRROR,y    ; Tile index
    iny
    lda sprite_attr,x
    sta OAM_MIRROR,y    ; Attributes
    iny
    lda sprite_x,x
    sta OAM_MIRROR,y    ; X position
    
    bra sprite_next
    
sprite_inactive:
    ; Move sprite off-screen
    txa
    asl
    asl
    tay
    lda #$FF
    sta OAM_MIRROR,y    ; Y = 255
    iny
    sta OAM_MIRROR,y    ; Tile = $FF
    iny
    sta OAM_MIRROR,y    ; Attr = $FF
    iny
    sta OAM_MIRROR,y    ; X = 255
    
sprite_next:
    inx
    cpx #128            ; 128 sprites
    bne update_oam_loop
    
    rts
.endproc
