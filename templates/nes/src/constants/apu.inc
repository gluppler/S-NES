; ============================================================================
; APU Constants
; ============================================================================
; Per NES documentation: APU register addresses and constants
; ============================================================================

.ifndef APU_CONSTANTS_INC
APU_CONSTANTS_INC = 1

; APU registers (NES hardware addresses: $4000-$4017)
APU_PULSE1_CTRL = $4000
APU_PULSE1_SWEEP = $4001
APU_PULSE1_TIMER_LOW = $4002
APU_PULSE1_TIMER_HIGH = $4003

APU_PULSE2_CTRL = $4004
APU_PULSE2_SWEEP = $4005
APU_PULSE2_TIMER_LOW = $4006
APU_PULSE2_TIMER_HIGH = $4007

APU_TRIANGLE_CTRL = $4008
APU_TRIANGLE_UNUSED = $4009
APU_TRIANGLE_TIMER_LOW = $400A
APU_TRIANGLE_TIMER_HIGH = $400B

APU_NOISE_CTRL = $400C
APU_NOISE_UNUSED = $400D
APU_NOISE_PERIOD = $400E
APU_NOISE_LENGTH = $400F

APU_DMC_CTRL = $4010
APU_DMC_LOAD = $4011
APU_DMC_ADDR = $4012
APU_DMC_LENGTH = $4013

APU_STATUS = $4015      ; APU status register
APU_FRAME_COUNTER = $4017
OAMDMA = $4014          ; OAM DMA register

; APU status bits
APU_STATUS_DMC_ACTIVE = %10000000
APU_STATUS_NOISE_ACTIVE = %00001000
APU_STATUS_TRIANGLE_ACTIVE = %00000100
APU_STATUS_PULSE2_ACTIVE = %00000010
APU_STATUS_PULSE1_ACTIVE = %00000001

.endif ; APU_CONSTANTS_INC
