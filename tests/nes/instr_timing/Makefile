# Makefile for instr_timing
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1-instr_timing.nes: source/1-instr_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1-instr_timing.asm.o

source/1-instr_timing.asm.o: source/1-instr_timing.asm
	$(CA65) -I source/common -o $@ $<

2-branch_timing.nes: source/2-branch_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2-branch_timing.asm.o

source/2-branch_timing.asm.o: source/2-branch_timing.asm
	$(CA65) -I source/common -o $@ $<

all: 1-instr_timing.nes 2-branch_timing.nes

clean:
	rm -f source/1-instr_timing.o source/2-branch_timing.o 1-instr_timing.nes 2-branch_timing.nes