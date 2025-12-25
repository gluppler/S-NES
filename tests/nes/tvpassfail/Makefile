# Makefile for tvpassfail
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.ini

.PHONY: all clean

tv.nes: tv.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ tv.asm.o

tv.asm.o: tv.asm
	$(CA65) -o $@ $<

all: tv.nes

clean:
	rm -f tv.o tv.nes