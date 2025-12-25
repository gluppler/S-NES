# Makefile for window5
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

colorwin.nes: colorwin.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ colorwin.asm.o

colorwin.asm.o: colorwin.asm
	$(CA65) -o $@ $<

maping.nes: maping.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ maping.asm.o

maping.asm.o: maping.asm
	$(CA65) -o $@ $<

win_timing.nes: win_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ win_timing.asm.o

win_timing.asm.o: win_timing.asm
	$(CA65) -o $@ $<

all: colorwin.nes maping.nes win_timing.nes

clean:
	rm -f colorwin.o maping.o win_timing.o colorwin.nes maping.nes win_timing.nes