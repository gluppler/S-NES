# Makefile for cpu_interrupts_v2
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

1-cli_latency.nes: source/1-cli_latency.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/1-cli_latency.asm.o

source/1-cli_latency.asm.o: source/1-cli_latency.asm
	$(CA65) -I source/common -o $@ $<

2-nmi_and_brk.nes: source/2-nmi_and_brk.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/2-nmi_and_brk.asm.o

source/2-nmi_and_brk.asm.o: source/2-nmi_and_brk.asm
	$(CA65) -I source/common -o $@ $<

3-nmi_and_irq.nes: source/3-nmi_and_irq.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/3-nmi_and_irq.asm.o

source/3-nmi_and_irq.asm.o: source/3-nmi_and_irq.asm
	$(CA65) -I source/common -o $@ $<

4-irq_and_dma.nes: source/4-irq_and_dma.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4-irq_and_dma.asm.o

source/4-irq_and_dma.asm.o: source/4-irq_and_dma.asm
	$(CA65) -I source/common -o $@ $<

4-nmi_and_dma.nes: source/4-nmi_and_dma.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/4-nmi_and_dma.asm.o

source/4-nmi_and_dma.asm.o: source/4-nmi_and_dma.asm
	$(CA65) -I source/common -o $@ $<

5-branch_delays_irq.nes: source/5-branch_delays_irq.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/5-branch_delays_irq.asm.o

source/5-branch_delays_irq.asm.o: source/5-branch_delays_irq.asm
	$(CA65) -I source/common -o $@ $<

all: 1-cli_latency.nes 2-nmi_and_brk.nes 3-nmi_and_irq.nes 4-irq_and_dma.nes 4-nmi_and_dma.nes 5-branch_delays_irq.nes

clean:
	rm -f source/1-cli_latency.o source/2-nmi_and_brk.o source/3-nmi_and_irq.o source/4-irq_and_dma.o source/4-nmi_and_dma.o source/5-branch_delays_irq.o 1-cli_latency.nes 2-nmi_and_brk.nes 3-nmi_and_irq.nes 4-irq_and_dma.nes 4-nmi_and_dma.nes 5-branch_delays_irq.nes