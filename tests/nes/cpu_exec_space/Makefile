# Makefile for cpu_exec_space
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

test_cpu_exec_space_apu.nes: source/test_cpu_exec_space_apu.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/test_cpu_exec_space_apu.asm.o

source/test_cpu_exec_space_apu.asm.o: source/test_cpu_exec_space_apu.asm
	$(CA65) -I source/common -o $@ $<

test_cpu_exec_space_ppuio.nes: source/test_cpu_exec_space_ppuio.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/test_cpu_exec_space_ppuio.asm.o

source/test_cpu_exec_space_ppuio.asm.o: source/test_cpu_exec_space_ppuio.asm
	$(CA65) -I source/common -o $@ $<

all: test_cpu_exec_space_apu.nes test_cpu_exec_space_ppuio.nes

clean:
	rm -f source/test_cpu_exec_space_apu.o source/test_cpu_exec_space_ppuio.o test_cpu_exec_space_apu.nes test_cpu_exec_space_ppuio.nes