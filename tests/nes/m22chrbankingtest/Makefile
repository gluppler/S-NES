# Makefile for m22chrbankingtest
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

0-127h.nes: 0-127h.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ 0-127h.asm.o

0-127h.asm.o: 0-127h.asm
	$(CA65) -o $@ $<

all: 0-127h.nes

clean:
	rm -f 0-127h.o 0-127h.nes