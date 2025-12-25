# Makefile for apu_reset
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

4015_cleared.nes: source/4015_cleared.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4015_cleared.asm.o

source/4015_cleared.asm.o: source/4015_cleared.asm
	$(CA65) -I source/common -o $@ $<

4017_timing.nes: source/4017_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4017_timing.asm.o

source/4017_timing.asm.o: source/4017_timing.asm
	$(CA65) -I source/common -o $@ $<

4017_written.nes: source/4017_written.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4017_written.asm.o

source/4017_written.asm.o: source/4017_written.asm
	$(CA65) -I source/common -o $@ $<

irq_flag_cleared.nes: source/irq_flag_cleared.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/irq_flag_cleared.asm.o

source/irq_flag_cleared.asm.o: source/irq_flag_cleared.asm
	$(CA65) -I source/common -o $@ $<

len_ctrs_enabled.nes: source/len_ctrs_enabled.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/len_ctrs_enabled.asm.o

source/len_ctrs_enabled.asm.o: source/len_ctrs_enabled.asm
	$(CA65) -I source/common -o $@ $<

works_immediately.nes: source/works_immediately.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/works_immediately.asm.o

source/works_immediately.asm.o: source/works_immediately.asm
	$(CA65) -I source/common -o $@ $<

all: 4015_cleared.nes 4017_timing.nes 4017_written.nes irq_flag_cleared.nes len_ctrs_enabled.nes works_immediately.nes

clean:
	rm -f source/4015_cleared.o source/4017_timing.o source/4017_written.o source/irq_flag_cleared.o source/len_ctrs_enabled.o source/works_immediately.o 4015_cleared.nes 4017_timing.nes 4017_written.nes irq_flag_cleared.nes len_ctrs_enabled.nes works_immediately.nes