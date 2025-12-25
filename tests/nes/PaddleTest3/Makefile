# Makefile for PaddleTest3
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

PaddleTest.nes: PaddleTest.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ PaddleTest.asm.o

PaddleTest.asm.o: PaddleTest.asm
	$(CA65) -o $@ $<

all: PaddleTest.nes

clean:
	rm -f PaddleTest.o PaddleTest.nes