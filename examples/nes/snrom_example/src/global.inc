.ifndef GLOBAL_INC
.define GLOBAL_INC

; init.asm
.global reset_handler

; main.asm
.global OAM
.global main, nmi_handler, irq_handler
.globalzp cur_keys, new_keys, oam_used

; bg.asm
.global draw_bg

; player.asm
.global init_player, move_player

; pads.asm
.global read_pads

; ppuclear.asm
.global ppu_clear_nt, ppu_clear_oam, ppu_screen_on

; bankcall ids
.globalzp draw_player_sprite, load_chr_ram

.endif
