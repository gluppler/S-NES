; ============================================================================
; Reset Handler
; ============================================================================
; EXACTLY matches hello_world example initialization sequence
; ============================================================================

.segment "CODE"

.include "constants/ppu.inc"

; APU constants (NES hardware addresses: $4000-$4017)
APU_FRAMECTR    = $4017  ; Frame counter register
APU_MODCTRL     = $4010  ; DMC control register

; Constants (matching hello_world exactly)
DEFMASK        = %00001000 ; background enabled
START_X        = 9
START_Y        = 14
NAMETABLE_A    = $2000
ATTRTABLE_A    = $23C0
START_NT_ADDR  = NAMETABLE_A + 32*START_Y + START_X

; Color constants (matching hello_world exactly) - imported from ppu.inc
; BLACK, WHITE, DARK, NEUTRAL, LIGHT defined in constants/ppu.inc

; WAIT_VBLANK macro (matching hello_world exactly)
.macro WAIT_VBLANK
:  bit PPUSTATUS
   bpl :-
.endmacro

; Export reset entry point
.export reset

; String data (EXACTLY like hello_world - defined before reset function)
template_str:
    .byte "NES TEMPLATE", 0

ready_str:
    .byte "READY TO CODE", 0

reset:
    ; EXACTLY like hello_world: Initialize CPU
    sei
    cld
    ldx #$40
    stx APU_FRAMECTR ; disable IRQ
    ldx #$FF
    txs ; init stack pointer
    inx ; reset X to zero to initialize PPU and APU registers
    stx PPUCTRL
    stx PPUMASK
    stx APU_MODCTRL

    WAIT_VBLANK

    ; while waiting for two frames for PPU to stabilize, reset RAM
    ; EXACTLY like hello_world
    txa   ; still zero!
@clr_ram:
    sta $000,x
    sta $100,x
    sta $200,x
    sta $300,x
    sta $400,x
    sta $500,x
    sta $600,x
    sta $700,x
    inx
    bne @clr_ram

    WAIT_VBLANK

    ; start writing to palette, starting with background color
    ; EXACTLY like hello_world
    ; Reset PPU address latch by reading PPUSTATUS first
    bit PPUSTATUS
    lda #>BG_COLOR
    sta PPUADDR
    lda #<BG_COLOR
    sta PPUADDR
    lda #BLACK
    sta PPUDATA ; black background color
    sta PPUDATA ; palette 0, color 0 = black
    lda #(WHITE | DARK)
    sta PPUDATA ; color 1 = dark white
    lda #(WHITE | NEUTRAL)
    sta PPUDATA ; color 2 = neutral white
    lda #(WHITE | LIGHT)
    sta PPUDATA ; color 3 = light white

    ; place "NES TEMPLATE" string
    ; EXACTLY like hello_world pattern
    ; Reset PPU address latch
    bit PPUSTATUS
    lda #>START_NT_ADDR
    sta PPUADDR
    lda #<START_NT_ADDR
    sta PPUADDR
    ldx #0
@template_loop:
    lda template_str,x
    beq @ready_line
    sta PPUDATA
    inx
    jmp @template_loop

@ready_line:
    ; Place "READY TO CODE" on next line (START_Y + 1)
    ; EXACTLY like hello_world pattern
    ; Reset PPU address latch
    bit PPUSTATUS
    lda #>(NAMETABLE_A + 32*(START_Y + 1) + START_X)
    sta PPUADDR
    lda #<(NAMETABLE_A + 32*(START_Y + 1) + START_X)
    sta PPUADDR
    ldx #0
@ready_loop:
    lda ready_str,x
    beq @setpal
    sta PPUDATA
    inx
    jmp @ready_loop

@setpal:
    ; set all table A tiles to palette 0
    ; EXACTLY like hello_world
    ; Reset PPU address latch
    bit PPUSTATUS
    lda #>ATTRTABLE_A
    sta PPUADDR
    lda #<ATTRTABLE_A
    sta PPUADDR
    lda #0
    ldx #64
@attr_loop:
    sta PPUDATA
    dex
    bne @attr_loop

    ; Wait for VBLANK after all PPU writes (EXACTLY like hello_world)
    WAIT_VBLANK

    ; set scroll position to 0,0
    ; EXACTLY like hello_world
    lda #0
    sta PPUSCROLL ; x = 0
    sta PPUSCROLL ; y = 0
    ; enable NMI and display
    ; EXACTLY like hello_world: NMI enabled, background from pattern table 0
    lda #%10001000
    sta PPUCTRL
    lda #DEFMASK
    sta PPUMASK

    ; Enter main loop (imported from main.asm)
    .import main_loop
    jmp main_loop

; ============================================================================
; Interrupt Vectors
; ============================================================================
; EXACTLY like hello_world: vectors at end
; NOTE: Imported symbols (nmi, irq) may not resolve in VECTORS segment
; Workaround: Import them and let linker resolve, or define all in one file
; ============================================================================

.import nmi, irq

.segment "VECTORS"
    .word nmi         ; $fffa vblank nmi (imported - linker should resolve)
    .word reset       ; $fffc reset (local - should work)
    .word irq         ; $fffe irq / brk (imported - linker should resolve)
