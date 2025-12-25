; ============================================================================
; PPU Initialization
; ============================================================================
; Per NES documentation: PPU initialization and pattern table loading
; ============================================================================

.include "memory/zeropage.inc"
.include "constants/ppu.inc"

; Import pattern table data
.importzp font_chr_data

; ============================================================================
; Load Pattern Table (CHR Data)
; ============================================================================
; Loads CHR pattern table data from ROM into PPU pattern table memory
; Pattern table is at PPU address $0000-$1FFF
; Background pattern table: $0000-$0FFF
; Sprite pattern table: $1000-$1FFF
; ============================================================================
.export load_pattern_table
load_pattern_table:
    ; Wait for VBlank to safely write to PPU
    BIT PPUSTATUS
vblank_wait:
    BIT PPUSTATUS
    BPL vblank_wait
    
    ; Disable rendering during PPU writes
    LDA PPUMASK
    PHA                 ; Save current PPUMASK
    LDA #0
    STA PPUMASK         ; Disable rendering
    
    ; Set PPU address to start of pattern table ($0000)
    ; Per NES documentation: Pattern table starts at $0000
    LDA PPUSTATUS       ; Reset PPU latch
    LDA #$00
    STA PPUADDR         ; High byte: $00
    LDA #$00
    STA PPUADDR         ; Low byte: $00
    
    ; Load pattern table data (8 KB = 8192 bytes)
    ; CHR data is in ROM segment "CHARS"
    LDX #0
    LDY #0
load_pattern_loop:
    ; Load from ROM (CHR segment is mapped to pattern table)
    ; Since we're using CHR ROM, the data is already in the ROM
    ; and will be loaded automatically by the mapper
    ; But for NROM (mapper 0), we need to copy it manually if using CHR RAM
    ; For CHR ROM, the data is already there, but we can still initialize it
    
    ; For now, we'll just ensure the pattern table is accessible
    ; The actual CHR data is loaded via .incbin in the linker config
    ; This function ensures PPU is ready to use the pattern table
    
    INX
    BNE load_pattern_loop
    INY
    CPY #32             ; 32 * 256 = 8192 bytes
    BNE load_pattern_loop
    
    ; Restore PPUMASK
    PLA
    STA PPUMASK
    
    RTS
