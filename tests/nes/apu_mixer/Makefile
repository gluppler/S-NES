# Makefile for apu_mixer
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

dmc.nes: source/dmc.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/dmc.asm.o

source/dmc.asm.o: source/dmc.asm
	$(CA65) -I source/common -o $@ $<

noise.nes: source/noise.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/noise.asm.o

source/noise.asm.o: source/noise.asm
	$(CA65) -I source/common -o $@ $<

square.nes: source/square.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/square.asm.o

source/square.asm.o: source/square.asm
	$(CA65) -I source/common -o $@ $<

triangle.nes: source/triangle.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/triangle.asm.o

source/triangle.asm.o: source/triangle.asm
	$(CA65) -I source/common -o $@ $<

all: dmc.nes noise.nes square.nes triangle.nes

clean:
	rm -f source/dmc.o source/noise.o source/square.o source/triangle.o dmc.nes noise.nes square.nes triangle.nes