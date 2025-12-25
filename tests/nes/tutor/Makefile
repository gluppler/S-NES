# Makefile for tutor
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

tutor.nes: tutor.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ tutor.asm.o

tutor.asm.o: tutor.asm
	$(CA65) -o $@ $<

tutorchr.nes: tutorchr.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ tutorchr.asm.o

tutorchr.asm.o: tutorchr.asm
	$(CA65) -o $@ $<

tutorprg.nes: tutorprg.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ tutorprg.asm.o

tutorprg.asm.o: tutorprg.asm
	$(CA65) -o $@ $<

all: tutor.nes tutorchr.nes tutorprg.nes

clean:
	rm -f tutor.o tutorchr.o tutorprg.o tutor.nes tutorchr.nes tutorprg.nes