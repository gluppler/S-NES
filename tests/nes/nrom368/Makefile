# Makefile for nrom368
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

crt0.nes: crt0.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ crt0.asm.o

crt0.asm.o: crt0.asm
	$(CA65) -o $@ $<

famitone.nes: famitone.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ famitone.asm.o

famitone.asm.o: famitone.asm
	$(CA65) -o $@ $<

music.nes: music.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ music.asm.o

music.asm.o: music.asm
	$(CA65) -o $@ $<

neslib.nes: neslib.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ neslib.asm.o

neslib.asm.o: neslib.asm
	$(CA65) -o $@ $<

sounds.nes: sounds.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ sounds.asm.o

sounds.asm.o: sounds.asm
	$(CA65) -o $@ $<

all: crt0.nes famitone.nes music.nes neslib.nes sounds.nes

clean:
	rm -f crt0.o famitone.o music.o neslib.o sounds.o crt0.nes famitone.nes music.nes neslib.nes sounds.nes