# Makefile for blargg_nes_cpu_test5
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01-implied.nes: source/01-implied.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01-implied.a.o

source/01-implied.a.o: source/01-implied.a
	$(CA65) -I source/common -o $@ $<

02-immediate.nes: source/02-immediate.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02-immediate.a.o

source/02-immediate.a.o: source/02-immediate.a
	$(CA65) -I source/common -o $@ $<

03-zero_page.nes: source/03-zero_page.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03-zero_page.a.o

source/03-zero_page.a.o: source/03-zero_page.a
	$(CA65) -I source/common -o $@ $<

04-zp_xy.nes: source/04-zp_xy.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04-zp_xy.a.o

source/04-zp_xy.a.o: source/04-zp_xy.a
	$(CA65) -I source/common -o $@ $<

05-absolute.nes: source/05-absolute.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/05-absolute.a.o

source/05-absolute.a.o: source/05-absolute.a
	$(CA65) -I source/common -o $@ $<

06-abs_xy.nes: source/06-abs_xy.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/06-abs_xy.a.o

source/06-abs_xy.a.o: source/06-abs_xy.a
	$(CA65) -I source/common -o $@ $<

07-ind_x.nes: source/07-ind_x.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/07-ind_x.a.o

source/07-ind_x.a.o: source/07-ind_x.a
	$(CA65) -I source/common -o $@ $<

08-ind_y.nes: source/08-ind_y.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/08-ind_y.a.o

source/08-ind_y.a.o: source/08-ind_y.a
	$(CA65) -I source/common -o $@ $<

09-branches.nes: source/09-branches.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/09-branches.a.o

source/09-branches.a.o: source/09-branches.a
	$(CA65) -I source/common -o $@ $<

10-stack.nes: source/10-stack.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/10-stack.a.o

source/10-stack.a.o: source/10-stack.a
	$(CA65) -I source/common -o $@ $<

11-special.nes: source/11-special.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/11-special.a.o

source/11-special.a.o: source/11-special.a
	$(CA65) -I source/common -o $@ $<

all: 01-implied.nes 02-immediate.nes 03-zero_page.nes 04-zp_xy.nes 05-absolute.nes 06-abs_xy.nes 07-ind_x.nes 08-ind_y.nes 09-branches.nes 10-stack.nes 11-special.nes

clean:
	rm -f source/01-implied.o source/02-immediate.o source/03-zero_page.o source/04-zp_xy.o source/05-absolute.o source/06-abs_xy.o source/07-ind_x.o source/08-ind_y.o source/09-branches.o source/10-stack.o source/11-special.o 01-implied.nes 02-immediate.nes 03-zero_page.nes 04-zp_xy.nes 05-absolute.nes 06-abs_xy.nes 07-ind_x.nes 08-ind_y.nes 09-branches.nes 10-stack.nes 11-special.nes