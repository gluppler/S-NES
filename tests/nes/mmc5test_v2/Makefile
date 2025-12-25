# Makefile for mmc5test_v2
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

mmc5test.nes: mmc5test.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ mmc5test.asm.o

mmc5test.asm.o: mmc5test.asm
	$(CA65) -o $@ $<

all: mmc5test.nes

clean:
	rm -f mmc5test.o mmc5test.nes