# Makefile for mmc3_test_2
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1-clocking.nes: source/1-clocking.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1-clocking.asm.o

source/1-clocking.asm.o: source/1-clocking.asm
	$(CA65) -I source/common -o $@ $<

2-details.nes: source/2-details.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2-details.asm.o

source/2-details.asm.o: source/2-details.asm
	$(CA65) -I source/common -o $@ $<

3-A12_clocking.nes: source/3-A12_clocking.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/3-A12_clocking.asm.o

source/3-A12_clocking.asm.o: source/3-A12_clocking.asm
	$(CA65) -I source/common -o $@ $<

4-scanline_timing.nes: source/4-scanline_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4-scanline_timing.asm.o

source/4-scanline_timing.asm.o: source/4-scanline_timing.asm
	$(CA65) -I source/common -o $@ $<

5-MMC3.nes: source/5-MMC3.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/5-MMC3.asm.o

source/5-MMC3.asm.o: source/5-MMC3.asm
	$(CA65) -I source/common -o $@ $<

6-MMC3_alt.nes: source/6-MMC3_alt.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/6-MMC3_alt.asm.o

source/6-MMC3_alt.asm.o: source/6-MMC3_alt.asm
	$(CA65) -I source/common -o $@ $<

all: 1-clocking.nes 2-details.nes 3-A12_clocking.nes 4-scanline_timing.nes 5-MMC3.nes 6-MMC3_alt.nes

clean:
	rm -f source/1-clocking.o source/2-details.o source/3-A12_clocking.o source/4-scanline_timing.o source/5-MMC3.o source/6-MMC3_alt.o 1-clocking.nes 2-details.nes 3-A12_clocking.nes 4-scanline_timing.nes 5-MMC3.nes 6-MMC3_alt.nes