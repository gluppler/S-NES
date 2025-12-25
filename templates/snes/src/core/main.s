; ============================================================================
; Main Game Loop
; ============================================================================
; SNES main game loop with frame synchronization
; See ../../docs/snes/programming/game-loop/frame-synchronization.md
; ============================================================================

.p816
.export main
.smart
.import cpu_init, ppu_init
.include "../headers/snes_registers.inc"
.include "../headers/snes_constants.inc"

.segment "ZEROPAGE"
nmis: .res 1
frame_counter: .res 1

.segment "CODE"

; ============================================================================
; Main Entry Point
; ============================================================================
; See ../../docs/snes/programming/game-loop/frame-synchronization.md
; ============================================================================
.proc main
    ; Initialize CPU
    jsr cpu_init
    
    ; Initialize PPU
    jsr ppu_init
    
    ; Load game assets (VRAM, CGRAM, etc.)
    ; ... asset loading code ...
    
    ; In LoROM no larger than 16 Mbit, all program banks can reach
    ; the system area (low RAM, PPU ports, and DMA ports).
    ; This isn't true of larger LoROM or of HiROM (without tricks).
    phk
    plb
    
    ; Program the PPU for the display mode
    seta8
    stz BGMODE         ; Mode 0 (four 2-bit BGs) with 8x8 tiles
    stz BG12NBA        ; BG planes 0-1 CHR at $0000
    
    ; OBSEL needs the start of the sprite pattern table in $2000-word
    ; units. In other words, bits 14 and 13 of the address go in bits
    ; 1 and 0 of OBSEL.
    lda #$4000 >> 13
    sta OBJSEL         ; Sprite CHR at $4000, sprites are 8x8 and 16x16
    lda #>$6000
    sta BG1SC          ; Plane 0 nametable at $6000
    sta BG2SC          ; Plane 1 nametable also at $6000
    
    ; Set up plane 0's scroll
    stz BG1HOFS
    stz BG1HOFS        ; Dual-write
    lda #$FF
    sta BG1VOFS        ; The PPU displays lines 1-224, so set scroll to
    sta BG1VOFS        ; $FF so that the first displayed line is line 0 (dual-write)
    
    lda #%00010001     ; Enable sprites and plane 0
    sta TM
    lda #$81           ; Enable NMI (bit 7) and auto-joypad (bit 0)
    sta NMITIMEN
    
    ; Enable display
    lda #$0F           ; Full brightness
    sta INIDISP        ; Turn on rendering (clear forced blank bit)
    
    ; Main game loop
forever:
    ; Wait for VBlank
    ; Note: ppu_vsync is in dma/oam_dma.asm
    ; For inline version, see ../../docs/snes/programming/game-loop/frame-synchronization.md
    wai                 ; Wait for NMI (VBlank)
    
    ; Game logic (runs during visible period)
    inc frame_counter
    
    ; Update rendering (OAM, scroll, etc.)
    ; ... rendering code ...
    
    ; Wait for control reading to finish
    lda #$01
padwait:
    bit HVBJOY          ; $4212: Check auto-joypad status
    bne padwait
    
    ; Update scroll position (during VBlank)
    stz BG1HOFS
    stz BG1HOFS         ; Write twice (dual-write register)
    
    jmp forever
.endproc
