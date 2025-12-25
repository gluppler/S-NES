# Makefile for sprite_overflow_tests
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1.Basics.nes: source/1.Basics.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1.Basics.a.o

source/1.Basics.a.o: source/1.Basics.a
	$(CA65) -I source/common -o $@ $<

2.Details.nes: source/2.Details.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2.Details.a.o

source/2.Details.a.o: source/2.Details.a
	$(CA65) -I source/common -o $@ $<

3.Timing.nes: source/3.Timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/3.Timing.a.o

source/3.Timing.a.o: source/3.Timing.a
	$(CA65) -I source/common -o $@ $<

4.Obscure.nes: source/4.Obscure.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4.Obscure.a.o

source/4.Obscure.a.o: source/4.Obscure.a
	$(CA65) -I source/common -o $@ $<

5.Emulator.nes: source/5.Emulator.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/5.Emulator.a.o

source/5.Emulator.a.o: source/5.Emulator.a
	$(CA65) -I source/common -o $@ $<

console.nes: source/console.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/console.a.o

source/console.a.o: source/console.a
	$(CA65) -I source/common -o $@ $<

debug.nes: source/debug.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/debug.a.o

source/debug.a.o: source/debug.a
	$(CA65) -I source/common -o $@ $<

delays.nes: source/delays.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/delays.a.o

source/delays.a.o: source/delays.a
	$(CA65) -I source/common -o $@ $<

ppu_sync.nes: source/ppu_sync.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ppu_sync.a.o

source/ppu_sync.a.o: source/ppu_sync.a
	$(CA65) -I source/common -o $@ $<

ppu_util.nes: source/ppu_util.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ppu_util.a.o

source/ppu_util.a.o: source/ppu_util.a
	$(CA65) -I source/common -o $@ $<

prefix.nes: source/prefix.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix.a.o

source/prefix.a.o: source/prefix.a
	$(CA65) -I source/common -o $@ $<

prefix_ppu.nes: source/prefix_ppu.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_ppu.a.o

source/prefix_ppu.a.o: source/prefix_ppu.a
	$(CA65) -I source/common -o $@ $<

runtime_rom.nes: source/runtime_rom.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/runtime_rom.a.o

source/runtime_rom.a.o: source/runtime_rom.a
	$(CA65) -I source/common -o $@ $<

runtime_rom_common.nes: source/runtime_rom_common.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/runtime_rom_common.a.o

source/runtime_rom_common.a.o: source/runtime_rom_common.a
	$(CA65) -I source/common -o $@ $<

validation.nes: source/validation.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/validation.a.o

source/validation.a.o: source/validation.a
	$(CA65) -I source/common -o $@ $<

all: 1.Basics.nes 2.Details.nes 3.Timing.nes 4.Obscure.nes 5.Emulator.nes console.nes debug.nes delays.nes ppu_sync.nes ppu_util.nes prefix.nes prefix_ppu.nes runtime_rom.nes runtime_rom_common.nes validation.nes

clean:
	rm -f source/1.Basics.o source/2.Details.o source/3.Timing.o source/4.Obscure.o source/5.Emulator.o source/console.o source/debug.o source/delays.o source/ppu_sync.o source/ppu_util.o source/prefix.o source/prefix_ppu.o source/runtime_rom.o source/runtime_rom_common.o source/validation.o 1.Basics.nes 2.Details.nes 3.Timing.nes 4.Obscure.nes 5.Emulator.nes console.nes debug.nes delays.nes ppu_sync.nes ppu_util.nes prefix.nes prefix_ppu.nes runtime_rom.nes runtime_rom_common.nes validation.nes