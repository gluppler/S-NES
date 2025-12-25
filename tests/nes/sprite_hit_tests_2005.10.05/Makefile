# Makefile for sprite_hit_tests_2005.10.05
# Auto-generated NES test build system

CA65 = ca65
LD65 = ld65
CFG = source/nes.cfg

.PHONY: all clean

01.basics.nes: source/01.basics.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/01.basics.asm.o

source/01.basics.asm.o: source/01.basics.asm
	$(CA65) -I source/common -o $@ $<

02.alignment.nes: source/02.alignment.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/02.alignment.asm.o

source/02.alignment.asm.o: source/02.alignment.asm
	$(CA65) -I source/common -o $@ $<

03.corners.nes: source/03.corners.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/03.corners.asm.o

source/03.corners.asm.o: source/03.corners.asm
	$(CA65) -I source/common -o $@ $<

04.flip.nes: source/04.flip.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/04.flip.asm.o

source/04.flip.asm.o: source/04.flip.asm
	$(CA65) -I source/common -o $@ $<

05.left_clip.nes: source/05.left_clip.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/05.left_clip.asm.o

source/05.left_clip.asm.o: source/05.left_clip.asm
	$(CA65) -I source/common -o $@ $<

06.right_edge.nes: source/06.right_edge.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/06.right_edge.asm.o

source/06.right_edge.asm.o: source/06.right_edge.asm
	$(CA65) -I source/common -o $@ $<

07.screen_bottom.nes: source/07.screen_bottom.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/07.screen_bottom.asm.o

source/07.screen_bottom.asm.o: source/07.screen_bottom.asm
	$(CA65) -I source/common -o $@ $<

08.double_height.nes: source/08.double_height.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/08.double_height.asm.o

source/08.double_height.asm.o: source/08.double_height.asm
	$(CA65) -I source/common -o $@ $<

09.timing_basics.nes: source/09.timing_basics.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/09.timing_basics.asm.o

source/09.timing_basics.asm.o: source/09.timing_basics.asm
	$(CA65) -I source/common -o $@ $<

10.timing_order.nes: source/10.timing_order.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/10.timing_order.asm.o

source/10.timing_order.asm.o: source/10.timing_order.asm
	$(CA65) -I source/common -o $@ $<

11.edge_timing.nes: source/11.edge_timing.asm.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/11.edge_timing.asm.o

source/11.edge_timing.asm.o: source/11.edge_timing.asm
	$(CA65) -I source/common -o $@ $<

prefix_sprite_hit.nes: source/prefix_sprite_hit.a.o $(CFG)
	$(LD65) -C $(CFG) -o $@ source/prefix_sprite_hit.a.o

source/prefix_sprite_hit.a.o: source/prefix_sprite_hit.a
	$(CA65) -I source/common -o $@ $<

all: 01.basics.nes 02.alignment.nes 03.corners.nes 04.flip.nes 05.left_clip.nes 06.right_edge.nes 07.screen_bottom.nes 08.double_height.nes 09.timing_basics.nes 10.timing_order.nes 11.edge_timing.nes prefix_sprite_hit.nes

clean:
	rm -f source/01.basics.o source/02.alignment.o source/03.corners.o source/04.flip.o source/05.left_clip.o source/06.right_edge.o source/07.screen_bottom.o source/08.double_height.o source/09.timing_basics.o source/10.timing_order.o source/11.edge_timing.o source/prefix_sprite_hit.o 01.basics.nes 02.alignment.nes 03.corners.nes 04.flip.nes 05.left_clip.nes 06.right_edge.nes 07.screen_bottom.nes 08.double_height.nes 09.timing_basics.nes 10.timing_order.nes 11.edge_timing.nes prefix_sprite_hit.nes