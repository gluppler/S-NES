# Makefile for blargg_ppu_tests_2005.09.15b
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

palette_ram.nes: source/palette_ram.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/palette_ram.asm.o

source/palette_ram.asm.o: source/palette_ram.asm
	$(CA65) -I source/common -o $@ $<

power_up_palette.nes: source/power_up_palette.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/power_up_palette.asm.o

source/power_up_palette.asm.o: source/power_up_palette.asm
	$(CA65) -I source/common -o $@ $<

prefix_ppu.nes: source/prefix_ppu.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_ppu.asm.o

source/prefix_ppu.asm.o: source/prefix_ppu.asm
	$(CA65) -I source/common -o $@ $<

sprite_ram.nes: source/sprite_ram.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/sprite_ram.asm.o

source/sprite_ram.asm.o: source/sprite_ram.asm
	$(CA65) -I source/common -o $@ $<

vbl_clear_time.nes: source/vbl_clear_time.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/vbl_clear_time.asm.o

source/vbl_clear_time.asm.o: source/vbl_clear_time.asm
	$(CA65) -I source/common -o $@ $<

vram_access.nes: source/vram_access.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/vram_access.asm.o

source/vram_access.asm.o: source/vram_access.asm
	$(CA65) -I source/common -o $@ $<

all: palette_ram.nes power_up_palette.nes prefix_ppu.nes sprite_ram.nes vbl_clear_time.nes vram_access.nes

clean:
	rm -f source/palette_ram.o source/power_up_palette.o source/prefix_ppu.o source/sprite_ram.o source/vbl_clear_time.o source/vram_access.o palette_ram.nes power_up_palette.nes prefix_ppu.nes sprite_ram.nes vbl_clear_time.nes vram_access.nes