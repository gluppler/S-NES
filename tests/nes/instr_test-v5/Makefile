# Makefile for instr_test-v5
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01-basics.nes: source/01-basics.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01-basics.asm.o

source/01-basics.asm.o: source/01-basics.asm
	$(CA65) -I source/common -o $@ $<

02-implied.nes: source/02-implied.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02-implied.asm.o

source/02-implied.asm.o: source/02-implied.asm
	$(CA65) -I source/common -o $@ $<

03-immediate.nes: source/03-immediate.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03-immediate.asm.o

source/03-immediate.asm.o: source/03-immediate.asm
	$(CA65) -I source/common -o $@ $<

04-zero_page.nes: source/04-zero_page.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04-zero_page.asm.o

source/04-zero_page.asm.o: source/04-zero_page.asm
	$(CA65) -I source/common -o $@ $<

05-zp_xy.nes: source/05-zp_xy.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/05-zp_xy.asm.o

source/05-zp_xy.asm.o: source/05-zp_xy.asm
	$(CA65) -I source/common -o $@ $<

06-absolute.nes: source/06-absolute.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/06-absolute.asm.o

source/06-absolute.asm.o: source/06-absolute.asm
	$(CA65) -I source/common -o $@ $<

07-abs_xy.nes: source/07-abs_xy.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/07-abs_xy.asm.o

source/07-abs_xy.asm.o: source/07-abs_xy.asm
	$(CA65) -I source/common -o $@ $<

08-ind_x.nes: source/08-ind_x.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/08-ind_x.asm.o

source/08-ind_x.asm.o: source/08-ind_x.asm
	$(CA65) -I source/common -o $@ $<

09-ind_y.nes: source/09-ind_y.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/09-ind_y.asm.o

source/09-ind_y.asm.o: source/09-ind_y.asm
	$(CA65) -I source/common -o $@ $<

10-branches.nes: source/10-branches.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/10-branches.asm.o

source/10-branches.asm.o: source/10-branches.asm
	$(CA65) -I source/common -o $@ $<

11-stack.nes: source/11-stack.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/11-stack.asm.o

source/11-stack.asm.o: source/11-stack.asm
	$(CA65) -I source/common -o $@ $<

12-jmp_jsr.nes: source/12-jmp_jsr.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/12-jmp_jsr.asm.o

source/12-jmp_jsr.asm.o: source/12-jmp_jsr.asm
	$(CA65) -I source/common -o $@ $<

13-rts.nes: source/13-rts.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/13-rts.asm.o

source/13-rts.asm.o: source/13-rts.asm
	$(CA65) -I source/common -o $@ $<

14-rti.nes: source/14-rti.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/14-rti.asm.o

source/14-rti.asm.o: source/14-rti.asm
	$(CA65) -I source/common -o $@ $<

15-brk.nes: source/15-brk.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/15-brk.asm.o

source/15-brk.asm.o: source/15-brk.asm
	$(CA65) -I source/common -o $@ $<

16-special.nes: source/16-special.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/16-special.asm.o

source/16-special.asm.o: source/16-special.asm
	$(CA65) -I source/common -o $@ $<

all: 01-basics.nes 02-implied.nes 03-immediate.nes 04-zero_page.nes 05-zp_xy.nes 06-absolute.nes 07-abs_xy.nes 08-ind_x.nes 09-ind_y.nes 10-branches.nes 11-stack.nes 12-jmp_jsr.nes 13-rts.nes 14-rti.nes 15-brk.nes 16-special.nes

clean:
	rm -f source/01-basics.o source/02-implied.o source/03-immediate.o source/04-zero_page.o source/05-zp_xy.o source/06-absolute.o source/07-abs_xy.o source/08-ind_x.o source/09-ind_y.o source/10-branches.o source/11-stack.o source/12-jmp_jsr.o source/13-rts.o source/14-rti.o source/15-brk.o source/16-special.o 01-basics.nes 02-implied.nes 03-immediate.nes 04-zero_page.nes 05-zp_xy.nes 06-absolute.nes 07-abs_xy.nes 08-ind_x.nes 09-ind_y.nes 10-branches.nes 11-stack.nes 12-jmp_jsr.nes 13-rts.nes 14-rti.nes 15-brk.nes 16-special.nes