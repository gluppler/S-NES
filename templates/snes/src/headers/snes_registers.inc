; ============================================================================
; SNES Register Definitions
; ============================================================================
; Complete SNES hardware register map
; Based on Fullsnes and SNESdev Wiki
; ============================================================================

.ifndef SNES_REGISTERS_INC
SNES_REGISTERS_INC = 1

; ============================================================================
; S-PPU Registers ($2100-$213F)
; ============================================================================

; Screen Display
INIDISP     = $2100   ; Initial settings for screen (forced blank, brightness)
OBJSEL      = $2101   ; Object size and character size
OAMADDL     = $2102   ; OAM address (low byte)
OAMADDH     = $2103   ; OAM address (high byte)
OAMDATA     = $2104   ; OAM data write

; Background Configuration
BGMODE      = $2105   ; BG mode and character size
MOSAIC      = $2106   ; Mosaic register
BG1SC       = $2107   ; BG1 tilemap address
BG2SC       = $2108   ; BG2 tilemap address
BG3SC       = $2109   ; BG3 tilemap address
BG4SC       = $210A   ; BG4 tilemap address
BG12NBA     = $210B   ; BG1/BG2 character address
BG34NBA     = $210C   ; BG3/BG4 character address

; Background Scrolling (dual-write registers)
BG1HOFS     = $210D   ; BG1 horizontal scroll
BG1VOFS     = $210E   ; BG1 vertical scroll
BG2HOFS     = $210F   ; BG2 horizontal scroll
BG2VOFS     = $2110   ; BG2 vertical scroll
BG3HOFS     = $2111   ; BG3 horizontal scroll
BG3VOFS     = $2112   ; BG3 vertical scroll
BG4HOFS     = $2113   ; BG4 horizontal scroll
BG4VOFS     = $2114   ; BG4 vertical scroll

; VRAM Access
VMAINC      = $2115   ; VRAM address increment
VMADDL      = $2116   ; VRAM address (low byte)
VMADDH      = $2117   ; VRAM address (high byte)
VMDATAL     = $2118   ; VRAM data write (low byte)
VMDATAH     = $2119   ; VRAM data write (high byte)

; Mode 7
M7SEL       = $211A   ; Mode 7 settings
M7A         = $211B   ; Mode 7 matrix A (dual-write)
M7B         = $211C   ; Mode 7 matrix B (dual-write)
M7C         = $211D   ; Mode 7 matrix C (dual-write)
M7D         = $211E   ; Mode 7 matrix D (dual-write)
M7X         = $211F   ; Mode 7 center X (dual-write)
M7Y         = $2120   ; Mode 7 center Y (dual-write)

; CGRAM (Palette)
CGADD       = $2121   ; CGRAM address
CGDATA      = $2122   ; CGRAM data write (dual-write)

; Windowing
W12SEL      = $2123   ; Window mask settings (BG1/BG2)
W34SEL      = $2124   ; Window mask settings (BG3/BG4)
WOBJSEL     = $2125   ; Window mask settings (OBJ)
WH0         = $2126   ; Window 1 left position
WH1         = $2127   ; Window 1 right position
WH2         = $2128   ; Window 2 left position
WH3         = $2129   ; Window 2 right position
WBGLOG      = $212A   ; Window mask logic (BG)
WOBJLOG     = $212B   ; Window mask logic (OBJ)

; Layer Enables
TM          = $212C   ; Main screen designation
TS          = $212D   ; Sub screen designation
TMW         = $212E   ; Window mask main screen
TSW         = $212F   ; Window mask sub screen

; Color Math
CGWSEL      = $2130   ; Color math register
CGADSUB     = $2131   ; Color math register
COLDATA     = $2132   ; Fixed color data

; Display Settings
SETINI      = $2133   ; Screen mode select

; PPU Status (read-only)
MPYL        = $2134   ; Multiplication result (low)
MPYM        = $2135   ; Multiplication result (mid)
MPYH        = $2136   ; Multiplication result (high)
SLHV        = $2137   ; Software latch for H/V counter
OAMDATAREAD = $2138   ; OAM data read
VMDATALREAD = $2139   ; VRAM data read (low)
VMDATAHREAD = $213A   ; VRAM data read (high)
CGDATAREAD  = $213B   ; CGRAM data read
OPHCT       = $213C   ; Horizontal counter (dual-read)
OPVCT       = $213D   ; Vertical counter (dual-read)
STAT77      = $213E   ; PPU status register 1
STAT78      = $213F   ; PPU status register 2

; ============================================================================
; S-CPU I/O Registers ($4200-$43FF)
; ============================================================================

; Interrupts
NMITIMEN    = $4200   ; Interrupt enable (NMI, auto-joypad)
WRIO        = $4201   ; IO port write
WRMPYA      = $4202   ; Multiplicand A
WRMPYB      = $4203   ; Multiplicand B
WRDIVL      = $4204   ; Dividend (low)
WRDIVH      = $4205   ; Dividend (high)
WRDIVB      = $4206   ; Divisor
HTIMEL      = $4207   ; H-count timer (low)
HTIMEH      = $4208   ; H-count timer (high)
VTIMEL      = $4209   ; V-count timer (low)
VTIMEH      = $420A   ; V-count timer (high)
MDMAEN      = $420B   ; DMA enable
HDMAEN      = $420C   ; HDMA enable
MEMSEL      = $420D   ; ROM speed (fast ROM enable)

; Status (read-only)
RDNMI       = $4210   ; NMI flag status
TIMEUP      = $4211   ; IRQ flag status
HVBJOY      = $4212   ; H/V blank and joypad status
RDIO        = $4213   ; IO port read
RDDIVL      = $4214   ; Division result (low)
RDDIVH      = $4215   ; Division result (high)
RDMPYL      = $4216   ; Multiplication result (low)
RDMPYH      = $4217   ; Multiplication result (high)

; Auto-Joypad
JOY1L       = $4218   ; Joypad 1 data (low)
JOY1H       = $4219   ; Joypad 1 data (high)
JOY2L       = $421A   ; Joypad 2 data (low)
JOY2H       = $421B   ; Joypad 2 data (high)
JOY3L       = $421C   ; Joypad 3 data (low)
JOY3H       = $421D   ; Joypad 3 data (high)
JOY4L       = $421E   ; Joypad 4 data (low)
JOY4H       = $421F   ; Joypad 4 data (high)

; ============================================================================
; DMA Registers ($4300-$43FF)
; ============================================================================

; Channel 0
DMAP0       = $4300   ; DMA parameters
BBAD0       = $4301   ; B-bus address
A1T0L       = $4302   ; A-bus address (low)
A1T0H       = $4303   ; A-bus address (high)
A1T0B       = $4304   ; A-bus address (bank)
DAS0L       = $4305   ; DMA size (low)
DAS0H       = $4306   ; DMA size (high)
A2A0L       = $4307   ; HDMA table address (low)
A2A0H       = $4308   ; HDMA table address (high)
A2A0B       = $4309   ; HDMA table address (bank)
NTRL0       = $430A   ; HDMA line counter

; Channels 1-7 follow same pattern ($4310-$437F)

; ============================================================================
; SPC700 Communication ($2140-$2143)
; ============================================================================

APUIO0      = $2140   ; APU IO port 0
APUIO1      = $2141   ; APU IO port 1
APUIO2      = $2142   ; APU IO port 2
APUIO3      = $2143   ; APU IO port 3

; ============================================================================
; WRAM Access ($2180-$2183)
; ============================================================================

WMDATA      = $2180   ; WRAM data register
WMADDL      = $2181   ; WRAM address (low)
WMADDM      = $2182   ; WRAM address (mid)
WMADDH      = $2183   ; WRAM address (high)

; ============================================================================
; Old-Style Joypad ($4016-$4017)
; ============================================================================

JOYSER0     = $4016   ; Old-style joypad (write to enable)
JOYSER1     = $4017   ; Old-style joypad (read)

.endif ; SNES_REGISTERS_INC
