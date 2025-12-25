# Makefile for ppu_read_buffer
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

bank_switch.nes: source/bank_switch.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/bank_switch.asm.o

source/bank_switch.asm.o: source/bank_switch.asm
	$(CA65) -I source/common -o $@ $<

crash_proof.nes: source/crash_proof.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/crash_proof.asm.o

source/crash_proof.asm.o: source/crash_proof.asm
	$(CA65) -I source/common -o $@ $<

graphics.nes: source/graphics.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/graphics.asm.o

source/graphics.asm.o: source/graphics.asm
	$(CA65) -I source/common -o $@ $<

test_ppu_read_buffer.nes: source/test_ppu_read_buffer.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/test_ppu_read_buffer.asm.o

source/test_ppu_read_buffer.asm.o: source/test_ppu_read_buffer.asm
	$(CA65) -I source/common -o $@ $<

testing2-begin.nes: source/testing2-begin.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/testing2-begin.asm.o

source/testing2-begin.asm.o: source/testing2-begin.asm
	$(CA65) -I source/common -o $@ $<

testing2-end.nes: source/testing2-end.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/testing2-end.asm.o

source/testing2-end.asm.o: source/testing2-end.asm
	$(CA65) -I source/common -o $@ $<

all: bank_switch.nes crash_proof.nes graphics.nes test_ppu_read_buffer.nes testing2-begin.nes testing2-end.nes

clean:
	rm -f source/bank_switch.o source/crash_proof.o source/graphics.o source/test_ppu_read_buffer.o source/testing2-begin.o source/testing2-end.o bank_switch.nes crash_proof.nes graphics.nes test_ppu_read_buffer.nes testing2-begin.nes testing2-end.nes