.ifndef REGISTERS_INC
REGISTERS_INC = 1
; -----------------------------------------------------------------------------
;   File: Registers.inc
;   Description: Symbols representing the memory mapped registers of the SNES
; -----------------------------------------------------------------------------

;-------------------------------------------------------------------------------
;   PPU Registers
;-------------------------------------------------------------------------------
    INIDISP     := $2100    ; Display Control 1
    OBJSEL      := $2101    ; Object Size & Object Base
    OAMADDL     := $2102    ; OAM Address, lower byte
    OAMADDH     := $2103    ; OAM Address, bit 9 & Priority Rotation
    OAMDATA     := $2104    ; OAM Data Write
    BGMODE      := $2105    ; BG Mode & BG Character Size
    BG1SC       := $2107    ; BG1 Screen Base & Screen Size
    BG12NBA     := $210B    ; BG1/BG2 Character Data Area Designation
    VMAINC      := $2115    ; VRAM Address Increment Mode
    VMADDL      := $2116    ; VRAM Address, lower byte
    VMADDH      := $2117    ; VRAM Address, higher byte
    VMDATAL     := $2118    ; VRAM Data Write, lower byte
    VMDATAH     := $2119    ; VRAM Data Write, higher byte
    BG1HOFS     := $210D    ; BG1 Horizontal Scroll (X) / M7HOFS
    BG1VOFS     := $210E    ; BG1 Vertical   Scroll (Y) / M7VOFS
    CGADD       := $2121    ; Palette CGRAM Address
    CGDATA      := $2122    ; Palette CGRAM Data Write
    TM          := $212C    ; Main Screen Designation
    CGSWSEL     := $2130    ; Color Math Control Register A
    COLDATA     := $2132    ; Color Math Sub Screen Backdrop Color
;-------------------------------------------------------------------------------
;   CPU Registers
;-------------------------------------------------------------------------------
    NMITIMEN    := $4200    ; Interrupt Enable & Joypad Request
    WRIO        := $4201    ; Programmable I/O Port (Open-Collector Output)
    MDMAEN      := $420B    ; Select General Purpose DMA Channels & Start Transfer
    RDNMI       := $4210    ; V-Blank NMI Flag and CPU Version Number (Read/Ack)
    HVBJOY      := $4212    ; H/V-Blank Flag & Joypad Busy Flag
    JOY1L       := $4218    ; Joypad 1 (Gameport 1, Pin 4), lower byte
    JOY1H       := $4219    ; Joypad 1 (Gameport 1, Pin 4), higher byte
;-------------------------------------------------------------------------------
;   DMA Registers
;-------------------------------------------------------------------------------
    DMAP0       := $4300    ; DMA0 DMA/HDMA Parameters
    BBAD0       := $4301    ; DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
    A1T0L       := $4302    ; DMA0 DMA/HDMA Table Start Address, lower byte
    A1T0H       := $4303    ; DMA0 DMA/HDMA Table Start Address, higher byte
    A1T0B       := $4304    ; DMA0 DMA/HDMA Table Start Address (Bank)
    DAS0L       := $4305    ; DMA0 DMA Count, lower byte
    DAS0H       := $4306    ; DMA0 DMA Count, higher byte
    DAS0B       := $4307    ; DMA0 Indirect HDMA Address (Bank)
;-------------------------------------------------------------------------------

.endif
