# Makefile for cpu_dummy_writes
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

cpu_dummy_writes_oam.nes: source/cpu_dummy_writes_oam.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/cpu_dummy_writes_oam.asm.o

source/cpu_dummy_writes_oam.asm.o: source/cpu_dummy_writes_oam.asm
	$(CA65) -I source/common -o $@ $<

cpu_dummy_writes_ppumem.nes: source/cpu_dummy_writes_ppumem.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/cpu_dummy_writes_ppumem.asm.o

source/cpu_dummy_writes_ppumem.asm.o: source/cpu_dummy_writes_ppumem.asm
	$(CA65) -I source/common -o $@ $<

all: cpu_dummy_writes_oam.nes cpu_dummy_writes_ppumem.nes

clean:
	rm -f source/cpu_dummy_writes_oam.o source/cpu_dummy_writes_ppumem.o cpu_dummy_writes_oam.nes cpu_dummy_writes_ppumem.nes