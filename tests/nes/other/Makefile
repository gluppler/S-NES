# Makefile for other
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

firefly.nes: firefly.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ firefly.asm.o

firefly.asm.o: firefly.asm
	$(CA65) -o $@ $<

smbdis.nes: smbdis.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ smbdis.asm.o

smbdis.asm.o: smbdis.asm
	$(CA65) -o $@ $<

all: firefly.nes smbdis.nes

clean:
	rm -f firefly.o smbdis.o firefly.nes smbdis.nes