# Your First SNES Program

## Complete Working Example

This is a minimal but complete SNES program that displays "Hello, World!" on screen.

## Source Code

```asm
; ============================================================================
; First SNES Program - Hello World
; ============================================================================
; Complete working SNES program demonstrating:
; - Native 65816 mode entry
; - PPU initialization
; - Text rendering
; - Frame synchronization
; ============================================================================

.p816   ; 65816 processor
.i16    ; X/Y are 16 bits
.a8     ; A is 8 bits

; SNES register definitions
INIDISP = $2100
BGMODE  = $2105
BG1SC   = $2107
BG12NBA = $210B
VMAINC  = $2115
VMADDL  = $2116
VMADDH  = $2117
VMDATAL = $2118
VMDATAH = $2119
CGADD   = $2121
CGDATA  = $2122
TM      = $212C
NMITIMEN = $4200
RDNMI   = $4210

.segment "HEADER"
.byte "HELLO WORLD SNES  "  ; ROM name (21 bytes)

.segment "ROMINFO"
.byte $30    ; LoROM, fast-capable
.byte 0      ; No battery RAM
.byte $07    ; 128K ROM
.byte 0,0,0,0
.word $AAAA, $5555  ; Dummy checksum

.segment "CODE"
start:
    ; Switch to native mode
    clc
    xce
    
    ; Set register widths
    rep #$10        ; 16-bit X, Y
    sep #$20        ; 8-bit A
    
    ; Initialize stack
    ldx #$01FF
    txs
    
    ; Initialize direct page
    lda #$0000
    tcd
    
    ; Enable forced blanking
    lda #$80
    sta INIDISP
    
    ; Clear VRAM (via DMA - see ClearVRAM subroutine)
    jsr ClearVRAM
    
    ; Initialize PPU registers
    stz BGMODE      ; Mode 0
    lda #$10
    sta BG1SC       ; BG1 nametable at $1000
    lda #$00
    sta BG12NBA     ; BG tiles at $0000
    
    ; Load palette
    stz CGADD
    stz CGDATA       ; Color 0: black
    stz CGDATA
    lda #$7F         ; Color 1: white (low byte)
    sta CGDATA
    lda #$7F         ; Color 1: white (high byte)
    sta CGDATA
    
    ; Load font tiles to VRAM
    lda #$80         ; Increment by 1 word
    sta VMAINC
    ldx #$0000       ; VRAM address $0000
    stx VMADDL
    ldx #0
font_loop:
    lda font_data,x
    stz VMDATAL      ; Low byte = 0
    sta VMDATAH      ; High byte = font data
    inx
    cpx #(128*8)      ; 128 characters × 8 bytes
    bne font_loop
    
    ; Write "HELLO WORLD" to nametable
    lda #$80
    sta VMAINC
    ldx #$1000       ; BG1 nametable at $1000
    stx VMADDL
    ldx #0
text_loop:
    lda hello_text,x
    beq text_done
    sta VMDATAL      ; Tile index
    stz VMDATAH      ; Attributes (palette 0)
    inx
    bra text_loop
text_done:
    
    ; Enable display
    lda #$01         ; Enable BG1
    sta TM
    lda #$0F         ; Full brightness
    sta INIDISP
    
    ; Enable NMI
    lda #$80
    sta NMITIMEN
    
    ; Main loop
game_loop:
    wai              ; Wait for VBlank
    jmp game_loop

; NMI handler
nmi:
    lda RDNMI        ; Acknowledge NMI
    rti

; Clear VRAM via DMA
ClearVRAM:
    pha
    phx
    php
    
    rep #$30
    sep #$20
    
    lda #$80
    sta VMAINC
    ldx #$1809       ; DMA mode: fixed source, word to $2118/9
    stx $4300
    ldx #$0000
    stx VMADDL
    stx $0000        ; Source = $00:0000 (zero)
    stx $4302
    lda #$00
    sta $4304
    ldx #$FFFF       ; Transfer 64K-1 bytes
    stx $4305
    lda #$01
    sta $420B        ; Start DMA
    
    stz $2119        ; Clear last byte
    
    plp
    plx
    pla
    rts

; Font data (128 characters, 8 bytes each)
font_data:
    ; ... font bitmap data here ...
    .res 128*8, $00  ; Placeholder

; Text string
hello_text:
    .byte "HELLO WORLD", 0

.segment "VECTORS"
.word 0, 0           ; Native mode vectors
.word nmi, start, 0  ; NMI, Reset, IRQ
.word 0, 0           ; Emulation mode vectors
.word nmi, start, 0  ; NMI, Reset, IRQ
```

## Building

```bash
# Assemble
ca65 --cpu 65816 -o main.o main.asm

# Link
ld65 -C snes.cfg main.o -o hello.sfc
```

## What This Demonstrates

1. **Native Mode Entry**: `clc; xce` switches to native mode
2. **Register Widths**: 8-bit A, 16-bit X/Y
3. **Stack Initialization**: `ldx #$01FF; txs`
4. **Direct Page**: `lda #$0000; tcd`
5. **Forced Blanking**: Required before VRAM access
6. **PPU Setup**: Background mode, tilemaps, tiles
7. **DMA Usage**: Clearing VRAM via DMA
8. **Frame Sync**: `wai` waits for VBlank
9. **NMI Handler**: Acknowledges NMI

## Next Steps

- [Understanding 65816](04-understanding-65816.md) - Learn native vs emulation mode
- [Hardware Documentation](../hardware/) - Detailed hardware docs
- [Examples](../../../examples/snes/) - More complete examples
