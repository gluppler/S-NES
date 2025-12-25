# Makefile for stomper
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

smwstomp.nes: smwstomp.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ smwstomp.asm.o

smwstomp.asm.o: smwstomp.asm
	$(CA65) -o $@ $<

all: smwstomp.nes

clean:
	rm -f smwstomp.o smwstomp.nes