; ============================================================================
; NES Template
; ============================================================================
; Minimal working NES program structure
; Follows NES documentation best practices and hardware-accurate patterns
;
; Architecture:
;   - 32 KB PRG ROM (Mapper 0, NROM)
;   - 8 KB CHR ROM (512 tiles)
;   - Frame-synchronized game loop
;   - OAM buffer for sprites
; ============================================================================

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

; ============================================================================
; Zero Page Variables
; ============================================================================
; Per NES documentation: Zero page ($0000-$00FF) for frequently accessed data
; Zero page access is faster (3 cycles vs 4 cycles for absolute addressing)
; 
; ADD CODE HERE: Define your own zero page variables
; Recommended locations: $09-$7F (avoid $00-$08 which are used by template)
; ============================================================================
zp_temp = $00           ; Temporary variable
zp_ptr = $02            ; 16-bit pointer (low byte at $02, high byte at $03)
frame_counter = $04     ; Frame counter
frame_ready = $05       ; Frame synchronization flag
scroll_x = $06          ; Horizontal scroll position
scroll_y = $07          ; Vertical scroll position
ppu_ctrl = $08          ; PPU control register value

; ADD CODE HERE: Your zero page variables
; Example:
;   player_x = $09      ; Player X position
;   player_y = $0A       ; Player Y position
;   score = $0B          ; Score (low byte)
;   score_high = $0C    ; Score (high byte)

; ============================================================================
; RAM Variables
; ============================================================================
; Per NES documentation: RAM usage patterns
; 
; ADD CODE HERE: Define your own RAM variables
; Recommended locations: $0300-$07FF (avoid $0000-$02FF which are used)
; ============================================================================
oam_buffer = $0200      ; OAM buffer (256 bytes, 64 sprites)

; ADD CODE HERE: Your RAM variables
; Example:
;   game_state = $0300   ; Game state variable
;   level_data = $0400   ; Level data buffer (256 bytes)
;   enemy_data = $0500   ; Enemy data buffer (256 bytes)

; ============================================================================
; Reset Handler
; ============================================================================
; Per NES documentation: Initialize system, clear RAM, setup PPU
; Must follow exact sequence for hardware compatibility
; ============================================================================
reset:
    ; Disable interrupts and initialize CPU
    SEI                 ; Disable interrupts (per NES documentation: required first)
    CLD                 ; Clear decimal mode (6502 specific: NES doesn't use BCD)
    LDX #$FF
    TXS                 ; Initialize stack pointer to $01FF
    INX                 ; X = 0 (for clearing RAM)
    
    ; Disable PPU rendering
    ; Per NES documentation: Must disable before VRAM access to prevent corruption
    STX $2000           ; Disable NMI (PPUCTRL = 0)
    STX $2001           ; Disable rendering (PPUMASK = 0)
    STX $4010           ; Disable DMC IRQ
    
    ; Wait for PPU to stabilize
    ; Per NES documentation: Wait 2 VBlanks to ensure PPU is ready
    BIT $2002           ; Clear VBlank flag
vblank_wait1:
    BIT $2002
    BPL vblank_wait1    ; Wait for VBlank flag to be set (bit 7)
    
    ; Clear RAM
    ; Per NES documentation: Initialize all RAM to known state ($0000-$07FF)
    LDA #0
clear_ram:
    STA $0000,X         ; Zero page
    STA $0100,X         ; Stack
    STA $0200,X         ; OAM buffer
    STA $0300,X         ; RAM
    STA $0400,X         ; RAM
    STA $0500,X         ; RAM
    STA $0600,X         ; RAM
    STA $0700,X         ; RAM
    INX
    BNE clear_ram       ; Loop until X wraps to 0 (256 iterations)
    
    ; Wait for second VBlank
    ; Per NES documentation: Ensures PPU is fully stabilized
vblank_wait2:
    BIT $2002
    BPL vblank_wait2
    
    ; Initialize PPU registers
    ; Per NES documentation: Set up PPU before enabling rendering
    ; PPUCTRL ($2000): Bit 7=1 (NMI enable), Bit 3=0 (pattern table $0000 for background)
    ;                   Bit 0-1=00 (name table $2000), Bit 2=0 (increment by 1)
    LDA #%10000000      ; Enable NMI, pattern table 0, name table 0, increment by 1
    STA $2000
    STA ppu_ctrl        ; Store for later updates
    ; PPUMASK ($2001): Bit 3=1 (show background), Bit 4=1 (show sprites)
    ;                   Bit 1=1 (show background in left 8px), Bit 0=0 (no grayscale)
    LDA #%00011110      ; Enable background and sprites, show left 8px
    STA $2001
    
    ; Initialize game state variables
    LDA #0
    STA frame_counter
    STA frame_ready
    STA scroll_x
    STA scroll_y
    
    ; Initialize OAM buffer (move all sprites off-screen)
    ; Per NES documentation: Sprites with Y=255 are off-screen
    LDX #0
    LDA #$FF
clear_oam:
    STA oam_buffer,X
    INX
    BNE clear_oam       ; Loop until X wraps to 0 (256 iterations)
    
    ; Load palette
    JSR load_palette
    
    ; ADD CODE HERE: Load background (optional - uncomment to use)
    ; JSR load_background
    
    ; ADD CODE HERE: Initialize your game state variables
    ; Example:
    ;   LDA #0
    ;   STA player_x
    ;   STA player_y
    ;   LDA #100
    ;   STA score
    
    ; Enter main loop
    ; Per NES documentation: Game loop pattern with frame synchronization
    JMP main_loop

; ============================================================================
; NMI Handler
; ============================================================================
; Per NES documentation: Called every frame during VBlank (60 Hz NTSC)
; Must complete quickly (< ~2000 cycles) to avoid frame drops
; ============================================================================
nmi:
    ; Save CPU registers
    ; Per NES documentation: NMI can interrupt main loop, must preserve state
    PHA                 ; Save accumulator
    TXA
    PHA                 ; Save X register
    TYA
    PHA                 ; Save Y register
    
    ; Read $2002 to clear VBlank flag
    ; Per NES documentation: Required! Reading $2002 clears bit 7
    LDA $2002
    
    ; Update OAM via DMA
    ; Per NES documentation: Fastest way to update sprites (513 cycles)
    LDA #0
    STA $2003           ; OAM address = 0
    LDA #>oam_buffer    ; High byte of OAM buffer address
    STA $4014           ; Start OAM DMA (513 cycles)
    
    ; Update scroll registers
    ; Per NES documentation: Must be written twice per frame to maintain position
    ; First write = X scroll, second write = Y scroll
    ; ADD CODE HERE: Update scroll_x and scroll_y variables if you need scrolling
    LDA scroll_x
    STA $2005           ; X scroll
    LDA scroll_y
    STA $2005           ; Y scroll
    
    ; Update PPU control register
    ; Per NES documentation: Must be done every frame
    ; ADD CODE HERE: Modify ppu_ctrl if you need to change name table, pattern table, etc.
    LDA ppu_ctrl
    STA $2000
    
    ; Increment frame counter
    INC frame_counter
    
    ; Set frame ready flag
    ; Per NES documentation: Frame synchronization
    LDA #1
    STA frame_ready
    
    ; Restore CPU registers
    PLA                 ; Restore Y register
    TAY
    PLA                 ; Restore X register
    TAX
    PLA                 ; Restore accumulator
    RTI                 ; Return from interrupt

; ============================================================================
; IRQ Handler
; ============================================================================
; Per NES documentation: IRQ is rarely used on NES, but handler is required
; ============================================================================
irq:
    RTI                 ; Return from interrupt (no-op for this program)

; ============================================================================
; Main Loop
; ============================================================================
; Per NES documentation: Game loop pattern with frame synchronization
; ============================================================================
main_loop:
    ; Wait for frame
    ; Per NES documentation: Frame synchronization
    LDA frame_ready
    BEQ main_loop       ; Wait until frame ready flag is set
    
    ; Clear frame flag
    LDA #0
    STA frame_ready
    
    ; Read controllers
    ; Per NES documentation: Input polling
    JSR read_controllers
    
    ; Update game logic
    ; Per NES documentation: Game logic runs in main loop, not NMI
    JSR update_game
    
    ; Update rendering data
    ; Per NES documentation: Prepare rendering data before NMI
    JSR update_rendering
    
    ; Loop back
    JMP main_loop

; ============================================================================
; Read Controllers
; ============================================================================
; Per NES documentation: Controller reading via shift register
; ============================================================================
read_controllers:
    ; Strobe controller 1
    ; Per NES documentation: Set then clear strobe
    LDA #$01
    STA $4016           ; Set strobe
    LDA #$00
    STA $4016           ; Clear strobe
    
    ; ADD CODE HERE: Read 8 buttons (A, B, Select, Start, Up, Down, Left, Right)
    ; Example implementation:
    ;   LDX #0              ; Button index
    ; read_loop:
    ;   LDA $4016           ; Read button state
    ;   AND #$01            ; Isolate bit 0
    ;   STA button_states,X ; Store in RAM
    ;   INX
    ;   CPX #8              ; 8 buttons total
    ;   BNE read_loop
    
    RTS

; ============================================================================
; Update Game
; ============================================================================
; Per NES documentation: Game logic runs in main loop, not NMI
; ============================================================================
update_game:
    ; ADD CODE HERE: Game logic goes here
    ; This is called once per frame (60 Hz NTSC)
    ; 
    ; Example: Update player position, check collisions, update game state
    ; 
    ; Important: Keep this function fast! Slow game logic can cause frame drops.
    ; If you need to do heavy processing, split it across multiple frames.
    
    RTS

; ============================================================================
; Update Rendering
; ============================================================================
; Per NES documentation: Prepare rendering data before NMI
; ============================================================================
update_rendering:
    ; ADD CODE HERE: Prepare rendering data (OAM buffer, etc.)
    ; This is called once per frame, before NMI
    ; 
    ; Example: Update OAM buffer with sprite positions
    ;   LDX #0
    ;   LDA player_y
    ;   STA oam_buffer,X    ; Sprite Y position
    ;   INX
    ;   LDA #0              ; Tile index
    ;   STA oam_buffer,X    ; Sprite tile
    ;   INX
    ;   LDA #0              ; Attributes
    ;   STA oam_buffer,X    ; Sprite attributes
    ;   INX
    ;   LDA player_x
    ;   STA oam_buffer,X    ; Sprite X position
    ; 
    ; Note: OAM buffer is at $0200-$02FF (256 bytes, 64 sprites)
    ; Format: Y, Tile, Attributes, X (4 bytes per sprite)
    
    RTS

; ============================================================================
; Load Palette
; ============================================================================
; Per NES documentation: Palettes are at $3F00-$3F1F (32 bytes)
; Must write during VBlank or forced blanking
; ============================================================================
load_palette:
    ; Reset PPU address latch
    ; Per NES documentation: Read $2002 first to reset latch
    LDA $2002
    LDA #$3F            ; Palette RAM high byte
    STA $2006           ; Write high byte first
    LDA #$00            ; Palette RAM low byte
    STA $2006           ; Write low byte second - address is now $3F00
    
    ; Write all 32 palette bytes
    ; Per NES documentation: 8 palettes × 4 colors = 32 bytes
    LDX #0
palette_loop:
    LDA palette_data,X
    STA $2007           ; Write palette byte, auto-increments address
    INX
    CPX #32             ; 32 palette bytes total
    BNE palette_loop
    
    RTS

; ============================================================================
; Load Background
; ============================================================================
; Per NES documentation: Name table is 32×30 tiles (960 bytes) + 64 bytes attribute
; Name table: $2000-$23BF (960 bytes)
; Attribute table: $23C0-$23FF (64 bytes)
; ============================================================================
load_background:
    ; Clear name table (fill with tile 0 = space)
    ; Per NES documentation: $2006 write sequence is high byte, then low byte
    LDA $2002           ; Reset PPU address latch (MUST read first)
    LDA #$20            ; Name table 0 high byte
    STA $2006           ; Write high byte first
    LDA #$00            ; Name table 0 low byte
    STA $2006           ; Write low byte second - address is now $2000
    
    ; Fill name table with tile 0 (960 bytes)
    ; Per NES documentation: Name table is 32×30 = 960 bytes
    LDX #0
    LDY #0
clear_name_table:
    LDA #0              ; Tile 0 (empty)
    STA $2007           ; Write tile, auto-increments address
    INX
    BNE clear_name_table ; Loop 256 times (X wraps to 0)
    INY
    CPY #4              ; 4 iterations of 256 = 1024 bytes
    BNE clear_name_table
    ; After 960 bytes, PPU address is at $23C0 (attribute table start)
    ; After 1024 bytes, PPU address is at $2400 (next name table)
    ; This clears both name table (960 bytes) and attribute table (64 bytes)
    
    ; Clear attribute table explicitly (ensure all bytes are 0 = palette 0)
    ; Per NES documentation: Attribute table at $23C0-$23FF (64 bytes)
    LDA $2002           ; Reset latch
    LDA #$23            ; Attribute table high byte
    STA $2006
    LDA #$C0            ; Attribute table low byte
    STA $2006           ; Address is now $23C0
    
    LDX #0
clear_attribute_table:
    LDA #0              ; Attribute 0 = palette 0 for all 4 attribute groups
    STA $2007           ; Write attribute byte, auto-increments address
    INX
    CPX #64             ; 64 attribute bytes total
    BNE clear_attribute_table
    
    ; ADD CODE HERE: Write your background tiles to name table
    ; Example: Write a pattern of tiles starting at row 0, column 0
    ;   LDA $2002           ; Reset latch
    ;   LDA #$20            ; Name table 0 high byte
    ;   STA $2006
    ;   LDA #$00            ; Name table 0 low byte (row 0, col 0)
    ;   STA $2006
    ;   LDA #1              ; Tile 1
    ;   STA $2007           ; Write tile
    
    RTS

; ============================================================================
; Data Section
; ============================================================================
; Per NES documentation: Constants and data in ROM
; ============================================================================

; ============================================================================
; Palette Data
; ============================================================================
; ADD CODE HERE: Customize your palette colors
; Per NES documentation: 32 bytes, 8 palettes × 4 colors
; Format: Background color, Color 1, Color 2, Color 3
; 
; Color values: $00-$3F (64 colors total in NES palette)
; Common colors: $0F=black, $30=white, $10=grey, $16=red, $27=blue, $18=green
; 
; Palette structure:
;   - Background palettes 0-3: Used by background tiles (name table)
;   - Sprite palettes 0-3: Used by sprites (OAM)
palette_data:
    .byte $0F, $30, $10, $00  ; Background palette 0: bg=$0F(black), c1=$30(white), c2=$10(grey), c3=$00(black)
    .byte $0F, $30, $10, $00  ; Background palette 1
    .byte $0F, $30, $10, $00  ; Background palette 2
    .byte $0F, $30, $10, $00  ; Background palette 3
    .byte $0F, $16, $27, $18  ; Sprite palette 0
    .byte $0F, $16, $27, $18  ; Sprite palette 1
    .byte $0F, $16, $27, $18  ; Sprite palette 2
    .byte $0F, $16, $27, $18  ; Sprite palette 3

; ============================================================================
; CHR ROM Data
; ============================================================================
; Per NES documentation: Pattern table data, 8 KB (512 tiles × 16 bytes)
; Each tile is 16 bytes: 8 bytes bitplane 0, 8 bytes bitplane 1
; ============================================================================
.segment "CHARS"
    .incbin "chars.chr"
