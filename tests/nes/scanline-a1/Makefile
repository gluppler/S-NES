# Makefile for scanline-a1
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

scanline.nes: scanline.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ scanline.asm.o

scanline.asm.o: scanline.asm
	$(CA65) -o $@ $<

all: scanline.nes

clean:
	rm -f scanline.o scanline.nes