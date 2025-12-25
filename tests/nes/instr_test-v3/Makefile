# Makefile for instr_test-v3
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01-implied.nes: source/01-implied.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01-implied.asm.o

source/01-implied.asm.o: source/01-implied.asm
	$(CA65) -I source/common -o $@ $<

02-immediate.nes: source/02-immediate.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02-immediate.asm.o

source/02-immediate.asm.o: source/02-immediate.asm
	$(CA65) -I source/common -o $@ $<

03-zero_page.nes: source/03-zero_page.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03-zero_page.asm.o

source/03-zero_page.asm.o: source/03-zero_page.asm
	$(CA65) -I source/common -o $@ $<

04-zp_xy.nes: source/04-zp_xy.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04-zp_xy.asm.o

source/04-zp_xy.asm.o: source/04-zp_xy.asm
	$(CA65) -I source/common -o $@ $<

05-absolute.nes: source/05-absolute.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/05-absolute.asm.o

source/05-absolute.asm.o: source/05-absolute.asm
	$(CA65) -I source/common -o $@ $<

06-abs_xy.nes: source/06-abs_xy.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/06-abs_xy.asm.o

source/06-abs_xy.asm.o: source/06-abs_xy.asm
	$(CA65) -I source/common -o $@ $<

07-ind_x.nes: source/07-ind_x.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/07-ind_x.asm.o

source/07-ind_x.asm.o: source/07-ind_x.asm
	$(CA65) -I source/common -o $@ $<

08-ind_y.nes: source/08-ind_y.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/08-ind_y.asm.o

source/08-ind_y.asm.o: source/08-ind_y.asm
	$(CA65) -I source/common -o $@ $<

09-branches.nes: source/09-branches.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/09-branches.asm.o

source/09-branches.asm.o: source/09-branches.asm
	$(CA65) -I source/common -o $@ $<

10-stack.nes: source/10-stack.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/10-stack.asm.o

source/10-stack.asm.o: source/10-stack.asm
	$(CA65) -I source/common -o $@ $<

11-jmp_jsr.nes: source/11-jmp_jsr.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/11-jmp_jsr.asm.o

source/11-jmp_jsr.asm.o: source/11-jmp_jsr.asm
	$(CA65) -I source/common -o $@ $<

12-rts.nes: source/12-rts.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/12-rts.asm.o

source/12-rts.asm.o: source/12-rts.asm
	$(CA65) -I source/common -o $@ $<

13-rti.nes: source/13-rti.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/13-rti.asm.o

source/13-rti.asm.o: source/13-rti.asm
	$(CA65) -I source/common -o $@ $<

14-brk.nes: source/14-brk.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/14-brk.asm.o

source/14-brk.asm.o: source/14-brk.asm
	$(CA65) -I source/common -o $@ $<

15-special.nes: source/15-special.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/15-special.asm.o

source/15-special.asm.o: source/15-special.asm
	$(CA65) -I source/common -o $@ $<

all: 01-implied.nes 02-immediate.nes 03-zero_page.nes 04-zp_xy.nes 05-absolute.nes 06-abs_xy.nes 07-ind_x.nes 08-ind_y.nes 09-branches.nes 10-stack.nes 11-jmp_jsr.nes 12-rts.nes 13-rti.nes 14-brk.nes 15-special.nes

clean:
	rm -f source/01-implied.o source/02-immediate.o source/03-zero_page.o source/04-zp_xy.o source/05-absolute.o source/06-abs_xy.o source/07-ind_x.o source/08-ind_y.o source/09-branches.o source/10-stack.o source/11-jmp_jsr.o source/12-rts.o source/13-rti.o source/14-brk.o source/15-special.o 01-implied.nes 02-immediate.nes 03-zero_page.nes 04-zp_xy.nes 05-absolute.nes 06-abs_xy.nes 07-ind_x.nes 08-ind_y.nes 09-branches.nes 10-stack.nes 11-jmp_jsr.nes 12-rts.nes 13-rti.nes 14-brk.nes 15-special.nes