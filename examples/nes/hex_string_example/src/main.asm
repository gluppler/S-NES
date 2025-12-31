; Hex String Macro Example
; Demonstrates using the hex macro to define multibyte constants

.include "macros/hex_string.inc"

; PPU Registers
PPUCTRL   = $2000
PPUMASK   = $2001
PPUSTATUS = $2002
PPUADDR   = $2006
PPUDATA   = $2007
PPUSCROLL = $2005

; PPU VRAM Addresses
NAMETABLE_A = $2000
ATTRTABLE_A = $23C0
BG_COLOR    = $3F00

; Text positioning (like templates/nes)
START_X = 6
START_Y = 10
START_NT_ADDR = NAMETABLE_A + 32*START_Y + START_X

; Colors
BLACK   = $1D
WHITE   = $30
DARK    = $00
NEUTRAL = $10
LIGHT   = $20

.segment "HEADER"
    .byte "NES", $1A
    .byte $01 ; 16k PRG
    .byte $01 ; 8k CHR
    .byte $00 ; mapper 0, vertical mirroring
    .byte $00, $00, $00, $00, $00, $00, $00, $00

.segment "VECTORS"
    .word nmi
    .word reset
    .word irq

.segment "CODE"

; String definitions (inline in CODE segment like templates/nes)
title_text:
    .byte "HEX STRING EXAMPLE", 0

magic_label_text:
    .byte "MAGIC: ", 0

data_label_text:
    .byte "DATA: ", 0

; Hex digit lookup table (ASCII codes for '0'-'F' as tile indices)
hex_digits:
    .byte $30, $31, $32, $33, $34, $35, $36, $37  ; '0'-'7'
    .byte $38, $39, $41, $42, $43, $44, $45, $46  ; '8'-'9', 'A'-'F'

; Example lookup table using hex string macro (in CODE segment for accessibility)
lookup_table:
    hex "09F9_1102_9D74"      ; Bytes: $09, $F9, $11, $02, $9D, $74
    hex "E35B_D841_56C5"      ; Underscores ignored for readability
    hex "6356_88C0"           ; Must have even number of hex digits
lookup_table_end:

; Example: Magic number using hex string (in CODE segment)
magic_signature:
    hex "4E4553"              ; "NES" in ASCII hex: $4E, $45, $53
magic_signature_end:

reset:
    ; EXACTLY like templates/nes: Initialize CPU
    SEI
    CLD
    LDX #$40
    STX $4017  ; disable APU frame IRQ
    LDX #$FF
    TXS  ; init stack pointer
    INX  ; reset X to zero
    STX PPUCTRL
    STX PPUMASK
    STX $4015  ; disable APU
    
    ; Wait for VBlank (first wait)
    BIT PPUSTATUS
vblank_wait1:
    BIT PPUSTATUS
    BPL vblank_wait1
    
    ; Clear RAM while waiting (EXACTLY like templates/nes)
    TXA  ; still zero!
@clr_ram:
    STA $000,X
    STA $100,X
    STA $200,X
    STA $300,X
    STA $400,X
    STA $500,X
    STA $600,X
    STA $700,X
    INX
    BNE @clr_ram
    
    ; Wait for second VBlank
    BIT PPUSTATUS
vblank_wait2:
    BIT PPUSTATUS
    BPL vblank_wait2
    
    ; Clear nametables
    BIT PPUSTATUS
    LDA #>$2000
    STA PPUADDR
    LDA #<$2000
    STA PPUADDR
    LDY #16
    LDX #0
    LDA #0
@clear_nametable:
    STA PPUDATA
    INX
    BNE @clear_nametable
    DEY
    BNE @clear_nametable
    
    ; Set up palette
    ; Reset PPU address latch
    BIT PPUSTATUS
    LDA #>BG_COLOR
    STA PPUADDR
    LDA #<BG_COLOR
    STA PPUADDR
    
    LDA #BLACK
    STA PPUDATA  ; Background color
    STA PPUDATA  ; Palette 0, color 0 = black
    LDA #(WHITE | DARK)
    STA PPUDATA  ; Color 1 = dark white
    LDA #(WHITE | NEUTRAL)
    STA PPUDATA  ; Color 2 = neutral white
    LDA #(WHITE | LIGHT)
    STA PPUDATA  ; Color 3 = light white
    
    ; Write hex string data to nametable
    ; EXACTLY like templates/nes pattern
    ; Reset PPU address latch
    BIT PPUSTATUS
    LDA #>START_NT_ADDR
    STA PPUADDR
    LDA #<START_NT_ADDR
    STA PPUADDR
    
    ; Display "HEX STRING EXAMPLE" title
    LDX #0
@title_loop:
    LDA title_text,X
    BEQ @title_done
    STA PPUDATA
    INX
    JMP @title_loop
@title_done:
    
    ; Move to next row (START_Y + 1)
    BIT PPUSTATUS
    LDA #>(NAMETABLE_A + 32*(START_Y + 1) + START_X)
    STA PPUADDR
    LDA #<(NAMETABLE_A + 32*(START_Y + 1) + START_X)
    STA PPUADDR
    
    ; Display "MAGIC: " label
    LDX #0
@magic_label_loop:
    LDA magic_label_text,X
    BEQ @magic_label_done
    STA PPUDATA
    INX
    JMP @magic_label_loop
@magic_label_done:
    
    ; Display magic signature "NES" from hex string
    LDX #0
@magic_loop:
    LDA magic_signature,X
    STA PPUDATA
    INX
    CPX #(magic_signature_end - magic_signature)
    BNE @magic_loop
    
    ; Move to row START_Y + 2
    BIT PPUSTATUS
    LDA #>(NAMETABLE_A + 32*(START_Y + 2) + START_X)
    STA PPUADDR
    LDA #<(NAMETABLE_A + 32*(START_Y + 2) + START_X)
    STA PPUADDR
    
    ; Display "DATA: " label
    LDX #0
@data_label_loop:
    LDA data_label_text,X
    BEQ @data_label_done
    STA PPUDATA
    INX
    JMP @data_label_loop
@data_label_done:
    
    ; Display lookup table data as hex digits
    LDX #0
@data_loop:
    LDA lookup_table,X
    ; Convert byte to two hex digits
    PHA
    LSR A
    LSR A
    LSR A
    LSR A
    TAY
    LDA hex_digits,Y
    STA PPUDATA
    PLA
    AND #$0F
    TAY
    LDA hex_digits,Y
    STA PPUDATA
    ; Add space
    LDA #32  ; Space character (ASCII 32)
    STA PPUDATA
    INX
    CPX #(lookup_table_end - lookup_table)
    BNE @data_loop
    
    ; Set up attribute table (all palette 0)
    BIT PPUSTATUS
    LDA #>ATTRTABLE_A
    STA PPUADDR
    LDA #<ATTRTABLE_A
    STA PPUADDR
    LDA #0
    LDX #64
@attr_loop:
    STA PPUDATA
    DEX
    BNE @attr_loop
    
    ; Wait for VBLANK after all PPU writes (EXACTLY like templates/nes)
    BIT PPUSTATUS
vblank_wait3:
    BIT PPUSTATUS
    BPL vblank_wait3
    
    ; Set scroll position to 0,0
    LDA #0
    STA PPUSCROLL
    STA PPUSCROLL
    
    ; Enable NMI and display (EXACTLY like templates/nes)
    LDA #%10001000  ; NMI enabled, background from pattern table 0
    STA PPUCTRL
    LDA #%00011110  ; Show background
    STA PPUMASK
    
    ; Infinite loop
forever:
    JMP forever

nmi:
    PHA
    
    ; Refresh scroll position
    LDA #0
    STA PPUSCROLL
    STA PPUSCROLL
    
    ; Keep PPU config
    LDA #%10001000
    STA PPUCTRL
    LDA #%00011110
    STA PPUMASK
    
    PLA
    RTI

irq:
    RTI

.segment "RODATA"

; Example: Single hex string with separators (demonstration only, not displayed)
example_data:
    hex "112''''23_34_4f'f"   ; Demonstrates single quotes and underscores
                              ; Result: $11, $22, $33, $44, $4F, $FF

; Include CHR data (font)
.include "font.asm"
