# Makefile for mmc3_irq_tests
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1.Clocking.nes: source/1.Clocking.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1.Clocking.asm.o

source/1.Clocking.asm.o: source/1.Clocking.asm
	$(CA65) -I source/common -o $@ $<

2.Details.nes: source/2.Details.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2.Details.asm.o

source/2.Details.asm.o: source/2.Details.asm
	$(CA65) -I source/common -o $@ $<

3.A12_clocking.nes: source/3.A12_clocking.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/3.A12_clocking.asm.o

source/3.A12_clocking.asm.o: source/3.A12_clocking.asm
	$(CA65) -I source/common -o $@ $<

4.Scanline_timing.nes: source/4.Scanline_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4.Scanline_timing.asm.o

source/4.Scanline_timing.asm.o: source/4.Scanline_timing.asm
	$(CA65) -I source/common -o $@ $<

5.MMC3_rev_A.nes: source/5.MMC3_rev_A.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/5.MMC3_rev_A.asm.o

source/5.MMC3_rev_A.asm.o: source/5.MMC3_rev_A.asm
	$(CA65) -I source/common -o $@ $<

6.MMC3_rev_B.nes: source/6.MMC3_rev_B.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/6.MMC3_rev_B.asm.o

source/6.MMC3_rev_B.asm.o: source/6.MMC3_rev_B.asm
	$(CA65) -I source/common -o $@ $<

console.nes: source/console.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/console.asm.o

source/console.asm.o: source/console.asm
	$(CA65) -I source/common -o $@ $<

debug.nes: source/debug.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/debug.asm.o

source/debug.asm.o: source/debug.asm
	$(CA65) -I source/common -o $@ $<

delays.nes: source/delays.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/delays.asm.o

source/delays.asm.o: source/delays.asm
	$(CA65) -I source/common -o $@ $<

ppu_sync.nes: source/ppu_sync.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ppu_sync.asm.o

source/ppu_sync.asm.o: source/ppu_sync.asm
	$(CA65) -I source/common -o $@ $<

ppu_util.nes: source/ppu_util.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/ppu_util.asm.o

source/ppu_util.asm.o: source/ppu_util.asm
	$(CA65) -I source/common -o $@ $<

prefix_cpu.nes: source/prefix_cpu.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_cpu.asm.o

source/prefix_cpu.asm.o: source/prefix_cpu.asm
	$(CA65) -I source/common -o $@ $<

prefix_mmc3.nes: source/prefix_mmc3.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_mmc3.asm.o

source/prefix_mmc3.asm.o: source/prefix_mmc3.asm
	$(CA65) -I source/common -o $@ $<

prefix_mmc3_validation.nes: source/prefix_mmc3_validation.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_mmc3_validation.asm.o

source/prefix_mmc3_validation.asm.o: source/prefix_mmc3_validation.asm
	$(CA65) -I source/common -o $@ $<

prefix_swap.nes: source/prefix_swap.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_swap.asm.o

source/prefix_swap.asm.o: source/prefix_swap.asm
	$(CA65) -I source/common -o $@ $<

runtime_swapcart.nes: source/runtime_swapcart.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/runtime_swapcart.asm.o

source/runtime_swapcart.asm.o: source/runtime_swapcart.asm
	$(CA65) -I source/common -o $@ $<

validation.nes: source/validation.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/validation.asm.o

source/validation.asm.o: source/validation.asm
	$(CA65) -I source/common -o $@ $<

all: 1.Clocking.nes 2.Details.nes 3.A12_clocking.nes 4.Scanline_timing.nes 5.MMC3_rev_A.nes 6.MMC3_rev_B.nes console.nes debug.nes delays.nes ppu_sync.nes ppu_util.nes prefix_cpu.nes prefix_mmc3.nes prefix_mmc3_validation.nes prefix_swap.nes runtime_swapcart.nes validation.nes

clean:
	rm -f source/1.Clocking.o source/2.Details.o source/3.A12_clocking.o source/4.Scanline_timing.o source/5.MMC3_rev_A.o source/6.MMC3_rev_B.o source/console.o source/debug.o source/delays.o source/ppu_sync.o source/ppu_util.o source/prefix_cpu.o source/prefix_mmc3.o source/prefix_mmc3_validation.o source/prefix_swap.o source/runtime_swapcart.o source/validation.o 1.Clocking.nes 2.Details.nes 3.A12_clocking.nes 4.Scanline_timing.nes 5.MMC3_rev_A.nes 6.MMC3_rev_B.nes console.nes debug.nes delays.nes ppu_sync.nes ppu_util.nes prefix_cpu.nes prefix_mmc3.nes prefix_mmc3_validation.nes prefix_swap.nes runtime_swapcart.nes validation.nes