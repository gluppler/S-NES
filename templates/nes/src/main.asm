; ============================================================================
; NES Template - Main Entry Point
; ============================================================================
; Full-featured NES development template with modular architecture
; Follows NES documentation best practices and hardware-accurate patterns
;
; This template applies to:
;   - ✅ NES (Nintendo Entertainment System): Primary focus
;   - ✅ : Fully compatible (same hardware)
;   - ❌ SNES: Does not apply (see ../snes/ for SNES template)
;
; Architecture:
;   - 32 KB PRG ROM (Mapper 0, NROM)
;   - 8 KB CHR ROM (512 tiles)
;   - Frame-synchronized game loop
;   - Modular architecture
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

; Interrupt vectors
; Note: vectors.asm is compiled separately and linked

.segment "CODE"

; ============================================================================
; Include Memory Definitions
; ============================================================================
.include "memory/zeropage.inc"
.include "memory/ram.inc"
.include "memory/oam.inc"

; Import symbols from separately compiled modules
.import update_game_state
.import update_oam_buffer
.include "memory/stack.inc"

; ============================================================================
; Include Constants
; ============================================================================
.include "constants/cpu.inc"
.include "constants/ppu.inc"
.include "constants/apu.inc"
.include "constants/controller.inc"
.include "constants/mapper.inc"

; ============================================================================
; Include Macros
; ============================================================================
.include "macros/registers.inc"
.include "macros/ppu.inc"
.include "macros/memory.inc"
.include "macros/math.inc"
.include "macros/sprites.inc"
.include "macros/loops.inc"
.include "macros/branches.inc"
.include "macros/controller.inc"
.include "macros/text.inc"
.include "macros/timing.inc"

; ============================================================================
; Sprite System
; ============================================================================
; Note: sprite_utils.asm and sprite_dma.asm are compiled separately and linked
.include "sprites/sprite_dma.asm"

; ============================================================================
; State Management
; ============================================================================
; Note: state_machine.asm is compiled separately and linked

; ============================================================================
; Palette System
; ============================================================================
; Note: palette_load.asm is compiled separately and linked

; ============================================================================
; Core Modules
; ============================================================================
; Note: nmi.asm and irq.asm are compiled separately and linked

; ============================================================================
; Include Input System
; ============================================================================
.include "input/controller.asm"
.include "input/debounce.asm"

; ============================================================================
; Include PPU System
; ============================================================================
.include "ppu/ppu_init.asm"
.include "ppu/ppu_write.asm"
.include "ppu/scrolling.asm"

; ============================================================================
; Text System
; ============================================================================
; Note: print.asm and print_centered.asm are compiled separately and linked

; ============================================================================
; Include Tilemap System
; ============================================================================
.include "tilemap/tilemap_loader.asm"

; ============================================================================
; Include Game Logic
; ============================================================================
.include "game/entities.asm"

; ============================================================================
; Include Screen Modules
; ============================================================================
; Note: welcome screen is now integrated into reset.asm (matching hello_world pattern)
.include "screens/game.asm"

; ============================================================================
; Include PPU Attributes (after ppu_write for set_ppu_address)
; ============================================================================
.include "ppu/attributes.asm"

; ============================================================================
; Main Loop
; ============================================================================
; Per NES documentation: Game loop pattern with frame synchronization
; ============================================================================
.export main_loop
main_loop:
    ; EXACTLY like hello_world: Simple VBLANK wait loop
    ; The text is already written to nametable in reset.asm
    ; Just wait for VBLANK to keep the display stable
    ; Per NES documentation: Simple game loop pattern
    BIT PPUSTATUS
@vblank_wait:
    BIT PPUSTATUS
    BPL @vblank_wait
    ; do something (placeholder - text already displayed in reset)
    JMP main_loop

; ============================================================================
; Update Game
; ============================================================================
; Per NES documentation: Game logic runs in main loop, not NMI
; ============================================================================
update_game:
    ; ADD CODE HERE: Game logic goes here
    ; This is called once per frame (60 Hz NTSC)
    RTS

; ============================================================================
; Update Rendering
; ============================================================================
; Per NES documentation: Prepare rendering data before NMI
; ============================================================================
update_rendering:
    ; Update OAM buffer from sprite state
    ; Per NES documentation: OAM buffer is updated via DMA in NMI
    JSR update_oam_buffer
    
    ; ADD CODE HERE: Additional rendering preparation
    RTS

; ============================================================================
; Data Section
; ============================================================================
; Per NES documentation: Constants and data in ROM
; ============================================================================

; ============================================================================
; Reset Handler
; ============================================================================
; Note: reset.asm is compiled separately and linked
; It imports main_loop, init_sprites, init_game_state, load_palette from this file

; ============================================================================
; CHR ROM Data
; ============================================================================
; Per NES documentation: Pattern table data, 8 KB (512 tiles × 16 bytes)
; ASCII font starting at tile 0 (ASCII 32 = space, ASCII 65 = 'A', etc.)
; EXACTLY like hello_world: include CHR data in main.asm
; ============================================================================
.include "../assets/data/neschar.asm"
