;
; File: apu.inc
; Namespace: apu_ / APU_
; Code Segment: APULIB
; Copyright (c) 2011 Mathew Brenaman (see 'LICENSE' for details)
; Assembled with ca65
;
; General purpose APU library
;

.ifndef APU_INC
APU_INC = 1

; APU I/O locations

SQ1_VOL = $0
SQ1_SWEEP = $1
SQ1_LO = $2
SQ1_HI = $3
SQ2_VOL = $4
SQ2_SWEEP = $5
SQ2_LO = $6
SQ2_HI = $7
TRI_LINEAR = $8
TRI_LO = $A
TRI_HI = $B
NOISE_VOL = $C
NOISE_LO = $E
NOISE_HI = $F
DMC_FREQ = $0
DMC_RAW = $1
DMC_START = $2
DMC_LEN = $3
SND_CHN = $5

.endif

