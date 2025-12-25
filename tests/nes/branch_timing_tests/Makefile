# Makefile for branch_timing_tests
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1.Branch_Basics.nes: source/1.Branch_Basics.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1.Branch_Basics.a.o

source/1.Branch_Basics.a.o: source/1.Branch_Basics.a
	$(CA65) -I source/common -o $@ $<

2.Backward_Branch.nes: source/2.Backward_Branch.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2.Backward_Branch.a.o

source/2.Backward_Branch.a.o: source/2.Backward_Branch.a
	$(CA65) -I source/common -o $@ $<

3.Forward_Branch.nes: source/3.Forward_Branch.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/3.Forward_Branch.a.o

source/3.Forward_Branch.a.o: source/3.Forward_Branch.a
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

ppu_util.nes: source/ppu_util.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ppu_util.a.o

source/ppu_util.a.o: source/ppu_util.a
	$(CA65) -I source/common -o $@ $<

prefix.nes: source/prefix.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix.a.o

source/prefix.a.o: source/prefix.a
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

all: 1.Branch_Basics.nes 2.Backward_Branch.nes 3.Forward_Branch.nes console.nes debug.nes delays.nes ppu_util.nes prefix.nes runtime_rom.nes runtime_rom_common.nes validation.nes

clean:
	rm -f source/1.Branch_Basics.o source/2.Backward_Branch.o source/3.Forward_Branch.o source/console.o source/debug.o source/delays.o source/ppu_util.o source/prefix.o source/runtime_rom.o source/runtime_rom_common.o source/validation.o 1.Branch_Basics.nes 2.Backward_Branch.nes 3.Forward_Branch.nes console.nes debug.nes delays.nes ppu_util.nes prefix.nes runtime_rom.nes runtime_rom_common.nes validation.nes