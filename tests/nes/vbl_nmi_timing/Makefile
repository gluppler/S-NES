# Makefile for vbl_nmi_timing
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1.frame_basics.nes: source/1.frame_basics.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1.frame_basics.a.o

source/1.frame_basics.a.o: source/1.frame_basics.a
	$(CA65) -I source/common -o $@ $<

2.vbl_timing.nes: source/2.vbl_timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2.vbl_timing.a.o

source/2.vbl_timing.a.o: source/2.vbl_timing.a
	$(CA65) -I source/common -o $@ $<

3.even_odd_frames.nes: source/3.even_odd_frames.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/3.even_odd_frames.a.o

source/3.even_odd_frames.a.o: source/3.even_odd_frames.a
	$(CA65) -I source/common -o $@ $<

4.vbl_clear_timing.nes: source/4.vbl_clear_timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4.vbl_clear_timing.a.o

source/4.vbl_clear_timing.a.o: source/4.vbl_clear_timing.a
	$(CA65) -I source/common -o $@ $<

5.nmi_suppression.nes: source/5.nmi_suppression.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/5.nmi_suppression.a.o

source/5.nmi_suppression.a.o: source/5.nmi_suppression.a
	$(CA65) -I source/common -o $@ $<

6.nmi_disable.nes: source/6.nmi_disable.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/6.nmi_disable.a.o

source/6.nmi_disable.a.o: source/6.nmi_disable.a
	$(CA65) -I source/common -o $@ $<

7.nmi_timing.nes: source/7.nmi_timing.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/7.nmi_timing.a.o

source/7.nmi_timing.a.o: source/7.nmi_timing.a
	$(CA65) -I source/common -o $@ $<

all: 1.frame_basics.nes 2.vbl_timing.nes 3.even_odd_frames.nes 4.vbl_clear_timing.nes 5.nmi_suppression.nes 6.nmi_disable.nes 7.nmi_timing.nes

clean:
	rm -f source/1.frame_basics.o source/2.vbl_timing.o source/3.even_odd_frames.o source/4.vbl_clear_timing.o source/5.nmi_suppression.o source/6.nmi_disable.o source/7.nmi_timing.o 1.frame_basics.nes 2.vbl_timing.nes 3.even_odd_frames.nes 4.vbl_clear_timing.nes 5.nmi_suppression.nes 6.nmi_disable.nes 7.nmi_timing.nes