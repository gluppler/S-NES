# Makefile for cpu_timing_test6
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

console.nes: source/console.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/console.a.o

source/console.a.o: source/console.a
	$(CA65) -I source/common -o $@ $<

cpu_timing_test.nes: source/cpu_timing_test.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/cpu_timing_test.asm.o

source/cpu_timing_test.asm.o: source/cpu_timing_test.asm
	$(CA65) -I source/common -o $@ $<

debug.nes: source/debug.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/debug.a.o

source/debug.a.o: source/debug.a
	$(CA65) -I source/common -o $@ $<

delays.nes: source/delays.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/delays.a.o

source/delays.a.o: source/delays.a
	$(CA65) -I source/common -o $@ $<

ppu_util.nes: source/ppu_util.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ppu_util.a.o

source/ppu_util.a.o: source/ppu_util.a
	$(CA65) -I source/common -o $@ $<

runtime_rom.nes: source/runtime_rom.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/runtime_rom.a.o

source/runtime_rom.a.o: source/runtime_rom.a
	$(CA65) -I source/common -o $@ $<

runtime_rom_common.nes: source/runtime_rom_common.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/runtime_rom_common.a.o

source/runtime_rom_common.a.o: source/runtime_rom_common.a
	$(CA65) -I source/common -o $@ $<

all: console.nes cpu_timing_test.nes debug.nes delays.nes ppu_util.nes runtime_rom.nes runtime_rom_common.nes

clean:
	rm -f source/console.o source/cpu_timing_test.o source/debug.o source/delays.o source/ppu_util.o source/runtime_rom.o source/runtime_rom_common.o console.nes cpu_timing_test.nes debug.nes delays.nes ppu_util.nes runtime_rom.nes runtime_rom_common.nes