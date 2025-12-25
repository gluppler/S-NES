# Makefile for full_palette
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

full_palette.nes: full_palette.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ full_palette.asm.o

full_palette.asm.o: full_palette.asm
	$(CA65) -o $@ $<

full_palette_smooth.nes: full_palette_smooth.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ full_palette_smooth.asm.o

full_palette_smooth.asm.o: full_palette_smooth.asm
	$(CA65) -o $@ $<

all: full_palette.nes full_palette_smooth.nes

clean:
	rm -f full_palette.o full_palette_smooth.o full_palette.nes full_palette_smooth.nes