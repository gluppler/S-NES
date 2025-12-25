# Makefile for MMC1_A12
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

MMC1.nes: MMC1.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ MMC1.asm.o

MMC1.asm.o: MMC1.asm
	$(CA65) -o $@ $<

joypad.nes: joypad.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ joypad.asm.o

joypad.asm.o: joypad.asm
	$(CA65) -o $@ $<

maping.nes: maping.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ maping.asm.o

maping.asm.o: maping.asm
	$(CA65) -o $@ $<

mmc1_a12.nes: mmc1_a12.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ mmc1_a12.asm.o

mmc1_a12.asm.o: mmc1_a12.asm
	$(CA65) -o $@ $<

all: MMC1.nes joypad.nes maping.nes mmc1_a12.nes

clean:
	rm -f MMC1.o joypad.o maping.o mmc1_a12.o MMC1.nes joypad.nes maping.nes mmc1_a12.nes