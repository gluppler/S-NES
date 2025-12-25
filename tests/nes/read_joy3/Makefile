# Makefile for read_joy3
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

count_errors.nes: source/count_errors.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/count_errors.asm.o

source/count_errors.asm.o: source/count_errors.asm
	$(CA65) -I source/common -o $@ $<

count_errors_fast.nes: source/count_errors_fast.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/count_errors_fast.asm.o

source/count_errors_fast.asm.o: source/count_errors_fast.asm
	$(CA65) -I source/common -o $@ $<

test_buttons.nes: source/test_buttons.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/test_buttons.asm.o

source/test_buttons.asm.o: source/test_buttons.asm
	$(CA65) -I source/common -o $@ $<

thorough_test.nes: source/thorough_test.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/thorough_test.asm.o

source/thorough_test.asm.o: source/thorough_test.asm
	$(CA65) -I source/common -o $@ $<

all: count_errors.nes count_errors_fast.nes test_buttons.nes thorough_test.nes

clean:
	rm -f source/count_errors.o source/count_errors_fast.o source/test_buttons.o source/thorough_test.o count_errors.nes count_errors_fast.nes test_buttons.nes thorough_test.nes