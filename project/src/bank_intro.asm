;This is the intro code normally in main memory and bank 0
;relocated here in order to free up space in main memory

	org $C000

intro_call_0967
    ld   a,(l_e33b)
    and  a
    jp   z,intro_call_0972
    jp   m,intro_call_09A7
    ret
intro_call_0972
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e34f)
    and  a
    ret  nz
    ld   hl,l_e33b
    ld   (hl),$FF
    ld   hl,l_e33c
    ld   (hl),$78
    ld   a,(l_e64b)
    inc  a
    ld   iy,$5080;$7a82+$e;$D99E
    call Write_Layer2_Num
    ld   hl,intro_data_09D2
    ld   de,$5058;$7a82;$D81E
    ld   c,$00;$00
    ;call call_0E9A
	call Write_Layer2_Text
    ld   hl,intro_data_09D8
    ld   de,$6058;$7b22;$D822
    ld   c,$00;$00
    jp   Write_Layer2_Text
intro_call_09A7
    ld   hl,l_e33c
    dec  (hl)
    ret  nz
    ld   hl,l_e33b
    ld   (hl),$01
    ld   hl,intro_data_09E0
    ld   de,$5058;$7a7e;$D79E
    ld   c,$00;$00
    call Write_Layer2_Text
    ld   hl,intro_data_09E0
    ld   de,$5858;$7acc;$D7A0
    ld   c,$00;$00
    call Write_Layer2_Text
    ld   hl,intro_data_09E0
    ld   de,$6058;$7b1c;$D7A2
    ld   c,$00;$00
    jp   Write_Layer2_Text


intro_data_09D2
    defb $05,"ROUND"

intro_data_09D8
    defb $07,"READY !"
    
intro_data_09E0
    defb $0B,"           "

intro_call_2578					;this code is run once start button is pressed
    ld a,0
    ld (options_control),a
    ld hl,MODULE1
    ld (music_module),hl
    ld a,2
    ld (music_playing),a
	call call_03D0
	call intro_call_B391
    call call_03B4
    call call_031C
    call call_0372
    call intro_call_B3B5
    ld   hl,$7658;$CD04
    ld   de,intro_data_B3F2
    ld   bc,$020C
;    ld   a,$2D
;    call $0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
    ld   hl,$7658+$18;$D004
    ld   de,intro_data_B52A
    ld   bc,$020C
;    ld   a,$2D
;    call $0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
    ld   hl,$7658+$18+$18;$D304
    ld   de,intro_data_B662
    ld   bc,$0208
;25AC: 3E 2E         ld   a,$2E
;25AE: CD C6 0E      call $0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
    ld   hl,l_e76c
    ld   bc,$0180
    call call_0D50
    ld   hl,l_e619
    ld   bc,$001B
    call call_0D50
    ;ld   hl,$0000
    ;ld   (l_f822),hl			;TODO - palette
    ld   hl,intro_data_28B5
    ld   de,$7700;$D608
    ld   c,1*16;$04
    call call_0E9A
    ld   hl,intro_data_28CE
    ld   de,$779A;$D54C
    ld   c,1*16;$04
    call call_0E9A
    ld   hl,intro_data_28ED
    ld   de,$7838;$D510
    ld   c,1*16;$04
    call call_0E9A
    ld   hl,intro_data_290E
    ld   de,$78ee;$D7D4
    ld   c,1*16;$04
    call call_0E9A
    ld   hl,$01E0
    ld   (l_e61a),hl
    call intro_call_264B
    call intro_call_2776
    ld   c,$07
    call call_1350
intro_call_2606
    call call_0020
	call intro_call_B738
    call intro_call_2873
    ld   hl,l_e619
    ld   (hl),$00
    call intro_call_269E
    call intro_call_27BB
    call call_482C
    ld   hl,(l_e61a)
    ld   de,$0110
    or   a
    sbc  hl,de
    jr   nz,intro_call_262B
    ld   hl,l_f35b
    ld   (hl),$02
intro_call_262B
    ld   hl,(l_e61a)
    dec  hl
    ld   (l_e61a),hl
    ld   a,l
    or   h
    jr   nz,intro_call_2606
    call call_0431
    call call_040C
    call call_03CB
    call call_03D0
    call call_0330
    ;call call_0B30
    jp   call_0427



intro_call_264B
    ld   ix,l_e76c
    xor  a
    ld   b,a
    ld   de,$0000
intro_call_2654
    push af
    ld   (ix+$09),a
    add  a,a
    add  a,a
    ld   hl,l_e20d
    call call_0D89
    ld   (ix+$03),l
    ld   (ix+$04),h
    inc  hl
    ld   a,d
    call call_0D6C
    or   e
    ld   (hl),a
    ld   (ix+$07),a
    inc  d
    ld   a,d
    cp   $04
    jr   nz,intro_call_2679
    ld   d,$00
    inc  e
intro_call_2679
    inc  hl
    inc  hl
    ld   (hl),$12
    ld   a,(l_e5db)
    and  a
    jr   z,intro_call_268C
    ld   a,b
    add  a,$08
    ld   b,a
    ld   (ix+$08),a
    jr   intro_call_2691
intro_call_268C
    ld   a,r
    ld   (ix+$08),a
intro_call_2691
    ex   de,hl
    ld   de,$000C
    add  ix,de
    ex   de,hl
    pop  af
    inc  a
    cp   $20
    jr   nz,intro_call_2654
intro_call_269E					;Hanging in this routine!
    ld   ix,l_e76c
    ld   b,$20
intro_call_26A4
    push bc
    bit  0,(ix+$00)
    jp   nz,intro_call_26D8
    ld   hl,(l_e61a)
    ld   de,$0096
    or   a
    sbc  hl,de
    jp   c,intro_call_276B
    dec  (ix+$08)
    jp   nz,intro_call_276B
    ld   hl,l_e619
    bit  0,(hl)
    jp   nz,intro_call_276B
    set  0,(hl)
    call call_1529
    ld   (hl),$78
    inc  hl
    inc  hl
    ld   (hl),$78
    set  0,(ix+$00)
    jp   intro_call_276B
intro_call_26D8
    inc  (ix+$0b)
    ld   a,(ix+$0b)
    cp   $40
    jr   z,intro_call_274E
    bit  0,(ix+$01)
    jr   nz,intro_call_2703
    ld   de,$0A06
    call call_15CA
    jr   nz,intro_call_26F6
    set  0,(ix+$01)
    jr   intro_call_2703
intro_call_26F6
    add  a,a
    add  a,a
    add  a,$D4			;this is base gfx code for the bubbles
    ld   b,a
    ld   c,$1C
    ld   a,(ix+$07)
    call call_147D
intro_call_2703
    ld   a,(ix+$09)
    call call_109C		;get offset of data at 10a2 + a*2 into HL
    ld   a,(ix+$0a)
    call call_0D84		;Add A to DE
    ld   a,(de)			;get A from 
    cp   $88
    jr   nz,intro_call_271A
    ld   (ix+$0a),$00
    jr   intro_call_2703
intro_call_271A
    call call_1529
    bit  3,a
    jr   z,intro_call_2725
    dec  (hl)
    dec  (hl)
    jr   intro_call_272B
intro_call_2725
    bit  0,a
    jr   z,intro_call_272B
    inc  (hl)
    inc  (hl)
intro_call_272B
    inc  hl
    inc  hl
    bit  7,a
    jr   z,intro_call_2735
    dec  (hl)
    dec  (hl)
    jr   intro_call_273B
intro_call_2735
    bit  4,a
    jr   z,intro_call_273B
    inc  (hl)
    inc  (hl)
intro_call_273B
    inc  (ix+$0a)
    bit  4,(ix+$09)
    jr   z,intro_call_276B
    ld   a,(hl)
    bit  7,(hl)
    jr   z,intro_call_276B
    inc  hl
    set  6,(hl)
    jr   intro_call_276B
intro_call_274E
    call call_1529
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    inc  hl
    res  6,(hl)
    ld   (ix+$08),$01
    xor  a
    ld   (ix+$0b),a
    ld   (ix+$01),a
    ld   (ix+$0a),a
    ld   (ix+$00),a
intro_call_276B
    ld   de,$000C
    add  ix,de
    pop  bc
    dec  b
    jp   nz,intro_call_26A4
    ret
intro_call_2776
    ld   ix,l_e61e
    ld   (ix+$08),$00
    ld   hl,l_e28d
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (ix+$1c),$0F
    ld   (ix+$07),$08
    ld   (ix+$0a),$1F
    ld   ix,l_e629
    ld   (ix+$08),$01
    ld   hl,l_e29d
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (ix+$1c),$1B
    ld   (ix+$07),$09
    ld   (ix+$0a),$23
    ld   hl,l_e28d
    ld   de,$0008
    ld   b,$08
    jp   call_18A5
intro_call_27BB
    ld   ix,l_e61e
    ld   b,$02
intro_call_27C1
    push bc
    bit  0,(ix+$00)
    jr   nz,intro_call_27EE
    ld   de,intro_data_2919
    bit  0,(ix+$08)
    jr   z,intro_call_27D4
    ld   de,intro_data_2921
intro_call_27D4
    call call_1529
    ld   b,$04
intro_call_27D9
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  hl
    ld   (hl),$14
    inc  hl
    inc  de
    djnz intro_call_27D9
    set  0,(ix+$00)
    jp   intro_call_2868
intro_call_27EE
    ld   de,$0A02
    call call_15CA
    add  a,a
    add  a,a
    ld   hl,intro_data_2929
    call call_0D89
    ld   c,(ix+$0a)
    ld   b,$04
intro_call_2801
    call call_14BD
    ld   de,intro_data_6D1D
    bit  0,(ix+$08)
    jr   z,intro_call_2810
    ld   de,intro_data_6CAF
intro_call_2810
    ld   a,(ix+$09)
    inc  (ix+$09)
    call call_0D84
    call call_1529
    ld   a,(de)
    cp   $88
    jr   nz,intro_call_2827
    ld   (ix+$09),$00
    jr   intro_call_27EE
intro_call_2827
    and  $F0
    or   a
    jr   z,intro_call_2848
    bit  7,a
    jr   nz,intro_call_283D
    push hl
    ld   b,$04
intro_call_2833
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz intro_call_2833
    pop  hl
    jr   intro_call_2848
intro_call_283D
    push hl
    ld   b,$04
intro_call_2840
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz intro_call_2840
    pop  hl
intro_call_2848
    ld   a,(de)
    and  $0F
    or   a
    jp   z,intro_call_2868
    bit  3,a
    jr   nz,intro_call_285F
    ld   b,$04
intro_call_2855
    inc  hl
    inc  hl
    inc  (hl)
    inc  hl
    inc  hl
    djnz intro_call_2855
    jp   intro_call_2868
intro_call_285F
    ld   b,$04
intro_call_2861
    inc  hl
    inc  hl
    dec  (hl)
    inc  hl
    inc  hl
    djnz intro_call_2861
intro_call_2868
    ld   de,$000B
    add  ix,de
    pop  bc
    dec  b
    jp   nz,intro_call_27C1
    ret
intro_call_2873
    ld   a,(l_e61d)
    cp   $0F
    ret  z
    ld   hl,l_e61c
    inc  (hl)
    ld   a,(hl)
    cp   $05
    ret  nz
    ld   (hl),$00
    inc  hl
    inc  (hl)
    ld   a,(hl)
    add  a,a
    ld   hl,intro_data_2895
    call call_0D89
    ;ld   e,(hl)
    ;inc  hl
    ;ld   d,(hl)
    ;ld   ($F822),de		;FADE TEXT
	nextreg $43,%10110000        ; (R/W) 0x43 (67) => Palette Control - Tiles
    nextreg $40,$11                  ; (R/W) 0x40 (64) => Palette Index
	call call_0B30_update_entry
    ret
intro_data_2895
	defb $00,$00,$10,$00,$20,$00,$30,$00,$40,$00,$50,$00,$60,$00,$70,$00
	defb $80,$00,$90,$00,$A0,$00,$B0,$00,$C0,$00,$D0,$00,$E0,$00,$F0,$00
intro_data_28B5
	defb $18,"NOW,IT IS BEGINNING OF A"
intro_data_28CE
	defb $1e,"FANTASTIC STORY!! LET'S MAKE A"
intro_data_28ED
	defb $20,"JOURNEY TO THE CAVE OF MONSTERS!"
intro_data_290E
	defb $0A,"GOOD LUCK!"
intro_data_2919
	defb $80,$38,$80,$48,$70,$38,$70,$48 
intro_data_2921
	defb $80,$A8,$80,$B8,$70,$A8,$70,$B8
intro_data_2929
	defb $64,$68,$7C,$80,$6C,$70,$84,$88
	defb $3A,$DB,$E5,$A7,$C9,$C0,$00,$00,$00,$00,$18,$02,$E3,$D1
	
	
intro_call_2F2B
    ld   hl,intro_data_2FA2
    ;ld   de,$7ad0;$D820
    ;ld   c,1*16;$04  ;red
    ;call call_0E9A;writetext  'GAME OVER'
	ld   de,$5860;$7a82;$D81E
    ld   c,$10;$00    
	call Write_Layer2_Text
	ret

intro_data_2FA2
    defb $09,"GAME OVER"			;GAME OVER message in DEMO MODE
	
intro_call_2F7A
    ld   hl,intro_data_2F7A_1
    ;ld   de,$7ad0;$D820
    ;ld   c,1*16;$04  ;red
    ;call call_0E9A;writetext  'GAME OVER'
	ld   de,$5860;$7a82;$D81E
    ld   c,$00;$00    
	call Write_Layer2_Text
	ret

intro_data_2F7A_1
    defb $09,"         "			;GAME OVER message in DEMO MODE
	
	
intro_call_clear_level_num      ;Clear level number in top left
	di
	
	ld 	(oldstack),sp
	ld sp,$FF00				;space at end of this bank	
	
	ld bc,$123B		;now we can safely page in Layer 2 for writes
	ld a,%00000011	;set write mode
	out (c),a

	xor  a
	ld   c,0
	ld de,$0000
	call Layer2_Write_Char
	xor  a
	ld   c,0
	ld de,$0008
	call Layer2_Write_Char
	xor  a
	ld   c,0
	ld de,$0800
	call Layer2_Write_Char
	xor  a
	ld   c,0
	ld de,$0808
	call Layer2_Write_Char
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	ei
	
    ret
	

intro_call_30DF      ;Display level number in top left
	di
	
	ld 	(oldstack),sp
	ld sp,$FF00				;space at end of this bank
	
	ld bc,$123B		;now we can safely page in Layer 2 for writes
	ld a,%00000011	;set write mode
	out (c),a

	xor  a
	ld   c,0
	ld de,$0000
	call Layer2_Write_Char
	xor  a
	ld   c,0
	ld de,$0008
	call Layer2_Write_Char
	xor  a
	ld   c,0
	ld de,$0800
	call Layer2_Write_Char
	xor  a
	ld   c,0
	ld de,$0808
	call Layer2_Write_Char
	
	;ld   ($D508),a
    ;ld   ($D50A),a
    ;ld   ($D548),a
    ;ld   ($D54A),a
		
    ld   a,(l_e5d3)
    and  a
    jr  nz,getouttahere
	
    call intro_call_3142
	ld	iyl,a			;store colour info
    ;ld   ($D509),a
    ;ld   ($D50B),a
    ;ld   ($D549),a
    ;ld   ($D54B),a
    ld   a,(l_e64b)
    inc  a
    cp   $64
    jr   z,intro_call_3125
    call call_1040
    ld   a,b
    or   a
    jr   z,intro_call_3119
    add  a,a		;print 10s digit
    add  a,$76
    ;ld   ($D508),a
    ;inc  a
    ;ld   ($D50A),a
	ld iyh,c
	push af
	ld de,$0000
	ld c,iyl
	call Layer2_Write_Char
	pop af
	inc a
	ld de,$0800
	ld c,iyl
	call Layer2_Write_Char
	ld c,iyh
intro_call_3119		;print 1s digit
    ld   a,c
    add  a,a
    add  a,$64
    ;ld   ($D548),a
    ;inc  a
    ;ld   ($D54A),a
	push af
	ld de,$0008
	ld c,iyl
	call Layer2_Write_Char
	pop af
	inc a
	ld de,$0808
	ld c,iyl
	call Layer2_Write_Char
getouttahere	
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	ei
	
    ret
intro_call_3125			;print level 100
    ;ld   a,$8A
    ;ld   ($D508),a
    ;inc  a
    ;ld   ($D50A),a
    ;inc  a
    ;ld   ($D548),a
    ;inc  a
    ;ld   ($D54A),a
	
	ld a,$8a
	ld de,$0000
	ld c,iyl
	call Layer2_Write_Char
	ld a,$8b
	ld de,$0008
	ld c,iyl
	call Layer2_Write_Char
	ld a,$8c
	ld de,$0800
	ld c,iyl
	call Layer2_Write_Char
	ld a,$8d
	ld de,$0808
	ld c,iyl
	call Layer2_Write_Char
	
;    ld   hl,($0004)			;Protection
;    ld   de,$00B9
;    or   a
;    sbc  hl,de

	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	ei

    ret
;intro_call_3140
;    pop  de
;    pop  hl
intro_call_3142
    ld   a,(l_e64b)
    ld   e,a
    ld   a,$f1
    bit  0,e
    ret  nz
    ld   a,$e1
    ret
	
intro_call_35FF		;In game high score entry/player resume
    call intro_call_36AC
    call intro_call_3648
    ld   a,(l_e677)
    cp   $05
    ret  z
    ld   b,$07
    call call_0DB1
    ld   de,l_e658
    add  hl,de
    ld   (hl),$43
    inc  hl
    ld   (hl),$4E
    inc  hl
    ld   (hl),$54
    ret



intro_call_361D			;Called once all lives are lost	
    ld a,0
    ld (music_playing),a
	call intro_call_clear_level_num
    call intro_call_36AC
    call call_03CB
    call call_03D0
    ld   hl,l_e5d6
    ld   (hl),$00
    call intro_call_363C
    call call_03D0
	
	;additional code to clear the EXTEND SPRITE
	ld a,EXTEND_FIRST_SPRITE_P1
	nextreg $34,a
	ld b,6
	ld a,0
intro_call_361D_1
	nextreg $78,a
	djnz intro_call_361D_1
	
	ld a,EXTEND_FIRST_SPRITE_P2
	nextreg $34,a
	ld b,6
	ld a,0
intro_call_361D_2
	nextreg $78,a
	djnz intro_call_361D_2
	
	
    ld   hl,l_e5d6
    ld   (hl),$01
    call intro_call_363C
    jp   call_03D0
intro_call_363C
    call intro_call_3648
    ld   a,(l_e677)
    cp   $05
    ret  z
    jp   intro_call_36D1
intro_call_3648
    ld   a,(l_e5d6)
    and  a
    jr   nz,intro_call_3653
    ld   hl,l_e643
    jr   intro_call_3656
intro_call_3653
    ld   hl,l_e648
intro_call_3656
    ld   b,$05
    ld   de,l_e672
intro_call_365B
	call call_0E85
    jr   nc,intro_call_366C
    push hl
    ex   de,hl
    ld   de,$0007
    or   a
    sbc  hl,de
    ex   de,hl
    pop  hl
    djnz intro_call_365B
intro_call_366C
    ld   hl,l_e677
    ld   (hl),b
    ld   a,b
    cp   $05
    ret  z
    cp   $04
    jr   z,intro_call_3695
    cpl
    and  $03
    inc  a
    ld   b,$07
    call call_0DB1
    push hl
    pop  bc
    ld   hl,l_e66f
    ld   de,l_e676
    lddr
    ld   hl,$0003
    ex   de,hl
    or   a
    sbc  hl,de
    ex   de,hl
    jr   intro_call_3698
intro_call_3695
    ld   de,l_e673
intro_call_3698
    ld   a,(l_e5d6)
    and  a
    jr   nz,intro_call_36A3
    ld   hl,l_e644
    jr   intro_call_36A6
intro_call_36A3
    ld   hl,l_e649
intro_call_36A6
    ld   bc,$0004
    lddr
    ret
intro_call_36AC
    ld   hl,l_e67b
    ld   a,(l_e644)
    cp   (hl)
    jr   c,intro_call_36B6
    ld   (hl),a
intro_call_36B6
    ld   a,(l_e649)
    cp   (hl)
    jr   c,intro_call_36BD
    ld   (hl),a
intro_call_36BD
    ld   hl,l_e67c
    ld   a,(l_e644)
    cp   (hl)
    jr   c,intro_call_36C7
    ld   (hl),a
intro_call_36C7
    ld   hl,l_e67d
    ld   a,(l_e649)
    cp   (hl)
    ret  c
    ld   (hl),a
    ret
intro_call_36D1
    ld   a,(l_e677)
    ld   b,$07
    call call_0DB1
    ld   de,l_e658
    add  hl,de
    ld   bc,$0003
    call call_0D50
    call call_349F				;Display high score screen
    call intro_call_38BD

    ld   a,(l_e5d6)
    and  a
    jr   nz,intro_call_36F4
    ld   de,l_e643
    jr   intro_call_36F7
intro_call_36F4
    ld   de,l_e648
intro_call_36F7
    ld   hl,$7982;$D658
    call call_3002
    ld   a,'0'
    ld   ($798E),a;($D7D8),a
    ld   a,(l_e5d6)
    and  a
    jr   nz,intro_call_370D
    ld   hl,l_e644
    jr   intro_call_3710
intro_call_370D
    ld   hl,l_e649
intro_call_3710
    ld   a,(hl)
    inc  a
    ld   iy,$7998;$D918
    cp   $65
    jr   z,intro_call_371F
    call call_0FC2
    jr   intro_call_372B
intro_call_371F
    ld   (iy-$02),$41		;'A'
    ld   (iy+$00),$4C		;'L'
    ld   (iy+$02),$4C		;'L'
intro_call_372B    
	xor  a
    ld   (l_e679),a
    ld   (l_e678),a
    ld   (l_e67a),a
    call intro_call_38A4
    ld   bc,$012C
intro_call_373B
    ld   a,$08
;flip
;	jp flip
    call call_0018;rst  $18
    dec  bc
    ld   a,c
    or   b
    jp   z,intro_call_3756
    push bc
    call intro_call_381E
    call intro_call_383C
    call intro_call_385A
    pop  bc
    ld   a,(l_e678)
    cp   $03
    jr   nz,intro_call_373B
intro_call_3756
    call call_0020
    call intro_call_3811
    ld   de,intro_data_37DF
    ld   b,$00
intro_call_375F
    push hl
    push de
    ld   a,(de)
    cp   (hl)
    jr   nz,intro_call_3771
    inc  hl
    inc  de
    ld   a,(de)
    cp   (hl)
    jr   nz,intro_call_3771
    inc  hl
    inc  de
    ld   a,(de)
    cp   (hl)
    jr   z,intro_call_377F
intro_call_3771
    pop  de
    pop  hl
    inc  de
    inc  de
    inc  de
    inc  b
    ld   a,b
    cp   $0A
    jr   nz,intro_call_375F
    jp   intro_call_37D1
intro_call_377F
    pop  de
    pop  hl
    ld   a,b
    ld   hl,intro_data_37FD
    call call_0DA7
    ex   de,hl
    jp   (hl)
intro_call_378A
    call intro_call_3811
    ld   (hl),$48
    inc  hl
    ld   (hl),$2E
    inc  hl
    ld   (hl),$21
    ld   c,$12
    call call_1350
    call call_18BB
    ld   hl,l_f457
    inc  (hl)
;    ld   iy,$0061
;    bit  3,(iy-$5f)
;    jr   nz,$37D1
	jr   intro_call_37D1
;    push de
;37AC: DD E3         ex   (sp),ix
intro_call_37AE
    ld   hl,l_e604
    inc  (hl)
    jr   intro_call_37D1
intro_call_37B4
    ld   hl,l_e605
    inc  (hl)
    jr   intro_call_37D1
intro_call_37BA
    ld   hl,l_e606
    inc  (hl)
    jr   intro_call_37D1
intro_call_37C0
    ld   hl,l_e607
    inc  (hl)
    jr   intro_call_37D1
intro_call_37C6
    ld   hl,l_e608
    inc  (hl)
    ld   c,$2D
    call call_1350
    jr   intro_call_37D1
intro_call_37D1
    call call_349F
    call intro_call_38BD
    xor  a
    ld   (l_e677),a
    ld   a,$78
    call call_0018; rst  $18
    ret
intro_data_37DF
	defb "SEXTAKSTRKTT..."
	defb "I.FMTJNSOKIMYSH"
	;defb $53,$45,$58,$54,$41,$4B,$53,$54,$52,$4B,$54,$54,$2E,$2E,$2E,$49
	;defb $2E,$46,$4D,$54,$4A,$4E,$53,$4F,$4B,$49,$4D,$59,$53,$48
intro_data_37FD
    defb LOW intro_call_378A,HIGH intro_call_378A
    defb LOW intro_call_37AE,HIGH intro_call_37AE
    defb LOW intro_call_37B4,HIGH intro_call_37B4
    defb LOW intro_call_37BA,HIGH intro_call_378A
    defb LOW intro_call_37C0,HIGH intro_call_37C0
    defb LOW intro_call_37C6,HIGH intro_call_37C6
    defb LOW intro_call_37C6,HIGH intro_call_37C6
    defb LOW intro_call_37C6,HIGH intro_call_37C6
    defb LOW intro_call_37C6,HIGH intro_call_37C6
    defb LOW intro_call_37C6,HIGH intro_call_37C6

	;defb $8A,$37
	;defb $AE,$37,$B4,$37,$BA,$37,$C0,$37,$C6,$37,$C6,$37,$C6,$37,$C6,$37
	;defb $C6,$37
intro_call_3811
    ld   a,(l_e677)
    ld   b,$07
    call call_0DB1
    ld   de,l_e658
    add  hl,de
    ret
	
;High score entry
intro_call_381E			;1st call
    ld   a,(l_e5d6)
    and  a
    jr   nz,intro_call_3829
    ld   hl,l_fc22
    jr   intro_call_382C
intro_call_3829
    ld   hl,l_fc23
intro_call_382C
    bit  1,(hl)
    ret  nz
    ld   hl,l_e679
    inc  (hl)
    ld   a,(hl)
    cp   $1C
    jr   nz,intro_call_38A4
    ld   (hl),$00
    jr   intro_call_38A4
intro_call_383C				;2nd call
    ld   a,(l_e5d6)
    and  a
    jr   nz,intro_call_3847
    ld   hl,l_fc22
    jr   intro_call_384A
intro_call_3847
    ld   hl,l_fc23
intro_call_384A
    bit  0,(hl)
    ret  nz
    ld   hl,l_e679
    dec  (hl)
    ld   a,(hl)
    cp   $FF
    jr   nz,intro_call_38A4
    ld   (hl),$1B
    jr   intro_call_38A4
intro_call_385A			;3rd call
    ld   a,(l_e5d6)
    and  a
    jr   nz,intro_call_3865
    ld   hl,l_fc22
    jr   intro_call_3868
intro_call_3865
    ld   hl,l_fc23
intro_call_3868
    bit  4,(hl)
    jr   z,intro_call_3876
    bit  5,(hl)
    jr   z,intro_call_3876
    ld   hl,l_e67a
    ld   (hl),$00
    ret
intro_call_3876
    ld   hl,l_e67a
    bit  0,(hl)
    ret  nz
    set  0,(hl)
    ld   a,(l_e677)
    ld   b,$07
    call call_0DB1
    ld   de,l_e658
    add  hl,de
    ld   a,(l_e678)
    call call_0D89
    ld   a,(l_e679)
    ld   de,intro_data_38D4
    call call_0D84
    ld   a,(de)
    ld   (hl),a
    ld   hl,l_e679
    ld   (hl),$00
    ld   hl,l_e678
    inc  (hl)
intro_call_38A4
    ld   a,(l_e678)			;current high score letter position
    cp   $03				;if it is 3 then exit
    ret  z
    ;call call_0D8E			;mul a x 64 and put in DE
	add a,a					;otherwise add to base screen address
	ld e,a
	ld d,0
    ld   hl,$79A2;$DA58
    add  hl,de
    ld   a,(l_e679)
    ld   de,intro_data_38D4
    call call_0D84			;add a to de
    ld   a,(de)
    ld   (hl),a
    ret
intro_call_38BD			;Colour current score yellow
    ld   a,(l_e677)
	ld	 b,$A0
    call call_0DB1
    ;add  a,a
	ld	 de,$7b11
    ;ld   hl,$7B11;$D663
	add hl,de
    call call_0D89
    ld   b,$18
intro_call_38CA
    ld   (hl),4*16;$10
    ld   a,$2;$40
    call call_0D89
    djnz intro_call_38CA
    ret
intro_data_38D4
	defb "ABCDEFGHIJKLMNOPQRSTUVWXYZ ."
	;defb $41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50
	;defb $51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$20,$2E


intro_call_62FB
    ld   iy,$D020;$79c8	
    ld   hl,l_e742
    call intro_call_630C			;write the EXTRA down the side	
    ld   iy,$D110;$7a04
    ld   hl,l_e743	
intro_call_630C
    ld   a,(hl)
    or   a
    ret  z
    ld   bc,$0600
intro_call_6312
    rrca
    push af
    push bc
    push iy
    call c,intro_call_6322
    pop  iy
    pop  bc
    pop  af
    inc  c
    djnz intro_call_6312
    ret
	
intro_call_6322
	ld a,$d1
	cp iyh
	ld a,EXTEND_FIRST_SPRITE_P2
	jr z,intro_call_6322_0
	ld a,EXTEND_FIRST_SPRITE_P1
intro_call_6322_0
	add a,c	
	nextreg $34,a		;select correct EXTEND sprite number
	;ld a,c
	rrca
	jr c,intro_call_6322_1	;odd sprite number
	or $c0
	nextreg $38,a		;Attr 3 
	ld a,%10000000
	nextreg $39,a
	jr intro_call_6322_2
intro_call_6322_1
	or $c0
	nextreg $38,a		;Attr 3 
	ld a,%11000000
	nextreg $39,a		;Attr 4
intro_call_6322_2
	ld a,iyl
	nextreg $35,a		;LSB of X coord
	ld a,iyh
	nextreg $37,a
	
	ld a,c			;retrieve extend number
	cp	6
	jr c,p1_extend
	sub 6
p1_extend
	call call_0D6D		;mul 16
	add a,$68			;add on offset
	nextreg $76,a			;finally set Y coord
    ret	


/*
intro_call_6322
	ld   d,c
	ld	 a,c
	ld   b,$A0
	call call_0DB1	;a*b into HL
	ld   a,d
    add  a,a
    add  a,a
    ld   e,l
    ld   d,h
    add  iy,de
    add  a,$04
    ld   e,$D1
    ld   (iy+$00),a
    ld   (iy+$01),e
    inc  a
    ld   (iy+$02),a
    ld   (iy+$03),e
    inc  a
    ld   (iy+$50),a
    ld   (iy+$51),e
    inc  a
    ld   (iy+$52),a
    ld   (iy+$53),e
    ret
*/



intro_data_6CAF
	defb $10,$00,$10,$00,$11,$00,$10,$00,$10,$00,$11,$00,$11,$00,$11,$00
	defb $11,$00,$01,$00,$01,$00,$11,$00,$01,$00,$01,$01,$00,$01,$00,$F1
	defb $00,$01,$00,$01,$00,$F1,$00,$F1,$00,$F1,$00,$F1,$00,$F0,$00,$F0
	defb $00,$F1,$00,$F0,$00,$F0,$F0,$00,$F0,$00,$FF,$00,$F0,$00,$F0,$00
	defb $FF,$00,$FF,$00,$FF,$00,$FF,$00,$0F,$00,$0F,$00,$FF,$00,$0F,$00
	defb $0F,$0F,$00,$0F,$00,$1F,$00,$0F,$00,$0F,$00,$1F,$00,$1F,$00,$1F
	defb $00,$1F,$00,$10,$00,$10,$00,$1F,$00,$10,$00,$10,$00,$88
intro_data_6D1D
	defb $10,$00
	defb $10,$00,$1F,$00,$10,$00,$10,$00,$1F,$00,$1F,$00,$1F,$00,$1F,$00
	defb $0F,$00,$0F,$00,$1F,$00,$0F,$00,$0F,$0F,$00,$0F,$00,$FF,$00,$0F
	defb $00,$0F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$F0,$00,$F0,$00,$FF
	defb $00,$F0,$00,$F0,$F0,$00,$F0,$00,$F1,$00,$F0,$00,$F0,$00,$F1,$00
	defb $F1,$00,$F1,$00,$F1,$00,$01,$00,$01,$00,$F1,$00,$01,$00,$01,$01
	defb $00,$01,$00,$11,$00,$01,$00,$01,$00,$11,$00,$11,$00,$11,$00,$11
	defb $00,$10,$00,$10,$00,$11,$00,$10,$00,$10,$00,$88
	
	
intro_get_tiles_at_8000		;a=gfxbank
	;out ($54),a
	nextreg $54,a
	;inc a
	;out ($55),a
	ret
	
intro_restore_8000		;a=gfxbank
	nextreg $54,$04
	;out ($54),a
	;inc a
	;out ($55),a
	ret
	
intro_call_6F82
	ld   a,(ix+$02)
    add  a,a
    ld   e,a
    add  a,a
    add  a,e
    ld   de,intro_data_6FE3
    call call_0D84
intro_call_6F98
    ld   l,(ix+$04)
    ld   h,(ix+$05)
    push hl
    pop  iy
    ld   bc,$0600
intro_call_6FA3
	push bc
	ld   a,(de)					
	ld b,a
	
	ld a,$d1
	cp iyh
	ld a,EXTEND_FIRST_SPRITE_P2
	jr z,intro_call_6FA3_0
	ld a,EXTEND_FIRST_SPRITE_P1
intro_call_6FA3_0
	add   a,b
	nextreg $34,a		;select correct EXTEND sprite number

	ld a,c
	call call_0D6D		;mul 16
	add a,$68			;add on offset
	nextreg $76,a
    
    inc  de
	pop bc
	inc c
    djnz intro_call_6FA3
    ret
	

	
intro_call_6FBF

	;clear the EXTEND SPRITES
	ld a,EXTEND_FIRST_SPRITE_P1
	nextreg $34,a
	ld b,6
	ld a,0
intro_call_6FBF_1
	nextreg $78,a
	djnz intro_call_6FBF_1
	
	ld a,EXTEND_FIRST_SPRITE_P2
	nextreg $34,a
	ld b,6
	ld a,0
intro_call_6FBF_2
	nextreg $78,a
	djnz intro_call_6FBF_2
	
	call intro_call_clear_level_num

    jp intro_call_7007
	
;intro_data_6FE3
;	defb $18,$04,$08,$0C,$10,$14,$14,$18,$04,$08,$0C,$10,$10,$14,$18,$04,$08,$0C
;	defb $0C,$10,$14,$18,$04,$08,$08,$0C,$10,$14,$18,$04,$04,$08,$0C,$10
;	defb $14,$18
	
intro_data_6FE3
	defb $05,$00,$01,$02,$03,$04,$04,$05,$00,$01,$02,$03,$03,$04,$05,$00,$01,$02
	defb $02,$03,$04,$05,$00,$01,$01,$02,$03,$04,$05,$00,$00,$01,$02,$03
	defb $04,$05



intro_call_7007			;we will put code in here to add extend tiles to layer 2

;	ld hl,$044D			;protection removed
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $7015
;    push iy

	ld   a,gfxbank23
	ld   hl,intro_bank1_data_8A54  
	ld	 de,$0708		;d=number of  rows - e=x pos
	ld	 bc,$1ed0		;b=number of columns - c=colour
	
	call extend_0EC6
	
intro_call_7015			;EXTEND complete code
    ld   a,$03
    call call_0008
    ld   a,$04
    call call_0008
    call call_040C		;clear sprite structures
    ;ld   a,bank1		;relocated into intro_bank
    ;call call_026C
	
    ;ld   hl,l_f8e0		;TODO - palette
    ;ld   de,$F920
    ;ld   bc,$0040
    ;ldir
	
	ld   hl,layer2_palette_70
    ;ld   de,$F8E0
	nextreg $43, %00010000        ; (R/W) 0x43 (67) => Palette Control - Layer 2
    nextreg $40, $90                  ; (R/W) 0x40 (64) => Palette Index
    ld   b,$40
intro_call_7015_loop
	call call_0B30_update_entry
	djnz intro_call_7015_loop
	
    ;call call_029B
    ld   hl,l_eb5d
    ld   (hl),$00
    ld   hl,l_eb5e
    ld   (hl),$00
    call call_03CB    ;Clear screen
    call call_02D6	   ;Clear some variables
    call call_030E    ;
    ;ld   hl,$D500		;Top left corner of second screen (need to change to layer 2 code)
    ;ld   bc,$0400
;intro_call_704A
    ;ld   (hl),$05		;TODO - screen locs
   ; inc  hl
    ;ld   (hl),$00		;TODO - screen locs
 ;   inc  hl
  ;  dec  bc
   ; ld   a,c
   ; or   b
    ;jr   nz,intro_call_704A		
    ;ld   a,bank1		    ;relocated into intro_bank
    ;call call_026C
	;Draw the flower screen for EXTEND
    ld   hl,$76F8;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_849E  
    ld   bc,$1A0C
	ex af,af'
	ld a,0*16	;gfx atrtibute
	ex af,af'
	ld a,$d0
    call call_0EC6_Adjusted		
    ld   hl,$76F8+$18		;top row, 12 across of level area
    ld   de,intro_bank1_data_85D6  
    ld   bc,$1A0C
	ex af,af'
	ld a,0*16	;gfx atrtibute
	ex af,af'
	ld a,$d0
    call call_0EC6_Adjusted		
    ld   hl,$76F8+$18+$18		;top row, 24 across of level area
    ld   de,intro_bank1_data_870E  
    ld   bc,$1A08
	ex af,af'
	ld a,0*16	;gfx atrtibute
	ex af,af'
	ld a,$d0
    call call_0EC6_Adjusted

    call intro_call_7969 
;    call call_029B	;we are back to bank 0 now
intro_call_7098
	ld   hl,$0384
    ld   (l_eb5f),hl
    ld   de,$0018
    ld   b,$01
    ld   hl,l_e2c5
    call call_18A5
    ld   hl,l_e2c5
    ld   (l_eb69),hl
    ld   (hl),$FF
    inc  hl
    ld   a,(hl)
    ld   (l_eb6f),a
    inc  hl
    ld   (hl),$E0
    ld   a,(l_eb56)
    and  a
    jr   z,intro_call_70C6
    ld   (hl),$14
    ld   a,$07
    ld   (l_eb70),a
intro_call_70C6
    inc  hl
    ld   (hl),$12
    ld   hl,l_e20d
    ld   de,$0000
    ld   b,$18
    call call_18A5
    ld   ix,l_eb73
    ld   hl,l_e20d
    xor  a
intro_call_70DC
    push af
    ld   (ix+$04),a
    ld   b,$04
    ld   (ix+$01),l
    ld   (ix+$02),h
    inc  hl
    ld   a,(hl)
    ld   (ix+$05),a
intro_call_70ED
    inc  hl
    inc  hl
    ld   (hl),$1A
    inc  hl
    inc  hl
    djnz intro_call_70ED
    dec  hl
    ld   de,$0006
    add  ix,de
    pop  af
    inc  a
    cp   $06
    jr   nz,intro_call_70DC
intro_call_7101
    call call_0020
    ld   hl,(l_eb5f)
    dec  hl
    ld   (l_eb5f),hl
    ld   a,l
    or   h
    jp   z,intro_call_7913
;    ld   a,$01
;    call $026C
    call intro_call_7136
    call intro_call_7205
    call intro_call_7293
    call intro_call_7321
    call intro_call_739D
    call intro_call_7419
    call intro_call_7495
    call intro_call_7511
    call intro_call_759F
    call intro_call_77C6
;    call $029B
    jr   intro_call_7101
intro_call_7136
    ld   a,(l_eb56)
    and  a
    ret  nz
    ld   a,(l_eb72)
    and  a
    jr   z,intro_call_7147
    call intro_call_71C4
    jp   intro_call_7196
intro_call_7147
    ld   hl,l_eb70
    ld   a,(hl)
    cp   $06
    ld   hl,(l_eb69)
    jr   z,intro_call_716D
    ld   a,(l_eb6d)
    and  a
    jr   nz,intro_call_718B
intro_call_7158
    ld   hl,(l_eb69)
    ld   a,(hl)
    cp   $90
    jr   nc,intro_call_716D
    ld   hl,l_eb70
    inc  (hl)
    ld   de,intro_data_79C6
    call intro_call_71E7
    jp   intro_call_7196
intro_call_716D
    ld   a,(hl)
    cp   $19
    jr   nc,intro_call_7187
    ld   hl,l_eb72
    ld   (hl),$01
    ld   hl,l_eb97
    ld   (hl),$3C
    ld   hl,l_eb6e
    ld   (hl),$00
    call intro_call_780B
    jp   intro_call_7196
intro_call_7187
    dec  (hl)
    jp   intro_call_7196
intro_call_718B
    ld   b,$02
intro_call_718D
    push bc
    call intro_call_788E
    pop  bc
    jr   z,intro_call_7158
    djnz intro_call_718D
intro_call_7196
    ld   hl,l_eb6b
    ld   bc,l_eb6c
    ld   de,$0A02
    call intro_call_7900
    add  a,a
    add  a,a
    ld   hl,l_eb6e
    bit  0,(hl)
    ld   b,$6C
    jr   z,intro_call_71AF
    ld   b,$74
intro_call_71AF
    add  a,b
    ld   b,a
    ld   a,(l_eb72)
    and  a
    ld   a,(l_eb6f)
    ld   c,$1E
    jr   z,intro_call_71C0
    call call_149C
    ret
intro_call_71C0
    call call_147D
    ret
intro_call_71C4
    ld   a,(l_eb6e)
    and  a
    ld   hl,(l_eb69)
    jr   nz,intro_call_71DA
    ld   a,(hl)
    cp   $19
    jr   c,intro_call_71D4
    dec  (hl)
    ret
intro_call_71D4
    ld   hl,l_eb6e
    ld   (hl),$01
    ret
intro_call_71DA
    ld   a,(hl)
    cp   $30
    jr   nc,intro_call_71E1
    inc  (hl)
    ret
intro_call_71E1
    ld   hl,l_eb6e
    ld   (hl),$00
    ret
intro_call_71E7
    ld   hl,l_eb6e
    ld   (hl),$01
    ld   hl,l_eb6d
    ld   (hl),$01
    ld   (l_eb65),de
    inc  de
    ld   a,(de)
    ld   (l_eb68),a
    ld   hl,l_eb67
    ld   (hl),$00
    ld   c,$2C
    call call_1350
    ret
intro_call_7205
    ld   a,(l_eb56)
    and  a
    ret  z
    ld   a,(l_eb72)
    and  a
    jr   z,intro_call_7216
    call intro_call_71C4
    jp   intro_call_7265
intro_call_7216
    ld   hl,l_eb70
    ld   a,(hl)
    cp   $01
    ld   hl,(l_eb69)
    jr   z,intro_call_723C
    ld   a,(l_eb6d)
    and  a
    jr   nz,intro_call_725A
intro_call_7227
    ld   hl,(l_eb69)
    ld   a,(hl)
    cp   $90
    jr   nc,intro_call_723C
    ld   hl,l_eb70
    dec  (hl)
    ld   de,intro_data_79C6
    call intro_call_71E7
    jp   intro_call_7265
intro_call_723C
    ld   a,(hl)
    cp   $19
    jr   nc,intro_call_7256
    ld   hl,l_eb72
    ld   (hl),$01
    ld   hl,l_eb97
    ld   (hl),$3C
    ld   hl,l_eb6e
    ld   (hl),$00
    call intro_call_780B
    jp   intro_call_7265
intro_call_7256
    dec  (hl)
    jp   intro_call_7265
intro_call_725A
    ld   b,$02
intro_call_725C
    push bc
    call intro_call_788E
    pop  bc
    jr   z,intro_call_7227
    djnz intro_call_725C
intro_call_7265	
    ld   hl,l_eb6b
    ld   bc,l_eb6c
    ld   de,$0A02
    call intro_call_7900
    add  a,a
    add  a,a
    ld   hl,l_eb6e
    bit  0,(hl)
    ld   b,$6C
    jr   z,intro_call_727E
    ld   b,$74
intro_call_727E
    add  a,b
    ld   b,a
    ld   a,(l_eb72)
    and  a
    ld   a,(l_eb6f)
    ld   c,$22
    jr   z,intro_call_728F
    call call_147D
    ret
intro_call_728F
    call call_149C
    ret
intro_call_7293
    ld   a,(l_eb72)
    and  a
    ret  nz
    ld   a,(l_eb70)
    cp   $06
    jr   nz,intro_call_72A7
    ld   a,(l_eb71)
    set  0,a
    ld   (l_eb71),a
intro_call_72A7
    ld   a,(l_eb71)
    bit  0,a
    jp   nz,intro_call_72F3
    ld   hl,l_eb63
    ld   bc,l_eb64
    ld   de,$0F04
    call intro_call_7900
    or   a
    jr   z,intro_call_72D5
    cp   $01
    jr   z,intro_call_72C6
    cp   $02
    jr   z,intro_call_72E4
intro_call_72C6
    ;ld   hl,$D55A
    ;ld   de,intro_bank1_data_88B0
    ;ld   bc,$0705
    ;ld   a,$35
	ld   a,gfxbank22+1
	ld   hl,intro_bank1_data_88B0  
	ld	 de,$0708
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_72D5
    ;ld   hl,$D55A
    ;ld   de,intro_bank1_data_87DE
    ;ld   bc,$0705
    ;ld   a,$34
	ld   a,gfxbank22
	ld   hl,intro_bank1_data_87DE  
	ld	 de,$0708
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_72E4
    ;ld   hl,$D55A
    ;ld   de,intro_bank1_data_8982
    ;ld   bc,$0705
    ;ld   a,$36
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_8982 
	ld	 de,$0708
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_72F3
    ld   hl,l_eb61
    ld   bc,l_eb62
    ld   de,$0A02
    call intro_call_7900
    cp   $01
    jr   z,intro_call_7312
    ;ld   hl,$D55A
    ;ld   de,intro_bank1_data_8B26
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8B26
	ld	 de,$0708
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7312
    ;ld   hl,$D55A
    ;ld   de,intro_bank1_data_8BF8
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8BF8
	ld	 de,$0708
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7321
    ld   a,(l_eb72)
    and  a
    ret  nz
    ld   a,(l_eb70)
    cp   $05
    jr   nz,intro_call_7335
    ld   a,(l_eb71)
    set  1,a
    ld   (l_eb71),a
intro_call_7335
    ld   a,(l_eb71)
    bit  1,a
    jp   nz,intro_call_7378
    ld   a,(l_eb64)
    or   a
    jr   z,intro_call_735A
    cp   $01
    jr   z,intro_call_734B
    cp   $02
    jr   z,intro_call_7369
intro_call_734B
    ;ld   hl,$D69A
    ;ld   de,intro_bank1_data_88D3
    ;ld   bc,$0705
    ;ld   a,$35
	ld   a,gfxbank22+1
	ld   hl,intro_bank1_data_88D3
	ld	 de,$0730
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_735A
    ;ld   hl,$D69A
    ;ld   de,intro_bank1_data_8801
    ;ld   bc,$0705
    ;ld   a,$34
	ld   a,gfxbank22
	ld   hl,intro_bank1_data_8801
	ld	 de,$0730
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7369
    ;ld   hl,$D69A
    ;ld   de,intro_bank1_data_89A5
    ;ld   bc,$0705
    ;ld   a,$36
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_89A5
	ld	 de,$0730
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7378
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_738E
    ;ld   hl,$D69A
    ;ld   de,intro_bank1_data_8B49
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8B49
	ld	 de,$0730
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_738E
    ;ld   hl,$D69A
    ;ld   de,intro_bank1_data_8C1B
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8C1B
	ld	 de,$0730
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_739D
    ld   a,(l_eb72)
    and  a
    ret  nz
    ld   a,(l_eb70)
    cp   $04
    jr   nz,intro_call_73B1
    ld   a,(l_eb71)
    set  2,a
    ld   (l_eb71),a
intro_call_73B1
    ld   a,(l_eb71)
    bit  2,a
    jp   nz,intro_call_73F4
    ld   a,(l_eb64)
    or   a
    jr   z,intro_call_73D6
    cp   $01
    jr   z,intro_call_73C7
    cp   $02
    jr   z,intro_call_73E5
intro_call_73C7
    ;ld   hl,$D7DA
    ;ld   de,intro_bank1_data_88F6
    ;ld   bc,$0705
    ;ld   a,$35
	ld   a,gfxbank22+1
	ld   hl,intro_bank1_data_88F6
	ld	 de,$0758
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_73D6
    ;ld   hl,$D7DA
    ;ld   de,intro_bank1_data_8824
    ;ld   bc,$0705
    ;ld   a,$34
	ld   a,gfxbank22
	ld   hl,intro_bank1_data_8824
	ld	 de,$0758
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_73E5
    ;ld   hl,$D7DA
    ;ld   de,intro_bank1_data_89C8
    ;ld   bc,$0705
    ;ld   a,$36
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_89C8
	ld	 de,$0758
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_73F4
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_740A
    ;ld   hl,$D7DA
    ;ld   de,intro_bank1_data_8B6C
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8B6C
	ld	 de,$0758
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_740A
    ;ld   hl,$D7DA
    ;ld   de,intro_bank1_data_8C3E
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8C3E
	ld	 de,$0758
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7419
    ld   a,(l_eb72)
    and  a
    ret  nz
    ld   a,(l_eb70)
    cp   $03
    jr   nz,intro_call_742D
    ld   a,(l_eb71)
    set  3,a
    ld   (l_eb71),a
intro_call_742D
    ld   a,(l_eb71)
    bit  3,a
    jp   nz,intro_call_7470
    ld   a,(l_eb64)
    or   a
    jr   z,intro_call_7452
    cp   $01
    jr   z,intro_call_7443
    cp   $02
    jr   z,intro_call_7461
intro_call_7443
    ;ld   hl,$D91A
    ;ld   de,intro_bank1_data_8919
    ;ld   bc,$0705
    ;ld   a,$35
	ld   a,gfxbank22+1
	ld   hl,intro_bank1_data_8919
	ld	 de,$0780
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7452
    ;ld   hl,$D91A
    ;ld   de,intro_bank1_data_8847
    ;ld   bc,$0705
    ;ld   a,$34
	ld   a,gfxbank22
	ld   hl,intro_bank1_data_8847
	ld	 de,$0780
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7461
    ;ld   hl,$D91A
    ;ld   de,intro_bank1_data_89EB
    ;ld   bc,$0705
    ;ld   a,$36
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_89EB
	ld	 de,$0780
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7470
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_7486
    ;ld   hl,$D91A
    ;ld   de,intro_bank1_data_8B8F
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8B8F
	ld	 de,$0780
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7486
    ;ld   hl,$D91A
    ;ld   de,intro_bank1_data_8C61
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8C61
	ld	 de,$0780
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7495
    ld   a,(l_eb72)
    and  a
    ret  nz
    ld   a,(l_eb70)
    cp   $02
    jr   nz,intro_call_74A9
    ld   a,(l_eb71)
    set  4,a
    ld   (l_eb71),a
intro_call_74A9
    ld   a,(l_eb71)
    bit  4,a
    jp   nz,intro_call_74EC
    ld   a,(l_eb64)
    or   a
    jr   z,intro_call_74CE
    cp   $01
    jr   z,intro_call_74BF
    cp   $02
    jr   z,intro_call_74DD
intro_call_74BF
    ;ld   hl,$DA5A
    ;ld   de,intro_bank1_data_893C
    ;ld   bc,$0705
    ;ld   a,$35
	ld   a,gfxbank22+1
	ld   hl,intro_bank1_data_893C
	ld	 de,$07A8
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_74CE
    ;ld   hl,$DA5A
    ;ld   de,intro_bank1_data_886A
    ;ld   bc,$0705
    ;ld   a,$34
	ld   a,gfxbank22
	ld   hl,intro_bank1_data_886A
	ld	 de,$07A8
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_74DD
    ;ld   hl,$DA5A
    ;ld   de,intro_bank1_data_8A0E
    ;ld   bc,$0705
    ;ld   a,$36
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_8A0E
	ld	 de,$07A8
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_74EC
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_7502
    ;ld   hl,$DA5A
    ;ld   de,intro_bank1_data_8BB2
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8BB2
	ld	 de,$07A8
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7502
    ;ld   hl,$DA5A
    ;ld   de,intro_bank1_data_8C84
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8C84
	ld	 de,$07A8
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7511
    ld   a,(l_eb72)
    and  a
    ret  nz
    ld   a,(l_eb70)
    cp   $01
    jr   nz,intro_call_7525
    ld   a,(l_eb71)
    set  5,a
    ld   (l_eb71),a
intro_call_7525
    ld   a,(l_eb71)
    bit  5,a
    jp   nz,intro_call_7571
    ld   hl,l_eb63
    ld   bc,l_eb64
    ld   de,$0F04
    call intro_call_7900
    or   a
    jr   z,intro_call_7553
    cp   $01
    jr   z,intro_call_7544
    cp   $02
    jr   z,intro_call_7562
intro_call_7544
    ;ld   hl,$DB9A
    ;ld   de,intro_bank1_data_895F
    ;ld   bc,$0705
    ;ld   a,$35
	ld   a,gfxbank22+1
	ld   hl,intro_bank1_data_895F
	ld	 de,$07D0
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7553
    ;ld   hl,$DB9A
    ;ld   de,intro_bank1_data_888D
    ;ld   bc,$0705
    ;ld   a,$34
	ld   a,gfxbank22
	ld   hl,intro_bank1_data_888D
	ld	 de,$07D0
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7562
    ;ld   hl,$DB9A
    ;ld   de,intro_bank1_data_8A31
    ;ld   bc,$0705
    ;ld   a,$36
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_8A31
	ld	 de,$07D0
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7571
    ld   hl,l_eb61
    ld   bc,l_eb62
    ld   de,$0A02
    call intro_call_7900
    cp   $01
    jr   z,intro_call_7590
    ;ld   hl,$DB9A
    ;ld   de,intro_bank1_data_8BD5
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8BD5
	ld	 de,$07D0
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_7590
    ;ld   hl,$DB9A
    ;ld   de,intro_bank1_data_8CA7
    ;ld   bc,$0705
    ;ld   a,$37
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8CA7
	ld	 de,$07D0
	ld	 bc,$05d0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_759F
    ld   a,(l_eb72)
    and  a
    ret  z
    call intro_call_7782
    ld   hl,l_eb97
    dec  (hl)
    ld   ix,l_eb73
    ld   de,intro_data_7860
    xor  a
intro_call_75B3
    push af
    push de
    bit  0,(ix+$00)
    jr   z,intro_call_75CC
    bit  4,(ix+$00)
    jr   nz,intro_call_75CC
    ld   a,(l_eb97)
    or   a
    jp   nz,intro_call_775A
    set  4,(ix+$00)
intro_call_75CC
    bit  2,(ix+$00)
    jp   nz,intro_call_7767
    bit  5,(ix+$00)
    jp   nz,intro_call_76A8
    bit  1,(ix+$00)
    jp   nz,intro_call_7673
    bit  0,(ix+$00)
    jr   nz,intro_call_760D
    ld   b,$04
    ld   l,(ix+$01)
    ld   h,(ix+$02)
intro_call_75EF
    ld   a,b
    cp   $03
    ld   (hl),$78               ;set y pos of EXTEND screen stars
    jr   nc,intro_call_75F8
    ld   (hl),$68               ;set y pos of EXTEND screen stars
intro_call_75F8
    inc  hl
    inc  hl
    ld   a,(de)
    bit  0,b
    jr   z,intro_call_7601
    add  a,$10
intro_call_7601
    ld   (hl),a                 ;set x pos of EXTEND screen stars
    inc  hl
    inc  hl
    djnz intro_call_75EF
    set  0,(ix+$00)
    jp   intro_call_775A
intro_call_760D
    ld   de,intro_data_7776
    ld   a,(ix+$04)
    add  a,a
    call call_0D84
    ld   b,$04
    ld   l,(ix+$01)
    ld   h,(ix+$02)
    ld   a,(hl)
    cp   $A0
    jr   c,intro_call_7655
    ld   hl,l_eb98
    ld   (hl),$01
    ld   a,(ix+$04)
    cp   $04
    jr   nz,intro_call_763C
    set  1,(ix+$00)
    ld   hl,l_eb97
    ld   (hl),$3C
    jp   intro_call_775A
intro_call_763C
    ld   b,$04
    set  2,(ix+$00)
    ld   l,(ix+$01)
    ld   h,(ix+$02)
intro_call_7648
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    inc  hl
    inc  hl
    djnz intro_call_7648
    jp   intro_call_775A
intro_call_7655
    ld   a,(de)
    add  a,(hl)
    ld   (hl),a
    inc  de
    inc  hl
    inc  hl
    ld   a,(ix+$04)
    cp   $03
    jr   c,intro_call_7668
    ld   a,(de)
    ld   c,a
    ld   a,(hl)
    sub  c
    jr   intro_call_766A
intro_call_7668
    ld   a,(de)
    add  a,(hl)
intro_call_766A
    ld   (hl),a
    inc  hl
    inc  hl
    dec  de
    djnz intro_call_7655
    jp   intro_call_775A
intro_call_7673
    ld   hl,l_eb97
    ld   a,(hl)
    or   a
    jp   nz,intro_call_775A
    inc  (hl)
    ld   l,(ix+$01)
    ld   h,(ix+$02)
    ld   b,$04
intro_call_7684
    ld   a,(hl)
    cp   $01
    jr   nc,intro_call_7690
    set  5,(ix+$00)
    jp   intro_call_7648
intro_call_7690
    sub  $04
    ld   (hl),a
    inc  hl
    inc  hl
    ld   a,(l_eb56)
    and  a
    jr   z,intro_call_769F
    inc  (hl)
    inc  (hl)
    jr   intro_call_76A1
intro_call_769F
    dec  (hl)
    dec  (hl)
intro_call_76A1
    inc  hl
    inc  hl
    djnz intro_call_7684
    jp   intro_call_775A
intro_call_76A8
    bit  3,(ix+$00)
    jp   nz,intro_call_7732
    ld   a,(l_eb56)
    and  a
    jr   nz,intro_call_76F5
    ld   a,(l_e645)
    inc  a
    cp   $05
    jr   c,intro_call_76BF
    ld   a,$05
intro_call_76BF
    ld   b,$08
    call call_0DB1
    ld   c,l
    ld   b,$04
    ld   l,(ix+$01)
    ld   h,(ix+$02)
intro_call_76CD
    ld   (hl),$14
    ld   a,b
    cp   $03
    jr   nc,intro_call_76D6
    ld   (hl),$04
intro_call_76D6
    inc  hl
    inc  hl
    ld   a,c
    sub  $10
    jr   nc,intro_call_76DE
    xor  a
intro_call_76DE
    bit  0,b
    jr   z,intro_call_76E4
    add  a,$10
intro_call_76E4
    ld   (hl),a
    inc  hl
    inc  hl
    djnz intro_call_76CD
    set  3,(ix+$00)
    ld   hl,l_eb97
    ld   (hl),$3C
    jp   intro_call_775A
intro_call_76F5
    ld   a,(l_e64a)
    inc  a
    cp   $05
    jr   c,intro_call_76FF
    ld   a,$05
intro_call_76FF
    ld   b,$08
    call call_0DB1
    ld   c,l
    ld   b,$04
    ld   l,(ix+$01)
    ld   h,(ix+$02)
intro_call_770D
    ld   (hl),$14
    ld   a,b
    cp   $03
    jr   nc,intro_call_7716
    ld   (hl),$04
intro_call_7716
    inc  hl
    inc  hl
    ld   a,$F0
    sub  c
    bit  0,b
    jr   z,intro_call_7721
    add  a,$10
intro_call_7721
    ld   (hl),a
    inc  hl
    inc  hl
    djnz intro_call_770D
    set  3,(ix+$00)
    ld   hl,l_eb97
    ld   (hl),$3C
    jp   intro_call_775A
intro_call_7732
    ld   hl,l_eb97
    ld   a,(hl)
    or   a
    jp   nz,intro_call_775A
    ld   a,(l_eb56)
    and  a
    jr   nz,intro_call_7745
    call call_32E0
    jr   intro_call_7748
intro_call_7745
    call call_32F4
intro_call_7748
    call intro_call_7969
    set  2,(ix+$00)
    ld   l,(ix+$01)
    ld   h,(ix+$02)
    ld   b,$04
    jp   intro_call_7648
intro_call_775A
   ;break
    ld   e,(ix+$05)
    ld   b,$04
    ld   hl,intro_data_7866
    ld   c,$25
    call call_14C0     ;draw 32 x 32 sprites using data at HL
intro_call_7767
    ld   de,$0006
    add  ix,de
    pop  de
    inc  de
    pop  af
    inc  a
    cp   $06
    jp   nz,intro_call_75B3
    ret
intro_data_7776
	defb $02,$04,$02,$03,$02,$01,$02,$01
	defb $02,$03,$02,$04
intro_call_7782
	nextreg $43,%10100000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    inc  (ix+$03)
    ld   a,(ix+$03)
    cp   $05
    ret  nz
    ld   (ix+$03),$00
    inc  (ix+$02)
    bit  0,(ix+$02)
    jr   nz,intro_call_77AF
	
    nextreg $40,$9b                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$FC		 ;reset logo palette cycle to original colour
    ;ld   de,$00FF			;TODO - Palette
;    ld   ($F936),de
	nextreg $40,$ab                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$FC		 ;reset logo palette cycle to original colour
;    ld   ($F956),de
	;nextreg $43,%10100000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    nextreg $40,$90                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$FF		 ;reset logo palette cycle to original colour
;    ld   de,$F0FF
;    ld   ($F920),de
	nextreg $40,$A0                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$FF		 ;reset logo palette cycle to original colour
;    ld   ($F940),de
    ret
intro_call_77AF
	nextreg $40,$9b                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$F0		 ;reset logo palette cycle to original colour
    ;ld   de,$00F8
;    ld   ($F936),de		;TODO - Palette
	nextreg $40,$ab                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$F0		 ;reset logo palette cycle to original colour
;    ld   ($F956),de
	nextreg $40,$90                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$FC		 ;reset logo palette cycle to original colour
    ;ld   de,$00FF
    ;ld   ($F920),de
	nextreg $40,$a0                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$FC		 ;reset logo palette cycle to original colour
    ;ld   ($F940),de
    ret
intro_call_77C6
    ld   a,(l_eb98)
    and  a
    ret  z
    ld   a,(l_eb56)
    and  a
    jr   nz,intro_call_77EE
    ;ld   hl,$D61A
    ;ld   de,intro_bank1_data_8CCA
    ;ld   bc,$040E
    ;ld   a,$27
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8CCA
	ld	 de,$0420
	ld	 bc,$0E90		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ;ld   hl,$D9DA
    ;ld   de,intro_bank1_data_8D02
    ;ld   bc,$0408
    ;ld   a,$26
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_8D02
	ld	 de,$0498
	ld	 bc,$0890		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_call_77EE
    ;ld   hl,$D61A
    ;ld   de,intro_bank1_data_8CCA
    ;ld   bc,$040E
    ;ld   a,$2B
	ld   a,gfxbank23+1
	ld   hl,intro_bank1_data_8CCA
	ld	 de,$0420
	ld	 bc,$0EA0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ;ld   hl,$D9DA
    ;ld   de,intro_bank1_data_8D22
    ;ld   bc,$0408
    ;ld   a,$2A
	ld   a,gfxbank23
	ld   hl,intro_bank1_data_8D22
	ld	 de,$0498
	ld	 bc,$08A0		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
   ret
intro_call_780B
    ;ld   hl,$D55A
    ;ld   de,intro_data_786B
    ;ld   bc,$0705
    ;ld   a,$00
	ld   a,gfxbank00
	ld   hl,intro_data_786B
	ld	 de,$0708
	ld	 bc,$0500		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ;ld   hl,$D69A
    ;ld   de,intro_data_786B
    ;ld   bc,$0705
    ;ld   a,$00
	ld   a,gfxbank00
	ld   hl,intro_data_786B
	ld	 de,$0730
	ld	 bc,$0590		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ;ld   hl,$D7DA
    ;ld   de,intro_data_786B
    ;ld   bc,$0705
    ;ld   a,$00
	ld   a,gfxbank00
	ld   hl,intro_data_786B
	ld	 de,$0758
	ld	 bc,$0500		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ;ld   hl,$D91A
    ;ld   de,intro_data_786B
    ;ld   bc,$0705
    ;ld   a,$00
	ld   a,gfxbank00
	ld   hl,intro_data_786B
	ld	 de,$0780
	ld	 bc,$0500		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ;ld   hl,$DA5A
    ;ld   de,intro_data_786B
    ;ld   bc,$0705
    ;ld   a,$00
	ld   a,gfxbank00
	ld   hl,intro_data_786B
	ld	 de,$07A8
	ld	 bc,$0500		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ;ld   hl,$DB9A
    ;ld   de,intro_data_786B
    ;ld   bc,$0705
    ;ld   a,$00
	ld   a,gfxbank00
	ld   hl,intro_data_786B
	ld	 de,$07D0
	ld	 bc,$0500		;b=number of columns - c=colour
	call extend_0EC6
;    call $0EC6
    ret
intro_data_7860
	defb $08,$30,$58,$80,$A8,$D0
intro_data_7866
	defb $B8,$BC,$C0,$C4,$C8

intro_data_786B
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00
intro_call_788E
    ld   hl,(l_eb65)
    ld   a,(hl)
    cp   $99
    ret  z
    cp   $88
    jr   nz,intro_call_78A6
    ld   hl,l_eb67
    ld   (hl),$00
    ld   hl,l_eb6e
    ld   (hl),$00
    jp   intro_call_78F1
intro_call_78A6
    or   a
    jr   z,intro_call_78B4
    ld   hl,l_eb56
    bit  0,(hl)
    jr   nz,intro_call_78B4
    ld   b,a
    ld   a,$20
    sub  b
intro_call_78B4
    call call_109C
    ld   a,(l_eb67)
    call call_0D84
    ld   a,(de)
    ld   b,a
    ld   hl,(l_eb69)
    bit  0,b
    jr   z,intro_call_78CE
    bit  3,b
    jr   nz,intro_call_78CD
    inc  (hl)
    jr   intro_call_78CE
intro_call_78CD
    dec  (hl)
intro_call_78CE
    bit  4,b
    jr   z,intro_call_78DC
    inc  hl
    inc  hl
    bit  7,b
    jr   nz,intro_call_78DB
    inc  (hl)
    jr   intro_call_78DC
intro_call_78DB
    dec  (hl)
intro_call_78DC
    ld   hl,l_eb67
    inc  (hl)
    inc  de
    ld   a,(de)
    cp   $88
    jr   z,intro_call_78E7
    ret
intro_call_78E7
    ld   hl,l_eb67
    ld   (hl),$00
    ld   hl,l_eb68
    dec  (hl)
    ret  nz
intro_call_78F1
    ld   hl,(l_eb65)
    inc  hl
    inc  hl
    ld   (l_eb65),hl
    inc  hl
    ld   a,(hl)
    ld   (l_eb68),a
    inc  a
    ret
intro_call_7900
    inc  (hl)
    ld   a,(hl)
    cp   d
    jp   nz,intro_call_7911
    ld   (hl),$00
    ld   a,(bc)
    inc  a
    ld   (bc),a
    ld   a,(bc)
    cp   e
    ret  nz
    xor  a
    ld   (bc),a
    ret
intro_call_7911
    ld   a,(bc)
    ret
intro_call_7913
	;call $029B
    call call_18BB
    ld   hl,l_ed3d
    ld   (hl),$00
    call call_0431
    ld   iy,l_fca5
    bit  4,(iy-$20)
    nop
    nop
    call call_03CB
    call call_02AC
    call call_02E4
    ;call call_0B30
	
	nextreg $40,$9b      ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$DC		 ;reset palette to original colour
	nextreg $40,$ab      ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$1B		 ;reset palette to original colour
    nextreg $40,$90      ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$FF		 ;reset palette to original colour
	nextreg $40,$A0      ; (R/W) 0x40 (64) => Palette Index
	nextreg $44,$A2		 ;reset palette to original colour
	nextreg $44,$01		 ;reset palette to original colour
	
;    ld   hl,$D500
;    ld   b,$20
;intro_call_793C
;    push bc
;    push hl
    ;call $03FD		clear screen
;    pop  hl
;    pop  bc
;    inc  hl
;    inc  hl
;    djnz intro_call_793C
	
	call layer2_update_palette_ret		;this clears the layer 2 screen
	
intro_call_7947	
	call call_0020
    ld   hl,l_e358
    ld   (hl),$00
    ld   c,$30
    call call_1350
    call call_0427
    ld   hl,l_e357
    ld   (hl),$01
    ld   hl,l_e737
    ld   (hl),$00
    ld   hl,l_e342
    ld   (hl),$01	
	ld   a,$02
    call call_0010
    
	ret
	
	
	
	
	
	
	;ret
	
;stopit
;	jp stopit
;    call call_0018
intro_call_7969
	ld   hl,$D53A
    ld   b,$20
intro_call_796E
;	ld   (hl),$05
 ;   inc  hl
 ;   ld   (hl),$00
    ld   a,$3F
    call call_0D89
    djnz intro_call_796E
intro_call_797A
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,intro_call_79A1
    ld   hl,l_e645
    ld   a,(hl)
    or   a
    jr   z,intro_call_79A1
    jp   m,intro_call_79A1
    cp   $05
    jr   c,intro_call_7991
    ld   a,$05
intro_call_7991
    ld   b,a
    ld   hl,$D53A
intro_call_7995
 ;   ld   (hl),$AB
 ;   inc  hl
 ;   ld   (hl),$1C
    ld   a,$3F
    call call_0D89
    djnz intro_call_7995
intro_call_79A1
	ld   hl,l_e5d7
    bit  1,(hl)
    ret  z
    ld   hl,l_e64a
    ld   a,(hl)
    or   a
    ret  z
    ret  m
    cp   $05
    jr   c,intro_call_79B4
    ld   a,$05
intro_call_79B4
    ld   b,a
    ld   hl,$DCFA
intro_call_79B8
 ;   ld   (hl),$AC
 ;   inc  hl
 ;   ld   (hl),$1C
    or   a
    ld   de,$0041
    sbc  hl,de
    djnz intro_call_79B8
    ret
intro_data_79C6
	defb $01,$01,$02,$02,$03,$01,$05,$01,$08,$02,$00,$01,$08,$02,$00,$01
	defb $10,$01,$88,$00,$08,$02,$10,$01,$08,$02,$0B,$01,$0D,$01,$0E,$02
	defb $0F,$01,$99,$21,$99,$EB

	
intro_bank1_data_849E
    defb $00,$01,$02,$02,$02,$02,$02,$02,$03,$04,$05,$05
	defb $06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$08,$09
	defb $00,$10,$11,$12,$13,$14,$15,$16,$17,$18,$11,$19
	defb $06,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$14,$0F,$22
	defb $00,$01,$23,$24,$25,$20,$26,$1B,$27,$28,$0B,$0A
	defb $06,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$0F,$0E,$31
	defb $00,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$0A,$22
	defb $06,$07,$0B,$3B,$3A,$1C,$1B,$3C,$3D,$3E,$31,$18
	defb $00,$01,$0E,$0F,$0E
    defb $0F,$0E,$3F,$40,$0A,$22,$41,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E
    defb $0F,$08,$09,$00,$10,$11,$12,$13,$14,$15,$16,$17,$18,$11,$19,$06
    defb $1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$14,$0F,$22,$00,$01,$23,$24,$25
    defb $20,$26,$1B,$27,$28,$0B,$0A,$06,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30
    defb $0F,$0E,$31,$00,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$0A,$22,$06
    defb $07,$0B,$3B,$3A,$1C,$1B,$3C,$3D,$3E,$31,$18,$00,$01,$0E,$0F,$0E
    defb $0F,$0E,$3F,$40,$0A,$22,$41,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E
    defb $0F,$08,$09,$00,$01,$11,$12,$13,$14,$15,$16,$17,$18,$11,$19,$06
    defb $07,$1B,$1C,$1D,$1E,$1F,$20,$21,$14,$0F,$22,$00,$01,$23,$24,$25
    defb $20,$26,$1B,$27,$28,$0B,$0A,$06,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30
    defb $0F,$0E,$31,$00,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$0A,$22,$06
    defb $07,$0B,$3B,$3A,$1C,$1B,$3C,$3D,$3E,$31,$18,$00,$01,$0E,$0F,$0E
    defb $0F,$0E,$3F,$40,$0A,$22,$41,$06,$07,$02,$02,$02,$02,$02,$02,$42
    defb $0F,$05,$05

intro_bank1_data_85D6
    defb $43,$44,$45,$45,$45,$45,$45,$46,$47,$48,$49,$45,$4A
    defb $4B,$43,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$4C,$54,$55,$56,$57,$58
    defb $59,$5A,$5B,$5C,$5D,$56,$5E,$5F,$60,$54,$61,$62,$63,$64,$65,$66
    defb $59,$67,$68,$69,$4B,$6A,$6B,$6C,$65,$6D,$54,$6E,$6F,$4E,$4D,$70
    defb $4F,$71,$72,$73,$74,$75,$76,$77,$67,$78,$79,$5F,$5A,$7A,$7B,$7C
    defb $7D,$7E,$7F,$69,$80,$4D,$68,$56,$4B,$4E,$4A,$80,$61,$54,$81,$82
    defb $83,$79,$70,$84,$85,$86,$67,$78,$67,$78,$87,$88,$4D,$68,$89,$4A
    defb $8A,$8B,$4C,$4D,$4E,$4F,$8C,$78,$67,$43,$4C,$54,$8D,$8E,$57,$58
    defb $59,$5A,$8F,$90,$70,$56,$5E,$5F,$60,$54,$61,$62,$63,$64,$65,$66
    defb $59,$67,$68,$69,$4B,$6A,$6B,$6C,$65,$6D,$54,$6E,$6F,$4E,$4D,$70
    defb $4F,$71,$72,$73,$74,$75,$76,$77,$67,$78,$79,$5F,$5A,$7A,$7B,$7C
    defb $7D,$7E,$7F,$69,$80,$4D,$68,$56,$91,$92,$4A,$80,$61,$54,$81,$82
    defb $83,$79,$70,$84,$93,$94,$67,$78,$67,$78,$87,$88,$4D,$68,$89,$4A
    defb $95,$96,$4C,$4D,$4E,$4F,$8C,$78,$67,$43,$4C,$54,$55,$56,$57,$58
    defb $59,$5A,$8F,$90,$70,$56,$5E,$5F,$60,$54,$61,$62,$63,$64,$65,$66
    defb $59,$67,$68,$69,$4B,$6A,$6B,$6C,$65,$6D,$54,$6E,$6F,$4E,$4D,$70
    defb $4F,$71,$72,$73,$74,$75,$76,$77,$67,$78,$79,$5F,$5A,$7A,$7B,$7C
    defb $7D,$7E,$7F,$69,$80,$4D,$68,$56,$4B,$4E,$4A,$80,$61,$54,$81,$82
    defb $83,$79,$70,$84,$8C,$78,$67,$78,$67,$78,$87,$97,$4B,$68,$89,$98
    defb $99,$45,$45,$45,$45,$45,$46,$46,$46,$46,$45

intro_bank1_data_870E
    defb $9A,$9B,$9C,$9C,$9C
    defb $9C,$9D,$9E,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB
    defb $AC,$AD,$9E,$AE,$AF,$A7,$B0,$B1,$B2,$B3,$A6,$B4,$A0,$B5,$B6,$B7
    defb $B8,$B9,$9E,$BA,$BB,$BC,$BD,$BE,$BF,$A5,$A6,$AE,$C0,$C1,$C2,$C3
    defb $C4,$C5,$9E,$A9,$A0,$A4,$9F,$C6,$B0,$C7,$A6,$C8,$C9,$CA,$CB,$CA
    defb $CB,$9D,$9E,$9F,$CC,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$CD,$A9,$AA,$AB
    defb $AC,$AD,$9E,$AE,$AF,$A7,$B0,$B1,$B2,$B3,$A6,$B4,$A0,$B5,$B6,$B7
    defb $B8,$B9,$9E,$BA,$BB,$BC,$BD,$BE,$BF,$A5,$A6,$AE,$C0,$C1,$C2,$C3
    defb $C4,$C5,$9E,$A9,$CE,$CF,$9F,$C6,$B0,$C7,$A6,$C8,$D0,$D1,$CB,$CA
    defb $CB,$9D,$9E,$9F,$D2,$D3,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB
    defb $AC,$AD,$9E,$AE,$AF,$A7,$B0,$B1,$B2,$B3,$A6,$B4,$A0,$B5,$B6,$B7
    defb $B8,$B9,$9E,$BA,$BB,$BC,$BD,$BE,$BF,$A5,$A6,$AE,$C0,$C1,$C2,$C3
    defb $C4,$C5,$9E,$A9,$A0,$A4,$9F,$C6,$B0,$C7,$A6,$C8,$D4,$CA,$CB,$CA
    defb $CB,$9D,$9E,$D5,$D6,$9C,$9C,$9C,$9C,$D7,$A6
intro_bank1_data_87DE
    defb $00,$01,$02,$03,$04,$15,$16,$17,$18,$19,$30,$31,$32,$33,$34,$4E
    defb $4F,$32,$50,$51,$69,$6A,$6B,$6C,$6D,$83,$84,$85,$86,$87,$05,$05
    defb $9B,$05,$05	;8801
intro_bank1_data_8801
    defb $05,$06,$07,$08,$05,$1A,$1B,$1C,$1C,$1D,$35,$36,$37,$38,$39,$52
    defb $53,$54,$55,$56,$6E,$6F,$70,$71,$72,$88,$89,$1C,$8A,$8B,$05,$9C
    defb $9D,$9E,$05	;8824
intro_bank1_data_8824
    defb $05,$05,$09,$05,$05,$1E,$1F,$20,$21,$22,$3A,$3B,$3C,$3D,$3E,$57
    defb $58,$59,$5A,$5B,$73,$20,$74,$20,$75,$8C,$20,$8D,$20,$8E,$9F,$A0
    defb $A1,$A2,$A3	;8847
intro_bank1_data_8847
    defb $05,$0A,$0B,$0C,$05,$23,$24,$25,$25,$26,$3F,$40,$41,$42,$43,$5C
    defb $5D,$41,$5E,$5F,$76,$77,$41,$42,$78,$8F,$90,$25,$91,$92,$05,$A4
    defb $A5,$A6,$05	;886A
intro_bank1_data_886A
    defb $0D,$0E,$0F,$10,$11,$27,$28,$29,$2A,$2B,$44,$45,$46,$47,$48,$60
    defb $61,$62,$63,$64,$79,$7A,$7B,$7C,$7D,$93,$94,$29,$95,$96,$05,$05
    defb $A7,$05,$05	;888D
intro_bank1_data_888D
    defb $05,$12,$13,$14,$05,$2C,$2D,$2E,$2E,$2F,$49,$4A,$4B,$4C,$4D,$65
    defb $66,$2E,$67,$68,$7E,$7F,$80,$81,$82,$97,$98,$2E,$99,$9A,$05,$A8
    defb $A9,$AA,$05
intro_bank1_data_88B0
    defb $00,$01,$02,$03,$00,$13,$14,$15,$15,$16,$2E,$2F,$30,$31,$32,$4C
    defb $4D,$4E,$4F,$15,$66,$67,$68,$31,$69,$7F,$80,$15,$15,$81,$00,$92
    defb $93,$94,$00	;88D3
intro_bank1_data_88D3
    defb $00,$04,$05,$06,$00,$17,$18,$19,$1A,$1B,$33,$34,$35,$36,$37,$50
    defb $51,$52,$53,$54,$6A,$6B,$6C,$6D,$6E,$82,$19,$19,$83,$84,$00,$95
    defb $96,$97,$00	;88F6
intro_bank1_data_88F6
    defb $00,$07,$08,$09,$00,$1C,$1D,$1E,$1E,$1F,$38,$39,$3A,$3B,$3C,$55
    defb $1E,$56,$1E,$57,$6F,$1E,$70,$1E,$71,$85,$86,$1E,$87,$88,$00,$98
    defb $99,$9A,$00	;8919
intro_bank1_data_8919
    defb $00,$0A,$0B,$0C,$00,$20,$21,$22,$23,$24,$3D,$3E,$3F,$40,$41,$58
    defb $59,$3F,$5A,$5B,$72,$73,$3F,$40,$74,$89,$22,$22,$8A,$8B,$00,$9B
    defb $9C,$9D,$00	;893C
intro_bank1_data_893C
    defb $00,$0D,$0E,$0F,$00,$25,$26,$27,$27,$28,$42,$43,$44,$45,$46,$5C
    defb $5D,$5E,$5F,$60,$75,$76,$77,$78,$79,$8C,$8D,$27,$27,$8E,$00,$9E
    defb $9F,$A0,$00	;895F
intro_bank1_data_895F
    defb $00,$10,$11,$12,$00,$29,$2A,$2B,$2C,$2D,$47,$48,$49,$4A,$4B,$61
    defb $62,$63,$64,$65,$7A,$7B,$7C,$7D,$7E,$8F,$2B,$2B,$90,$91,$A1,$A2
    defb $A3,$A4,$00
intro_bank1_data_8982
    defb $00,$00,$01,$00,$00,$11,$12,$13,$14,$15,$2F,$30,$31,$32,$33,$4D
    defb $4E,$4F,$50,$51,$69,$6A,$4F,$6B,$6C,$82,$83,$84,$85,$86,$95,$96
    defb $97,$98,$99	;88A5
intro_bank1_data_89A5
    defb $00,$02,$03,$04,$00,$16,$17,$18,$19,$1A,$34,$35,$36,$37,$38,$52
    defb $53,$54,$55,$56,$6D,$6E,$6F,$70,$71,$87,$18,$18,$18,$88,$00,$9A
    defb $9B,$9C,$00	;89C8
intro_bank1_data_89C8
    defb $05,$06,$07,$08,$09,$1B,$1C,$1D,$1E,$1F,$39,$3A,$3B,$3C,$3D,$57
    defb $58,$59,$58,$5A,$72,$58,$73,$58,$74,$89,$8A,$58,$8B,$8C,$00,$00
    defb $9D,$00,$00	;89EB
intro_bank1_data_89EB
    defb $00,$0A,$0B,$0C,$00,$20,$21,$22,$23,$24,$3E,$3F,$40,$41,$42,$5B
    defb $5C,$40,$5D,$5E,$75,$76,$40,$41,$77,$8D,$22,$22,$22,$8E,$00,$9E
    defb $9F,$A0,$00	;8A0E
intro_bank1_data_8A0E
    defb $00,$00,$0D,$00,$00,$25,$26,$27,$28,$29,$43,$44,$45,$46,$47,$5F
    defb $60,$61,$62,$63,$78,$79,$7A,$7B,$7C,$8F,$90,$27,$91,$92,$A1,$A2
    defb $A3,$A4,$A5	;8A31
intro_bank1_data_8A31
    defb $00,$0E,$0F,$10,$00,$2A,$2B,$2C,$2D,$2E,$48,$49,$4A,$4B,$4C,$64
    defb $65,$66,$67,$68,$7D,$7E,$7F,$80,$81,$93,$2C,$2C,$2C,$94,$00,$A6
    defb $A7,$A8,$00
intro_bank1_data_8A54
    defb $00,$00,$01,$00,$00,$00,$02,$03,$04,$00,$05,$06,$07,$08,$09,$00,$0A,$0B,$0C,$00,$00,$00,$0D,$00,$00,$00,$0E,$0F,$10,$00
    defb $11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E
	defb $2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C
	defb $4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$58,$5A,$5B,$5C,$40,$5D,$5E,$5F,$60,$61,$62,$63,$64,$65,$66,$67,$68
	defb $69,$6A,$4F,$6B,$6C,$6D,$6E,$6F,$70,$71,$72,$58,$73,$58,$74,$75,$76,$40,$41,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,$80,$81
	defb $82,$83,$84,$85,$86,$87,$18,$18,$18,$88,$89,$8A,$58,$8B,$8C,$8D,$22,$22,$22,$8E,$8F,$90,$27,$91,$92,$93,$2C,$2C,$2C,$94
	defb $95,$96,$97,$98,$99,$00,$9A,$9B,$9C,$00,$00,$00,$9D,$00,$00,$00,$9E,$9F,$A0,$00,$A1,$A2,$A3,$A4,$A5,$00,$A6,$A7,$A8,$00 
intro_bank1_data_8B26
    defb $00,$01,$02,$01,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$01
    defb $1D,$1E,$1F,$01,$2F,$30,$1E,$0C,$31,$3F,$40,$41,$42,$43,$44,$01
    defb $45,$01,$01	;8B49
intro_bank1_data_8B49
    defb $00,$01,$02,$01,$03,$04,$05,$06,$07,$08,$09,$0E,$0F,$10,$0D,$01
    defb $20,$21,$22,$01,$2F,$32,$33,$34,$31,$3F,$40,$41,$42,$43,$44,$01
    defb $45,$01,$01	;8B6C
intro_bank1_data_8B6C
    defb $00,$01,$02,$01,$03,$04,$05,$06,$07,$08,$09,$11,$12,$13,$0D,$01
    defb $23,$24,$25,$01,$2F,$35,$36,$37,$31,$3F,$40,$41,$42,$43,$44,$01
    defb $45,$01,$01	;8B8F
intro_bank1_data_8B8F
    defb $00,$01,$02,$01,$03,$04,$05,$06,$07,$08,$09,$14,$15,$16,$0D,$01
    defb $26,$27,$28,$01,$2F,$38,$27,$16,$31,$3F,$40,$41,$42,$43,$44,$01
    defb $45,$01,$01	;8BB2
intro_bank1_data_8BB2
    defb $00,$01,$02,$01,$03,$04,$05,$06,$07,$08,$09,$17,$18,$19,$0D,$01
    defb $29,$2A,$2B,$01,$2F,$39,$3A,$3B,$31,$3F,$40,$41,$42,$43,$44,$01
    defb $45,$01,$01	;8BD5
intro_bank1_data_8BD5
    defb $00,$01,$02,$01,$03,$04,$05,$06,$07,$08,$09,$1A,$1B,$1C,$0D,$01
    defb $2C,$2D,$2E,$01,$2F,$3C,$3D,$3E,$31,$3F,$40,$41,$42,$43,$44,$01
    defb $45,$01,$01
intro_bank1_data_8BF8
    defb $46,$47,$48,$47,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$47
    defb $63,$64,$65,$47,$75,$76,$64,$52,$77,$84,$85,$86,$87,$88,$89,$47
    defb $8A,$47,$47	;8C1B
intro_bank1_data_8C1B
    defb $46,$47,$48,$47,$49,$4A,$4B,$4C,$4D,$4E,$4F,$54,$55,$56,$53,$47
    defb $66,$67,$68,$47,$75,$78,$79,$7A,$77,$84,$85,$86,$87,$88,$89,$47
    defb $8A,$47,$47	;8C3E
intro_bank1_data_8C3E
    defb $46,$47,$48,$47,$49,$4A,$4B,$4C,$4D,$4E,$4F,$57,$58,$59,$53,$47
    defb $69,$6A,$6B,$47,$75,$7B,$7C,$47,$77,$84,$85,$86,$87,$88,$89,$47
    defb $8A,$47,$47	;8C61
intro_bank1_data_8C61
    defb $46,$47,$48,$47,$49,$4A,$4B,$4C,$4D,$4E,$4F,$5A,$5B,$5C,$53,$47
    defb $6C,$6D,$6E,$47,$75,$7D,$6D,$5C,$77,$84,$85,$86,$87,$88,$89,$47
    defb $8A,$47,$47	;8C84
intro_bank1_data_8C84
    defb $46,$47,$48,$47,$49,$4A,$4B,$4C,$4D,$4E,$4F,$5D,$5E,$5F,$53,$47
    defb $6F,$70,$71,$47,$75,$7E,$7F,$80,$77,$84,$85,$86,$87,$88,$89,$47
    defb $8A,$47,$47	;8CA7
intro_bank1_data_8CA7
    defb $46,$47,$48,$47,$49,$4A,$4B,$4C,$4D,$4E,$4F,$60,$61,$62,$53,$47
    defb $72,$73,$74,$47,$75,$81,$82,$83,$77,$84,$85,$86,$87,$88,$89,$47
    defb $8A,$47,$47	;8CCA
intro_bank1_data_8CCA	;WELL DONE 
    defb $8B,$8C,$8F,$90,$93,$94,$97,$98,$9B,$9C,$9F,$A0,$A3,$A4,$8D,$8E
    defb $91,$92,$95,$96,$99,$9A,$9D,$9E,$A1,$A2,$A5,$A6,$AB,$AC,$AF,$B0
    defb $B3,$B4,$B7,$B8,$BB,$BC,$BF,$C0,$C3,$C4,$AD,$AE,$B1,$B2,$B5,$B6
    defb $B9,$BA,$BD,$BE,$C1,$C2,$C5,$C6
intro_bank1_data_8D02	;1UP
    defb $A9,$AA,$AD,$AE,$B1,$B2,$B5,$B6,$AB,$AC,$AF,$B0,$B3,$B4,$B7,$B8
    defb $B9,$BA,$BD,$BE,$C1,$C2,$C5,$C6,$BB,$BC,$BF,$C0,$C3,$C4,$C7,$C8
intro_bank1_data_8D22	;2UP
    defb $C9,$CA,$CD,$CE,$D1,$D2,$D5,$D6,$CB,$CC,$CF,$D0,$D3,$D4,$D7,$D8
    defb $D9,$DA,$DD,$DE,$E1,$E2,$E5,$E6,$DB,$DC,$DF,$E0,$E3,$E4,$E7,$E8	;8D42



intro_call_B391
    ld   hl,l_f359
    ld   bc,$0009
    jp   call_0D50
	
intro_call_B3B5
    call call_0431
    ;ld   hl,$F960
    ;ld   bc,$0020
    ;call call_0D50 
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tiles
    nextreg $40, $B0                  ; (R/W) 0x40 (64) => Palette Index
    ld   b,$10
intro_call_B3B5_loop
	nextreg $44,$00
	nextreg $44,$00
	djnz intro_call_B3B5_loop
	nextreg $40, $11                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $44,$00
	nextreg $44,$00
    call call_02D6
    call call_0020
    ld   hl,$76F8;CD08
    ld   de,intro_data_B3F2
    ld   bc,$1A0C
    ;ld   a,$2D
    ;call call_0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
    ld   hl,$76F8+$18;$D008
    ld   de,intro_data_B52A
    ld   bc,$1A0C
    ;ld   a,$2D
    ;call call_0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
    ld   hl,$76F8+$18+$18;$D308
    ld   de,intro_data_B662
    ld   bc,$1A08
    ;ld   a,$2E
    ;call call_0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tiles
    jp   call_0427
intro_data_B3F2
	defb $00,$01,$02,$03,$04,$05,$06,$03,$04,$05,$06,$07,$08,$09,$0A,$0B
	defb $0C,$0D,$0E,$0B,$0C,$0D,$0E,$0C,$0F,$10,$11,$12,$13,$14,$15,$0F
	defb $10,$11,$0B,$16,$14,$17,$18,$19,$1A,$1B,$1C,$14,$17,$18,$1D,$1E
	defb $1F,$20,$21,$22,$23,$05,$06,$1F,$20,$21,$03,$04,$24,$25,$07,$12
	defb $26,$0D,$0E,$24,$25,$07,$0B,$0C,$27,$28,$29,$0B,$16,$14,$15,$27
	defb $28,$29,$0B,$16,$2A,$2B,$2C,$1D,$1E,$1B,$1C,$2A,$2B,$2C,$1D,$1E
	defb $00,$01,$02,$03,$04,$05,$06,$00,$01,$02,$03,$04,$08,$09,$0A,$0B
	defb $0C,$0D,$0E,$08,$09,$0A,$0B,$0C,$16,$14,$15,$2D,$16,$14,$15,$2D
	defb $29,$0B,$16,$14,$1E,$1B,$1C,$2E,$1E,$1B,$1C,$2E,$2C,$1D,$1E,$1B
	defb $04,$05,$06,$07,$04,$05,$06,$07,$02,$03,$04,$05,$0C,$0D,$0E,$0C
	defb $0C,$0D,$0E,$0C,$0A,$0B,$0C,$0D,$2F,$30,$31,$32,$33,$34,$35,$2F
	defb $30,$31,$32,$33,$36,$34,$35,$2F,$30,$34,$35,$2F,$30,$31,$32,$33
	defb $37,$38,$39,$3A,$3B,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42
	defb $43,$40,$41,$42,$43,$44,$45,$46,$47,$30,$3F,$48,$49,$4A,$4B,$4C
	defb $4D,$3F,$48,$49,$2F,$30,$31,$32,$33,$34,$35,$2F,$30,$31,$32,$33
	defb $3A,$3B,$3C,$3D,$3E,$38,$39,$3A,$3B,$3C,$3D,$3E,$42,$43,$44,$45
	defb $46,$40,$41,$42,$43,$44,$45,$46,$4B,$47,$30,$4E,$4F,$50,$2A,$2B
	defb $2C,$1D,$1E,$51,$35,$52,$4D,$53,$54,$55,$00,$01,$02,$03,$04,$56
	defb $39,$57,$58,$59,$5A,$35,$08,$09,$0A,$0B,$0C,$00,$41,$5B,$5C,$5D
	defb $5E,$5F,$0F,$10,$11,$12,$13,$60
intro_data_B52A
	defb $61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70
	defb $71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,$79
	defb $7A,$7B,$7C,$7D,$80,$81,$82,$83,$84,$85,$86,$80,$81,$82,$83,$84
	defb $87,$88,$89,$76,$8A,$6C,$8B,$87,$88,$89,$76,$8A,$8C,$8D,$8E,$6A
	defb $8F,$78,$90,$8C,$8D,$8E,$76,$77,$79,$7A,$7B,$7C,$7D,$7E,$7F,$7C
	defb $7D,$7E,$7F,$8E,$80,$81,$82,$83,$84,$85,$86,$83,$84,$85,$86,$91
	defb $87,$88,$89,$76,$8A,$6C,$8B,$76,$8A,$6C,$8B,$92,$87,$88,$89,$76
	defb $8A,$6C,$8B,$87,$88,$89,$76,$8A,$93,$94,$95,$96,$94,$97,$93,$94
	defb $94,$97,$93,$94,$98,$62,$63,$64,$99,$9A,$98,$62,$99,$9A,$98,$62
	defb $9B,$6E,$6F,$70,$9C,$9D,$9B,$6E,$9C,$9D,$9B,$6E,$9E,$9F,$95,$A0
	defb $A1,$A2,$9E,$9F,$A1,$A2,$9E,$9F,$94,$95,$96,$A3,$A4,$97,$93,$94
	defb $95,$96,$A3,$A4,$62,$63,$64,$65,$66,$9A,$98,$62,$63,$64,$65,$66
	defb $6E,$6F,$70,$71,$72,$9D,$9B,$6E,$6F,$70,$71,$72,$9F,$95,$A0,$A5
	defb $A6,$A2,$9E,$9F,$95,$A0,$A5,$A6,$94,$95,$99,$A7,$A8,$97,$93,$A9
	defb $AA,$99,$A7,$A8,$62,$63,$AB,$AC,$AD,$9A,$98,$AE,$AF,$AB,$AC,$AD
	defb $6E,$6F,$B0,$B1,$9E,$9D,$9B,$B2,$B3,$B0,$B1,$9E,$9F,$95,$B4,$B5
	defb $B6,$A2,$9E,$B7,$AA,$B4,$B5,$B6,$94,$97,$93,$94,$95,$97,$93,$94
	defb $95,$96,$A3,$A4,$99,$9A,$98,$62,$63,$9A,$98,$62,$63,$64,$65,$66
	defb $9C,$9D,$9B,$6E,$6F,$9D,$9B,$6E,$6F,$70,$71,$72,$A1,$A2,$9E,$9F
	defb $95,$A2,$9E,$9F,$95,$A0,$A5,$A6
intro_data_B662
	defb $00,$01,$02,$03,$00,$04,$05,$06,$07,$08,$09,$0A,$07,$0B,$0C,$0D
	defb $0E,$0F,$10,$11,$12,$13,$14,$0E,$10,$15,$16,$17,$18,$19,$1A,$10
	defb $1B,$01,$02,$1C,$1D,$1E,$1F,$1B,$20,$08,$09,$21,$12,$22,$23,$20
	defb $24,$0F,$10,$25,$07,$26,$27,$24,$28,$15,$16,$29,$2A,$2B,$2C,$28
	defb $06,$01,$02,$03,$00,$04,$05,$06,$0D,$08,$09,$0A,$07,$0B,$0C,$0D
	defb $2D,$0F,$10,$25,$2D,$0F,$10,$25,$2E,$15,$16,$29,$2E,$15,$16,$29
	defb $22,$01,$02,$03,$22,$01,$02,$03,$0A,$08,$09,$0A,$0A,$08,$09,$0A
	defb $2F,$30,$31,$32,$33,$34,$35,$2F,$2F,$30,$31,$35,$2F,$30,$31,$36
	defb $37,$38,$39,$3A,$37,$38,$39,$3B,$3C,$3D,$3E,$3F,$3C,$3D,$3E,$40
	defb $41,$42,$43,$44,$45,$40,$35,$46,$2F,$30,$31,$32,$33,$34,$35,$2F
	defb $37,$38,$39,$47,$48,$49,$3A,$37,$3C,$3D,$3E,$4A,$4B,$4C,$3F,$3C
	defb $2C,$28,$4D,$4E,$4F,$35,$46,$42,$05,$06,$50,$51,$52,$53,$54,$30
	defb $0C,$0D,$30,$55,$56,$57,$58,$38,$14,$0E,$59,$5A,$5B,$5C,$5D,$3D
	
	
intro_call_B738				;error caused by this call
    ld   a,(l_f35b)
    bit  0,a
    jp   nz,intro_call_B789
    bit  1,a
    jp   nz,intro_call_B7C5
    ld   hl,l_f359
    inc  (hl)
    ld   a,(hl)
    cp   $0A
    ret  nz
    ld   (hl),$00
    inc  hl
    inc  (hl)
    ld   a,(hl)
    cp   $0A
    jr   z,intro_call_B779
    add  a,a
    ld   l,a
    add  a,a
    add  a,l
    ld   hl,intro_data_B83C
intro_call_B75D
    call call_0D89
    ;ld   e,(hl)
    ;inc  hl
    ;ld   d,(hl)
    ;inc  hl
	nextreg $40,$B0
	call call_0B30_update_entry
    ;ld   ($F960),de   
    ;ld   e,(hl)
    ;inc  hl
    ;ld   d,(hl)
    ;inc  hl
    ;ld   ($F96E),de   
	nextreg $40,$B7
	call call_0B30_update_entry
    ;ld   e,(hl)
    ;inc  hl
    ;ld   d,(hl)
    ;inc  hl
    ;ld   ($F968),de  
	nextreg $40,$B4
	call call_0B30_update_entry
    ret
intro_call_B779
    ld   hl,l_f359
    ld   (hl),$09
    ld   hl,l_f35a
    ld   (hl),$00
    ld   hl,l_f35b
    ld   (hl),$01
    ret
intro_call_B789
    ld   hl,l_f359
    inc  (hl)
    ld   a,(hl)
    cp   $0A
    ret  nz
    ld   (hl),$00
    inc  hl
    inc  (hl)
    ld   a,(hl)
    cp   $0A
    jr   nz,intro_call_B79C
    xor  a
    ld   (hl),a
intro_call_B79C
    add  a,a
    ld   l,a
    add  a,a
    add  a,l
    ld   hl,intro_data_B800
    call intro_call_B75D
    ld   e,$A2
    ld   a,(l_e5d8)
    and  a
    jr   nz,intro_call_B7B0
    ld   e,$31
intro_call_B7B0
    ld   a,(l_e5c4)
    cp   e
    ret  c
    ld   hl,l_f359
    ld   (hl),$00
    ld   hl,l_f35a
    ld   (hl),$00
    ld   hl,l_f35b
    ld   (hl),$02
    ret
intro_call_B7C5				;more specifically - it is this routine that crashes
    ld   hl,l_f359
    inc  (hl)
    ld   a,(hl)
    cp   $14
    ret  nz
    ld   (hl),$00
	push bc
	nextreg $40,$b0
	ld bc,$243b				;register select
	ld a,$41				;8 bit colour
	out (c),a
	ld bc,$253b
    ;ld   hl,l_f960			;TODO - Palette - Reads Don't work on emulation - hopefully on real hardware
    call intro_call_B7DE
	nextreg $40,$b7
	ld bc,$243b
	ld a,$41
	out (c),a
	ld bc,$253b
    ;d   hl,l_f96e			;TODO - Palette - Reads Don't work on emulation - hopefully on real hardware
    call intro_call_B7DE
	nextreg $40,$b4
	ld bc,$243b
	ld a,$41
	out (c),a
	ld bc,$253b
    ;ld   hl,l_f968			;TODO - Palette - Reads Don't work on emulation - hopefully on real hardware
	call intro_call_B7DE
	pop bc
	ret
intro_call_B7DE
    ;ld   a,(hl)
	in a,(c)
	ld d,0
    and  $1c;$03				;check green
    jr   z,intro_call_B7E5
	call call_0D66				;div 4
    dec  a
	call call_0D6F				;mul 4
    ;ld   (hl),a
	;out (c),a
	ld d,a
intro_call_B7E5
    ;ld   a,(hl)
	in a,(c)
	ld e,0
    and  $e0;1c					;check red
    jr   z,intro_call_B7F2
    call call_0D60				;div 32
    dec  a
    call call_0D6C				;mul 32
    ;ld   (hl),a
	;out (c),a
	ld e,a
intro_call_B7F2
    ;ld   a,(hl)
	in a,(c)
    and  $03
    jr z,intro_call_B7F2_2
    dec  a
    ;ld   (hl),a
intro_call_B7F2_2
	or d
	or e
	;ld a,255
	out (c),a
	;nextreg $44,a
	;nextreg $44,0
    ret

intro_data_B800
	defb $00,$00,$00,$00,$80,$F0,$07,$D0,$00,$50,$60,$D0,$08,$F0,$03,$70
	defb $40,$B0,$0B,$F0,$05,$B0,$00,$90,$08,$F0,$07,$D0,$00,$50,$00,$00
	defb $09,$F0,$00,$00,$08,$F0,$07,$D0,$00,$50,$0B,$F0,$05,$B0,$00,$90
	defb $08,$F0,$03,$70,$40,$B0,$07,$D0,$00,$50,$60,$D0
intro_data_B83C
	defb $02,$60,$00,$20,$00,$00,$03,$70,$01,$30,$00,$10,$04,$80,$01,$40
	defb $00,$20,$05,$90,$02,$50,$00,$30,$06,$A0,$02,$60,$00,$40,$07,$B0
	defb $03,$70,$00,$50,$08,$C0,$03,$80,$00,$60,$09,$D0,$04,$90,$00,$70
	defb $0A,$E0,$04,$A0,$00,$80,$0B,$F0,$05,$B0,$00,$90


Write_Layer2_Num
	call call_1028
	
	di
	
	ld 	(oldstack),sp
	ld sp,$FF00				;space at end of this bank
	
	push bc
	push af
	
	ld bc,$123B		;now we can safely page in Layer 2 for writes
	ld a,iyh
	and $C0			;get correct bank for Layer 2
	or %00000011	;set write mode
	out (c),a
	
	ld a,iyh
	and $3f
	ld iyh,a			;mask layer 2 address with 16k bank
	
	pop af
	pop bc
	
    ld   d,c
    cp   $30
    jr   nz,Write_Layer2_Num2
    ld   a,b
    cp   $30
    jr   nz,Write_Layer2_Num1
    ld   b,$00
Write_Layer2_Num1
	xor  a
Write_Layer2_Num2
    ld	 c,0
	ld 	 l,d
	ld   d,iyh
	ld	 e,iyl
	call Layer2_Write_Char
	
	ld	 de,$0008
	add  iy,de
	ld	 a,b
	ld   d,iyh
	ld	 e,iyl
	call Layer2_Write_Char
	
	ld	 de,$0008
	add  iy,de
	ld	 a,l
	ld   d,iyh
	ld	 e,iyl
	call Layer2_Write_Char
    
	
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	ei
	
	ret

	
Write_Layer2_Text
	di				;no interrupts while writing text!
	
	ld 	(oldstack),sp
	ld sp,$FF00				;space at end of this bank
	
	push bc
	
	ld bc,$123B		;now we can safely page in Layer 2 for writes
	ld a,d
	and $C0			;get correct bank for Layer 2
	or %00000011	;set write mode
	out (c),a
	
	ld a,d
	and $3f
	ld d,a			;mask layer 2 address with 16k bank
	
	
	pop bc
	
    ;hl points to text
    ;de screen location
    ;c=colour 
;	ld de,$0000
	ld   b,(hl)		;get text length
	inc  hl
Write_Layer2_Text_Loop
	
	
	ld   a,(hl)
    ;ld   (de),a
    inc  hl
	call Layer2_Write_Char
	
	
    ;inc  de
    ;ld   a,c
	;ld   (de),a
	;inc  de
    djnz Write_Layer2_Text_Loop
	
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	ei
	ret

Layer2_Write_Char			;write a letter to Layer 2
	push hl
	push bc
	push bc
	
	
	
	ld b,$20				;32 bytes per tile in Tilemap Memory
	call call_0DB1   		;a * b - returned in HL - HL has offset for letter
	pop bc
	push bc
	ld a,c					;get bank value
	and $07
	rrca
	rrca
	rrca
	add a,$40
	ld b,a
	ld c,0
	;ld bc,$4000				;Start of tile gfx
	add hl,bc
	
	
	
	
	
	pop bc
	ld a,c
	and $F0				;isolate colour info
	ld c,a
	ld b,8
	push de
Layer2_Write_Char_Loop2
	push de
	push bc
	ld b,4
Layer2_Write_Char_Loop
	ld a,(hl)
	and $F0
	call call_0D62			;div 16
	or c
	ld (de),a
	inc de
	ld a,(hl)
	and $0F
	or c
	ld (de),a
	inc de
	inc hl
	djnz Layer2_Write_Char_Loop
	pop bc
	pop de
	inc d
	djnz Layer2_Write_Char_Loop2
	pop de
	ld hl,$0008
	add hl,de
	ex de,hl
	pop bc
	pop hl
	ret
	
	
extend_0EC6
	di
	
	call intro_get_tiles_at_8000
	
	ld 	(oldstack),sp
	ld sp,$FF00				;space at end of this bank	
	
	push bc
	
	ld bc,$123B		;now we can safely page in Layer 2 for writes
	ld a,%01000011	;set write mode
	out (c),a
	
	pop bc
	
	
	ld a,d
	ld d,0
extendl2loop2
    push bc
	push af
	push de
extendl2loop
	;ld c,$D0
	ld a,(hl)
	inc hl
	;add a,91
	;jr nc,extendl2_infirst256
	;ld c,$D1
;extendl2_infirst256
	call Layer2_Write_Char8000
	djnz extendl2loop
	pop de
	ex de,hl
	ld bc,$0800
	add hl,bc
	ex de,hl
	pop af
	pop bc
	dec a
	jr nz,extendl2loop2

	

	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	
	call intro_restore_8000
	

	
	ei
	ret
	
Layer2_Write_Char8000			;write a letter to Layer 2 from bank at address $8000
	push hl
	push bc
	push bc
	
	
	
	ld b,$20				;32 bytes per tile in Tilemap Memory
	call call_0DB1   		;a * b - returned in HL - HL has offset for letter
	pop bc
	push bc
	ld a,c					;get bank value
	and $01
	rrca
	rrca
	rrca
	add a,$80
	ld b,a
	ld c,0
	;ld bc,$4000				;Start of tile gfx
	add hl,bc
	
	
	
	
	
	
	pop bc
	ld a,c
	and $F0				;isolate colour info
	ld c,a
	ld b,8
	push de
Layer2_Write_Char8000_Loop2
	push de
	push bc
	ld b,4
Layer2_Write_Char8000_Loop
	ld a,(hl)
	and $F0
	call call_0D62			;div 16
	or c
	ld (de),a
	inc de
	ld a,(hl)
	and $0F
	or c
	ld (de),a
	inc de
	inc hl
	djnz Layer2_Write_Char8000_Loop
	pop bc
	pop de
	inc d
	djnz Layer2_Write_Char8000_Loop2
	pop de
	ld hl,$0008
	add hl,de
	ex de,hl
	pop bc
	pop hl
	ret
	
oldstack
	defw	$0000
	
	
intro_init_layer2				;set up layer 2 palette and clear screen
	di
	jr layer2_update_palette
layer2_update_palette_ret
	di
	
;	nextreg $12,$08		;ensure layer 2 points to bank 8
;	nextreg $13,$08		;ensure layer 2 shadow also points to bank 8
	
	ld bc,$123B
	ld a,%00000101	;set write mode for bank 0
	out (c),a
	ld bc,$3fff
	ld hl,$0000
	ld de,$0001
	ld (hl),$0f			;this is our transparency colour
	ldir
	ld bc,$123B
	ld a,%01000101	;set write mode for bank 1
	out (c),a
	ld bc,$3fff
	ld hl,$0000
	ld de,$0001
	ld (hl),$0f			;this is our transparency colour
	ldir
	ld bc,$123B
	ld a,%10000101	;set write mode for bank 2
	out (c),a
	ld bc,$3fff
	ld hl,$0000
	ld de,$0001
	ld (hl),$0f			;this is our transparency colour
	ldir
	
	
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ei
	ret
	
layer2_update_palette	;set the layer 2 palette
    nextreg $43,%00010000
    ld   hl,layer2_palette    ;load palette from rom bank
	nextreg $40,$00			   ;select palette entry 0
;    ld   de,l_f800
;    ld   bc,$0200
;    ldir
	ld b,0			;loop 256 times
layer2_update_palette_loop
	jr layer2_update_entry
layer2_palette_ret
	djnz layer2_update_palette_loop
	nextreg $14,$00			;set Layer 2 Transparency
    jr layer2_update_palette_ret

layer2_update_entry
	ld a,(hl)	
	ld d,a
	and $e0			;isolate red bits
	ld e,a			;store red bits in e
	ld a,d			;get original byte value
	and $0e			;isolate green bits
	add a,a			;shift left 1 bit
	or e			;add red bits
	ld d,a			;store in d
	inc hl
	ld a,(hl)		;get next byte
	ld e,a
	srl	a			;isolate 2 blue msb
	srl a
	srl a
	srl a
	srl a
	ld	e,a			;at this point copy result to e for later
	srl a
	or d			;add red and green bits to blue
	nextreg $44,a	;write to colour register
	ld a,e			;retrieve result with blue lsb in bit 0
	and 1			;isloate the blue lsb
	nextreg $44,a	;write to colour register
	inc hl
	jr layer2_palette_ret
	
	
layer2_update_level	
    ld   a,(l_e5db)  ;check super BB
    and  a
    jr   nz,layer2_update_level_1
    ld   a,(l_e598)
    jr   layer2_update_level_2
layer2_update_level_1
    ld   a,(l_e5a6)
    add  a,$03
    cp   $08
    jr   c,layer2_update_level_2
    sub  $08
layer2_update_level_2
	nextreg $43,%00010000		;select layer 2 palette
	add a,a		;double it as each palette entry is 2 bytes
	ld d,0
	ld e,a
	ld   hl,layer2_level_palette
	add hl,de
	
	nextreg $40, $fc                  ; (R/W) 0x40 (64) => Palette Index set to 252
    ld   a,(l_e64b)
    bit  0,a
    jr   nz,layer2_update_level_3
    ;ld   de,l_f9c0
	nextreg $40, $ec                  ; (R/W) 0x40 (64) => Palette Index set to 236
layer2_update_level_3
	call call_0B30_update_entry
	nextreg $43,%00110000		;select tilemap palette
	ret
	
layer2_palette
    defb $00,$00,$FF,$F0,$CC,$F0,$0A,$00,$F6,$00,$FB,$00,$0F,$00,$F8,$00
    defb $FF,$F0,$F0,$00,$A0,$00,$FF,$60,$F7,$70,$F5,$70,$00,$00,$00,$00
    defb $00,$00,$F0,$00,$77,$70,$99,$90,$BB,$B0,$FF,$F0,$44,$40,$55,$50
    defb $00,$00,$00,$00,$00,$00,$FB,$00,$FF,$00,$FF,$F0,$F0,$70,$00,$00
    defb $00,$00,$0F,$00,$0B,$00,$FA,$A0,$66,$B0,$88,$B0,$AA,$D0,$00,$C0
    defb $66,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
    defb $FF,$F0,$00,$00,$0B,$00,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$FA,$80
    defb $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
    defb $00,$00,$FF,$00,$F0,$00,$FF,$F0,$00,$00,$EA,$60,$C8,$50,$88,$60
    defb $A7,$40,$F0,$70,$CC,$A0,$0B,$00,$00,$00,$75,$50,$AA,$80,$00,$00
    defb $00,$00,$0B,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    defb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    defb $FF,$F0,$00,$00,$0A,$F0,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$FA,$80
    defb $0B,$F0,$F0,$70,$0C,$F0,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
layer2_palette_70
	defb $FF,$F0,$20,$00,$0B,$00,$FA,$A0,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
    defb $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
layer2_palette_80
	defb $FF,$F0,$20,$00,$08,$F0,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
	defb $0B,$F0,$F0,$70,$0A,$F0,$0F,$F0,$F8,$00,$F7,$70,$D4,$00,$00,$00
layer2_palette_90
	defb $FF,$F0,$20,$00,$0B,$00,$FB,$00,$F7,$70,$A0,$90,$70,$C0,$80,$00
	defb $F0,$60,$F0,$00,$0F,$00,$CF,$00,$F8,$00,$0F,$F0,$A0,$00,$00,$00
layer2_palette_A0
	defb $A0,$A0,$0F,$00,$A0,$00,$FF,$00,$0F,$E0,$FA,$70,$F9,$00,$FA,$F0
	defb $00,$F0,$0E,$F0,$08,$F0,$0C,$F0,$F0,$F0,$FF,$F0,$F0,$00,$00,$00
	defb $FF,$F0,$00,$00,$0B,$00,$FA,$A0,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
	defb $0B,$F0,$F0,$70,$F8,$00,$FA,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
	defb $FF,$F0,$00,$00,$0D,$00,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
	defb $0C,$F0,$F0,$70,$08,$00,$FF,$00,$F8,$00,$FA,$80,$D4,$00,$00,$00
	defb $FF,$F0,$20,$00,$0B,$00,$FA,$A0,$80,$F0,$70,$80,$AA,$D0,$09,$F0
	defb $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$20,$00,$00,$00,$00,$00,$00,$00,$00,$00
	defb $F0,$00,$70,$00,$80,$40,$FF,$F0,$FA,$F0,$F0,$00,$F0,$90,$00,$00
	defb $00,$00,$00,$00,$00,$00,$20,$00,$00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00,$00,$F0,$0F,$00,$00,$00,$00,$00
	
layer2_level_palette
;more palette info - colour data for level number - to be loaded into either EC/FC
	defb $F9,$70,$AA,$D0,$0F,$F0,$CC,$C0,$FF,$00,$FA,$F0,$CC,$80,$FC,$80
