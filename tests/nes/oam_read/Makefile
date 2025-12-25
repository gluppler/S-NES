# Makefile for oam_read
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

oam_read.nes: source/oam_read.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/oam_read.asm.o

source/oam_read.asm.o: source/oam_read.asm
	$(CA65) -I source/common -o $@ $<

all: oam_read.nes

clean:
	rm -f source/oam_read.o oam_read.nes