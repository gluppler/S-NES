# Makefile for blargg_apu_2005.07.30
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01.len_ctr.nes: source/01.len_ctr.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01.len_ctr.asm.o

source/01.len_ctr.asm.o: source/01.len_ctr.asm
	$(CA65) -I source/common -o $@ $<

02.len_table.nes: source/02.len_table.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02.len_table.asm.o

source/02.len_table.asm.o: source/02.len_table.asm
	$(CA65) -I source/common -o $@ $<

03.irq_flag.nes: source/03.irq_flag.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03.irq_flag.asm.o

source/03.irq_flag.asm.o: source/03.irq_flag.asm
	$(CA65) -I source/common -o $@ $<

04.clock_jitter.nes: source/04.clock_jitter.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04.clock_jitter.asm.o

source/04.clock_jitter.asm.o: source/04.clock_jitter.asm
	$(CA65) -I source/common -o $@ $<

05.len_timing_mode0.nes: source/05.len_timing_mode0.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/05.len_timing_mode0.asm.o

source/05.len_timing_mode0.asm.o: source/05.len_timing_mode0.asm
	$(CA65) -I source/common -o $@ $<

06.len_timing_mode1.nes: source/06.len_timing_mode1.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/06.len_timing_mode1.asm.o

source/06.len_timing_mode1.asm.o: source/06.len_timing_mode1.asm
	$(CA65) -I source/common -o $@ $<

07.irq_flag_timing.nes: source/07.irq_flag_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/07.irq_flag_timing.asm.o

source/07.irq_flag_timing.asm.o: source/07.irq_flag_timing.asm
	$(CA65) -I source/common -o $@ $<

08.irq_timing.nes: source/08.irq_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/08.irq_timing.asm.o

source/08.irq_timing.asm.o: source/08.irq_timing.asm
	$(CA65) -I source/common -o $@ $<

09.reset_timing.nes: source/09.reset_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/09.reset_timing.asm.o

source/09.reset_timing.asm.o: source/09.reset_timing.asm
	$(CA65) -I source/common -o $@ $<

10.len_halt_timing.nes: source/10.len_halt_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/10.len_halt_timing.asm.o

source/10.len_halt_timing.asm.o: source/10.len_halt_timing.asm
	$(CA65) -I source/common -o $@ $<

11.len_reload_timing.nes: source/11.len_reload_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/11.len_reload_timing.asm.o

source/11.len_reload_timing.asm.o: source/11.len_reload_timing.asm
	$(CA65) -I source/common -o $@ $<

apu_util.nes: source/apu_util.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/apu_util.asm.o

source/apu_util.asm.o: source/apu_util.asm
	$(CA65) -I source/common -o $@ $<

prefix_apu.nes: source/prefix_apu.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_apu.asm.o

source/prefix_apu.asm.o: source/prefix_apu.asm
	$(CA65) -I source/common -o $@ $<

all: 01.len_ctr.nes 02.len_table.nes 03.irq_flag.nes 04.clock_jitter.nes 05.len_timing_mode0.nes 06.len_timing_mode1.nes 07.irq_flag_timing.nes 08.irq_timing.nes 09.reset_timing.nes 10.len_halt_timing.nes 11.len_reload_timing.nes apu_util.nes prefix_apu.nes

clean:
	rm -f source/01.len_ctr.o source/02.len_table.o source/03.irq_flag.o source/04.clock_jitter.o source/05.len_timing_mode0.o source/06.len_timing_mode1.o source/07.irq_flag_timing.o source/08.irq_timing.o source/09.reset_timing.o source/10.len_halt_timing.o source/11.len_reload_timing.o source/apu_util.o source/prefix_apu.o 01.len_ctr.nes 02.len_table.nes 03.irq_flag.nes 04.clock_jitter.nes 05.len_timing_mode0.nes 06.len_timing_mode1.nes 07.irq_flag_timing.nes 08.irq_timing.nes 09.reset_timing.nes 10.len_halt_timing.nes 11.len_reload_timing.nes apu_util.nes prefix_apu.nes