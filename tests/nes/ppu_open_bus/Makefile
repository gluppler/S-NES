# Makefile for ppu_open_bus
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

ppu_open_bus.nes: source/ppu_open_bus.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ppu_open_bus.asm.o

source/ppu_open_bus.asm.o: source/ppu_open_bus.asm
	$(CA65) -I source/common -o $@ $<

all: ppu_open_bus.nes

clean:
	rm -f source/ppu_open_bus.o ppu_open_bus.nes