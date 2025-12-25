# Makefile for cpu_reset
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

ram_after_reset.nes: source/ram_after_reset.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ram_after_reset.asm.o

source/ram_after_reset.asm.o: source/ram_after_reset.asm
	$(CA65) -I source/common -o $@ $<

registers.nes: source/registers.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/registers.asm.o

source/registers.asm.o: source/registers.asm
	$(CA65) -I source/common -o $@ $<

all: ram_after_reset.nes registers.nes

clean:
	rm -f source/ram_after_reset.o source/registers.o ram_after_reset.nes registers.nes