# Makefile for exram
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

mmc5exram.nes: mmc5exram.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ mmc5exram.asm.o

mmc5exram.asm.o: mmc5exram.asm
	$(CA65) -o $@ $<

all: mmc5exram.nes

clean:
	rm -f mmc5exram.o mmc5exram.nes