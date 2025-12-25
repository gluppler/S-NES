# Makefile for instr_misc
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01-abs_x_wrap.nes: source/01-abs_x_wrap.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01-abs_x_wrap.asm.o

source/01-abs_x_wrap.asm.o: source/01-abs_x_wrap.asm
	$(CA65) -I source/common -o $@ $<

02-branch_wrap.nes: source/02-branch_wrap.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02-branch_wrap.asm.o

source/02-branch_wrap.asm.o: source/02-branch_wrap.asm
	$(CA65) -I source/common -o $@ $<

03-dummy_reads.nes: source/03-dummy_reads.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03-dummy_reads.asm.o

source/03-dummy_reads.asm.o: source/03-dummy_reads.asm
	$(CA65) -I source/common -o $@ $<

04-dummy_reads_apu.nes: source/04-dummy_reads_apu.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04-dummy_reads_apu.asm.o

source/04-dummy_reads_apu.asm.o: source/04-dummy_reads_apu.asm
	$(CA65) -I source/common -o $@ $<

all: 01-abs_x_wrap.nes 02-branch_wrap.nes 03-dummy_reads.nes 04-dummy_reads_apu.nes

clean:
	rm -f source/01-abs_x_wrap.o source/02-branch_wrap.o source/03-dummy_reads.o source/04-dummy_reads_apu.o 01-abs_x_wrap.nes 02-branch_wrap.nes 03-dummy_reads.nes 04-dummy_reads_apu.nes