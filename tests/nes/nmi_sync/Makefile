# Makefile for nmi_sync
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = nes.cfg

.PHONY: all clean

demo_ntsc.nes: demo_ntsc.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ demo_ntsc.asm.o

demo_ntsc.asm.o: demo_ntsc.asm
	$(CA65) -o $@ $<

demo_pal.nes: demo_pal.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ demo_pal.asm.o

demo_pal.asm.o: demo_pal.asm
	$(CA65) -o $@ $<

nmi_sync.nes: nmi_sync.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ nmi_sync.asm.o

nmi_sync.asm.o: nmi_sync.asm
	$(CA65) -o $@ $<

all: demo_ntsc.nes demo_pal.nes nmi_sync.nes

clean:
	rm -f demo_ntsc.o demo_pal.o nmi_sync.o demo_ntsc.nes demo_pal.nes nmi_sync.nes