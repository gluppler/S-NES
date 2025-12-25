# Makefile for ppu_vbl_nmi
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01-vbl_basics.nes: source/01-vbl_basics.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01-vbl_basics.asm.o

source/01-vbl_basics.asm.o: source/01-vbl_basics.asm
	$(CA65) -I source/common -o $@ $<

02-vbl_set_time.nes: source/02-vbl_set_time.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02-vbl_set_time.asm.o

source/02-vbl_set_time.asm.o: source/02-vbl_set_time.asm
	$(CA65) -I source/common -o $@ $<

03-vbl_clear_time.nes: source/03-vbl_clear_time.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03-vbl_clear_time.asm.o

source/03-vbl_clear_time.asm.o: source/03-vbl_clear_time.asm
	$(CA65) -I source/common -o $@ $<

04-nmi_control.nes: source/04-nmi_control.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04-nmi_control.asm.o

source/04-nmi_control.asm.o: source/04-nmi_control.asm
	$(CA65) -I source/common -o $@ $<

05-nmi_timing.nes: source/05-nmi_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/05-nmi_timing.asm.o

source/05-nmi_timing.asm.o: source/05-nmi_timing.asm
	$(CA65) -I source/common -o $@ $<

06-suppression.nes: source/06-suppression.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/06-suppression.asm.o

source/06-suppression.asm.o: source/06-suppression.asm
	$(CA65) -I source/common -o $@ $<

07-nmi_on_timing.nes: source/07-nmi_on_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/07-nmi_on_timing.asm.o

source/07-nmi_on_timing.asm.o: source/07-nmi_on_timing.asm
	$(CA65) -I source/common -o $@ $<

08-nmi_off_timing.nes: source/08-nmi_off_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/08-nmi_off_timing.asm.o

source/08-nmi_off_timing.asm.o: source/08-nmi_off_timing.asm
	$(CA65) -I source/common -o $@ $<

09-even_odd_frames.nes: source/09-even_odd_frames.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/09-even_odd_frames.asm.o

source/09-even_odd_frames.asm.o: source/09-even_odd_frames.asm
	$(CA65) -I source/common -o $@ $<

10-even_odd_timing.nes: source/10-even_odd_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/10-even_odd_timing.asm.o

source/10-even_odd_timing.asm.o: source/10-even_odd_timing.asm
	$(CA65) -I source/common -o $@ $<

all: 01-vbl_basics.nes 02-vbl_set_time.nes 03-vbl_clear_time.nes 04-nmi_control.nes 05-nmi_timing.nes 06-suppression.nes 07-nmi_on_timing.nes 08-nmi_off_timing.nes 09-even_odd_frames.nes 10-even_odd_timing.nes

clean:
	rm -f source/01-vbl_basics.o source/02-vbl_set_time.o source/03-vbl_clear_time.o source/04-nmi_control.o source/05-nmi_timing.o source/06-suppression.o source/07-nmi_on_timing.o source/08-nmi_off_timing.o source/09-even_odd_frames.o source/10-even_odd_timing.o 01-vbl_basics.nes 02-vbl_set_time.nes 03-vbl_clear_time.nes 04-nmi_control.nes 05-nmi_timing.nes 06-suppression.nes 07-nmi_on_timing.nes 08-nmi_off_timing.nes 09-even_odd_frames.nes 10-even_odd_timing.nes