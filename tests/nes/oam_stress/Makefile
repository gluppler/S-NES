# Makefile for oam_stress
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

oam_stress.nes: source/oam_stress.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/oam_stress.asm.o

source/oam_stress.asm.o: source/oam_stress.asm
	$(CA65) -I source/common -o $@ $<

all: oam_stress.nes

clean:
	rm -f source/oam_stress.o oam_stress.nes