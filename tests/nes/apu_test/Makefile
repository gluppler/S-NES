# Makefile for apu_test
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1-len_ctr.nes: source/1-len_ctr.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1-len_ctr.asm.o

source/1-len_ctr.asm.o: source/1-len_ctr.asm
	$(CA65) -I source/common -o $@ $<

2-len_table.nes: source/2-len_table.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2-len_table.asm.o

source/2-len_table.asm.o: source/2-len_table.asm
	$(CA65) -I source/common -o $@ $<

3-irq_flag.nes: source/3-irq_flag.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/3-irq_flag.asm.o

source/3-irq_flag.asm.o: source/3-irq_flag.asm
	$(CA65) -I source/common -o $@ $<

4-jitter.nes: source/4-jitter.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4-jitter.asm.o

source/4-jitter.asm.o: source/4-jitter.asm
	$(CA65) -I source/common -o $@ $<

5-len_timing.nes: source/5-len_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/5-len_timing.asm.o

source/5-len_timing.asm.o: source/5-len_timing.asm
	$(CA65) -I source/common -o $@ $<

6-irq_flag_timing.nes: source/6-irq_flag_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/6-irq_flag_timing.asm.o

source/6-irq_flag_timing.asm.o: source/6-irq_flag_timing.asm
	$(CA65) -I source/common -o $@ $<

7-dmc_basics.nes: source/7-dmc_basics.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/7-dmc_basics.asm.o

source/7-dmc_basics.asm.o: source/7-dmc_basics.asm
	$(CA65) -I source/common -o $@ $<

8-dmc_rates.nes: source/8-dmc_rates.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/8-dmc_rates.asm.o

source/8-dmc_rates.asm.o: source/8-dmc_rates.asm
	$(CA65) -I source/common -o $@ $<

all: 1-len_ctr.nes 2-len_table.nes 3-irq_flag.nes 4-jitter.nes 5-len_timing.nes 6-irq_flag_timing.nes 7-dmc_basics.nes 8-dmc_rates.nes

clean:
	rm -f source/1-len_ctr.o source/2-len_table.o source/3-irq_flag.o source/4-jitter.o source/5-len_timing.o source/6-irq_flag_timing.o source/7-dmc_basics.o source/8-dmc_rates.o 1-len_ctr.nes 2-len_table.nes 3-irq_flag.nes 4-jitter.nes 5-len_timing.nes 6-irq_flag_timing.nes 7-dmc_basics.nes 8-dmc_rates.nes