# Makefile for stress
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

NEStress.nes: NEStress.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ NEStress.asm.o

NEStress.asm.o: NEStress.asm
	$(CA65) -o $@ $<

SolarTitleNAM.nes: SolarTitleNAM.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ SolarTitleNAM.asm.o

SolarTitleNAM.asm.o: SolarTitleNAM.asm
	$(CA65) -o $@ $<

all: NEStress.nes SolarTitleNAM.nes

clean:
	rm -f NEStress.o SolarTitleNAM.o NEStress.nes SolarTitleNAM.nes