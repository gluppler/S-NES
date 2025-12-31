arch snes.cpu

define '0' 0
define '1' 1
define '2' 2
define '3' 3
define '4' 4
define '5' 5
define '6' 6
define '7' 7
define '8' 8
define '9' 9
define 'A' 10
define 'B' 11
define 'C' 12
define 'D' 13
define 'E' 14
define 'F' 15
define 'G' 16
define 'H' 17
define 'I' 18
define 'J' 19
define 'K' 20
define 'L' 21
define 'M' 22
define 'N' 23
define 'O' 0
define 'P' 24
define 'Q' 25
define 'R' 26
define 'S' 27
define 'T' 28
define 'U' 29
define 'V' 30
define 'W' 31
define 'X' 32
define 'Y' 33
define 'Z' 34
define ' ' 35
define ':' 36


// ---------------- Variables
namespace zp
base $0000
trampoline: ; seek 1
pointer:    ; seek 2
nmitask:    ; seek 1
ppuctrl:    ; seek 1
exram:      ; seek 1
mirroring:  ; seek 1
bankorder:  ; seek 1
inputnew:   ; seek 1
inputold:   ; seek 1
databanks:  ; seek 8

// ---------------- Task indexes
namespace task
base $0000
readdata:   ; seek 2
setppuctrl: ; seek 2
setexram:   ; seek 2
setmirror:  ; seek 2
setbanks:   ; seek 2
initialize: ; seek 2

namespace global

macro seek n
  org ({n} & $1fff)
  base {n}
endmacro

macro vram x, y; ($0 + ({y} << 5) + {x}); endmacro

{seek $e000}
fill $0

{seek $fffa}
.word NMIVector
.word ResetVector
.word ResetVector

{seek $e000}
ResetVector:
cld
ldx #$00
stx $0
stx $1
stx $0
stx $5
stx $5010
stx $5015
bit $2
-
bit $2
bpl {-}
-
bit $2
bpl {-}
stx <zp::exram
stx <zp::mirroring
stx <zp::bankorder
stx $5105
stx $5200
stx $5204
dex // now FF
txs
stx <zp::inputold
stx $7
lda #$03
sta $5101
sta $5107
lda #$25
sta $5106
lda #$4c // jmp absolute
sta <zp::trampoline
lda #$30 // initial PPUCTRL
sta <zp::ppuctrl
sta $0

// ---------------- Set up ex-attribute table in EXRAM
lda #$02
sta $5104
ldy #$00
sty <zp::pointer
lda #$5c
sta <zp::pointer+1
lda #$03           // 4KB bank $03 = 1KB banks $0C-$0F
EXRAMOuterLoop:
ldx #$20
EXRAMInnerLoop:
sta (zp::pointer),y
iny
beq YOverflow
dex
beq EXRAMOuterLoop
clc
adc #$40           // make diagonal pattern: $03,$43,$83,$C3,$03...
bne EXRAMInnerLoop // always taken

YOverflow:
inc <zp::pointer+1
ldx <zp::pointer+1
cpx #$60
bcc EXRAMOuterLoop

// ---------------- Unpack data into VRAM
lda #<VRAMData
sta <zp::pointer
lda #<VRAMData>>8
sta <zp::pointer+1
lda #$20
ldy #$00
sta $6
sty $6
lda (zp::pointer),y // number of spaces
VRAMLoop:
tax
lda #$23 // space
-
sta $7
dex
bne {-}
iny
lda (zp::pointer),y // number of non-space characters
beq VRAMDone
tax
-
iny
lda (zp::pointer),y
sta $7
dex
bne {-}
tya
sec // add y+1 to src ptr
adc <zp::pointer
sta <zp::pointer
bcc {+}
inc <zp::pointer+1
+
ldy #$00
lda (zp::pointer),y // number of spaces
bne VRAMLoop

VRAMDone:
jsr SetPPUCTRL
jsr SetBanks
jsr SetupObjects
lda #<task::initialize
sta <zp::nmitask
lda <zp::ppuctrl
ora #$80
sta <zp::ppuctrl
bit $2
sta $0

Forever:
jmp Forever

// ---------------- Set up OAM
SetupObjects:
lda #$f0
ldx #$20
-
sta $0200,x
inx
bne {-}
lda <zp::ppuctrl
// fall through

UpdateObjects:
and #$20
ora #$1f
tax
ldy #$1f
-
lda >OAMData,x
sta $0200,y
dex
dey
bpl {-}
rts

// ---------------- NMI event loop
NMIVector:
lda #$00
sta $3
lda #$02
sta $4
bit $2
ldx <zp::nmitask
lda #<task::readdata
sta <zp::nmitask
lda >JumpTable,x
sta <zp::pointer
lda >JumpTable+1,x
sta <zp::pointer+1
jsr zp::trampoline

// set PPUSCROLL
lda #$00
sta $5
lda #$08
sta $5

// read joypad
lda #$01
sta <zp::inputnew
sta $6
lsr             // now 0
sta $6
-
lda $6
and #$03
cmp #$01
rol <zp::inputnew
bcc {-}
// get newly-pressed buttons: (new ^ old) & new
lda <zp::inputnew
tax
eor <zp::inputold
and <zp::inputnew
stx <zp::inputold
// A: toggle OBJ pattern table
asl
bcc {+}
lda <zp::ppuctrl
eor #$08
sta <zp::ppuctrl
lda #<task::setppuctrl
sta <zp::nmitask
rti
+
// B: toggle BG pattern table
asl
bcc {+}
lda <zp::ppuctrl
eor #$10
sta <zp::ppuctrl
lda #<task::setppuctrl
sta <zp::nmitask
rti
+
// Select: toggle EXRAM
asl
bcc {+}
lda <zp::exram
eor #$01
sta <zp::exram
lda #<task::setexram
sta <zp::nmitask
rti
+
// Start: toggle OBJ size
asl
bcc {+}
lda <zp::ppuctrl
eor #$20
sta <zp::ppuctrl
jsr UpdateObjects
lda #<task::setppuctrl
sta <zp::nmitask
rti
+
// Up: toggle fill mode
asl
bcc {+}
lda <zp::mirroring
eor #$ff
sta <zp::mirroring
lda #<task::setmirror
sta <zp::nmitask
rti
+
asl // Down
// Left: change bank write order
asl
bcc NotLeft
dec <zp::bankorder
bpl {+}
lda #<(BankOrderDataEnd-BankOrderData) / 12 - 1
sta <zp::bankorder
+
lda #<task::setbanks
sta <zp::nmitask
rti
NotLeft:
// Right: change bank write order
asl
bcc NotRight
ldx <zp::bankorder
inx
cpx #<(BankOrderDataEnd-BankOrderData) / 12
bcc {+}
ldx #$00
+
stx <zp::bankorder
lda #<task::setbanks
sta <zp::nmitask
NotRight:
rti

// ---------------- NMI tasks
JumpTable:
.word ReadData
.word SetPPUCTRL
.word SetEXRAM
.word SetMirror
.word SetBanks
.word Initialize

// ---------------- NMI task: read data from CHR (default)
ReadData:
// read last byte in each 1K bank ($03ff,$07ff,..., $1fff)
ldx #$07
ldy #$ff
-
lda >CHRAddrTable,x
sta $6
sty $6
lda $7
lda $7
sta <zp::databanks,x
dex
bpl {-}

lda #<{vram 15, 18}>>8
sta $6
lda #<{vram 15, 18}
sta $6
lda <zp::databanks
sta $7
lda <zp::databanks+1
sta $7
lda <zp::databanks+2
sta $7
lda <zp::databanks+3
sta $7
lda <zp::databanks+4
sta $7
lda <zp::databanks+5
sta $7
lda <zp::databanks+6
sta $7
lda <zp::databanks+7
sta $7
rts

CHRAddrTable:
.byte $03,$07,$0b,$0f,$13,$17,$1b,$1f

// ---------------- NMI task: Change PPUCTRL
SetPPUCTRL:
lda <zp::ppuctrl
ora #$04   // write downward
sta $0
ldx #<{vram 24, 8}>>8
stx $6
ldx #<{vram 24, 8}
stx $6
ldx #$00
stx $5105 // make sure real nametable is mapped in
and #$08  // current OBJ pattern table
beq {+}
inx
+
stx $7
lda <zp::ppuctrl
ldx #$00
and #$10 // current BG pattern table
beq {+}
inx
+
stx $7
lda <zp::ppuctrl
sta $0
jmp SetMirror

// ---------------- NMI task: Change CHR banks
SetBanks:
lda #<{vram 18, 12}>>8
sta $6
lda #<{vram 18, 12}
sta $6
// pointer = bankorder * 12 + BankOrderData
lda <zp::bankorder
asl
asl
sta <zp::pointer
asl
adc <zp::pointer
adc #<BankOrderData
sta <zp::pointer
lda #<BankOrderData>>8
adc #$00
sta <zp::pointer+1
ldy #$00
sty $5105 // make sure real nametable is mapped in
-
lda (zp::pointer),y
sta $7
tax
tya
sta $5120,x
iny
cpy #<12
bcc {-}
// fall through

// ---------------- NMI task: Change mirroring
SetMirror:
lda <zp::mirroring
sta $5105
rts

BankOrderData:
.byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11
.byte 8, 9,10,11, 0, 1, 2, 3, 4, 5, 6, 7
.byte 8, 0, 4, 9, 1, 5,10, 2, 6, 3, 7,11
.byte 0, 4, 8, 1, 5, 9, 2, 6,10,11, 3, 7
BankOrderDataEnd:

// ---------------- NMI task: Initialize PPUMASK and palette
Initialize:
lda #$1e
sta $1
// fall through

// ---------------- NMI task: Change EXRAM mode (and palette)
SetEXRAM:
lda #$3f
sta $6
ldx #$00
stx $6
lda <zp::exram
sta $5104
cmp #$01
bne {+}
ldx #$08
+
ldy >PaletteData
-
sty $7
inx
lda >PaletteData,x
sta $7
inx
lda >PaletteData,x
sta $7
sty $7
cpx #$10
bcc {-}
rts

PaletteData:
.byte $00
.byte $20,$0F
.byte $22,$0F
.byte $2A,$0F
.byte $26,$0F
.byte $33,$0F
.byte $36,$0F
.byte $39,$0F
.byte $3C,$0F

// ---------------- VRAM data
VRAMData:
.byte 4*32+7,  18, "MMC5 CHR BANK TEST"
.byte 7+32+7,  18, "REGISTER SETTINGS:"
.byte 7+32+4,  18, "OBJ PATTERN TABLE:", 3, 3, "000"
.byte 4   +4,  17, "BG PATTERN TABLE:", 4, 3, "000"
.byte 4+32+18, 12, "0123456789AB"
.byte 2   +2,  15, "BANK SET ORDER:"
.byte 15+32+7,  18, "CURRENT CHR BANKS:"
.byte 7+32+9,   4, "OBJ:"
.byte 19   +9,   3, "BG:", 7, 4, $25,$65,$A5,$E5
.byte 9   +9,   5, "DATA:"
.byte 18+32+12,  9, "CONTROLS:"
.byte 11+32+3,   2, "A:", 7, 17, "OBJ PATTERN TABLE"
.byte 3   +3,   2, "B:", 7, 16, "BG PATTERN TABLE"
.byte 4   +3,   6, "START:", 3, 15, "CHANGE OBJ SIZE"
.byte 5   +3,  21, "SELECT:  TOGGLE EXRAM"
.byte 8   +3,   6, "PAD U:", 3, 16, "TOGGLE FILL MODE"
.byte 4   +3,  26, "PAD L R: CHANGE BANK ORDER"
.byte 3+32*2,  64
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$05,$00
.byte $00,$00,$00,$00,$04,$05,$05,$01
.byte $00,$00,$00,$80,$A8,$AA,$00,$00
.byte $C0,$30,$00,$00,$00,$00,$00,$00
.byte $CC,$FF,$F3,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte 0

// ---------------- OAM data

define ypos 119
define xpos 176
OAMData:
// 8x8
.byte {ypos}, $25, 0, {xpos}-24
.byte {ypos}, $65, 1, {xpos}-16
.byte {ypos}, $a5, 2, {xpos}-8
.byte {ypos}, $e5, 3, {xpos}
.byte $f0, $f0, $f0, $f0
.byte $f0, $f0, $f0, $f0
.byte $f0, $f0, $f0, $f0
.byte $f0, $f0, $f0, $f0
// 8x16
.byte {ypos}-8, $26, 0, {xpos}-56
.byte {ypos}-8, $66, 1, {xpos}-48
.byte {ypos}-8, $a6, 2, {xpos}-40
.byte {ypos}-8, $e6, 3, {xpos}-32
.byte {ypos}-8, $27, 0, {xpos}-24
.byte {ypos}-8, $67, 1, {xpos}-16
.byte {ypos}-8, $a7, 2, {xpos}-8
.byte {ypos}-8, $e7, 3, {xpos}
