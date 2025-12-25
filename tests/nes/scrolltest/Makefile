# Makefile for scrolltest
# Note: This test uses dasm assembler, not ca65
# If dasm is not available, this test cannot be built with standard toolchain

DASM = dasm
EMU ?= mesen2

all: scroll.nes

scroll.nes: scroll.bin scrollhd.bin scrtest.chr scrtest.blk scrtest.map scrtest.pal
	cat scrollhd.bin scroll.bin > scroll.nes

scroll.bin: scroll.asm
	$(DASM) scroll.asm -oscroll.bin -f3 -v3 -p3

scrollhd.bin: scrollhd.asm
	$(DASM) scrollhd.asm -oscrollhd.bin -f3 -v3 -p3

clean:
	rm -f scroll.bin scrollhd.bin scroll.nes

.PHONY: all clean
