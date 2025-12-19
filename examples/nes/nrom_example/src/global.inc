.ifndef GLOBAL_INC
.define GLOBAL_INC

; init.asm
.global reset_handler

; main.asm
.global main, nmi_handler, irq_handler
.global OAM
.globalzp cur_keys, new_keys, oam_used

; bg.asm
.global draw_bg

; player.asm
.global init_player, move_player, draw_player_sprite

; ppuclear.asm
.global ppu_clear_nt, ppu_clear_oam, ppu_screen_on

; pads.asm
.global read_pads, run_dma_and_read_pads, autorepeat

.endif
