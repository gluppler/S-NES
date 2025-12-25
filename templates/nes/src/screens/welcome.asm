; ============================================================================
; Welcome Screen
; ============================================================================
; Welcome/title screen logic - displays "NES TEMPLATE" and "READY TO CODE"
; EXACTLY matches hello_world example pattern (ASCII direct to PPUDATA)
; ============================================================================

.include "memory/zeropage.inc"
.include "constants/ppu.inc"
.include "text/strings.asm"

; Constants (matching hello_world pattern exactly)
START_X        = 9
START_Y        = 14
NAMETABLE_A    = $2000
START_NT_ADDR  = NAMETABLE_A + 32*START_Y + START_X

; ============================================================================
; Initialize Welcome Screen
; ============================================================================
; Displays "NES TEMPLATE" and "READY TO CODE" text on screen
; EXACTLY like hello_world: write ASCII directly to PPUDATA (no conversion)
; ============================================================================
.export init_welcome_screen
init_welcome_screen:
    ; Wait for VBlank to safely write to PPU (exactly like hello_world)
    BIT PPUSTATUS
@vblank_wait:
    BIT PPUSTATUS
    BPL @vblank_wait
    
    ; Disable rendering during PPU writes
    LDA PPUMASK
    PHA                 ; Save current PPUMASK
    LDA #0
    STA PPUMASK         ; Disable rendering
    
    ; Display "NES TEMPLATE" on row 14, centered (column 9)
    ; EXACTLY like hello_world: write ASCII directly to PPUDATA
    LDA #>START_NT_ADDR
    STA PPUADDR
    LDA #<START_NT_ADDR
    STA PPUADDR
    
    LDX #0
@template_loop:
    LDA template_str,X
    BEQ @ready_line
    STA PPUDATA         ; Write ASCII directly (like hello_world)
    INX
    JMP @template_loop
    
@ready_line:
    ; Display "READY TO CODE" on row 15, centered (column 9)
    ; EXACTLY like hello_world pattern
    LDA #>(NAMETABLE_A + 32*(START_Y + 1) + START_X)
    STA PPUADDR
    LDA #<(NAMETABLE_A + 32*(START_Y + 1) + START_X)
    STA PPUADDR
    
    LDX #0
@ready_loop:
    LDA ready_str,X
    BEQ @set_attr
    STA PPUDATA         ; Write ASCII directly (like hello_world)
    INX
    JMP @ready_loop
    
@set_attr:
    ; Set all nametable tiles to palette 0 (exactly like hello_world)
    LDA #>$23C0          ; Attribute table A (ATTRTABLE_A from hello_world)
    STA PPUADDR
    LDA #<$23C0
    STA PPUADDR
    LDA #0
    LDX #64             ; 64 attribute bytes
@attr_loop:
    STA PPUDATA
    DEX
    BNE @attr_loop
    
    ; Restore PPUMASK
    PLA
    STA PPUMASK
    
    RTS
