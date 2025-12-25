# Makefile for dmc_dma_during_read4
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

dma_2007_read.nes: source/dma_2007_read.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/dma_2007_read.asm.o

source/dma_2007_read.asm.o: source/dma_2007_read.asm
	$(CA65) -I source/common -o $@ $<

dma_2007_write.nes: source/dma_2007_write.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/dma_2007_write.asm.o

source/dma_2007_write.asm.o: source/dma_2007_write.asm
	$(CA65) -I source/common -o $@ $<

dma_4016_read.nes: source/dma_4016_read.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/dma_4016_read.asm.o

source/dma_4016_read.asm.o: source/dma_4016_read.asm
	$(CA65) -I source/common -o $@ $<

double_2007_read.nes: source/double_2007_read.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/double_2007_read.asm.o

source/double_2007_read.asm.o: source/double_2007_read.asm
	$(CA65) -I source/common -o $@ $<

read_write_2007.nes: source/read_write_2007.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/read_write_2007.asm.o

source/read_write_2007.asm.o: source/read_write_2007.asm
	$(CA65) -I source/common -o $@ $<

all: dma_2007_read.nes dma_2007_write.nes dma_4016_read.nes double_2007_read.nes read_write_2007.nes

clean:
	rm -f source/dma_2007_read.o source/dma_2007_write.o source/dma_4016_read.o source/double_2007_read.o source/read_write_2007.o dma_2007_read.nes dma_2007_write.nes dma_4016_read.nes double_2007_read.nes read_write_2007.nes