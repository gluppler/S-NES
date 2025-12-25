# Makefile for pal_apu_tests
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01.len_ctr.nes: source/01.len_ctr.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01.len_ctr.a.o

source/01.len_ctr.a.o: source/01.len_ctr.a
	$(CA65) -I source/common -o $@ $<

02.len_table.nes: source/02.len_table.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02.len_table.a.o

source/02.len_table.a.o: source/02.len_table.a
	$(CA65) -I source/common -o $@ $<

03.irq_flag.nes: source/03.irq_flag.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03.irq_flag.a.o

source/03.irq_flag.a.o: source/03.irq_flag.a
	$(CA65) -I source/common -o $@ $<

04.clock_jitter.nes: source/04.clock_jitter.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04.clock_jitter.a.o

source/04.clock_jitter.a.o: source/04.clock_jitter.a
	$(CA65) -I source/common -o $@ $<

05.len_timing_mode0.nes: source/05.len_timing_mode0.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/05.len_timing_mode0.a.o

source/05.len_timing_mode0.a.o: source/05.len_timing_mode0.a
	$(CA65) -I source/common -o $@ $<

06.len_timing_mode1.nes: source/06.len_timing_mode1.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/06.len_timing_mode1.a.o

source/06.len_timing_mode1.a.o: source/06.len_timing_mode1.a
	$(CA65) -I source/common -o $@ $<

07.irq_flag_timing.nes: source/07.irq_flag_timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/07.irq_flag_timing.a.o

source/07.irq_flag_timing.a.o: source/07.irq_flag_timing.a
	$(CA65) -I source/common -o $@ $<

08.irq_timing.nes: source/08.irq_timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/08.irq_timing.a.o

source/08.irq_timing.a.o: source/08.irq_timing.a
	$(CA65) -I source/common -o $@ $<

10.len_halt_timing.nes: source/10.len_halt_timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/10.len_halt_timing.a.o

source/10.len_halt_timing.a.o: source/10.len_halt_timing.a
	$(CA65) -I source/common -o $@ $<

11.len_reload_timing.nes: source/11.len_reload_timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/11.len_reload_timing.a.o

source/11.len_reload_timing.a.o: source/11.len_reload_timing.a
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

prefix_apu.nes: source/prefix_apu.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_apu.a.o

source/prefix_apu.a.o: source/prefix_apu.a
	$(CA65) -I source/common -o $@ $<

runtime_rom.nes: source/runtime_rom.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/runtime_rom.a.o

source/runtime_rom.a.o: source/runtime_rom.a
	$(CA65) -I source/common -o $@ $<

runtime_rom_common.nes: source/runtime_rom_common.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/runtime_rom_common.a.o

source/runtime_rom_common.a.o: source/runtime_rom_common.a
	$(CA65) -I source/common -o $@ $<

sync_apu.nes: source/sync_apu.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/sync_apu.a.o

source/sync_apu.a.o: source/sync_apu.a
	$(CA65) -I source/common -o $@ $<

validation.nes: source/validation.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/validation.a.o

source/validation.a.o: source/validation.a
	$(CA65) -I source/common -o $@ $<

all: 01.len_ctr.nes 02.len_table.nes 03.irq_flag.nes 04.clock_jitter.nes 05.len_timing_mode0.nes 06.len_timing_mode1.nes 07.irq_flag_timing.nes 08.irq_timing.nes 10.len_halt_timing.nes 11.len_reload_timing.nes console.nes debug.nes delays.nes prefix_apu.nes runtime_rom.nes runtime_rom_common.nes sync_apu.nes validation.nes

clean:
	rm -f source/01.len_ctr.o source/02.len_table.o source/03.irq_flag.o source/04.clock_jitter.o source/05.len_timing_mode0.o source/06.len_timing_mode1.o source/07.irq_flag_timing.o source/08.irq_timing.o source/10.len_halt_timing.o source/11.len_reload_timing.o source/console.o source/debug.o source/delays.o source/prefix_apu.o source/runtime_rom.o source/runtime_rom_common.o source/sync_apu.o source/validation.o 01.len_ctr.nes 02.len_table.nes 03.irq_flag.nes 04.clock_jitter.nes 05.len_timing_mode0.nes 06.len_timing_mode1.nes 07.irq_flag_timing.nes 08.irq_timing.nes 10.len_halt_timing.nes 11.len_reload_timing.nes console.nes debug.nes delays.nes prefix_apu.nes runtime_rom.nes runtime_rom_common.nes sync_apu.nes validation.nes