	org $c000

music_call_136C
    ld   a,(l_e391) ;is sound command queue empty
    and  a
    ret  z          ;return if so
    ld   a,(l_e381) ;get next sound command from queue
    ;$00 - Silence (not called from queue)
    ;$02 - Unknown - no obvious sound (not called from queue)
    ;$03 - Unknown - no obvious sound (not called from queue)
    ;$04 - Unknown - no obvious sound (not called from queue)
    ;$07 = Intro/Game Music Start
    ;$08 = Record Screen Music
    ;$09 = Boss Music
    ;$0A = Invincible Music
    ;$0B = Game Over Music
    ;$0C = Lightning??
    ;$0D = Death sound
    ;$0E = Enemy Projectile Hits Wall (thud sound)
    ;$0F = Fast Music
    ;$10 = EXTEND Music (with bubble rotate lead)
    ;$11 = Pick Up 2 (alternative pick up noise)
    ;$12 = Explosion
    ;$13 = Shooting Star
    ;$14 = Good Ending Music
    ;$15 = Boss Fire sound (might also be other enemy fire?)
    ;$16 = Pick up special item
    ;$17 = Burst Extend Bubble
    ;$18 = Hurry Up Alarm and Faster Music
    ;$19 = Ghost Appear (also at 2A)
    ;$1A = Bottle hitting wall
    ;$1B = Big Item Drop
    ;$1C = Ending Noise - Walls Crummbling
    ;$1D = Invader Fire
    ;$1E = Water Bubble Burst
    ;$1F = Unknown - no obvious sound 
    ;$20 = Item Pickup
    ;$21 = Unknown Sfx
    ;$22 = Enemy fire (fireball)
    ;$23 = Big Lightning from Cross
    ;$24 = Ball Bouncing
    ;$25 = Burst Enemy Bubble
    ;$26 = Burst Enemy Bubble (alt channel?)
    ;$27 = Burst Lots of bubbles at once
    ;$28 = Unknown Sfx
    ;$29 = Secret Room Music
    ;$2A = Ghost Appear (also at 19)
    ;$2B = Bad End Music
    ;$2C = Jump
    ;$2D = Game intro/boot noise (not called from queue)
    ;$2E = Unknown - no obvious sound 
    ;$2F = Unknown Sfx
    ;$30 = Go back to Normal Speed Music
    ;$31 = Bubble Blow
    ;$32 = EXTEND Music (without bubble rotate lead - for vs level)
    ;$33 = Hit by Lightning
    ;$34 = Credit sound
    ;ld   ($FA00),a          ;SOUND IO - Play Sound Effects
    call music_process_sound_command
    ld   hl,l_e382      ;shift queue forward
    ld   de,l_e381
    ld   bc,$000F
    ldir
    ld   hl,l_e391      ;reduce queue counter
    dec  (hl)
    ret

music_process_sound_command
    ;put jump and fire first as they are most common sound events
    cp $2C
    jp z,slave_intro_sfx_jump
    cp $31
    jp z,slave_intro_sfx_fire
    cp $25
    jp z,slave_intro_sfx_burst
    cp $26
    jp z,slave_intro_sfx_burst
    cp $27
    jp z,slave_intro_sfx_big_burst
    cp $20
    jp z,slave_intro_sfx_pickup
    cp $11
    jp z,slave_intro_sfx_pickup2
    cp $16
    jp z,slave_intro_sfx_pickup_special
    cp $0D
    jp z,slave_intro_sfx_death

    cp $22
    jp z,slave_intro_sfx_enemy_fireball

    cp $1B
    jp z,slave_intro_sfx_big_item

    cp $1D
    jp z,slave_intro_sfx_invader_fire

    cp $0E
    jp z,slave_intro_sfx_proj_wall
    cp $1A
    jp z,slave_intro_sfx_bottle_wall

    cp $24
    jp z,slave_intro_sfx_ball_bounce

    cp $1e
    jp z,slave_intro_sfx_burst_water

    cp $33
    jp z,slave_intro_sfx_lighting_hit

    cp $23
    jp z,slave_intro_sfx_big_lighting

    cp $17
    jp z,slave_intro_sfx_burst_extend

    cp $0a
    jp z,slave_intro_music_invincible

    cp $15
    jp z,slave_intro_sfx_boss_fire

    cp $07
    jp z,slave_intro_music
  ;  cp $08
  ;  jr z,slave_music_stop
    cp $18
    jp z,slave_music_fast
    cp $19
    jp z,slave_intro_sfx_ghost
    cp $2A
    jp z,slave_intro_sfx_ghost
    cp $30
    jp z,slave_game_music
    cp $09
    jp z,slave_game_music_boss
    cp $10
    jp z,slave_music_extend
    cp $32
    jp z,slave_music_vs
    cp $08
    jp z,slave_game_record_music
    cp $34
    jp z,slave_game_sfx_credit
    cp $29
    jp z,slave_secret_room_music
    cp $14
    jp z,slave_good_end_music
    cp $2B
    jp z,slave_bad_end_music
    cp $1C
    jp z,slave_wall_crumble_music
    cp $13
    jp z,slave_intro_sfx_shooting_star
    ;break
    ret

slave_intro_sfx_jump
    ld a,1
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_fire
    ld a,2
    ld c,2
    ld b,0
    call SFX_PLAY
    ret


slave_intro_sfx_big_burst
    ld a,$0c
    ld c,2
    ld b,0
    call SFX_PLAY
slave_intro_sfx_burst
    ;TODO - Enemy trapped bubble burst sound
    ld a,$0c
    ld c,1
    ld b,0
    call SFX_PLAY
    ret



slave_intro_sfx_pickup
    ;TODO - item pick up sound
    ld a,$08
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_pickup2
    ;TODO - alternative item pick up sound
    ld a,$09
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_pickup_special
    ;TODO - alternative item pick up sound
    ld a,$0a
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_death
    ld a,3
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_proj_wall
    ;TODO - Enemy projectile hitting wall
    ld a,$07
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_bottle_wall
    ;TODO - Enemy bottle hitting wall
    ld a,$0b
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_ball_bounce
    ld a,$15
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_enemy_fireball
    ;TODO - Enemy fireball (Super BB)
    ld a,$11
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_invader_fire
    ld a,$13
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_big_item
    ld a,$14
    ld c,1
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_burst_extend
    ;TODO - Extend bubble burst sound
    ld a,$0e
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_burst_water
    ;TODO - Extend bubble burst sound
    ld a,$0d
    ld c,2
    ld b,0
    call SFX_PLAY
    ret



slave_intro_sfx_lighting_hit
    ld a,4
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_big_lighting
    ld a,$12
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_shooting_star
    ;TODO - Boss fire sound
    ld a,$10
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_intro_sfx_boss_fire
    ;TODO - Boss fire sound
    ld a,$0f
    ld c,1
    ld b,0
    call SFX_PLAY
    ret

slave_game_sfx_credit
    ld a,$06
    ld c,2
    ld b,0
    call SFX_PLAY
    ret


slave_intro_music
    ld a,music_intro
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_music_extend
    ld a,music_extend
    ld (music_module),a
    ld a,3
    ld (music_playing),a
    ret

slave_music_vs
    ld a,music_vs
    ld (music_module),a
    ld a,3
    ld (music_playing),a
    ret

slave_secret_room_music
    ld a,music_secret
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_good_end_music
    ld a,music_goodend
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_bad_end_music
    ld a,music_badend
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_wall_crumble_music
    ld a,music_crumble
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_music_stop
    ld a,0
    ld (music_playing),a
    ret

slave_intro_sfx_ghost
    ;need to play on all 3 channel to silence music
    ld a,5
    ld c,0
    ld b,0
    call SFX_PLAY
    ld a,5
    ld c,1
    ld b,0
    call SFX_PLAY
    ld a,5
    ld c,2
    ld b,0
    call SFX_PLAY
    ret

slave_music_fast
    ld a,music_mainfast
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_game_music
    ld a,music_mainshort
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_game_record_music
    ld a,music_record
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_intro_music_invincible
    ld a,music_invincible
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

slave_game_music_boss
    ld a,music_boss
    ld (music_module),a
    ld a,2
    ld (music_playing),a
    ret

music_ay_music
    cp 0
    jr z,music_ay_silence
    cp 2
    jr z,music_ay_new_module
    cp 3
    jr z,music_ay_new_module
    ld bc,$FFFD
    ld a,%11111101
    out (c),a
    call MUSIC_PLAY
    ret
music_ay_silence
    ;call MUSIC_MUTE ;need to change this to play a silent track!
    ld a,1
    ld (music_playing),a
    ld a,music_silent ;silent track
    ld hl,MODULE1;(music_module)
    call MUSIC_MOD_START
    ;call MUSIC_PLAY
    ret

music_ay_new_module
    sub #2      ;make A either 0 or 1
    ;ld (MUSIC_START+$0A),a      ;set looping
    ld a,1
    ld (music_playing),a
    ld a,(music_module)
    ld hl,MODULE1;(music_module)
    call MUSIC_MOD_START
    ;call MUSIC_PLAY
    ret
    

    ORG MUSIC_START
    incbin "../data/music.bin"

/*    incbin "../data/bb_0_1.bin"
    ORG MODULE1
    incbin "../data/bb_0_2.bin"
MODULE2
    incbin "../data/ext_0_2.bin"
MODULE3
    incbin "../data/bbm_0_2.bin"
MODULE4
    incbin "../data/gam_0_2.bin"
*/
MODULE2
MODULE3
MODULE4