; ============================================================================
; SNES Constants
; ============================================================================
; SNES-specific constants and definitions
; ============================================================================

.ifndef SNES_CONSTANTS_INC
SNES_CONSTANTS_INC = 1

; ============================================================================
; CPU Constants (65816)
; ============================================================================

; Register Width Flags
FLAG_8BIT_A  = %00100000  ; 8-bit accumulator
FLAG_16BIT_A = %00000000  ; 16-bit accumulator
FLAG_8BIT_XY = %00010000  ; 8-bit index registers
FLAG_16BIT_XY = %00000000 ; 16-bit index registers

; CPU Timing (NTSC)
CPU_FREQ_NTSC = 3579545   ; 3.58 MHz
CPU_FREQ_PAL  = 3546895   ; 3.55 MHz
CYCLES_PER_FRAME_NTSC = 21477  ; Cycles per frame (NTSC)
CYCLES_PER_FRAME_PAL  = 21200  ; Cycles per frame (PAL)

; Stack
STACK_BASE   = $0100
STACK_SIZE   = $0100
STACK_TOP    = $01FF

; Direct Page
DIRECT_PAGE_BASE = $0000

; ============================================================================
; PPU Constants
; ============================================================================

; INIDISP Bits
INIDISP_FORCE_BLANK = %10000000
INIDISP_BRIGHTNESS_MASK = %00001111

; BGMODE Values
BGMODE_0 = $00  ; 4 BGs, 2bpp
BGMODE_1 = $01  ; 3 BGs, 4bpp + 2bpp
BGMODE_2 = $02  ; 2 BGs, 4bpp
BGMODE_3 = $03  ; 2 BGs, 8bpp + 4bpp
BGMODE_4 = $04  ; 2 BGs, 8bpp + 2bpp
BGMODE_5 = $05  ; 2 BGs, 4bpp, 512×448
BGMODE_6 = $06  ; 1 BG, 4bpp, 512×448
BGMODE_7 = $07  ; 1 BG, 8bpp, Mode 7

; VMAINC Values
VMAINC_INCREMENT_1   = %00000000
VMAINC_INCREMENT_32  = %00000001
VMAINC_INCREMENT_128 = %00000010
VMAINC_INCREMENT_128_ALT = %00000011
VMAINC_INCREMENT_HI  = %10000000  ; Increment after high byte

; Layer Enable Bits
TM_BG1 = %00000001
TM_BG2 = %00000010
TM_BG3 = %00000100
TM_BG4 = %00001000
TM_OBJ = %00010000

; ============================================================================
; DMA Constants
; ============================================================================
; See ../../docs/snes/hardware/dma-hdma/general-dma.md
; See ../../docs/snes/programming/rendering/dma-oam-updates.md
; ============================================================================

; DMA Transfer Modes
DMA_LINEAR   = $00  ; Increment source address
DMA_01       = $01  ; Write to two consecutive registers
DMA_00       = $02  ; Write to same register twice (for dual-write ports)
DMA_0011     = $03  ; Write to two registers, then repeat
DMA_0123     = $04  ; Write to four consecutive registers
DMA_0101     = $05  ; Write to two registers, alternating

; DMA Address Increment
DMA_FORWARD  = $00  ; Increment source address
DMA_CONST    = $08  ; Fixed source address
DMA_BACKWARD = $10  ; Decrement source address

; DMA Direction
DMA_READPPU  = $80  ; Read from PPU, write to CPU

; DMA Indirect (HDMA)
DMA_INDIRECT = $40  ; Table contains pointers

; Composite DMA Mode Constants
; Format: (<PPU_REGISTER << 8) | DMA_MODE | DMA_DIRECTION
PPUDATA = VMDATAL  ; Alias for VRAM data port
DMAMODE_PPULOFILL = (<VMDATAL << 8)       | DMA_LINEAR | DMA_CONST
DMAMODE_PPUHIFILL = (<(VMDATAH << 8))     | DMA_LINEAR | DMA_CONST
DMAMODE_PPUFILL   = (<VMDATAL << 8)       | DMA_01     | DMA_CONST
DMAMODE_PPULODATA = (<VMDATAL << 8)       | DMA_LINEAR | DMA_FORWARD
DMAMODE_PPUHIDATA = (<(VMDATAH << 8))     | DMA_LINEAR | DMA_FORWARD
DMAMODE_PPUDATA   = (<VMDATAL << 8)       | DMA_01     | DMA_FORWARD
DMAMODE_CGDATA    = (<CGDATA << 8)        | DMA_00     | DMA_FORWARD
DMAMODE_OAMDATA   = (<OAMDATA << 8)       | DMA_00     | DMA_FORWARD

; DMA Register Aliases (for compatibility)
DMAMODE = DMAP0
DMAADDR = A1T0L
DMAADDRHI = A1T0H
DMAADDRBANK = A1T0B
DMALEN = DAS0L
DMALENHI = DAS0H
DMAPPUREG = BBAD0
COPYSTART = MDMAEN
HDMASTART = HDMAEN

; ============================================================================
; Memory Map Constants
; ============================================================================

; WRAM
WRAM_BASE   = $7E0000
WRAM_SIZE   = $20000     ; 128 KB
WRAM_END    = $7FFFFF

; VRAM
VRAM_SIZE   = $10000     ; 64 KB

; CGRAM
CGRAM_SIZE  = $0200      ; 512 bytes (256 colors)

; OAM
OAM_SIZE    = $0220      ; 544 bytes (512 + 32)

; ============================================================================
; Timing Constants
; ============================================================================

; VBlank
VBLANK_START_NTSC = 225   ; Scanline 225 (NTSC)
VBLANK_START_PAL  = 240   ; Scanline 240 (PAL)
VBLANK_DURATION_NTSC = 38 ; 38 scanlines (NTSC)
VBLANK_DURATION_PAL  = 73  ; 73 scanlines (PAL)

; ============================================================================
; Button Masks (Active-Low)
; ============================================================================

BUTTON_B      = %1000000000000000
BUTTON_Y      = %0100000000000000
BUTTON_SELECT = %0010000000000000
BUTTON_START  = %0001000000000000
BUTTON_UP     = %0000100000000000
BUTTON_DOWN   = %0000010000000000
BUTTON_LEFT   = %0000001000000000
BUTTON_RIGHT  = %0000000100000000
BUTTON_A      = %0000000010000000
BUTTON_X      = %0000000001000000
BUTTON_L      = %0000000000100000
BUTTON_R      = %0000000000010000

.endif ; SNES_CONSTANTS_INC
