# Makefile for stars_se
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

StarsSE.nes: StarsSE.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ StarsSE.asm.o

StarsSE.asm.o: StarsSE.asm
	$(CA65) -o $@ $<

starsnam.nes: starsnam.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ starsnam.asm.o

starsnam.asm.o: starsnam.asm
	$(CA65) -o $@ $<

all: StarsSE.nes starsnam.nes

clean:
	rm -f StarsSE.o starsnam.o StarsSE.nes starsnam.nes