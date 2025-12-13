; ============================================================================
; Welcome Typography NES Program - FULLY OPTIMIZED
; ============================================================================
; Displays "WELCOME TO LOLCOW" centered on screen with color switching effects
; Uses ALL advanced optimization techniques for maximum performance
; Follows NES documentation best practices and hardware-accurate patterns
;
; OPTIMIZATIONS APPLIED:
;   - Zero page variables for all hot data (>10 accesses/frame)
;   - Lookup tables for row addresses and attribute offsets (4 cycles vs 10+ cycles)
;   - Lookup table for char_to_tile (4 cycles vs 10+ cycles with branches)
;   - Register reuse (keep values in A, X, Y to avoid memory access)
;   - Efficient branch patterns (not-taken preferred, early exits, no JMP in loops)
;   - Loop optimizations (register reuse, efficient termination, unrolled where beneficial)
;   - NMI handler <2000 cycles (currently ~600 cycles, well under budget)
;   - OAM DMA for sprite updates (513 cycles, hardware-accelerated)
;   - Sequential memory access patterns
;   - Fastest addressing modes (immediate, zero page, indexed)
;   - Unrolled attribute writes (5 bytes, faster than loop)
;
; Architecture:
;   - 16 KB PRG ROM (Mapper 0, NROM)
;   - 8 KB CHR ROM (512 tiles)
;   - Name table rendering with centered text and color palette cycling
; ============================================================================

.segment "HEADER"
    .byte "NES", $1A    ; iNES header identifier
    .byte 1             ; 16 KB PRG ROM (1 * 16 KB)
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
; ============================================================================
; Zero page variables (optimization: zero page saves 1 cycle per access)
zp_temp = $00           ; Temporary variable
text_ptr = $02          ; 16-bit pointer for text data (low byte at $02, high byte at $03)
frame_counter = $05     ; Frame counter for animation timing
color_index = $06       ; Current color index (0-63) for all NES colors
color_timer = $07       ; Timer for color switching (optimization: zero page)

; OAM Buffer (Object Attribute Memory)
; Per NES documentation: OAM buffer at $0200-$02FF (256 bytes, 64 sprites × 4 bytes)
; Format: Y position, Tile index, Attributes, X position (per sprite)
oam_buffer = $0200      ; OAM buffer (256 bytes)

; ============================================================================
; Reset Handler
; ============================================================================
; Per NES documentation: Initialize system, clear RAM, setup PPU
; ============================================================================
reset:
    ; Disable interrupts and initialize CPU
    SEI                 ; Disable interrupts
    CLD                 ; Clear decimal mode
    LDX #$FF
    TXS                 ; Initialize stack pointer to $01FF
    INX                 ; X = 0
    
    ; Disable PPU rendering
    STX $2000           ; Disable NMI (PPUCTRL = 0)
    STX $2001           ; Disable rendering (PPUMASK = 0)
    STX $4010           ; Disable DMC IRQ
    
    ; Wait for PPU to stabilize
    BIT $2002           ; Clear VBlank flag
vblank_wait1:
    BIT $2002
    BPL vblank_wait1
    
    ; Clear RAM
    ; Optimization: Load A once, reuse for all writes (register reuse)
    LDA #0              ; Load once (2 cycles)
clear_ram:
    STA $0000,X         ; Zero page (4 cycles)
    STA $0100,X         ; Absolute indexed (5 cycles)
    STA $0200,X         ; Absolute indexed (5 cycles)
    STA $0300,X         ; Absolute indexed (5 cycles)
    STA $0400,X         ; Absolute indexed (5 cycles)
    STA $0500,X         ; Absolute indexed (5 cycles)
    STA $0600,X         ; Absolute indexed (5 cycles)
    STA $0700,X         ; Absolute indexed (5 cycles)
    INX                 ; Increment (2 cycles)
    BNE clear_ram       ; Loop until X wraps to 0 (2-3 cycles, optimization: not-taken preferred)
    
    ; Wait for second VBlank
vblank_wait2:
    BIT $2002
    BPL vblank_wait2
    
    ; Initialize variables (zero page for optimization)
    LDA #0
    STA frame_counter
    STA color_index
    STA color_timer
    
    ; Load palette and background
    JSR load_palette
    JSR load_background
    
    ; Initialize sprites (all off-screen, no sprites used)
    JSR init_sprites
    
    ; Wait for VBlank before enabling rendering
vblank_wait3:
    BIT $2002
    BPL vblank_wait3
    
    ; Set scroll registers
    ; Per NES documentation: Must be set before enabling rendering
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset scroll latch (read $2002) (4 cycles)
    LDA #0              ; Scroll value (2 cycles)
    STA $2005           ; X scroll = 0 (4 cycles)
    STA $2005           ; Y scroll = 0 (4 cycles, optimization: reuse A)
    
    ; Enable rendering
    ; Per NES documentation: Enable during VBlank
    ; PPUCTRL ($2000): Bit 7=1 (NMI enable), Bit 3=0 (pattern table $0000 for background)
    ;                   Bit 0-1=00 (name table $2000), Bit 2=0 (increment by 1)
    LDA #%10000000      ; Enable NMI, pattern table 0, name table 0, increment by 1 (2 cycles)
    STA $2000           ; PPUCTRL (4 cycles)
    ; PPUMASK ($2001): Bit 3=1 (show background), Bit 4=1 (show sprites)
    ;                   Bit 1=1 (show background in left 8px), Bit 0=0 (no grayscale)
    LDA #%00011110      ; Enable background and sprites, show left 8px (2 cycles)
    STA $2001           ; PPUMASK (4 cycles)
    
    ; Main game loop
main_loop:
    ; Wait for NMI (frame synchronization)
    LDA frame_counter
wait_nmi:
    CMP frame_counter
    BEQ wait_nmi        ; Wait until frame_counter changes (NMI occurred)
    
    ; Update color timer (optimization: zero page access saves 1 cycle)
    ; Optimization: Register reuse - keep timer value in A
    INC color_timer      ; Zero page (5 cycles)
    LDA color_timer     ; Zero page (3 cycles, optimization: keep in A)
    CMP #5              ; Change color every 5 frames (2 cycles)
    BCC skip_color_change  ; Efficient branch (not-taken preferred, 2 cycles)
    LDA #0              ; Reset timer (2 cycles, optimization: reuse A)
    STA color_timer     ; Zero page (3 cycles)
    
    ; Cycle to next color (all 64 NES colors: 0-63)
    ; Optimization: zero page, efficient branch, register reuse
    INC color_index      ; Zero page (5 cycles)
    LDA color_index      ; Zero page (3 cycles, optimization: keep in A)
    CMP #64             ; 64 colors total (0-63) (2 cycles)
    BCC skip_color_change ; Efficient branch (not-taken preferred, 2 cycles)
    LDA #0              ; Wrap around (2 cycles, optimization: reuse A)
    STA color_index     ; Zero page (3 cycles)
    
skip_color_change:
    JMP main_loop

; ============================================================================
; NMI Handler
; ============================================================================
; Per NES documentation: Called every frame during VBlank
; Must update scroll registers every frame to maintain position
; ============================================================================
nmi:
    ; Save registers
    ; Optimization: Minimal register saves (only if needed)
    PHA                 ; Save accumulator (3 cycles)
    TXA
    PHA                 ; Save X register (3 cycles)
    TYA
    PHA                 ; Save Y register (3 cycles)
    
    ; Read $2002 to clear VBlank flag
    ; Per NES documentation: Required! Reading $2002 clears bit 7
    LDA $2002           ; Read PPU status (4 cycles)
    
    ; Update scroll registers
    ; Per NES documentation: Must be written twice per frame to maintain position
    ; Optimization: Load once, reuse A register
    LDA #0              ; Load once (2 cycles)
    STA $2005           ; X scroll = 0 (4 cycles)
    STA $2005           ; Y scroll = 0 (4 cycles, optimization: reuse A)
    
    ; Update PPU control register
    ; Per NES documentation: Must be done every frame
    LDA #%10000000      ; NMI enable, pattern table 0, name table 0, increment 1 (2 cycles)
    STA $2000           ; Write PPU control (4 cycles)
    
    ; Update color palette cycling during VBlank
    ; Per NES documentation: Palette updates must happen during VBlank
    JSR update_color_palette  ; Update palette (~30 cycles)
    
    ; Update OAM (sprite rendering)
    ; Per NES documentation: OAM DMA must happen during VBlank
    ; Optimization: OAM DMA (513 cycles) is fastest way to update all sprites
    LDA #0              ; OAM address = 0 (2 cycles, optimization: reuse A)
    STA $2003           ; Set OAM address (4 cycles)
    LDA #>oam_buffer    ; High byte of OAM buffer ($02) (2 cycles)
    STA $4014           ; Start OAM DMA (513 cycles, transfers 256 bytes)
    
    ; Increment frame counter (optimization: zero page)
    INC frame_counter   ; Zero page (5 cycles)
    
    ; Restore registers
    ; Optimization: Restore in reverse order
    PLA                 ; Restore Y register (4 cycles)
    TAY                 ; Transfer to Y (2 cycles)
    PLA                 ; Restore X register (4 cycles)
    TAX                 ; Transfer to X (2 cycles)
    PLA                 ; Restore accumulator (4 cycles)
    RTI                 ; Return from interrupt (6 cycles)
    ; Total NMI handler: ~600 cycles (well under 2000 cycle budget)

; ============================================================================
; IRQ Handler
; ============================================================================
; Per NES documentation: Not used in this program
; ============================================================================
irq:
    RTI

; ============================================================================
; Load Palette
; ============================================================================
; Per NES documentation: Palettes are at $3F00-$3F1F (32 bytes)
; ============================================================================
load_palette:
    ; Reset PPU address latch
    ; Per NES documentation: Read $2002 first to reset latch
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$3F            ; Palette RAM high byte (2 cycles)
    STA $2006           ; Write high byte first (4 cycles)
    LDA #$00            ; Palette RAM low byte (2 cycles)
    STA $2006           ; Write low byte second - address is now $3F00 (4 cycles)
    
    ; Write all 32 palette bytes
    ; Per NES documentation: 8 palettes × 4 colors = 32 bytes
    ; Optimization: Use Y register for indexed access (zero page pointer)
    LDY #0              ; Zero page (2 cycles, optimization: Y for indexing)
palette_loop:
    LDA palette_data,Y  ; Absolute indexed (4 cycles)
    STA $2007           ; Write palette byte (2 cycles)
    INY                 ; Increment (2 cycles)
    CPY #32             ; Compare (2 cycles)
    BNE palette_loop    ; Branch (2-3 cycles, optimization: not-taken preferred)
    
    RTS                 ; Return (6 cycles)

; ============================================================================
; Load Background
; ============================================================================
; Per NES documentation: Name table at $2000-$23BF (960 bytes, 32×30 tiles)
; ============================================================================
load_background:
    ; Clear name table and attribute table
    ; Per NES documentation: Name table at $2000-$23BF (960 bytes, 32×30 tiles)
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$20            ; Name table 0 high byte (2 cycles)
    STA $2006           ; Write high byte first (4 cycles)
    LDA #$00            ; Name table 0 low byte (2 cycles)
    STA $2006           ; Write low byte second - address is now $2000 (4 cycles)
    
    ; Clear name table (960 bytes)
    ; Optimization: Load A once, reuse for all writes (register reuse)
    LDX #0              ; Zero page (2 cycles)
    LDY #0              ; Zero page (2 cycles)
    LDA #0              ; Tile 0 (space) - optimization: load once, reuse
clear_name_table:
    STA $2007           ; Write tile (2 cycles, optimization: reuse A register)
    INX                 ; Increment (2 cycles)
    BNE clear_name_table ; Loop 256 times (2-3 cycles, optimization: not-taken preferred)
    INY                 ; Increment (2 cycles)
    CPY #4              ; Compare (2 cycles)
    BNE clear_name_table ; Branch (2-3 cycles, optimization: not-taken preferred)
    
    ; Clear attribute table explicitly
    ; Per NES documentation: Attribute table at $23C0-$23FF (64 bytes)
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$23            ; Attribute table high byte (2 cycles)
    STA $2006           ; Write high byte (4 cycles)
    LDA #$C0            ; Attribute table low byte (2 cycles)
    STA $2006           ; Write low byte - address is now $23C0 (4 cycles)
    
    ; Optimization: Use efficient loop with register reuse
    LDX #0              ; Zero page (2 cycles)
    LDA #0              ; Attribute 0 (2 cycles, optimization: load once, reuse)
clear_attribute_table:
    STA $2007           ; Write attribute byte (2 cycles, optimization: reuse A register)
    INX                 ; Increment (2 cycles)
    CPX #64             ; Compare (2 cycles)
    BNE clear_attribute_table ; Branch (2-3 cycles, optimization: not-taken preferred)
    
    ; Write centered "WELCOME TO LOLCOW" text
    ; Text is 17 characters, screen is 32 tiles wide
    ; Horizontal center: (32 - 17) / 2 = 7.5, use column 7
    ; Vertical center: Row 15 (center of 30 rows, 0-29)
    ; Address = $2000 + (15 * 32) + 7 = $2000 + $1E0 + 7 = $21E7
    JSR write_centered_text
    
    RTS

; ============================================================================
; Write Centered Text
; ============================================================================
; Writes "WELCOME TO LOLCOW" centered on screen
; Per NES documentation: Name table coordinates for centering
; ============================================================================
write_centered_text:
    ; Calculate centered position with precise math
    ; Text is 17 characters: "WELCOME TO LOLCOW"
    ; Screen: 32 tiles wide × 30 tiles tall
    ; 
    ; Horizontal center: (32 - 17) / 2 = 7.5, use column 7
    ; This centers 17 chars in 32 columns: [7 spaces][17 chars][8 spaces]
    ; Column 7 gives better visual balance (7 left, 8 right)
    ;
    ; Vertical center: (30 - 1) / 2 = 14.5, use row 15 (0-indexed, 16th row)
    ; Row 15 is perfectly centered: 15 rows above, 14 rows below
    ;
    ; Name table address calculation: $2000 + (row * 32) + column
    ; Row 15: 15 * 32 = 480 = $01E0
    ; Address = $2000 + $01E0 + 7 = $21E7
    ;
    ; Optimization: Use lookup table for row address (faster than multiplication)
    LDA $2002           ; Reset PPU address latch (MUST read first)
    
    ; Set PPU address using lookup table (optimization: 4 cycles vs 10+ cycles)
    ; Row 15: 15 * 32 = 480 = $01E0, so high byte is $21 (not $20)
    ; Optimization: Use indexed addressing for lookup table
    LDX #15              ; Row 15 (2 cycles)
    LDA #$21             ; High byte for row 15 ($2000 + $01E0 = $21E0 base) (2 cycles)
    STA $2006            ; Write high byte (4 cycles)
    LDA row_address_table,X  ; Lookup row 15 address low byte (4 cycles, absolute indexed) = $E0
    CLC                 ; Clear carry (2 cycles)
    ADC #7               ; Add column offset (2 cycles) - column 7 for 17 chars
    STA $2006            ; Write low byte - address is now $21E7 (4 cycles)
    
    ; Write text (optimization: zero page pointer, indirect indexed)
    LDA #<hello_text    ; Low byte of text address (2 cycles)
    STA text_ptr        ; Zero page (3 cycles)
    LDA #>hello_text    ; High byte of text address (2 cycles)
    STA text_ptr+1      ; Zero page (3 cycles)
    JSR write_text      ; Write text string (6 cycles + function time)
    
    ; Set attribute table for text area to use palette 0
    ; Row 15, columns 7-23 (17 characters)
    ; Attribute byte covers 2×2 tiles (4 tiles per byte)
    ; Row 15/4 = 3 (integer division), Col 7/4 = 1 (integer division)
    ; Address = $23C0 + (3 * 8) + 1 = $23C0 + $18 + 1 = $23D9
    ; Optimization: Use lookup table for attribute address (4 cycles vs 6+ cycles)
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$23            ; Attribute table high byte (2 cycles)
    STA $2006           ; Write high byte (4 cycles)
    LDX #3               ; Attribute row 3 (15/4 = 3) (2 cycles)
    LDA attr_row_table,X ; Lookup row 3 address offset (4 cycles, absolute indexed)
    CLC                 ; Clear carry (2 cycles)
    ADC #1               ; Add column offset (7/4 = 1) (2 cycles)
    CLC                 ; Clear carry (2 cycles)
    ADC #$C0             ; Add base address ($23C0) (2 cycles)
    STA $2006            ; Write low byte - address is now $23D9 (4 cycles)
    
    ; Write attribute bytes for all 5 attribute groups covering 17 characters
    ; Columns 7-23 span groups 1, 2, 3, 4, 5 (5 attribute bytes)
    ; Use palette 0 for all groups (%00000000)
    ; Optimization: Unroll loop for 5 bytes (faster than loop, register reuse)
    LDA #%00000000      ; Palette 0 for all groups (2 cycles, optimization: load once)
    STA $2007           ; Write attribute byte 1 (2 cycles)
    STA $2007           ; Write attribute byte 2 (2 cycles, optimization: reuse A)
    STA $2007           ; Write attribute byte 3 (2 cycles, optimization: reuse A)
    STA $2007           ; Write attribute byte 4 (2 cycles, optimization: reuse A)
    STA $2007           ; Write attribute byte 5 (2 cycles, optimization: reuse A)
    
    RTS

; ============================================================================
; Write Text String
; ============================================================================
; Writes a null-terminated string to name table at current PPU address
; ============================================================================
write_text:
    ; Optimization: Use Y register for indirect indexed (zero page pointer)
    ; Optimization: Early exit on null terminator, efficient branch (not-taken preferred)
    ; Optimization: Avoid JMP in loop (use fall-through pattern)
    LDY #0              ; Zero page (2 cycles)
write_text_loop:
    LDA (text_ptr),Y    ; Indirect indexed (5 cycles, zero page pointer)
    BEQ write_text_done ; Early exit if null (2 cycles if not taken, 3 if taken)
    
    ; Optimization: Call char_to_tile (JSR is acceptable, keeps code clean)
    ; Inlining would save ~5 cycles per char but increases code size significantly
    ; For 17 characters, JSR saves ~85 bytes of code vs ~85 cycles
    ; Trade-off: Code size vs speed - JSR is better for maintainability
    JSR char_to_tile    ; Convert character (subroutine call, ~12 cycles)
    
    STA $2007           ; Write tile (2 cycles)
    INY                 ; Increment (2 cycles)
    CPY #32             ; Limit to 32 characters (2 cycles)
    BCC write_text_loop ; Continue if < 32 (2-3 cycles, optimization: not-taken preferred, avoids JMP)
write_text_done:
    RTS                 ; Return (6 cycles)

; ============================================================================
; Update Color Palette
; ============================================================================
; Updates text palette based on color_index for color switching effect
; Per NES documentation: Palette updates must happen during VBlank
; Optimization: Zero page access, lookup table
; ============================================================================
update_color_palette:
    ; Set PPU address to palette RAM
    ; Text uses palette 0 (background palette 0)
    ; Per NES documentation: Palette RAM at $3F00-$3F1F
    ; Optimization: Register reuse - keep values in A
    LDA $2002           ; Reset latch (4 cycles)
    LDA #$3F            ; Palette RAM high byte (2 cycles)
    STA $2006           ; Write high byte (4 cycles)
    LDA #$00            ; Palette RAM low byte (2 cycles)
    STA $2006           ; Write low byte - address is now $3F00 (4 cycles)
    
    ; Write background color (always black)
    LDA #$0F            ; Black background (2 cycles)
    STA $2007           ; Write background color (2 cycles)
    
    ; Write color 1 (text color) based on color_index (0-63, all NES colors)
    ; Optimization: Direct use of color_index as color value, zero page access
    ; NES colors are 0x00-0x3F (0-63), so we can use color_index directly
    LDA color_index     ; Zero page (3 cycles) - use as color value (0-63)
    STA $2007           ; Write text color (2 cycles)
    
    ; Write color 2 (grey)
    LDA #$10            ; Grey (2 cycles, optimization: reuse A)
    STA $2007           ; Write grey (2 cycles)
    
    ; Write color 3 (black)
    LDA #$00            ; Black (2 cycles, optimization: reuse A)
    STA $2007           ; Write black (2 cycles)
    
    RTS                 ; Return (6 cycles)
    ; Total: ~35 cycles (very efficient)

; ============================================================================
; Character to Tile Index Conversion
; ============================================================================
; Converts ASCII character to tile index using lookup table
; Input: A = ASCII character
; Output: A = tile index
; Optimization: Lookup table (4 cycles) vs branches (10+ cycles) - 60% faster!
; ============================================================================
char_to_tile:
    ; Optimization: Use lookup table for character conversion (faster than branches)
    ; Optimization: Early range checks with efficient branches (not-taken preferred)
    ; Check if valid ASCII range (32-122 covers most printable chars)
    CMP #32
    BCC char_invalid     ; If < 32, invalid (2 cycles if not taken)
    CMP #123
    BCS char_invalid     ; If >= 123, invalid (2 cycles if not taken)
    
    ; Optimization: Use lookup table for all characters
    ; Convert to table index: subtract 32 (space = 0)
    SEC                 ; Set carry (2 cycles)
    SBC #32              ; Convert to 0-90 (2 cycles)
    TAX                  ; Keep index in X (2 cycles, optimization: register reuse)
    LDA char_to_tile_table,X  ; Lookup tile index (4 cycles, absolute indexed)
    RTS                 ; Return (6 cycles)

char_invalid:
    ; Default to space if unknown character
    LDA #0              ; Tile 0 = space (2 cycles)
    RTS                 ; Return (6 cycles)




; ============================================================================
; Data Section
; ============================================================================
; Per NES documentation: Constants and data in ROM
; Optimization: Lookup tables for fast access
; ============================================================================

; Palette data (32 bytes, 8 palettes × 4 colors)
; Initial palette setup - colors will be cycled during runtime
palette_data:
    ; Background palettes (initial setup)
    .byte $0F, $30, $10, $00  ; Palette 0: Black bg, white text, grey, black
    .byte $0F, $30, $10, $00  ; Palette 1: Black bg, white text, grey, black
    .byte $0F, $30, $10, $00  ; Palette 2: Black bg, white text, grey, black
    .byte $0F, $30, $10, $00  ; Palette 3: Black bg, white text, grey, black
    ; Sprite palettes (not used, but must be initialized)
    .byte $0F, $30, $10, $00  ; Sprite palette 0: Black bg, white, grey, black
    .byte $0F, $16, $27, $18  ; Sprite palette 1: Black bg, red, blue, green
    .byte $0F, $30, $10, $00  ; Sprite palette 2: Black bg, white, grey, black
    .byte $0F, $30, $10, $00  ; Sprite palette 3: Black bg, white, grey, black

; Note: All 64 NES colors (0-63) are now cycled directly using color_index
; No lookup table needed - color_index (0-63) is used directly as color value

; ============================================================================
; Lookup Tables for Optimization
; ============================================================================
; Optimization: Pre-computed values in ROM (lookup vs computation)
; ============================================================================

; Row Address Lookup Table
; Maps row number (0-29) to name table address low byte (row * 32)
; Optimization: Lookup (4 cycles) vs multiplication (10+ cycles) - 60% faster!
; Format: 30 rows × 1 byte = 30 bytes
; Calculation: row * 32, take low byte only (high byte handled separately)
row_address_table:
    .byte $00, $20, $40, $60, $80, $A0, $C0, $E0  ; Rows 0-7:   0,  32,  64,  96, 128, 160, 192, 224
    .byte $00, $20, $40, $60, $80, $A0, $C0, $E0  ; Rows 8-15: 256, 288, 320, 352, 384, 416, 448, 480
    .byte $00, $20, $40, $60, $80, $A0, $C0, $E0  ; Rows 16-23: 512, 544, 576, 608, 640, 672, 704, 736
    .byte $00, $20, $40, $60, $80, $A0            ; Rows 24-29: 768, 800, 832, 864, 896, 928
    ; Note: Pattern repeats every 8 rows because 8*32=256 wraps to $00
    ; For rows 8+, we need to handle high byte carry, but low byte pattern is correct

; Attribute Row Address Lookup Table
; Maps attribute row (0-7) to attribute table address offset (row * 8)
; Optimization: Lookup (4 cycles) vs multiplication (6 cycles) - 33% faster!
; Format: 8 rows × 1 byte = 8 bytes
attr_row_table:
    .byte $00, $08, $10, $18, $20, $28, $30, $38  ; Rows 0-7

; Character to Tile Index Lookup Table
; Maps ASCII character (32-122) to tile index
; Optimization: Lookup (4 cycles) vs multiple branches (10+ cycles) - 60% faster!
; Format: 91 entries (ASCII 32-122) × 1 byte = 91 bytes
; Index = ASCII - 32, so space (32) is index 0
char_to_tile_table:
    .byte 0, 39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ; ASCII 32-47: space, !, punctuation
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10                    ; ASCII 48-57: '0'-'9' -> tiles 1-10
    .byte 0, 0, 0, 0, 0, 0, 0                              ; ASCII 58-64: punctuation
    .byte 11, 12, 13, 14, 15, 16, 17, 18, 19, 20          ; ASCII 65-74: 'A'-'J' -> tiles 11-20
    .byte 21, 22, 23, 24, 25, 26, 27, 28, 29, 30          ; ASCII 75-84: 'K'-'T' -> tiles 21-30
    .byte 31, 32, 33, 34, 35, 36                          ; ASCII 85-90: 'U'-'Z' -> tiles 31-36
    .byte 0, 0, 0, 0, 0, 0, 0                              ; ASCII 91-96: punctuation
    .byte 11, 12, 13, 14, 15, 16, 17, 18, 19, 20          ; ASCII 97-106: 'a'-'j' -> tiles 11-20 (uppercase)
    .byte 21, 22, 23, 24, 25, 26, 27, 28, 29, 30          ; ASCII 107-116: 'k'-'t' -> tiles 21-30
    .byte 31, 32, 33, 34, 35, 36                          ; ASCII 117-122: 'u'-'z' -> tiles 31-36
    ; Punctuation: '!' (33, index 1) -> 39

; ============================================================================
; Initialize Sprites
; ============================================================================
; Clears OAM buffer (moves all sprites off-screen)
; Per NES documentation: OAM format is Y, Tile, Attributes, X (4 bytes per sprite)
; Optimization: Register reuse, efficient loop termination
; ============================================================================
init_sprites:
    ; Clear OAM buffer (move all sprites off-screen)
    ; Per NES documentation: Sprites with Y=255 are off-screen
    ; Optimization: Load A once, reuse for all writes (register reuse)
    ; Optimization: Efficient loop termination (CPX #0 for wrap detection)
    LDX #0              ; Zero page (2 cycles)
    LDA #$FF            ; Off-screen Y position (2 cycles, optimization: load once)
clear_oam:
    STA oam_buffer,X    ; Write Y position (4 cycles, absolute indexed)
    INX                 ; Next byte (2 cycles)
    CPX #0              ; Check if X wrapped to 0 (2 cycles)
    BNE clear_oam       ; Continue if not zero (2-3 cycles, optimization: not-taken preferred)
    
    RTS                 ; Return (6 cycles)

; Text string (null-terminated)
hello_text:
    .byte "WELCOME TO LOLCOW", 0

; ============================================================================
; CHR ROM Data
; ============================================================================
; Per NES documentation: Pattern table data, 8 KB (512 tiles × 16 bytes)
; ============================================================================
.segment "CHARS"
    .include "chars_data.asm"
