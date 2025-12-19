;
; Common code for RNG tests
; Based on prng_6502 by Brad Smith (rainwarrior)
; http://rainwarrior.ca
;

.zeropage
seed: .res 4 ; seed can be 2-4 bytes
.exportzp seed
