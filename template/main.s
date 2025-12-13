; NES Bootstrap Template
; Minimal working NES program structure

.segment "HEADER"
    .byte "NES", $1A    ; iNES header identifier
    .byte 2             ; 32 KB PRG ROM (2 * 16 KB)
    .byte 1             ; 8 KB CHR ROM (1 * 8 KB)
    .byte %00000000     ; Mapper 0, horizontal mirroring, no battery
    .byte %00000000     ; Mapper 0 (high), NES format
    .byte 0             ; PRG RAM size
    .byte 0             ; NTSC
    .byte 0, 0, 0, 0, 0, 0  ; Unused

.segment "VECTORS"
    .addr nmi, reset, irq

.segment "CODE"

; Zero page variables
zp_temp = $00
zp_ptr = $02          ; 16-bit pointer (low, high)
frame_counter = $04
frame_ready = $05
scroll_x = $06
scroll_y = $07
ppu_ctrl = $08

; RAM variables
oam_buffer = $0200    ; OAM buffer (256 bytes)

reset:
    SEI                ; Disable interrupts
    CLD                ; Clear decimal mode
    LDX #$FF
    TXS                ; Initialize stack pointer
    INX                ; X = 0
    
    ; Disable PPU rendering
    STX $2000          ; Disable NMI
    STX $2001          ; Disable rendering
    STX $4010          ; Disable DMC IRQ
    
    ; Wait for PPU to stabilize
    BIT $2002          ; Clear VBlank flag
vblank_wait1:
    BIT $2002
    BPL vblank_wait1
    
    ; Clear RAM
    LDA #0
clear_ram:
    STA $0000,X
    STA $0100,X
    STA $0200,X
    STA $0300,X
    STA $0400,X
    STA $0500,X
    STA $0600,X
    STA $0700,X
    INX
    BNE clear_ram
    
    ; Wait for second VBlank
vblank_wait2:
    BIT $2002
    BPL vblank_wait2
    
    ; Initialize PPU
    LDA #%10000000      ; Enable NMI, pattern table 0 for background
    STA $2000
    STA ppu_ctrl
    LDA #%00011110      ; Enable background and sprites
    STA $2001
    
    ; Initialize game state
    LDA #0
    STA frame_counter
    STA frame_ready
    STA scroll_x
    STA scroll_y
    
    ; Initialize OAM buffer (move all sprites off-screen)
    LDX #0
    LDA #$FF
clear_oam:
    STA oam_buffer,X
    INX
    BNE clear_oam
    
    ; Load palette
    JSR load_palette
    
    ; Load name table (optional - can be removed if not needed)
    ; JSR load_background
    
    ; Enter main loop
    JMP main_loop

nmi:
    PHA                ; Save registers
    TXA
    PHA
    TYA
    PHA
    
    LDA $2002          ; Read PPU status (clear VBlank flag)
    
    ; Update OAM via DMA
    LDA #0
    STA $2003          ; OAM address = 0
    LDA #>oam_buffer
    STA $4014          ; Start OAM DMA (513 cycles)
    
    ; Update scroll registers
    LDA scroll_x
    STA $2005          ; X scroll
    LDA scroll_y
    STA $2005          ; Y scroll
    
    ; Update PPU control
    LDA ppu_ctrl
    STA $2000
    
    ; Increment frame counter
    INC frame_counter
    
    ; Set frame ready flag
    LDA #1
    STA frame_ready
    
    PLA                ; Restore registers
    TAY
    PLA
    TAX
    PLA
    RTI

irq:
    RTI

main_loop:
    ; Wait for frame
    LDA frame_ready
    BEQ main_loop
    
    ; Clear frame flag
    LDA #0
    STA frame_ready
    
    ; Read controllers
    JSR read_controllers
    
    ; Update game logic
    JSR update_game
    
    ; Update rendering
    JSR update_rendering
    
    ; Loop
    JMP main_loop

read_controllers:
    ; Strobe controller 1
    LDA #$01
    STA $4016
    LDA #$00
    STA $4016
    
    ; Read 8 buttons (not used in template, but structure is here)
    ; Store button states in RAM if needed
    
    RTS

update_game:
    ; Game logic goes here
    ; This is called once per frame
    
    RTS

update_rendering:
    ; Prepare rendering data (OAM buffer, etc.)
    ; This is called once per frame, before NMI
    
    RTS

load_palette:
    LDA $2002          ; Reset PPU address latch
    LDA #$3F
    STA $2006          ; Palette address high
    LDA #$00
    STA $2006          ; Palette address low
    
    LDX #0
palette_loop:
    LDA palette_data,X
    STA $2007
    INX
    CPX #32            ; 32 palette bytes
    BNE palette_loop
    
    RTS

load_background:
    LDA $2002          ; Reset PPU address latch
    LDA #$20
    STA $2006          ; Name table 0, high byte
    LDA #$00
    STA $2006          ; Name table 0, low byte
    
    ; Fill name table with tile 0 (empty)
    LDX #0
    LDY #4             ; 4 pages of 256 bytes = 1024 bytes (32x32 tiles, but we only use 32x30)
bg_loop:
    LDA #0             ; Tile 0
    STA $2007
    INX
    BNE bg_loop
    DEY
    BNE bg_loop
    
    RTS

palette_data:
    .byte $0F, $30, $10, $00  ; Background palette 0
    .byte $0F, $30, $10, $00  ; Background palette 1
    .byte $0F, $30, $10, $00  ; Background palette 2
    .byte $0F, $30, $10, $00  ; Background palette 3
    .byte $0F, $16, $27, $18  ; Sprite palette 0
    .byte $0F, $16, $27, $18  ; Sprite palette 1
    .byte $0F, $16, $27, $18  ; Sprite palette 2
    .byte $0F, $16, $27, $18  ; Sprite palette 3

.segment "CHARS"
    .incbin "chars.chr"
