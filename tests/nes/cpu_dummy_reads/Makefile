# Makefile for cpu_dummy_reads
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

cpu_dummy_reads.nes: source/cpu_dummy_reads.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/cpu_dummy_reads.asm.o

source/cpu_dummy_reads.asm.o: source/cpu_dummy_reads.asm
	$(CA65) -I source/common -o $@ $<

all: cpu_dummy_reads.nes

clean:
	rm -f source/cpu_dummy_reads.o cpu_dummy_reads.nes