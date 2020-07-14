
SHAREDHIGH EQU $26 ;5C ;E0

  ;  BLOCK 0x100,0 

call_0008
    push hl
    ld   h,SHAREDHIGH
    ld   l,a
    ld   (hl),$00
    pop  hl
    ret

call_0010
    push hl
    ld   h,SHAREDHIGH;$E0
    ld   l,a
    ld   (hl),$01
    pop  hl
    ret
    
call_0018
    push bc
    push de
    push hl
    jp   call_0093
    
call_0020
    push bc
    push de
    push hl
    ld   a,$01
    jp   call_0093
    
call_0028
    ld   hl,l_e000
    ld   b,$06
    jp   call_008D

    
call_0030
    ld   hl,l_e000
    ld   l,a
 ;   ld   h,$5C      
    ld   (hl),$01
	jp	 call_0AE4
call_0038	
	jp	 call_0AEE
	nop
call_003C
    add  hl,de
    ex   de,hl
    pop  hl
    sla  l
    ld   c,l
    ld   a,$06
    add  a,l
    ld   l,a
    ld   (hl),e
    inc  hl
    ld   (hl),d
    ld   a,$10
    add  a,e
    ld   e,a
    jr   nc,call_0050
    inc  d              
call_0050
    ld   hl,data_0B22
    ld   b,$00
    add  hl,bc
    ld   c,(hl)
    inc  hl
    ld   b,(hl)
    ex   de,hl
    ld   (hl),c
    inc  hl
    ld   (hl),b
    ret

  ;  BYTE "CALL_005E"
call_005E
    ld   hl,l_e000;$5C00
call_0061
    ld   a,(hl)
    and  a
    jr   z,call_0086
    dec  (hl)
    jr   nz,call_0086
    ld   (l_e192),hl
    sla  l
    ld   a,$06
    add  a,l
    ld   l,a
    ld   (l_e1c5),sp
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ex   de,hl
    ld   sp,hl
    pop  iy
    pop  ix
    pop  hl
    pop  de
    pop  bc
    exx
    pop  hl
    pop  de
    pop  bc
    ret
  ;  BYTE "CALL_0086"
call_0086
    inc  l
    ld   a,l
    cp   $06
    jr   nz,call_0061
    ret
    
call_008D
    ld   (hl),$00
    inc  hl
    djnz call_008D
    ret

    
    
call_0093
    exx
    push bc
    push de
    push hl
    push ix
    push iy
    ld   hl,(l_e192)
    ld   (hl),a
    sla  l
    ld   a,$06
    add  a,l
    ld   l,a
    ld   (l_e1c9),sp
    ld   de,(l_e1c9)
    ld   (hl),e
    inc  hl
    ld   (hl),d
    ld   sp,(l_e1c5)
    ld   hl,(l_e192)
    jr   call_0086

call_02AC
    ld   hl,l_e1d0
    ld   b,$10
call_02B1
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_02B1
    ret

call_02BA
    ld   hl,l_e1d0
    ld   b,$10
call_02BF
    ld   (hl),$11
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_02BF
    ret
call_02C8    
    ld   hl,l_e1d0
    ld   b,$10
call_02CD
    ld   (hl),$19
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_02CD
    ret
call_02D6
    ld   hl,l_e1d0
    ld   b,$10
call_02DB 
	ld   (hl),$1A
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_02DB
    ret
call_02E4
    ld   hl,l_e2f8
    ld   b,$10
call_02E9
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_02E9
    ret
call_02F2
    ld   hl,l_e2d8
    ld   b,$10
call_02F7
    ld   (hl),$11
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_02F7
    ret
call_0300
    ld   hl,l_e2f8
    ld   b,$10
call_0305
    ld   (hl),$1A
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_0305
    ret
call_030E
    ld   hl,l_e2f8
    ld   b,$10
call_0313
    ld   (hl),$1B
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_0313
    ret
call_031C
    ld   hl,l_e1ce
    ld   (hl),$9A
    ld   bc,$0FDB
    ld   hl,l_e1d2
call_0327
    ld   (hl),c
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  c
    djnz call_0327
    ret
    
call_0330    
    ld   hl,l_e2d5
    ld   bc,$0040
    call clearbytes
call_0339
    ld   hl,l_e2f5
    ld   de,data_0352
    ld   b,$10
call_0341
    ld   (hl),$00
    inc  hl
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   (hl),$00
    inc  hl
    djnz call_0341
    ret

data_0352
    BYTE	$AA,$00,$B9,$F0,$B8,$E0,$B7,$D0
    BYTE	$AB,$10,$AC,$20,$AD,$30,$AE,$40
data_0362
    BYTE	$AF,$50,$B0,$60,$B1,$70,$B2,$80
    BYTE	$B3,$90,$B4,$A0,$B5,$B0,$B6,$C0
    
call_0372
    ld   hl,l_e2f5
    ld   bc,$0040
    call clearbytes
    ld   hl,l_e2d5
    ld   de,data_0394
    ld   b,$10
call_0383
    ld   (hl),$00
    inc  hl
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   (hl),$00
    inc  hl
    djnz call_0383
    ret
    
data_0394
    BYTE $AA,$00,$AB,$10,$AC,$20,$AD,$30,$AE,$40,$AF,$50,$B0,$60,$B1,$70
    BYTE $B2,$80,$B3,$90,$B4,$A0,$B5,$B0,$B6,$C0,$B7,$D0,$B8,$E0,$B9,$F0

call_03B4           ;TODO - clear screen data
;    ld   hl,$C000
;    ld   de,$C001
;    ld   bc,$1CFE
;    ld   (hl),$00
;    ldir
	ld   hl,pattern_addr
    ld   de,pattern_addr+1
    ld   bc,$100
    ld   (hl),$00
    ldir
	ld   bc,$7f
    ld   (hl),$02		;flag sprites to be updated adfter clear!
    ldir
    call clearscreen
    ret


call_03C2   ;TODO clear screen sprite data part
  ;   ld   hl,$C000
 ;   ld   bc,$0C00
 ;   jp   clearbytes
	ld   hl,pattern_addr
    ld   de,pattern_addr+1
    ld   bc,$100			;should actually retain $cc00 to $cd00!
    ld   (hl),$00
    ldir
	ld   bc,$7f
    ld   (hl),$02		;flag sprites to be updated after clear!
    ldir
    ret
call_03CB
    ld   hl,$76F8;$CD08
    jp   call_03D3
	;ret			;ret inserted as we don't have a second location to clear
call_03D0
;clear the EXTEND SPRITES
	ld a,EXTEND_FIRST_SPRITE_P1
	nextreg $34,a
	ld b,6
	ld a,0
make_extend_invisible_1
	nextreg $78,a
	djnz make_extend_invisible_1
	
	ld a,EXTEND_FIRST_SPRITE_P2
	nextreg $34,a
	ld b,6
	ld a,0
make_extend_invisible_2
	nextreg $78,a
	djnz make_extend_invisible_2
call_03D0_1
	ld   hl,$7F18;$D508
	ld b,3
	jp call_03D5
call_03D3
    ld   b,$1a ;clears whole screen apart from top 2 lines
call_03D5
    push bc
    push hl
    call call_03FD
    pop  hl
	ld bc,$0050
	add hl,bc
    pop  bc
    ;inc  hl
    ;inc  hl
    djnz call_03D5
    ret
call_03E1				;routine below changed to clear the score lines
	ld   hl,$7608;$D508 ;prior to the screen scrolling between levels
	ld b,3
	jp call_03D5
/*
    ld   hl,$76B0;$D588
    ld   b,$19
call_03E6
    push bc
    push hl
    ld   b,$1C
call_03EA
    ld   (hl),$00
    inc  hl
    ld   (hl),$00
    ;ld   a,$3F
    ;call adda2hl;$0D89
	inc hl
    djnz call_03EA
    pop  hl
	ld bc,$50
	add hl,bc
    pop  bc
call_03F8
    inc  hl
    inc  hl
    djnz call_03E6
    ret
*/

call_03FD			;clear row
    ld   b,$20
call_03FF
    ld   (hl),$00
    inc  hl
    ld   (hl),$00
    inc hl
    djnz call_03FF
    ret

/*
clearrow  ;($03FD)
	ret
    ld   b,$20
call_03FF
    push hl
    ld   (hl),$00
    inc h
    ld   (hl),$00
    inc h
    ld   (hl),$00
    inc h
    ld   (hl),$00
    inc h
    ld   (hl),$00
    inc h
    ld   (hl),$00
    inc h
    ld   (hl),$00
    inc h
    ld   (hl),$00
    pop hl
    inc  hl
;    ld   (hl),$00
;    ld   a,$3F
;    call adda2hl
    djnz call_03FF
    ret
*/

call_040C    
    ld   hl,l_e20d
    ld   bc,$00E8
    jp   clearbytes

call_0415   ;TODO - clears some screen related info
	ld   hl,pattern_addr
    ld   de,pattern_addr+1
    ld   bc,$100		
    ld   (hl),$00
    ldir
	ld   bc,$7f
    ld   (hl),$02		;flag sprites to be updated adfter clear!
    ldir
    ret 

    
call_041E
    ld   hl,l_e1cd
    ld   bc,$0168
    jp   clearbytes

call_0427 
    ld   hl,l_e1cb
   ; set  6,(hl)  ;enable display
    ld   a,(hl)
  ;  ld   ($FB40),a
	push bc
	ld bc,$243b
    ld a,$6b	
    out (c),a    ;Select register $6b  (tilemap control)
	ld bc,$253b
    in a,(c)
    or $80        ;flip bit 7 (enable)
    out (c),a
	
	ld bc,$243b
    ld a,$15	
    out (c),a    ;Select register $6b  (sprite)
	ld bc,$253b
    in a,(c)
    or $1        ;flip bit 0 (enable)
    out (c),a
	
	ld bc,$243b
    ld a,$69	
    out (c),a    ;Select register $6b  (sprite)
	ld bc,$253b
    in a,(c)
    or $80        ;flip bit 0 (enable)
    out (c),a
	
	pop bc
    ret


call_042C
    ld   a,(hl)
;    ld   ($FB40),a
    ret
call_0431		;toggle screen on/off
	push bc
	ld bc,$243b
    ld a,$6b	
    out (c),a    ;Select register $6b  (tilemap control)
	ld bc,$253b
    in a,(c)
    xor $80        ;flip bit 7 (enable)
    out (c),a
	
	ld bc,$243b
    ld a,$15	
    out (c),a    ;Select register $6b  (sprite)
	ld bc,$253b
    in a,(c)
    xor $1        ;flip bit 0 (enable)
    out (c),a
	
	ld bc,$243b
    ld a,$69	
    out (c),a    ;Select register $6b  (sprite)
	ld bc,$253b
    in a,(c)
    xor $80        ;flip bit 0 (enable)
    out (c),a
	
	pop bc
    ld   hl,l_e1cb
    ;res  6,(hl)  ;enable display
    jr   call_042C

call_0438
    ld   a,(l_fc20)
    bit  1,a
    jr   z,call_0446
    ld   hl,l_e1cb
    ;res  7,(hl)  ;flip screen
    jr   call_042C
call_0446
    ld   hl,l_e1cb
   ; set  7,(hl)  ;flip screen
    jr   call_042C
    
    
  ;  BYTE "CALL_044D"
call_044D
    di              ;just to be safe (as SP is used in these routines)
    push af
    ;ld   ($FA80),a
    ;ld   a,($FC20)
    ;and  $05
    ;jp   z,$04D8       ;hardware test?
    ld   a,(l_e194)
    and  a
    jr   z,call_0490    ;check bit we set in startup - jr if not
    call call_04AD
    ld   hl,l_e194
    ld   (hl),$00
    ;ei
    call call_005E
    ld   a,$01
    ld   (l_e194),a
    pop  af
    di              
    pop  hl
    push af
    ;ld   a,h      ;
    ;cp   $C0       ;
    ;jr   c,$048B    ;'TIME ERROR' if no jump
call_048B
    pop  af
    push hl
    ;ei
    ret

    
 

call_0490
    ld   (l_e1c7),sp
    ld   sp,l_e1c5
    ;call call_04BE
    ld   sp,(l_e1c7)
    pop  af
    ;ei
    ret

    
call_04AD
;    ld   hl,$E1CD
;    ld   de,$DD00
;    ld   bc,$0168
;    ldir
     ;call call_136C     ;process sound queue - moved to interrupt routine
     call call_0E79     ;increase counter at l_e37f
     push bc
     push de
     push hl
     call call_0BE4
     call call_0CAC     ;test and return, can ignore for now??
     call call_0E7E
     call call_0504
     call call_0524
     ld   hl,l_e338
     inc  (hl)
     pop  hl
     pop  de
     pop  bc
     ret


call_0504
    ld   b,$03
    ld   hl,l_e335
call_0509
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    ret  c
    ld   (hl),$00
    inc  hl
    djnz call_0509
    ret    
call_0514    
    ld   hl,l_e335
    ld   (hl),$00
    ld   hl,l_e336
    ld   (hl),$00
    ld   hl,l_e337
    ld   (hl),$00
    ret
call_0524
    ld   a,(l_f66e)  ;slaveframecounter                
    ld   hl,l_e339	;check if counter has hit 0xB5
    cp   (hl)
    ld   (hl),a
    inc  hl
    jr   nz,call_0535
    inc  (hl)
    ld   a,(hl)
    cp   $B4
    ret     ;is ret c, on non bootleg
    ;rst  $00                ;reset machine!!!!!!!!!!!
call_0535
    ld   (hl),$00
    ret
    
	
;***** Code to control DEMO MODE *****
call_0538				;0538 - one of the addresses 'returned to' from $0085
    call call_063E		;clear vars
    call call_1775		;copy level info to ram (not the map yet)
    call call_18E7		;decode map data
    ld   hl,l_e33b
    ld   bc,$0014
    call clearbytes
    ld   a,(l_e64b)
    cp   $63
    call nz,call_0372
    call call_0B43		;copy level palette

    ld   a,(l_e64b)
    cp   $63
    jr   z,call_0563
    ld   a,(l_e350)
    cp   $02
    jr   nc,call_0566
call_0563
    ld   a,$03
    call call_0030
call_0566
    call call_0A12
    ld   hl,l_e5d7                     
    bit  0,(hl)
    push hl
    call nz,call_3308
    pop  hl
    bit  1,(hl)
    call nz,call_3353
	ld a,introbank
	call call_026C
    call intro_call_30DF  ;TODO - this clear the area where P2 'insert coins gfx will appear'
	call call_029B
call_057B
    call call_0020
  ;  BYTE "TEMP TO FIND 057B"
    call call_08B3		;057C - one of the addresses 'returned to' from $0085
    ld   a,(l_e6ff)
    and  a
    jp   p,call_057B
    ld   a,(l_e64b)
    cp   $63
    jr   nz,call_0592
    call call_0339
    jr   call_0599
call_0592
    ld   a,(l_e5d3)
    and  a
    call z,call_0330
call_0599
    ld   a,$03
    call  call_0018
    ld   a,(l_e5d3)
    and  a
    jp   nz,call_0627
call_05A3
    call call_0020
    ld   a,bank2;$02      ;switch bank
    call call_026C
    call bank2_call_B18F  ;show p2 insert coin?
    call call_029B    ;restore bank 
	ld   a,introbank      ;switch bank
    call call_026C
    call intro_call_0967
	call call_029B    ;restore bank 
    call call_08B9
    call call_09EC
    call call_0891
    call call_0742
    call call_085F
    call call_0730
    ld   a,(l_e5d7)
    and  a
    jr   z,call_0614
    ld   a,(l_ed3d)
    and  a
    jp   m,call_05D3
    jr   nz,call_05A3
call_05D3
    ld   hl,l_e76a
    ld   (hl),$01
    call call_0673
    ld   a,(l_e64b)
    cp   $63
    jr   z,call_0614
    call call_068C
    ld   bc,$01A4
call_05E8
    call call_0020
    push bc					;05e9 - one of the addresses 'returned to' from $0085
    call call_08B9
    ld   a,bank2;$02
    call call_026C
    call bank2_call_B18F
    call call_029B
    call call_09EC
    pop  bc
    ld   a,(l_e5d7)
    and  a
    jr   z,call_0614
    ld   a,(l_e737)
    cp   $01
    jr   z,call_05E8
    ld   a,(l_e342)
    and  a
    jr   nz,call_0614
    dec  bc
    ld   a,c
    or   b
    jr   nz,call_05E8
call_0614
    ld   hl,l_e358
    bit  0,(hl)
    jr   z,call_0622
    ld   (hl),$00
    ld   c,$30
    call call_1350
call_0622
    ld   a,$00
    call call_0010
    xor  a
    call call_0018
call_0627
    call call_0020
    call call_08C0
    ld   a,(l_ed3d)
    and  a
    jr   z,call_0633
    jr   call_0627
call_0633
    ld   hl,l_e76a
    ld   (hl),$01
call_0638
    call call_0020
    call call_08C0
    jr   call_0638
    
call_063E
    xor  a
    ld   (l_e6ff),a
    ld   (l_f513),a
    ld   (l_f47c),a
    ld   (l_f4cb),a
    ld   (l_e720),a
    ld   (l_f5b6),a
    ld   (l_f595),a
    ld   (l_f59e),a
    ld   (l_e737),a
    ld   (l_e341),a
    ld   (l_f536),a
    ld   (l_f66b),a	;clear flag to say player has control (travel bubble has burst)
    ld   (l_e342),a
  ;  ld   hl,$0000      ;palette entries
  ;  ld   (l_f9de),hl
  ;  ld   hl,$0000
  ;  ld   (l_f9fe),hl
	
    ret


call_0672
    ret
    
call_0673
    ld   a,(l_e34b)
    and  a
    jp   p,call_0683
    ld   hl,l_e2d5
    ld   bc,$0010
    call clearbytes;$0D50
call_0683
    ld   hl,l_e344
    ld   bc,$000B
    jp   clearbytes;$0D50

call_068C
    ld   a,(l_f464)
    and  a
    jr   z,call_0697
    ld   a,(l_f465)
    jr   call_0702
call_0697
    ld   a,(l_f46b)
    and  a
    jr   z,call_06A4
    ld   a,(l_f46d)
    add  a,$25
    jr   call_0702
call_06A4
    ld   b,$10
    ld   a,(l_e64b)
    ld   hl,data_0710
call_06AC
    cp   (hl)
    jr   z,call_06B5
    inc  hl
    inc  hl
    djnz call_06AC
    jr   call_06B9
call_06B5
    inc  hl
    ld   a,(hl)
    jr   call_0702
call_06B9
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_06CF
    ld   a,(l_e641)
    ld   hl,l_e646
    cp   (hl)
    jr   nz,call_06CF
    and  $0F
    add  a,$0B
    jr   call_0702
call_06CF
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,call_06E4
    ld   a,(l_e641)
    ld   b,$0A
    ld   hl,data_0706
call_06DE
    cp   (hl)
    jr   z,call_06FF
    inc  hl
    djnz call_06DE
call_06E4
    ld   hl,l_e5d7
    bit  1,(hl)
    jr   z,call_06F9
    ld   a,(l_e646)
    ld   b,$0A
    ld   hl,data_0706
call_06F3
    cp   (hl)
    jr   z,call_06FF
    inc  hl
    djnz call_06F3
call_06F9
    ld   hl,l_e744
    ld   (hl),$FF
    ret
call_06FF
    ld   a,$0A
    sub  b
call_0702
    ld   (l_e744),a
    ret
data_0706
    BYTE $00,$11,$22,$33,$44,$55,$66,$77,$88,$99
data_0710
    BYTE $00,$1B,$04,$1F,$09,$1C,$0E,$20,$13,$1D
data_071A
    BYTE $18,$22,$1D,$1E,$22,$21,$27,$23,$2C,$06
data_0724
    BYTE $31,$24,$54,$15,$55,$1A,$5B,$17,$5C,$16
data_072E
    BYTE $5D,$18


call_0730
    ld   a,(l_ed3d)
    cp   $01
    ret  nz
    ld   a,(l_e349)
    cp   $01
    ret  z
    ld   hl,l_e349
    ld   (hl),$FF
    ret


call_0742
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e64b)
    cp   $63
    ret  z
    ld   a,(l_e737)
    and  a
    ret  nz
    ld   a,(l_e34b)
    and  a
    jp   m,call_07A7
    ret  nz
    ld   hl,l_f448
    bit  6,(hl)
    jr   z,call_0765
    res  6,(hl)
    jr   call_0781
call_0765
    ld   a,(l_e346)
    and  a
    ret  nz
    ld   a,(l_e345)
    ld   hl,l_e5a5
    cp   (hl)
    jr   z,call_0781
    ld   a,(hl)
    sub  $01
    ld   hl,l_e345
    cp   (hl)
    ret  nz
    ld   hl,l_e34a
    ld   (hl),$01
    ret
call_0781
    ld   a,$03
    call call_0008;rst  $08
    ld   a,$05
    call call_0008;rst  $08
    ld   a,$04
    call call_0008;rst  $08
    ld   hl,l_f66b
    ld   (hl),$00
    call call_24B1
    ld   a,$00          ;Silence music ahead of Hurry Up
    ld (music_playing),a
;    ld   ($FA00),a     ;Sound IO
    ld   hl,data_0847
    ld   de,l_e2d5
    ld   bc,$0010
    ldir
    ld   hl,l_e34b
    ld   (hl),$FF
call_07A7
    ld   hl,l_e34c
    inc  (hl)
    ld   a,(hl)
    cp   $05
    jr   nz,call_07B4
    ld   (hl),$00
    inc  hl
    inc  (hl)
call_07B4
    ld   hl,data_0857
    ld   a,(l_e34d)
    bit  1,a
    jr   nz,call_07C1
    ld   hl,data_085B
call_07C1
    ld   e,$0B
    ld   bc,$041C
    call call_14C0
    ld   a,(l_e34b)
    cp   $FE
    jr   z,call_07F9
    cp   $FD
    jr   z,call_0815
    ld   hl,l_e2d5
    ld   b,$04
call_07D9
    ld   a,(hl)
    add  a,$04
    ld   (hl),a
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_07D9
    ld   a,(l_e2d5)
    cp   $78
    ret  c 
    ld   hl,l_e34b
    ld   (hl),$FE
    ld   hl,l_e358
    ld   (hl),$01
    ld   c,$18
    call call_1350
    ret

call_07F9
    ld   hl,l_e34e
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    ret  c
    ld   a,$03
    call call_0010;rst  $10
    ld   a,$05
    call call_0010;rst  $10
    ld   a,$04
    call call_0010;rst  $10
    ld   hl,l_f66b
    ld   (hl),$49
    ld   hl,l_e34b
    ld   (hl),$FD
    ret

call_0815
    ld   hl,l_e2d5
    ld   b,$04
call_081A
    ld   a,(hl)
    add  a,$08
    ld   (hl),a
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_081A
    ld   a,(l_e2d5)
    cp   $F0
    ret  c
    ld   hl,l_e34b
    ld   (hl),$01
    ld   hl,l_e349
    ld   (hl),$01
    ld   hl,l_f453
    ld   (hl),$01
    ld   hl,l_e5fe
    inc  (hl)
;    ld   hl,($0004)
;    ld   de,$00B9
;    or   a
;    sbc  hl,de
    ret


data_0847
    BYTE $00,$0B,$60,$15,$00,$2B,$70,$15,$00,$4B,$80,$15,$00,$6B,$90,$15
data_0857
    BYTE $AC,$B0,$B4,$B8
data_085B
    BYTE $BC,$C0,$C4,$C8    
call_085F
    ld   a,(l_e349)
    cp   $01
    ret  nz
    ld   a,(l_e343)
    and  a
    ret  nz
    ld   hl,l_e347
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    ret  c
    ld   (hl),$00
    inc  hl
    inc  (hl)
    ld   a,(l_e5a7)
    cp   (hl)
    ret  nc
    ld   hl,l_e343
    ld   (hl),$FF
    ld   hl,l_f454
    ld   (hl),$01
    ld   hl,l_e611
    inc  (hl)
    ld   a,(l_fc85)
    bit  0,a
    ret


call_0891
    ld   a,(l_e341)
    and  a
    ret  nz
    ld   hl,l_f455
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    jr   nz,call_08A3
    ld   (hl),$00
    inc  hl
    inc  (hl)
call_08A3
    ld   b,$03
    ld   hl,l_e344
call_08A8
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    ret  nz
    ld   (hl),$00
    inc  hl
    djnz call_08A8
    ret

call_08B3
    ld   a,(l_e5d3)
    and  a
    jr   nz,call_08C0
    ld   hl,(l_fc22)
    ld   (l_e33f),hl
    ret

call_08B9
    ld   hl,(l_fc22)
    ld   (l_e33f),hl
    ret

call_08C0
    ld   a,$00
    and  a
    jr   nz,call_0909
    ld   a,bank1;$01   ;switch bank
    call call_026C
    ld   iy,(l_e353)
    ld   hl,l_e33d
    ld   a,(hl)
    and  a
    jr   nz,call_08E1
    ld   a,(iy+$00)
    ld   (hl),a
    inc  iy
    inc  iy
    ld   (l_e353),iy
call_08E1
    dec  (hl)
    ld   a,(iy-$01)
    ld   (l_e33f),a
    ld   iy,(l_e355)
    ld   hl,l_e33e
    ld   a,(hl)
    and  a
    jr   nz,call_08FF
    ld   a,(iy+$00)
    ld   (hl),a
    inc  iy
    inc  iy
    ld   (l_e355),iy
call_08FF
    dec  (hl)
    ld   a,(iy-$01)
    ld   (l_e340),a
    jp   call_029B  ;restore bank

call_0909
    ld   a,bank1;$01
    call call_026C
    ld   iy,(l_e353)
    ld   hl,l_e33d
    ld   a,(hl)
    and  a
    jr   z,call_0927
    ld   a,(l_fc22)
    cp   (iy+$01)
    ld   a,(hl)
    jr   z,call_0927
    inc  iy
    inc  iy
    xor  a
call_0927
    inc  a
    ld   (hl),a
    ld   (iy+$00),a
    ld   a,(l_fc22)
    ld   (iy+$01),a
    ld   (l_e33f),a
    ld   (l_e353),iy
    ld   iy,(l_e355)
    ld   hl,l_e33e
    ld   a,(hl)
    and  a
    jr   z,call_0952
    ld   a,(l_fc23)
    cp   (iy+$01)
    ld   a,(hl)
    jr   z,call_0952
    inc  iy
    inc  iy
    xor  a
call_0952
    inc  a
    ld   (hl),a
    ld   (iy+$00),a
    ld   a,(l_fc23)
    ld   (iy+$01),a
    ld   (l_e340),a
    ld   (l_e355),iy
    jp   call_029B

/*				;moved to intro bank
call_0967
    ld   a,(l_e33b)
    and  a
    jp   z,call_0972
    jp   m,call_09A7
    ret
call_0972
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
    ld   iy,$7a82+$e;$D99E
    call call_0FC2
    ld   hl,data_09D2
    ld   de,$7a82;$D81E
    ld   c,$00;$00
    call call_0E9A
    ld   hl,data_09D8
    ld   de,$7b22;$D822
    ld   c,$00;$00
    jp   call_0E9A
call_09A7
    ld   hl,l_e33c
    dec  (hl)
    ret  nz
    ld   hl,l_e33b
    ld   (hl),$01
    ld   hl,data_09E0
    ld   de,$7a7e;$D79E
    ld   c,$00;$00
    call call_0E9A
    ld   hl,data_09E0
    ld   de,$7acc;$D7A0
    ld   c,$00;$00
    call call_0E9A
    ld   hl,data_09E0
    ld   de,$7b1c;$D7A2
    ld   c,$00;$00
    jp   call_0E9A


data_09D2
    BYTE $05,"ROUND"

data_09D8
    BYTE $07,"READY !"
    
data_09E0
    BYTE $0B,"           "
*/

call_09EC
    ld   a,(l_e5d3)
call_09EF
    and  a
    ret  nz
    ld   a,(l_e34f)
    and  a
    ret  z
    ld   a,$03
    call call_0008;rst  $08
    ld   a,$04
    call call_0008;rst  $08
    ld   a,$05
    call call_0008;rst  $08
    call call_041E
    call call_031C
    ld   hl,l_ed3d
    ld   (hl),$00
    call call_063E
    ld   a,$00
    call call_0010;rst  $10
    xor  a
    call call_0018;rst  $18
call_0A12
    call call_0A97
    ld   hl,l_e5c3
    ld   (hl),$01
    ld   a,(l_e5d3)
    and  a
    jr   nz,call_0A2C
    ld   a,(l_e357)
    and  a
    jr   nz,call_0A2C
    ld   a,(l_e64b)
    and  a
    jr   nz,call_0A42
call_0A2C
    call call_0431      ;swap screens (hide drawing)
	
    ld   hl,l_e5c3
    ld   (hl),$00
    call call_18EE      ;this draws level to screen
        
    call call_0AA4
    ld   hl,l_e357
    ld   (hl),$00
    jp   call_0427
call_0A42
    ld   hl,l_e351
    ld   (hl),$FF
	
	nextreg $1B,0
	nextreg $1B,159	;(this will be internally doubled as we have set sprites over border mode)
	nextreg $1B,24+8;+8+8		;this cuts off a lot of the screen while scrolling but stop level flicker!
	nextreg $1B,255-24
	
	call call_03D0_1
;	call call_03E1
	
call_0A47
    call  call_0020
call_0A48
    ld   a,(l_e1cd)
    and  $07
    call z,call_18EE
    ld   e,$08
    ld   a,(l_e34f)
    and  a
    jr   nz,call_0A5A
    ld   e,$02
call_0A5A				;this loop changes the scroll position of the 16 (16 pix wide) columns
    ld   b,$10
    ld   hl,l_e1cd
call_0A5F
    ld   a,e
    add  a,(hl)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_0A5F
    ld   a,(l_e1cd)
    and  a
    jr   nz,call_0A47

;	ld a,introbank
;	call call_026C
;	call intro_copy_tilemap_half
;	call call_029B
 ;   call call_0AA4
 
	call call_3395			;redisplay score lines
	call call_2FF0			;show actual scores
 
 	nextreg $1B,0
	nextreg $1B,159	;(this will be internally doubled as we have set sprites over border mode)
	nextreg $1B,0
	nextreg $1B,255-16
 
    xor  a
    ld   (l_e351),a
    ld   a,(l_e34f)
    and  a
    ret  z
	ld a,introbank
	call call_026C
    call intro_call_30DF
	call call_029B
    ld   a,(l_e64b)
    cp   $63
    jr   z,call_0A8A
    ld   hl,l_e350
    dec  (hl)
    jr   nz,call_0A92
call_0A8A
    xor  a
    ld   (l_e34f),a
    ld   (l_e350),a
    ret
call_0A92
    ld   a,$00
    call call_0010
    xor  a
    call call_0018


call_0A97
    ret            ;temp to skip screen copy routine... not sure why it is needed
;    ld   hl,l_e352
;    ld   (hl),$01
;    ld   hl,$CD04   ;first screen layer
;    ld   de,$D504   ;second screen layer
;    jr   call_0ACA



call_0AA4               ;this copies from screen 1 to screen 2
                        ;disabled for now (could use shadow screen?)
                        ;but is this really needed at all?
	
	call call_3395			;redisplay score lines
	call call_2FF0			;show actual scores
						
    ret
;    ld   hl,l_e352
;    ld   (hl),$00
;    ld   hl,$D504
;    ld   de,$CD04
;    call call_0ACA
;    ld   hl,$D504
;    call clearrow
;    ld   hl,$D506
;    call clearrow
;    ld   hl,$CD00
;    call clearrow
;    ld   hl,$CD02
;    jp   clearrow
call_0ACA
    ld   b,$20
call_0ACC
    push bc
    ld   b,$04
call_0ACF
    ld   a,(hl)
    ld   (de),a
    inc  hl
    inc  de
    djnz call_0ACF
    ld   a,$3C
    call adda2hl
    ld   a,$3C
    call adda2de
    pop  bc
    djnz call_0ACC
    ret

call_0AE3
    ret
	
call_0AE4
    push hl
    call call_0D8E
    ld   hl,l_e020
	jp call_003C
	
call_0AEE
    push hl
    push af
    push de
    push bc

 ;   nextreg $43,%10110000
 ;   nextreg $40,$0f
 ;   nextreg $41,$1c
 ;   nextreg $4C,$00
    call call_0AFC        
;    nextreg $40,$0f
;    nextreg $41,$00
;    nextreg $4C,$0f
    pop  bc
    pop  de
    pop  af
    pop  hl
    jp   call_044D


call_0AFC
    
    di
    
    ld bc,$243b
    ld a,86     ;4K page at C000
    out (c),a        
    ld bc,$253b
    ld a,bank3     ;set first 4K bank
    out (c),a    
    
    ld bc,$243b
    ld a,87     ;4K page at E000
    out (c),a        
    ld bc,$253b
    ld a,bank3     ;set second 4K bank
    inc a
    out (c),a    

    ld   hl,(l_fd86)
    jp   (hl)

    ;stack jump table
data_0B22
    BYTE LOW call_1D17,HIGH call_1D17;$17,$1D
    BYTE LOW call_2AF8,HIGH call_2AF8;$F8,$2A
    BYTE LOW call_0538,HIGH call_0538;$38,$05
    BYTE LOW call_3DF0,HIGH call_3DF0;$F0,$3D
    BYTE LOW bank0_call_85A9,HIGH bank0_call_85A9;$A9,$85,
    BYTE LOW call_5B3C,HIGH call_5B3C;$3C,$5B
data_0B2E
    BYTE LOW call_044D,HIGH call_044D;$4D,$04    

call_0B30				;set the main palette
    ld   a,bank1         ;bank switching
    call call_026C
    ld   hl,bank1_data_8000    ;load palette from rom bank
	nextreg $40,$00			   ;select palette entry 0
;    ld   de,l_f800
;    ld   bc,$0200
;    ldir
	ld b,0			;loop 256 times
call_0B30_loop
	call call_0B30_update_entry
	djnz call_0B30_loop
	
	nextreg $4C,$0F				;change transparency to 0F
	
    jp   call_029B
 ;   ret    ;need ret as not jumping to restorebank

call_0B30_update_entry
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
	ret

call_0B43
    ld   a,(l_fc85)
    bit  1,a
    jr   nz,call_0B4B
    nop
call_0B4B
    ld   a,bank1
    call call_026C ;switch bank
    ld   a,(l_e5db)  ;check super BB
    and  a
    jr   nz,call_0B5B
    ld   a,(l_e598)
    jr   call_0B66
call_0B5B
    ld   a,(l_e5a6)
    add  a,$03
    cp   $08
    jr   c,call_0B66
    sub  $08
call_0B66
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control
    
    call call_0D99
    ld   hl,bank1_data_8200
    add  hl,de
    ;ld   de,l_f9e0
	nextreg $40, $f0                  ; (R/W) 0x40 (64) => Palette Index set to 240
    ld   a,(l_e64b)
    bit  0,a
    jr   nz,call_0B7A
    ;ld   de,l_f9c0
	nextreg $40, $e0                  ; (R/W) 0x40 (64) => Palette Index set to 224
call_0B7A
    ld   b,$10
call_0B7C
    call call_0B30_update_entry
	djnz call_0B7C
    call call_029B  ;restore bank

	ld   a,introbank
    call call_026C ;switch bank
	call layer2_update_level
	jp	 call_029B
call_0B82     ;TODO - palette routine
;    ld   hl,($0004) ;ROM Check
;    ld   bc,$00B9
;    or   a
;    sbc  hl,bc
;    jr   call_0B8F
;    push af
;    push bc
call_0B8F
    ld   a,bank1;$01
    call call_026C
    ld   a,(l_e5db)
    and  a
    jr   nz,call_0B9F
    ld   a,(l_e598)
    jr   call_0BA4
call_0B9F
    ld   a,(l_e5a6)
    add  a,$03
call_0BA4
    add  a,$03
    cp   $08
    jr   c,call_0BAC
    sub  $08
call_0BAC
    call call_0D99
    ld   hl,bank1_data_8200
    add  hl,de
    ld   de,$F9E0   ;TODO
    ld   a,(l_e64b)
    bit  0,a
    jr   nz,call_0BC0
    ld   de,$F9C0   ;TODO
call_0BC0
    ld   bc,$0020
;    ldir           ;Will overwrite palette data at $F9x0
    jp   call_029B


call_0BC8
    ld   a,bank3
    call call_026C;bankswitch
    ld   a,(bank3_data_BFFF) ;checked this address on bank 3 = 0
    call mul16
    ld   hl,bank3_data_BFDF
    call adda2hl
    ld   de,l_e36a
    ld   bc,$0010
    ldir
    jp   call_029B
call_0BE4
    call call_0C6D
    ld   hl,l_e35e
    ld   a,(l_fc1f)
    call mul16
    ld   b,$03
call_0BF2
    push af
    push bc
    call call_0C99
    pop  bc
    pop  af
    sla  a
    djnz call_0BF2
    ld   a,(l_e361)
    cp   $00
    jr   nz,call_0C10
    ld   hl,l_e364
    ld   a,(l_fc20)
    ld   de,l_e36a
    call call_0C39
call_0C10
    ld   a,(l_e35f)
    cp   $00
    jr   nz,call_0C27
    ld   hl,l_e365
    ld   a,(l_fc20)
    srl  a
    srl  a
    ld   de,l_e372
    call call_0C39
call_0C27
    ld   a,(l_e363)
    cp   $00
    jr   nz,call_0C5A
    ld   a,(l_e366)
    cp   $09
    ld   a,$01
    jr   c,call_0C4E
    jr   call_0C5A
call_0C39
    call div4
    and  $06
    call adda2de
    ld   a,(de)
    cp   $01
    jr   z,call_0C4C
    inc  (hl)
    ld   a,(de)
    cp   (hl)
    ret  nz
    ld   (hl),$00
call_0C4C
    inc  de
    ld   a,(de)
call_0C4E
    ld   hl,l_e366
    add  a,(hl)
    ld   (hl),a
    ld   (l_fc1e),a
    ld   hl,l_e367
    inc  (hl)
call_0C5A
    ld   a,(l_e366)
    cp   $09
    jr   nc,call_0C67
    ld   hl,l_ff94         ;HARDWARE IO (or is it - this is MCU shared RAM)
    ld   (hl),$FF
    ret
call_0C67
    ld   hl,l_ff94         ;HARDWARE IO
    ld   (hl),$01
    ret
call_0C6D
    ld   a,(l_e368)
    and  a
    jr   nz,call_0C8A
    ld   hl,l_e367
    ld   a,(hl)
    and  a
    ret  z
    dec  (hl)
    ;ld   a,$34
    ;ld   (l_fa00),a         ;SOUND IO - credit insert

  ;  push bc         ;load credit sound into queue
    ld c,$34
    call call_135C
  ;  pop bc
    
    ld   a,$2D
    ld   (l_e369),a
    ld   a,$FF
    ld   (l_e368),a
    ret
call_0C8A
    ld   a,(l_e369)
    dec  a
    jr   z,call_0C94
    ld   (l_e369),a
    ret
call_0C94
    xor  a
    ld   (l_e368),a
    ret
call_0C99
    ld   e,a
    ld   d,(hl)
    ld   (hl),a
    xor  a
    rl   d
    jr   c,call_0CA2
    inc  a
call_0CA2
    rl   e
    jr   nc,call_0CA8
    add  a,$02
call_0CA8
    inc  hl
    ld   (hl),a
    inc  hl
    ret
    
call_0CAC
    ld   a,(l_fc1f)
    bit  0,a
    ret

call_0D14
    ret
call_0D15
    ;ld   a,(l_e1cb)
	
    ld bc,$243b
    ld a,86     ;4K page at C000
    out (c),a        
    ld bc,$253b
    ld   a,(l_e1cb) ;restore first 4k bank
    out (c),a
    push af
    ld bc,$243b
    ld a,87     ;4K page at E000
    out (c),a        
    ld bc,$253b
    pop af     ;restore second 4K bank
    inc a
    out (c),a    

	
 ;   ld   ($FB40),a
	;ei
    ret


call_0D50
clearbytes	;$0d50 clear bc number of bytes 
    ld   (hl),$00
    inc  hl
    dec  bc
    ld   a,c
    or   b
    jr   nz,clearbytes
    ret

call_0D5E
div64   ;$0d5e
    srl  a
call_0D60
div32
    srl  a
call_0D62
div16
    srl  a
call_0D64
div8
    srl  a
call_0D66
div4
    srl  a
call_0D68
div2
    srl  a
    ret



mul64
call_0D6B
    add  a,a
mul32          ;$0d6c
call_0D6C
    add  a,a
mul16		   ;0d6d
call_0D6D
    add  a,a
mul8
call_0D6E
    add  a,a
mul4
call_0D6F
    add  a,a
mul2
call_0D70
    add  a,a
    ret

call_0D7F
    add  a,c
    ld   c,a
    ret  nc
    inc  b
    ret


adda2de     ;$0d84
call_0D84
    add  a,e
    ld   e,a
    ret  nc
    inc  d
    ret

adda2hl     ;$0d89
call_0D89
    add  a,l
    ld   l,a
    ret  nc
    inc  h
    ret
    
call_0D8E   ;mul a x 64 and put in DE
    ld   l,a
    ld   h,$00
    add  hl,hl
    add  hl,hl
    add  hl,hl
    add  hl,hl
    add  hl,hl
    add  hl,hl
    ex   de,hl
    ret

call_0D99
    ld   e,$00
    srl  a
    rr   e
    rra
    rr   e
    rra
    rr   e
    ld   d,a
    ret


call_0DA7
    add  a,a
    add  a,l
    ld   l,a
    jr   nc,call_0DAD
    inc  h
call_0DAD
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ret


call_0DB1
    ld   l,$00
    ld   h,a
    ld   c,b
    ld   b,$00
    ld   a,$08
call_0DB9
    add  hl,hl
    jr   nc,call_0DBD
    add  hl,bc
call_0DBD
    dec  a
    jr   nz,call_0DB9
    ret
call_0DC1
    ld   a,e
    call call_0DD9
    ex   af,af'
    push hl
    ld   a,d
    call call_0DDB
    ld   d,a
    ex   af,af'
    add  a,h
    ld   h,l
    ld   l,e
    ld   e,a
    jr   nc,call_0DD4
    inc  d
call_0DD4
    pop  bc
    add  hl,bc
    ret  nc
    inc  de
    ret
call_0DD9
    ld   e,$00
call_0DDB
    ld   h,e
    ld   l,e
    add  a,a
    jr   nc,call_0DE2
    add  hl,bc
    adc  a,e
call_0DE2
    add  hl,hl
    adc  a,a
    jr   nc,call_0DE8
    add  hl,bc
    adc  a,e
call_0DE8
    add  hl,hl
    adc  a,a
    jr   nc,call_0DEE
    add  hl,bc
    adc  a,e
call_0DEE
    add  hl,hl
    adc  a,a
    jr   nc,call_0DF4
    add  hl,bc
    adc  a,e
call_0DF4
    add  hl,hl
    adc  a,a
    jr   nc,call_0DFA
    add  hl,bc
    adc  a,e
call_0DFA
    add  hl,hl
    adc  a,a
    jr   nc,call_0E00
    add  hl,bc
    adc  a,e
call_0E00
    add  hl,hl
    adc  a,a
    jr   nc,call_0E06
    add  hl,bc
    adc  a,e
call_0E06
    add  hl,hl
    adc  a,a
    ret  nc
    add  hl,bc
    adc  a,e
    ret
call_0E0C
    ld   c,$00
    ld   d,$08
call_0E10
    add  hl,hl
    xor  a
    sbc  hl,bc
    inc  hl
    jp   p,call_0E1B
    add  hl,bc
    res  0,l
call_0E1B
    dec  d
    jr   nz,call_0E10
    ret
    add  hl,hl
    or   a
    dec  a	
call_0E22
    ld   hl,data_0E30
    call call_0D89
    ld   de,l_e380	
    ld   b,$02
    jp   call_0E91
data_0E30
	BYTE $00,$00,$00,$80,$AB,$AA,$00,$C0,$CD,$CC,$55,$D5,$6E,$DB,$00,$E0
	BYTE $8E,$E3,$66,$E6,$00,$F0,$00,$F8,$00,$FC,$00,$FE,$00,$FF,$80,$FF
	BYTE $C0,$FF,$E0,$FF,$F0,$FF,$F8,$FF,$FC,$FF,$FE,$FF,$FF,$FF



call_0E5E           ;does e37f point to address in FE00 space??
    ld   hl,(l_e37f)
    add  hl,hl
    ccf
    rla
    and  $01
    ld   c,a
    ld   a,l
    rrca
    rrca
    rrca
    rrca
    and  $01
    xor  c
    ld   c,a
    ld   a,l
    and  $FE
    or   c
    ld   l,a
    ld   (l_e37f),hl
    ret
call_0E79
    ld   hl,l_e37f
    inc  (hl)
    ret
call_0E7E    
    ld   hl,l_e380
    dec  (hl)
    jp   call_0E5E

call_0E85
    push bc
    push de
    push hl
    ld   b,$03
    call call_0E91
    pop  hl
    pop  de
    pop  bc
    ret
call_0E91
    ld   a,(de)
    cp   (hl)
    ret  nz
    dec  de
    dec  hl
    djnz call_0E91
    ret
	
call_0E9A
    ;hl points to text
    ;de screen location
    ;c=colour 

	ld   b,(hl)		;get text length
	inc  hl
call_0E9C
	ld   a,(hl)
    ld   (de),a
    inc  hl
    inc  de
    ld   a,c
	ld   (de),a
	inc  de
    djnz call_0E9C
	ret



call_0EAA
    push bc
    ld   e,(iy+$00)
    ld   d,(iy+$01)
    ld   l,(iy+$02)
    ld   h,(iy+$03)
    ld   c,(iy+$04)
    call call_0E9A;writetext
    pop  bc
    ld   de,$0005
    add  iy,de
    djnz call_0EAA
    ret
	
call_0EC6_Adjusted
	ex de,hl
call_0EC6_Adjusted_loop2
	push bc
	push de;hl
	ld b,c
call_0EC6_Adjusted_loop1
	push af
	add a,(hl)
	;ld a,(hl)
	;push af
	ld (de),a
	inc de
	;pop af
	jr nc,call_0EC6_Adjusted_in_first_256
	ex af,af'
	inc a
	ld (de),a
	dec a
	jr call_0EC6_Adjusted_in_second_256
call_0EC6_Adjusted_in_first_256
	ex af,af'
	ld (de),a
call_0EC6_Adjusted_in_second_256
	ex af,af'
	inc de
	inc hl
	pop af
	djnz call_0EC6_Adjusted_loop1
	pop de;hl
	ex de,hl
	ld bc,80
	add hl,bc
	ex de,hl
	pop bc
	djnz call_0EC6_Adjusted_loop2
	ex de,hl
	ret



call_0EC6			;routine copies data to screen - column by column`
    push bc			;eaxh screen char is 16 bits, to manage char code, banking, colour and x/y flip
    push hl
    ld   b,c
call_0EC9
    ex   af,af'
    ld   a,(de)
    ld   (hl),a
    ex   af,af'
    inc  hl
    ld   (hl),a
    inc  de
    ex   af,af'
    ld   a,$1;$3F
    call adda2hl;$0D89
    ex   af,af'
    djnz call_0EC9
    pop  hl
	ld bc,$50
	add hl,bc
    pop  bc
    ;inc  hl
    ;inc  hl
    djnz call_0EC6
    ret

/*
leftlogoloop
	push bc
	push hl
	ld b,c
leftlogoloop1
	ld a,(de)
	add a,90
	ld (hl),a
	inc hl
	ld a,1*16			;palette 1 offset
	ld (hl),a
	inc hl
	inc de
	djnz leftlogoloop1
	pop hl
	ld bc,80
	add hl,bc
	pop bc
	djnz leftlogoloop
	ret
	
rightlogoloop
	push bc
	push hl
	ld b,c
rightlogoloop1
	ld a,(de)
	add a,224
	push af
	ld (hl),a
	inc hl
	pop af
	ld a,1*16			;palette 1 offset
	jr nc,rightloopinfirst256
	inc a
rightloopinfirst256
	ld (hl),a
	inc hl
	inc de
	djnz rightlogoloop1
	pop hl
	ld bc,80
	add hl,bc
	pop bc
	djnz rightlogoloop
	ret
	

	
superbblogoloop
	push bc
	push hl
	ld b,c
superbblogoloop1
	ld a,(de)
	sub 75
	;ld a,117
	ld (hl),a
	inc hl
	ld a,1*16+1
	ld (hl),a
	inc hl
	inc de
	djnz superbblogoloop1
	pop hl
	ld bc,80
	add hl,bc
	pop bc
	djnz superbblogoloop
	ret
*/	
	
call_0EE0
    ld   hl,l_fc21
    bit  6,(hl)
    ret  nz
    ld   (l_f7fe),a
    ld   b,$00
    bit  0,a
    jr   z,call_0EF1
    set  7,b
call_0EF1
    bit  1,a
    jr   z,call_0EF7
    set  6,b
call_0EF7
    bit  2,a
    jr   z,call_0EFD
    set  5,b
call_0EFD
     bit  3,a
     jr   z,call_0F03
     set  4,b
call_0F03
     bit  4,a
     jr   z,call_0F09
     set  3,b
call_0F09
     bit  5,a
     jr   z,call_0F0F
     set  2,b
call_0F0F
     bit  6,a
     jr   z,call_0F15
     set  1,b
call_0F15
     bit  7,a
     jr   z,call_0F1B
     set  0,b
call_0F1B
     ld   a,b
     ld   hl,l_f7ff
     ld   b,(hl)
     ld   (hl),a
     ld   a,b
call_0F22
     cp   (hl)
     jr   z,call_0F22       ;hang associated with DIP Switch B-#7
     ret
     
call_0F26
    ld   a,(l_fc21)
    bit  6,a
    ret  nz
    ld   a,$0E
    call call_0EE0
    ld   a,(l_e643)
    call div16;$0D62
    and  $0F
    call call_0EE0
    ld   a,(l_e643)
    call mul16;$0D6D
    and  $F0
    ld   e,a
    ld   a,(l_e642)
    call div16;$0D62
    or   e
    call call_0EE0
    ld   a,(l_e642)
    call mul16;$0D6D
    and  $F0
    ld   e,a
    ld   a,(l_e641)
    call div16;$0D62
    or   e
    call call_0EE0
    ld   a,(l_e641)
    call mul16;$0D6D
    call call_0EE0
    ld   a,(l_e64b)
    inc  a
    or   a
    daa
    jp   call_0EE0

call_0F74
    ld   a,(l_fc21)
    bit  6,a
    ret  nz
    ld   a,$0F
    call call_0EE0
    ld   a,(l_e648)
    call div16;$0D62
    and  $0F
    call call_0EE0
    ld   a,(l_e648)
    call mul16;$0D6D
    and  $F0
    ld   e,a
    ld   a,(l_e647)
    call div16;$0D62
    or   e
    call call_0EE0
    ld   a,(l_e647)
    call mul16;$0D6D
    and  $F0
    ld   e,a
    ld   a,(l_e646)
    call div16;$0D62
    or   e
    call call_0EE0
    ld   a,(l_e646)
    call mul16;0D6D
    call call_0EE0
    ld   a,(l_e64b)
    inc  a
    or   a
    daa
    jp   call_0EE0
	
call_0FC2
	call call_1028
    ld   d,c
    cp   $30
    jr   nz,call_0FD2
    ld   a,b
    cp   $30
    jr   nz,call_0FD1
    ld   b,$00
call_0FD1
	xor  a
call_0FD2
	ld   (iy-$02),a
	ld   (iy-$01),$00
    ld   (iy+$00),b
	ld   (iy+$01),$00
	ld   (iy+$02),d
	ld   (iy+$03),$00
	ret

call_1008
    ld   hl,data_1025
call_100B
    ld   b,$00
    ld   c,(hl)			;100, then 10, then 1
call_100E			
    sub  c				;sub 100, or 10, or 1
    jr   c,call_1014	;if number less than 100/10/1 leave with b holding the amount of 100s
    inc  b				;else inc b
    jr   call_100E
call_1014
    add  a,c			;add back the last subtract that caused the carry to get the correct position
						;as othewise a would be left as a negative
    push bc				;and store
    inc  hl
    bit  0,c			;loop after 100s and 10s, but not 1s
    jr   z,call_100B	;we have three BCs on the stack when we exit
    pop  bc				;get 1s into b
    pop  af				;get 10s into a
    rrca				;copy 10s into top nibble
    rrca
    rrca
    rrca
    or   b				;put 1s into bottom nibble
    pop  bc				;get 100s into b
    ld   c,a			;get 10s into c top nibble and 1s into c bottom nibble
    ret					;on ret BC has 100 and 10s in each byte and A has 10s and 1s BCD packed???

data_1025
	BYTE $64,$0A,$01

call_1028	
	call   call_1008
	push bc
	ld   a,c
	and  $F0
	rrca
    rrca
    rrca
    rrca
    add  a,$30
    ld   b,a
    ld   a,c
    and  $0F
    add  a,$30
    ld   c,a
    pop  af
    add  a,$30
    ret


call_1040
    call call_1008
    push bc
    ld   a,c
    and  $F0
    rrca
    rrca
    rrca
    rrca
    ld   b,a
    ld   a,c
    and  $0F
    ld   c,a
    pop  af
    ret

    
call_109C
    ld   hl,data_10A2
    jp   call_0DA7

data_10A2
    BYTE LOW data_10E2,HIGH data_10E2
    BYTE LOW data_10E4,HIGH data_10E4
    BYTE LOW data_10EA,HIGH data_10EA
    BYTE LOW data_10F5,HIGH data_10F5
    BYTE LOW data_10FB,HIGH data_10FB

    BYTE LOW data_1106,HIGH data_1106
    BYTE LOW data_110C,HIGH data_110C
    BYTE LOW data_1117,HIGH data_1117
    BYTE LOW data_111D,HIGH data_111D
    BYTE LOW data_111F,HIGH data_111F
    BYTE LOW data_1125,HIGH data_1125
    BYTE LOW data_1130,HIGH data_1130
    BYTE LOW data_1136,HIGH data_1136

    BYTE LOW data_1141,HIGH data_1141
    BYTE LOW data_1147,HIGH data_1147
    BYTE LOW data_1152,HIGH data_1152
    BYTE LOW data_1158,HIGH data_1158
    BYTE LOW data_115A,HIGH data_115A
    BYTE LOW data_1160,HIGH data_1160
    BYTE LOW data_116B,HIGH data_116B
    BYTE LOW data_1171,HIGH data_1171

    BYTE LOW data_117C,HIGH data_117C
    BYTE LOW data_1182,HIGH data_1182
    BYTE LOW data_118D,HIGH data_118D
    BYTE LOW data_1193,HIGH data_1193
    BYTE LOW data_1195,HIGH data_1195
    BYTE LOW data_119B,HIGH data_119B
    BYTE LOW data_11A6,HIGH data_11A6
    BYTE LOW data_11AC,HIGH data_11AC

    BYTE LOW data_11B7,HIGH data_11B7
    BYTE LOW data_11BD,HIGH data_11BD
    BYTE LOW data_11C8,HIGH data_11C8

data_10E2
	BYTE $01,$88
data_10E4
	BYTE $11,$01,$01,$01,$01,$88
data_10EA
	BYTE $11,$01,$11,$01,$01,$11,$01,$11,$01,$00,$88
data_10F5
	BYTE $11,$01,$11,$01,$10,$88
data_10FB
	BYTE $11,$11,$00,$11,$11,$00,$11,$11,$00,$11,$88
data_1106
	BYTE $11,$10,$11,$10,$01,$88
data_110C
	BYTE $11,$10,$11,$10,$10,$11,$10,$11,$10,$00,$88
data_1117
	BYTE $11,$10,$10,$10,$10,$88
data_111D
	BYTE $10,$88
data_111F
	BYTE $1F,$10,$10,$10,$10,$88
data_1125
	BYTE $1F,$10,$1F,$10,$10,$1F,$10,$1F,$10,$00,$88
data_1130
	BYTE $1F,$1F,$10,$1F,$00,$88
data_1136
	BYTE $1F,$1F,$00,$1F,$1F,$00,$1F,$1F,$00,$1F,$88
data_1141
	BYTE $1F,$0F,$1F,$0F,$10,$88
data_1147
	BYTE $1F,$0F,$0F,$1F,$0F,$0F,$1F,$0F,$0F,$10,$88
data_1152
	BYTE $1F,$0F,$0F,$0F,$0F,$88
data_1158
	BYTE $0F,$88
data_115A
	BYTE $FF,$0F,$0F,$0F,$0F,$88
data_1160
	BYTE $FF,$0F,$FF,$0F,$0F,$FF,$0F,$FF,$0F,$00,$88
data_116B
	BYTE $FF,$0F,$FF,$0F,$F0,$88
data_1171
	BYTE $FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$FF,$88
data_117C
	BYTE $FF,$F0,$FF,$F0,$0F,$88
data_1182
	BYTE $FF,$F0,$FF,$F0,$F0,$FF,$F0,$FF,$F0,$00,$88
data_118D
	BYTE $FF,$F0,$F0,$F0,$F0,$88
data_1193
	BYTE $F0,$88
data_1195
	BYTE $F1,$F0,$F0,$F0,$F0,$88
data_119B
	BYTE $F1,$F0,$F1,$F0,$F0,$F1,$F0,$F1,$F0,$00,$88
data_11A6
	BYTE $F1,$F1,$F0,$F1,$00,$88
data_11AC
	BYTE $F1,$F1,$00,$F1,$F1,$00,$F1,$F1,$00,$F1,$88
data_11B7
	BYTE $F1,$01,$F1,$01,$F0,$88
data_11BD
	BYTE $F1,$01,$01,$F1,$01,$01,$F1,$01,$01,$F0,$88
data_11C8
	BYTE $F1,$01,$01,$01,$01,$88

    
data_11CE
	BYTE LOW data_1220,HIGH data_1220
	BYTE LOW data_1222,HIGH data_1222
	BYTE LOW data_122D,HIGH data_122D
	BYTE LOW data_1233,HIGH data_1233
	BYTE LOW data_123E,HIGH data_123E
	BYTE LOW data_1244,HIGH data_1244
	BYTE LOW data_1247,HIGH data_1247
	BYTE LOW data_124D,HIGH data_124D	;x 8
	
	BYTE LOW data_1258,HIGH data_1258
	BYTE LOW data_125E,HIGH data_125E
	BYTE LOW data_1269,HIGH data_1269
	BYTE LOW data_126B,HIGH data_126B
	BYTE LOW data_1276,HIGH data_1276
	BYTE LOW data_127C,HIGH data_127C
	BYTE LOW data_1287,HIGH data_1287
	BYTE LOW data_128D,HIGH data_128D	;x 8
	
	BYTE LOW data_1290,HIGH data_1290
	BYTE LOW data_1296,HIGH data_1296
	BYTE LOW data_12A1,HIGH data_12A1
	BYTE LOW data_12A7,HIGH data_12A7
	BYTE LOW data_12B2,HIGH data_12B2
	BYTE LOW data_12B4,HIGH data_12B4
	BYTE LOW data_12BF,HIGH data_12BF
	BYTE LOW data_12C5,HIGH data_12C5	;x 8
	
	BYTE LOW data_12D0,HIGH data_12D0
	BYTE LOW data_12D6,HIGH data_12D6
	BYTE LOW data_12D9,HIGH data_12D9
	BYTE LOW data_12DF,HIGH data_12DF
	BYTE LOW data_12EA,HIGH data_12EA
	BYTE LOW data_12F0,HIGH data_12F0
	BYTE LOW data_12FB,HIGH data_12FB
	BYTE LOW data_12FD,HIGH data_12FD	;x 8
	
	BYTE LOW data_1308,HIGH data_1308
	BYTE LOW data_130E,HIGH data_130E
	BYTE LOW data_1319,HIGH data_1319
	BYTE LOW data_131F,HIGH data_131F
	BYTE LOW data_1322,HIGH data_1322
	BYTE LOW data_1328,HIGH data_1328
	BYTE LOW data_1333,HIGH data_1333
	BYTE LOW data_1339,HIGH data_1339
	BYTE LOW data_1344,HIGH data_1344	;x 9
	;total table address = 8+8+8+8+9=43 (0x2B)
	;total bytes = 43 x 2 = 86 (0x56)
	
    ;BYTE $20,$12,$22,$12,$2D,$12,$33,$12,$3E,$12,$44,$12,$47,$12,$4D,$12
    ;BYTE $58,$12,$5E,$12,$69,$12,$6B,$12,$76,$12,$7C,$12,$87,$12,$8D,$12
    ;BYTE $90,$12,$96,$12,$A1,$12,$A7,$12,$B2,$12,$B4,$12,$BF,$12,$C5,$12
    ;BYTE $D0,$12,$D6,$12,$D9,$12,$DF,$12,$EA,$12,$F0,$12,$FB,$12,$FD,$12
    ;BYTE $08,$13,$0E,$13,$19,$13,$1F,$13,$22,$13,$28,$13,$33,$13,$39,$13
    ;BYTE $44,$13


data_1220
	BYTE $00,$FF
data_1222
	BYTE $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF
data_122D
	BYTE $01
    BYTE $00,$00,$00,$00,$FF
data_1233
	BYTE $01,$00,$00,$01,$00,$00,$01,$00,$00,$00,$FF
data_123E
    BYTE $01,$00,$01,$00,$00,$FF
data_1244
	BYTE $01,$00,$FF
data_1247
	BYTE $01,$00,$01,$00,$01,$FF
data_124D
	BYTE $01
    BYTE $01,$00,$01,$01,$00,$01,$01,$00,$01,$FF
data_1258
	BYTE $01,$01,$01,$01,$00,$FF
data_125E
    BYTE $01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$FF
data_1269
	BYTE $01,$FF
data_126B
	BYTE $01,$01,$01
    BYTE $01,$01,$01,$01,$01,$01,$02,$FF
data_1276
	BYTE $01,$01,$01,$01,$02,$FF
data_127C
	BYTE $02,$01
    BYTE $01,$01,$02,$01,$01,$01,$02,$01,$FF
data_1287
	BYTE $01,$02,$01,$01,$02,$FF
data_128D
	BYTE $01,$02,$FF
data_1290
	BYTE $02,$01,$02,$01,$02,$FF
data_1296
	BYTE $02,$02,$02,$02,$01,$02,$02,$02
    BYTE $01,$01,$FF
data_12A1
	BYTE $01,$02,$02,$02,$02,$FF
data_12A7	
	BYTE $02,$02,$02,$02,$02,$02,$02
    BYTE $02,$02,$01,$FF
data_12B2
	BYTE $02,$FF
data_12B4
	BYTE $03,$02,$02,$02,$02,$02,$02,$02,$02,$02
    BYTE $FF
data_12BF
	BYTE $02,$02,$02,$02,$03,$FF
data_12C5
	BYTE $03,$02,$02,$02,$03,$02,$02,$02,$03
    BYTE $02,$FF
data_12D0
	BYTE $02,$03,$02,$02,$03,$FF
data_12D6
	BYTE $02,$03,$FF
data_12D9
	BYTE $03,$02,$03,$02,$03
    BYTE $FF
data_12DF
	BYTE $03,$03,$03,$03,$02,$03,$03,$03,$02,$02,$FF
data_12EA
	BYTE $02,$03,$03,$03
    BYTE $03,$FF
data_12F0
	BYTE $03,$03,$03,$03,$03,$02,$03,$03,$03,$03,$FF
data_12FB
	BYTE $03,$FF
data_12FD
	BYTE $04
    BYTE $03,$03,$03,$03,$03,$03,$03,$03,$03,$FF
data_1308
	BYTE $03,$03,$03,$03,$04,$FF
data_130E
	BYTE $04,$03,$03,$03,$04,$03,$03,$03,$04,$03,$FF
data_1319
	BYTE $03,$04,$03,$03,$04
    BYTE $FF
data_131F
	BYTE $03,$04,$FF
data_1322
	BYTE $04,$03,$04,$03,$04,$FF
data_1328
	BYTE $04,$04,$04,$04,$03,$04
    BYTE $04,$04,$03,$03,$FF
data_1333
	BYTE $03,$04,$04,$04,$04,$FF
data_1339
	BYTE $04,$04,$04,$04,$04
    BYTE $03,$04,$04,$04,$04,$FF
data_1344
	BYTE $04,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    BYTE $FF,$FF

call_1350
    ld   a,(l_e5d3)
    and  a
    jr   z,call_135C
    ld   hl,l_fc20
    bit  3,(hl)
    ret  z
call_135C               ;add sound command to queue
    ld   hl,l_e391
    ld   a,(hl)
    cp   $0F
    ret  z
    inc  (hl)
    ld   hl,l_e381
    call adda2hl;$0D89
    ld   (hl),c
    ret

    



call_1387
    ret
	
call_13C4
    ld   b,$00
    ld   hl,l_ed21
call_13C9
    bit  0,(hl)
    jr   z,call_13E4
    push hl
    inc  hl
    ld   a,(hl)
    sub  e
    jp   p,call_13D6
    neg
call_13D6
    cp   c
    jr   nc,call_13E2
    inc  hl
    ld   a,(hl)
    sub  d
    jp   p,call_13E1
    neg
call_13E1
    cp   c
call_13E2
    pop  hl
    ret  c
call_13E4
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  b
    ld   a,b
    cp   $07
    jr   nz,call_13C9
    xor  a
    ret

    
call_13F0
    ld   hl,l_e691
    bit  0,(hl)
    jp   z,call_141B
    inc  hl
    ld   a,(hl)
    sub  (ix+$01)
    jp   p,call_1402
    neg
call_1402
    cp   c
    jp   nc,call_141B
    inc  hl
    ld   a,(hl)
    sub  (ix+$02)
    jp   p,call_1410
    neg
call_1410
    cp   b
    jp   nc,call_141B
    ld   a,(l_e698)
    ld   c,a
    ld   a,$00
    ret
call_141B
    ld   hl,l_e6c3
    bit  0,(hl)
    jp   z,call_1442
    inc  hl
    ld   a,(hl)
    sub  (ix+$01)
    jp   p,call_142D
    neg
call_142D
    cp   c
    ret  nc
    inc  hl
    ld   a,(hl)
    sub  (ix+$02)
    jp   p,call_1439
    neg
call_1439
    cp   b
    ret  nc
    ld   a,(l_e6ca)
    ld   c,a
    ld   a,$01
    ret
call_1442
    xor  a
    ret
call_1444
    ld   bc,$0E0E
call_1447
    ld   a,l
    sub  (ix+$01)
    jp   p,call_1450
    neg
call_1450
    cp   b
    ret  nc
    ld   a,h
    sub  (ix+$02)
    jp   p,call_145B
    neg
call_145B
    cp   c
    ret
	


;call_145D    
;	;For SJ we need to calc the position within the pattern address bank
;    ld  h,a
;    and  $1F        ;mask to screen offset				;39 & 1f = 19
;	sla a
;	sla a												;=64
;    ld   l,a
;	ld a,h
;	rlca		;8 bit rotate
;	rlca		;3 times
;	rlca		;to move bits 6&5 into 1&0				;=c9
;	and $03		;mask off other bits					;=01
;	or l												;=65
;	ld l,a
	
;	ld   h,$00
;call_1479
;    ret
call_147D	
    ;first call (demo mode)
    ;a=$18	%00011000  
	;screen address would then be
	;%00011000 and $1f = %00011000 * 128 =3,072 = &c00 + &c000 = &cc00
	
    ;bc=$041f   ;b=frame, c & 3 =		
    ;de=$0118
    ;hl=$4ee3	

;	example when a=90 and bc=7821
	
    ;call call_145D		;calculate offset within address bank
	and $7f
	ld h,0
	ld l,a
	push hl
	ld de,pattern_bank
	add hl,de
	ld a,c
	and $3c
	sla a
	sla a
	or $02
	ld (hl),a			;set colour, flip info in pattern_bank plus update required flag
	pop hl
	add hl,hl			;double hl as address bank is 16 bit
	ld de,pattern_addr
	add hl,de			;hl now contains offset within pattern_addr to store gfx address
	
    ld a,c
    and $03
    ld d,a
    ld e,b	;de now contains sprite number relative to a 32k bank - maximum value if $3fc

	;ld de,$03b0
	
	ex de,hl	;swap he and hl for addition purposes
	
	add hl,hl	
	add hl,hl
	add hl,hl
	add hl,hl	;*32
	add hl,hl	;hl contains the address offset within the 32k bank
	
	ex	de,hl	;now hl has the offset to load the address into and de has the offset to load
	ld (hl),e
	inc hl
	ld (hl),d
    ret
	

call_149C
    ;call call_145D		;calculate offset within address bank
	and $7f
	ld h,0
	ld l,a
	push hl
	ld de,pattern_bank
	add hl,de
	ld a,c
	and $3c
	sla a
	sla a
	or $0a
	ld (hl),a			;set colour, flip info in pattern_bank plus update required flag
	pop hl
	add hl,hl			;double hl as address bank is 16 bit
	ld de,pattern_addr
	add hl,de			;hl now contains offset within pattern_addr to store gfx address
	
    ld a,c
    and $03
    ld d,a
    ld e,b	;de now contains sprite number relative to a 32k bank - maximum value if $3fc
	
	ex de,hl	;swap he and hl for addition purposes
	
	add hl,hl	
	add hl,hl
	add hl,hl
	add hl,hl	;*32
	add hl,hl	;hl contains the address offset within the 32k bank
	
	ex	de,hl	;now hl has the offset to load the address into and de has the offset to lead
	ld (hl),e
	inc hl
	ld (hl),d
    ret

call_14BD
    ld   e,(ix+$07)
call_14C0
    ld   d,$00
call_14C2
    ld   a,d
    call mul32
    or   e
    ex   af,af'
    inc  d
    ld   a,d
    cp   $04
    jp   nz,call_14D2
    ld   d,$00
    inc  e
call_14D2
    ex   af,af'
    push de
    push bc
    push hl
    ld   b,(hl)
    call call_147D      ;set sprite
    pop  hl
    pop  bc
    pop  de
    inc  hl
    djnz call_14C2
    ret

/*
call_0FC2   ;Draw credit number
    call call_1028
    ld   d,c
    cp   $30
    jr   nz,call_0FD2
    ld   a,b
    cp   $30
    jr   nz,call_0FD1
    ld   b,$00
call_0FD1
    xor  a
call_0FD2               ;TODO - actual screen address writes..
    push af
    ld a,d
    ;ld a,'0'
    ld de,$5000+$e0+$1f
    call plotcredit 
    ld a,b
    ;ld a,'0'
    ld de,$5000+$e0+$1e
    call plotcredit
    pop af
    ;ld a,'0'
    ld de,$5000+$e0+$1d
    call plotcredit
    ;ld   (iy-$40),a
    ;ld   (iy-$41),$00
;    ld   (iy+$00),b
;    ld   (iy+$01),$00
;    ld   (iy+$40),d
;    ld   (iy+$41),$00
    ret
*/
	
call_21C4
	ld   a,bank3
	call call_026C		;switch in bank 3
	call bank3_call_BE00		;routine in bank 3 to display text
	jp   call_029B		;restore bank
	;no ret needed due to jp above
	
;data_22D6
;	BYTE $0D,$0A,$04,$07
call_22DA
   ld   a,(l_e5dc)
   ld   c,a
   ld   a,(l_fc21)
   and  $03
   ld   hl,data_22D6
   call call_0D89
   ld   a,(hl)
   cp   c
   ret  nc
   ld   (l_e5dc),a
   ret

	
	
call_35FF				;Bank 2 is paged in when we reach here
	call call_029B		;so page it out
	ld a,introbank		;page in the intro bank
	call call_026C		;and call the intro bank version of the routine
	call intro_call_35FF
	call call_029B
	ld a,bank2			;maake sure we page bank 2 bank in
	call call_026C
    ret	
	
call_38F0  	;Routines for the Best Today Level Screen
	call copy_todays_record_tiles
    ld   hl,l_e67e
    ld   bc,$0012
    call call_0D50
    call call_3C60

    ;break
    ld a,introbank		;page in the intro bank
	call call_026C		;and call the intro bank version of the routine
	call intro_call_38FC
   ; break
	jp call_029B
    ;ret

call_39D8
    ;break
    call call_029B      ;Exit intro bank
    ld   a,$05				;failed protection check?!
    call call_0018
    ld a,introbank		;page in the intro bank
	call call_026C		;and call the intro bank version of the routine
	jp intro_call_39DB
	jp call_029B
    ;ret
    
/*
    ld   ix,l_e682
    ld   (ix+$01),$00
    ld   a,(l_e644)
    ld   (ix+$02),a
    ld   a,(l_e5d3)
    and  a
    jr   z,call_3916B
    ld   a,(l_e67c)
    ld   (ix+$02),a
call_3916
    ld   ix,l_e689
    ld   (ix+$01),$01
    ld   a,(l_e649)
    ld   (ix+$02),a
    ld   a,(l_e5d3)
    and  a
    jr   z,call_3930
    ld   a,(l_e67d)
    ld   (ix+$02),a
call_3930
    ld   hl,l_e20d
    ld   de,$0000
    ld   b,$28
call_3938
    call call_18A5
    ld   de,data_3D02
    ld   hl,l_e20d
    ld   b,$28
call_3943
    ld   a,(de)
    ld   (hl),a
    inc  de
    inc  hl
    inc  hl
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  de
    inc  hl
    djnz call_3943
    ld   hl,l_e220
    set  6,(hl)
    ld   hl,l_e234
    set  6,(hl)
    ld   hl,data_3D88
    ld   bc,$041F
    ld   e,$00
    call call_14C0
    ld   hl,data_3D7A
    ld   bc,$071E
    ld   e,$01
    call call_14C0
    ld   a,$03
    ld   bc,$FC1E
    call call_147D
    ld   a,$23
    ld   bc,$F81E
    call call_147D
    ld   a,(l_e67b)
    inc  a
    cp   $65
    jr   nz,call_398C
    ld   a,$64
call_398C
    call call_3C57
    ld   a,$BA
    sub  h
    ld   (l_e241),a
    ld   (l_e291),a
    ld   a,(l_e5d8)
    and  a
    jr   nz,call_39A6
    ld   hl,l_e67e
    set  1,(hl)
    jp   call_39DB
call_39A6
    ld   hl,data_3D88
    ld   bc,$0423
    ld   e,$05
    call call_14C0
    ld   hl,data_3D81
    ld   bc,$0722
    ld   e,$06
    call call_14C0
    ld   a,$08
    ld   bc,$FC22
    call call_147D
    ld   a,$28
    ld   bc,$F822
    call call_147D
;    ld   hl,($0004)
;    ld   de,$00B9
;    or   a
;    sbc  hl,de
    jr   call_39DB
;    rst  $38
call_39D8
    ld   a,$05				;failed protection check?!
    call call_0018
call_39DB
    ld   a,(l_e67e)
    cp   $03
    jp   nz,call_3A79
    ld   hl,data_3DC4
    ld   de,$774a;$D54A
    ld   c,3*16;$00
    call call_0E9A	;writetext "TODAY'S RECORD IS"
    ld   hl,l_e680
    inc  (hl)
    bit  2,(hl)
    jr   nz,call_3A41
    ld   a,$23
    ld   bc,$F81E
    call call_147D
    ld   a,(l_e5d8)
    and  a
    jr   z,call_3A0C
    ld   a,$28
    ld   bc,$F822
    call call_147D
call_3A0C
    ld   hl,data_3DD6
    ld   de,$776E;$D9CA
    ld   c,4*16
    call call_0E9A			;writetext "ROUND "      ""
    ld   iy,$777e;$DBCA
    ld   a,(l_e67b)			;best level reached
    inc  a
    cp   $65
    jr   nz,call_3A31
    ld   (iy-$02),$41
    ld   (iy+$00),$4C
    ld   (iy+$02),$4C
    jr   call_3A34
call_3A31
    call call_0FC2
call_3A34
    ld   a,4*16
    ld   (iy-$01),a
    ld   (iy+$01),a
    ld   (iy+$03),a
    jr   call_3A5C
call_3A41
    ld   hl,data_3DE3
    ld   de,$776C;$D9CA
    ld   c,4*16;$04
    call call_0E9A		;writetext "                "
    ld   a,$23
    ld   bc,$001E
    call call_147D
    ld   a,$28
    ld   bc,$0022
    call call_147D
call_3A5C
    ld   hl,l_e67f
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    jr   nz,call_3A79
    ld   a,$00
    ld (music_playing),a
;    ld   ($FA00),a				;Sound IO - Stop Record Screen sound
    call call_03CB
    call call_03D0
    call call_041E
    call call_031C
    jp   call_0372
call_3A79
    ld   ix,l_e682
    ld   b,$02
call_3A7F
    push bc
    bit  0,(ix+$01)
    jp   nz,call_3B63
    ld   de,$0302
    call call_15CA
    push af
    add  a,a
    add  a,a
    ld   hl,data_3D8C
    call call_0D89
    ld   bc,$041F
    ld   e,$04
    call call_14C0
    ld   a,$43
    ld   bc,$C80F			;This is a gfx code for the 'Round' sprite
    pop  de
    bit  0,d
    jr   z,call_3AAD
    call call_147D
    jr   call_3AB0
call_3AAD
    call call_149C
call_3AB0
    bit  0,(ix+$00)
    jp   nz,call_3C4A
    ld   a,(ix+$03)
    cp   (ix+$02)
    jr   nz,call_3AC8
    ld   (ix+$00),$01
    ld   hl,l_e67e
    set  0,(hl)
call_3AC8
    inc  (ix+$03)
    ld   a,(ix+$03)
    cp   $65
    jr   nz,call_3AD4
    ld   a,$64
call_3AD4
    call call_3C57
    ld   a,$BA
    sub  h
    ld   (l_e23d),a
    ld   a,$D2
    sub  h
    ld   (l_e24d),a
    ld   (l_e251),a
    ld   a,$C2
    sub  h
    ld   (l_e255),a
    ld   (l_e259),a
    ld   (l_e20d),a
    ld   (l_e215),a
    ld   (l_e21d),a
    ld   (l_e221),a
    ld   (l_e225),a
    ld   (l_e229),a
    ld   (l_e22d),a
    ld   a,$B2
    sub  h
    ld   (l_e211),a
    ld   (l_e219),a
    ld   (l_e231),a
    ld   (l_e235),a
    ld   a,(ix+$03)
    cp   $64
    jr   z,call_3B47
    cp   $65
    jr   z,call_3B55
    call call_1040
    ld   a,b
    push bc
    add  a,a
    ld   hl,data_3D94
    call call_0D89
    ld   bc,$021F
    ld   e,$00
    call call_14C0
    pop  bc
    ld   a,c
    add  a,a
    ld   hl,data_3DA8
    call call_0D89
    ld   bc,$021F
    ld   de,$0200
    call call_14C2
    jp   call_3C4A
call_3B47
    ld   hl,data_3DBC
    ld   bc,$041F
    ld   e,$00
    call call_14C0
    jp   call_3C4A
call_3B55
    ld   hl,data_3DC0
    ld   bc,$041F
    ld   e,$00
    call call_14C0
    jp   call_3C4A
call_3B63
    ld   de,$0302
    call call_15CA
    push af
    ld   c,a
    ld   a,(l_e5d8)
    and  a
    jp   z,call_3B83
    ld   a,c
    add  a,a
    add  a,a
    ld   hl,data_3D8C
    call call_0D89
    ld   bc,$0423
    ld   e,$09
    call call_14C0
call_3B83
    pop  de
    ld   a,$48
    ld   bc,$C81B
    bit  0,d
    jr   nz,call_3B92
    call call_147D
    jr   call_3B95
call_3B92
    call call_149C
call_3B95
    ld   a,(l_e5d8)
    and  a
    jp   z,call_3C4A
    bit  0,(ix+$00)
    jp   nz,call_3C4A
    ld   a,(ix+$03)
    cp   (ix+$02)
    jr   nz,call_3BB4
    ld   (ix+$00),$01
    ld   hl,l_e67e
    set  1,(hl)
call_3BB4
    inc  (ix+$03)
    ld   a,(ix+$03)
    cp   $65
    jr   nz,call_3BC0
    ld   a,$64
call_3BC0
    call call_3C57
    ld   a,$BA
    sub  h
    ld   (l_e28d),a
    ld   a,$D2
    sub  h
    ld   (l_e29d),a
    ld   (l_e2a1),a
    ld   a,$C2
    sub  h
    ld   (l_e2a5),a
    ld   (l_e2a9),a
    ld   (l_e25d),a
    ld   (l_e265),a
    ld   (l_e26d),a
    ld   (l_e271),a
    ld   (l_e275),a
    ld   (l_e279),a
    ld   (l_e27d),a
    ld   a,$B2
    sub  h
    ld   (l_e261),a
    ld   (l_e269),a
    ld   (l_e281),a
    ld   (l_e285),a
    ld   a,(ix+$03)
    cp   $64
    jr   z,call_3C32
    cp   $65
    jr   z,call_3C3F
    call call_1040
    ld   a,b
    push bc
call_3C0F
    add  a,a
    ld   hl,data_3D94
    call call_0D89
    ld   bc,$0223
    ld   e,$05
    call call_14C0
    pop  bc
    ld   a,c
    add  a,a
    ld   hl,data_3DA8
    call call_0D89
    ld   bc,$0223
    ld   de,$0205
    call call_14C2
    jr   call_3C4A
call_3C32
    ld   hl,data_3DBC
    ld   bc,$0423
    ld   e,$05
    call call_14C0
    jr   call_3C4A
call_3C3F
    ld   hl,data_3DC0
    ld   bc,$0423
    ld   e,$05
    call call_14C0
call_3C4A
    pop  bc
    ld   de,$0007
    add  ix,de
    dec  b
    jp   nz,call_3A7F
    jp   call_39D8
call_3C57
    ld   b,$00
    ld   c,a
    ld   de,$019A
    jp   call_0DC1
*/
call_3C60
    call call_02AC
    call call_02E4
    ld   hl,data_3CC2
    ;ld   de,$F8E0
	nextreg $43, %00100000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    nextreg $40, $70                  ; (R/W) 0x40 (64) => Palette Index
	ld   b,$40
call_3C60_loop
	call call_0B30_update_entry
	djnz call_3C60_loop
	
	ld   hl,data_3CC2
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tiles
    nextreg $40, $70                  ; (R/W) 0x40 (64) => Palette Index
    ld   b,$40
call_3C60_loop_2	
	call call_0B30_update_entry
	djnz call_3C60_loop_2
	
	;nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tiles
	nextreg $40,$3F				;temporarily change background palette to blue
	nextreg $44,$03
	nextreg $44,$01
	nextreg $40,$31				;temporarily change background palette to White
	nextreg $44,$FF
	nextreg $44,$01
	nextreg $40,$4F				;temporarily change background palette to blue
	nextreg $44,$03
	nextreg $44,$01
	nextreg $40,$41				;temporarily change background palette to Red
	nextreg $44,$E0
	nextreg $44,$00
	
	nextreg $4C,$0B				;change transparency to 0B
	
    ld   hl,$76F8;$CD08
    ld   de,$D070
    ld   bc,$0320
    call call_3CAD
    ld   hl,$76F8+($03*$50);$CD0E
    ld   de,$DA70
    ld   bc,$1720
    call call_3CAD
    ld   a,bank3
    call call_026C
    ld   hl,$76F8+($02*$50);$CD0C
    ld   de,bank3_data_9397
    ld   bc,$0120
    ld   a,7*16;$1D
    call call_0EC6
    ld   hl,$76F8+($03*$50)+$0C;$CE8E
    ld   de,bank3_data_93B7
    ld   bc,$1714
    ld   a,7*16;$1D
    call call_0EC6
    jp   call_029B
call_3CAD
    push bc
    push hl
    ld   b,c
call_3CB0
    ld   (hl),d
    inc  hl
    ld   (hl),e
    inc  hl
;    ld   a,$3E
;    call $0D89
    djnz call_3CB0
    pop  hl
	ld bc,$50
	add hl,bc
    pop  bc
    ;inc  hl
    ;inc  hl
    djnz call_3CAD
    ret

data_3CC2
	BYTE $FF,$F0,$00,$00,$0B,$00,$60,$00,$00,$F0,$90,$00,$40,$00,$09,$F0
	BYTE $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
	BYTE $FF,$F0,$00,$00,$08,$F0,$60,$00,$00,$F0,$90,$00,$40,$00,$09,$F0
	BYTE $0B,$F0,$F0,$70,$0A,$F0,$0F,$F0,$F8,$00,$F7,$70,$D4,$00,$00,$00
/*
data_3D02
	BYTE $C0,$0A,$15,$B0,$0A,$15,$C0,$1A,$15,$B0,$1A,$15,$C0,$FA,$14,$C0
	BYTE $2A,$14,$C0,$3A,$14,$C0,$4A,$14,$C0,$5A,$14,$B0,$FA,$14,$B0,$2A
	BYTE $14,$00,$00,$00,$C8,$68,$14,$B6,$68,$14,$18,$68,$16,$00,$00,$00
	BYTE $D0,$60,$14,$D0,$70,$14,$C0,$60,$14,$C0,$70,$14,$C0,$D6,$15,$B0
	BYTE $D6,$15,$C0,$E6,$15,$B0,$E6,$15,$C0,$96,$14,$C0,$A6,$14,$C0,$B6
	BYTE $14,$C0,$C6,$14,$C0,$F6,$14,$B0,$C6,$14,$B0,$F6,$14,$00,$00,$00
	BYTE $C8,$88,$14,$B6,$88,$14,$18,$88,$16,$00,$00,$00,$D0,$80,$14,$D0
	BYTE $90,$14,$C0,$80,$14,$C0,$90,$14
data_3D7A
	BYTE $B4,$B8,$BC,$C0,$C4,$C8,$CC
data_3D81
	BYTE $D0,$D4,$D8,$DC,$E0,$F0,$F4
data_3D88
	BYTE $40,$54,$94,$A8
data_3D8C
	BYTE $04,$08,$1C,$20,$0C,$10,$24,$28
data_3D94
	BYTE $40,$54,$44,$58
	BYTE $48,$5C,$4C,$60,$50,$64,$68,$7C,$6C,$80,$70,$84,$74,$88,$78,$8C
data_3DA8
	BYTE $90,$A4,$94,$A8,$98,$AC,$9C,$B0,$A0,$B4,$B8,$CC,$BC,$D0,$C0,$D4
	BYTE $C4,$D8,$C8,$DC
data_3DBC
	BYTE $E0,$E8,$E4,$EC
data_3DC0
	BYTE $F0,$F8,$F4,$FC
data_3DC4
	BYTE $11,"TODAY'S RECORD IS"
data_3DD6
	BYTE $0c,$22,"ROUND    ",$22," "
data_3DE3
	BYTE $0c,"            "

*/

call_539F
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,call_53B9
    ld   hl,l_e2c5
    ld   a,(hl)
    cp   $18
    jr   nz,call_53B9
    inc  hl
    inc  hl
    ld   a,(hl)
    cp   $77
    jr   c,call_53B9
    cp   $7A
    jr   c,call_53CF
call_53B9
    ld   hl,l_e5d7
    bit  1,(hl)
    ret  z
    ld   hl,l_e2b5
    ld   a,(hl)
    cp   $18
    ret  nz
    inc  hl
    inc  hl
    ld   a,(hl)
    cp   $77
    ret  c
    cp   $7A
    ret  nc
call_53CF
    ld   a,$03
    call call_0008;rst  $08
    call call_18BB
    call call_03CB
    call call_02AC
    ld   a,(l_e726)
    ld   (l_e64b),a
    ld   hl,l_e358
    ld   (hl),$00
    ld   c,$30
    call call_1350
    ld   hl,l_e342
    ld   (hl),$01
    ld   hl,l_e723
    ld   (hl),$00
    ld   hl,l_e357
    ld   (hl),$01
    ld   hl,l_ed3d
    ld   (hl),$00
    ld   hl,l_e730
    ld   (hl),$00
    xor  a
    call call_0018;rst  $18
/*data_5406
    BYTE $5E,$39,$68,$39,$5F,$39,$69,$39,$72,$39,$7B,$39,$73,$39,$7C,$39*/
data_5406
    BYTE $A9-$15,$E0,$AA-$15,$E0,$B3-$15,$E0,$B4-$15,$E0
    BYTE $BD-$15,$E0,$BE-$15,$E0,$C6-$15,$E0,$C7-$15,$E0

call_5416
    ld   hl,l_e730
    bit  7,(hl)
    ret  z
    jr   call_53CF
call_541E
    ld   hl,l_e727
    inc  (hl)
    ld   a,(hl)
    cp   $07
    ret  nz
    ld   (hl),$00
    inc  hl
    inc  (hl)
    bit  0,(hl)
    jr   nz,call_545B
    ld   hl,data_5488
    ld   de,$774c;CD8A
    ld   bc,$0004
    ldir
    ld   hl,data_548C
    ld   de,$779c;CDCA
    ld   bc,$0004
    ldir
    ld   hl,data_5488
    ld   de,$7780;D40A
    ld   bc,$0004
    ldir
    ld   hl,data_548C
    ld   de,$77d0;D44A
    ld   bc,$0004
    ldir
    ret
call_545B
    ld   hl,data_5490
    ld   de,$774c;CD8A
    ld   bc,$0004
    ldir
    ld   hl,data_5494
    ld   de,$779c;CDCA
    ld   bc,$0004
    ldir
    ld   hl,data_5490
    ld   de,$7780;D40A
    ld   bc,$0004
    ldir
    ld   hl,data_5494
    ld   de,$77d0;D44A
    ld   bc,$0004
    ldir
    ret
data_5488
    BYTE $E4-$15,$E0,$E5-$15,$E0
data_548C
    BYTE $EE-$15,$E0,$EF-$15,$E0
data_5490
    BYTE $F8-$15,$E0,$F9-$15,$E0
data_5494
    BYTE $EC,$E0,$ED,$E0
	
call_5C2B				;INTRO ERROR - THIS IS WHERE IX SHOULD GET LOADED (PROBABLY)
    call call_60F3
    ld   ix,l_e76c
    ld   hl,l_e75d
    dec  (hl)
    xor  a
call_5C37
    push af
    ld   a,(ix+$21)
    bit  7,a
    jp   nz,call_5CE8
    bit  5,a
    jp   nz,call_5C78
    bit  6,a
    jp   nz,call_6559
    ld   a,(ix+$00)
    bit  0,a
    jp   nz,call_5D57
    bit  1,a
    jp   nz,call_5D96
    bit  2,a
    jp   nz,call_5E10
    bit  3,a
    jp   nz,call_5EB1
    bit  4,a
    jp   nz,call_5F0B
    bit  6,a
    jp   nz,call_663D
    bit  5,a
    jp   nz,call_66CA
    bit  7,a
    jp   nz,call_5F96
    jp   call_6D8B
call_5C78
    bit  5,(ix+$26)
    jr   nz,call_5CB0
    ld   a,(l_e76a)
    and  a
    jp   nz,call_5F7B
    call call_1537
    call call_64C5
    jp   c,call_602A
    ld   de,$0208
    call call_15CA
    add  a,a
    add  a,a
    add  a,$AC
    ld   b,a
    ld   c,$11
    ld   a,(ix+$07)
    call call_147D
    call call_6144
    call call_6283
    call call_6249
    jp   nc,call_602A
    jp   call_5FE4
call_5CB0
    ld   de,$5000
    call call_604C
    push ix
    ld   ix,l_e691		;player 1 data structure
    bit  0,(ix+$16)
    jr   z,call_5CC6
    ld   ix,l_e6c3
call_5CC6
    set  6,(ix+$2d)
    ld   (ix+$28),$10
    ld   (ix+$2a),$05
    pop  ix
    ld   hl,l_f677
    bit  0,(ix+$16)
    jr   z,call_5CE0
    ld   hl,l_f679
call_5CE0
    ld   (hl),$08
    inc  hl
    ld   (hl),$01
    jp   call_5F7B
call_5CE8
    call call_1537
    ld   e,(ix+$01)
    ld   d,(ix+$02)
    ld   c,$0E
    call call_13C4
    jr   nc,call_5D12
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$09
    ld   hl,l_ed3d
    dec  (hl)
    ld   de,$0300
    call call_604C
;    ld   a,(data_0002)
;    cp   $5E
;    jr   z,call_5D12
;    pop  af
;    pop  bc
call_5D12
    ld   de,$0202
    call call_15CA
    ld   hl,call_5D55
    call call_0D89
    ld   b,(hl)
    ld   c,$1E
    ld   a,(ix+$07)
    bit  0,(ix+$0f)
    jr   z,call_5D2F
    call call_149C
    jr   call_5D32
call_5D2F
    call call_147D
call_5D32
    call call_1529
    inc  hl
    inc  hl
    bit  0,(ix+$0f)
    jr   z,call_5D49
    ld   a,(hl)
    add  a,$05
    ld   (hl),a
    cp   $E9
    jp   nc,call_5FE4
    jp   call_602A
call_5D49
    ld   a,(hl)
    sub  $05
    ld   (hl),a
    cp   $08
    jp   c,call_5FE4
    jp   call_602A
call_5D55
    ld   c,h
    ld   h,h
call_5D57
    bit  0,(ix+$1a)
    jr   nz,call_5D89
    ld   a,(l_e76a)
    and  a
    jp   nz,call_5F7B
    call call_6102
    jp   c,call_5F7B
    call call_64C5
    jp   c,call_602A
    call call_6144
    call call_6115
    ld   a,(ix+$0e)
    and  a
    jp   m,call_5F7B
    call call_6283
    call call_6249
    jp   nc,call_602A
    jp   call_5FE4
call_5D89
    ld   de,$0001
    call call_604C
    ld   hl,l_e5e0
    inc  (hl)
    jp   call_5F7B
call_5D96
    ld   e,(ix+$01)
    ld   d,(ix+$02)
    ld   c,$0E
    call call_13C4
    jp   c,call_5DE5
    ld   a,(l_e76a)
    and  a
    jp   nz,call_5F7B
    call call_1537
    call call_63D1
    jr   z,call_5DBF
    ld   a,(ix+$12)
    sub  (ix+$1f)
    ld   (ix+$12),a
    jp   nc,call_602A
call_5DBF
    call call_61E4
    ld   hl,l_f60f
    bit  0,(ix+$16)
    jr   z,call_5DCC
    inc  hl
call_5DCC
    bit  0,(hl)
    jr   nz,call_5DD7
    ld   (ix+$00),$01
    jp   call_602A
call_5DD7
    ld   (ix+$18),$03
    call call_158B
    ld   (ix+$00),$10
    jp   call_602A
call_5DE5
    ld   (ix+$15),b
    ld   (hl),$80
    inc  hl
    inc  hl
    inc  hl
    ld   a,(hl)
    add  a,a
    add  a,a
    ld   (ix+$19),a
    call call_60A2
    call call_158B
    call call_61E4
    ld   a,(l_e59f)
    ld   (ix+$0d),a
    ld   (ix+$0c),$01
    call call_1556
    ld   (ix+$1a),a
    ld   (ix+$00),$04
call_5E10
    ld   a,(l_f59e)
    and  a
    jr   nz,call_5E94
    ld   a,(l_f590)
    cp   $80
    jr   z,call_5E94
    ld   a,(l_e720)
    and  a
    jr   nz,call_5E94
    ld   a,(l_e737)
    and  a
    jr   nz,call_5E94
    ld   a,(l_f5b6)
    and  a
    jr   nz,call_5E94
    bit  2,(ix+$1a)
    jr   nz,call_5E66
    call call_6283
    ld   a,(l_e76a)
    and  a
    jr   nz,call_5E6C
    call call_6144
    call call_645C
    ld   a,(ix+$0e)
    cp   $FF
    jp   nz,call_602A
    ld   a,(ix+$15)
    add  a,a
    add  a,a
    ld   hl,l_ed21
    call call_0D89
    ld   (hl),$20
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    jp   call_5F7B
call_5E66
    ld   de,$0100
    call call_604C
call_5E6C
    ld   a,(ix+$15)
    add  a,a
    add  a,a
    ld   hl,l_ed21
    call call_0D89
    ld   (hl),$40
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$22)
    ld   (hl),a
    ld   hl,l_ed3d
    dec  (hl)
    ld   c,$25
    call call_1350
    jp   call_5F7B
call_5E94
    ld   a,(ix+$15)
    add  a,a
    add  a,a
    ld   hl,l_ed21
    call call_0D89
    ld   (hl),$40
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    inc  hl
    ld   (hl),$06
    jp   call_5F7B
call_5EB1
    bit  3,(ix+$1a)
    jr   nz,call_5ED3
    ld   a,(l_e76a)
    and  a
    jr   z,call_5EC4
    ld   hl,l_f676
    inc  (hl)
    jp   call_5F7B
call_5EC4
    call call_6144
    call call_6283
    call call_6249
    jp   nc,call_602A
    jp   call_5FE4
call_5ED3
    ld   hl,l_e742		;player 1 EXTEND variable
    bit  0,(ix+$16)
    jr   z,call_5EDD
    inc  hl				;change it to P2 EXTEND variable
call_5EDD
    ld   a,(ix+$17)
    ld   de,data_5F05	;lookup mask value
    call call_0D84
    ld   a,(de)
    or   (hl)
    ld   (hl),a			;and apply it to P1/P2 variable
    push af
    ld   a,(ix+$17)
    ld   hl,l_e5f8
    call call_0D89
    inc  (hl)
	
	call call_62FB
	;call call_7007		;temp!
	
    ld   c,$17
    call call_1350
    pop  af				;retrieve to mask value
    cp   $3F			;all 6 EXTEND collected?
    jp   nz,call_5F7B	;if not carry on
    jp   call_602A		;else go to EXTEND routine?
data_5F05
	BYTE $01,$02,$04,$08,$10,$20
call_5F0B
    bit  4,(ix+$1a)
    jp   nz,call_5F5C
    call call_6283
    ld   a,(l_e76a)
    and  a
    jp   nz,call_5F7B
    call call_6144
    call call_60B6
    ld   a,(ix+$0e)
    and  a
    jp   m,call_5F7B
    ld   de,$0A04
    call call_15CA
    ld   hl,data_5F71
    call call_0D89
    ld   a,(ix+$18)
    dec  a
    call call_0D6D
    ld   b,a
    add  a,a
    add  a,b
    add  a,(hl)
    ld   b,a
    ld   a,(ix+$0e)
    add  a,a
    add  a,a
    ld   c,a
    add  a,a
    add  a,c
    add  a,b
    ld   b,a
    ld   a,(ix+$07)
    ld   c,$1C
    call call_147D
    call call_6249
    jp   nc,call_602A
    jp   call_5FE4
call_5F5C
    ld   de,$0010
    call call_604C
    ld   a,(ix+$18)
    dec  a
    ld   hl,data_5F75
    call call_0DA7
    ex   de,hl
    inc  (hl)
    jp   call_5F7B
data_5F71
	BYTE $04,$08,$0c,$08
data_5F75
	;BYTE $e2,$e5,$e3,$e5,$e1,$e5
    BYTE LOW l_e5e2,HIGH l_e5e2
    BYTE LOW l_e5e3,HIGH l_e5e3
    BYTE LOW l_e5e1,HIGH l_e5e1
call_5F7B
    ld   hl,l_e75b
    dec  (hl)
    set  0,(ix+$0b)
    call call_1556
    ld   (ix+$1a),a
    ld   (ix+$21),a
    ld   (ix+$26),a
    ld   (ix+$00),$80
    call call_1570
call_5F96
    ld   de,$0408
    call call_15CA
    jr   z,call_5FBC
    ld   c,a
    add  a,a
    ld   hl,data_6055
    call call_0D89
    ld   b,(hl)
    ld   a,c
    cp   $02
    jr   nc,call_5FB1
    ld   a,(ix+$1b)
    add  a,b
    ld   b,a
call_5FB1
    inc  hl
    ld   c,(hl)
    ld   a,(ix+$07)
    call call_147D
    jp   call_602A
call_5FBC
    ld   a,(ix+$18)
    cp   $01
    jp   z,call_6633
    cp   $02
    jp   z,call_660D
    cp   $03
    jp   z,call_66A1
    ld   a,(l_ed3d)
    and  a
    jp   nz,call_5FE4
    ld   a,(l_e64b)
    cp   $64
    jp   z,call_5FE4
    ld   a,(l_e744)
    and  a
    jp   p,call_64C7
call_5FE4
    call call_154C
    bit  0,(ix+$0b)
    jr   nz,call_5FF1
    ld   hl,l_e75b
    dec  (hl)
call_5FF1
    call call_1556
    ld   (ix+$00),a
    ld   (ix+$1a),a
    ld   (ix+$08),a
    ld   (ix+$09),a
    ld   (ix+$0c),a
    ld   (ix+$0d),a
    ld   (ix+$0e),a
    ld   (ix+$16),a
    ld   (ix+$18),a
    ld   (ix+$1c),a
    ld   (ix+$1b),a
    ld   (ix+$01),a
    ld   (ix+$02),a
    ld   (ix+$20),a
    ld   (ix+$21),a
    ld   (ix+$11),a
    ld   (ix+$0b),a
    jp   call_602A
call_602A
    ld   de,$0028
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_e76b
    cp   (hl)
    jp   nz,call_5C37
    xor  a
    ld   (l_e76a),a
    ld   (l_e756),a
    ld   (l_e757),a
    ld   (l_e758),a
    ld   (l_e759),a
    ld   (l_e75a),a
    ret
call_604C
    ld   a,(ix+$16)
    ld   (l_e5d6),a
    jp   call_2FB3
data_6055
	BYTE $94,$1C,$A0,$1C,$14,$1F,$18,$1F,$14,$1F,$18,$1F,$14,$1F,$18,$1F
call_6065
    ret

call_60A2
    ld   a,(ix+$16)
    ld   (ix+$0e),a
    ret
call_60A9
    ld   a,(ix+$0d)
    and  a
    jr   nz,call_60B2
    ld   a,$04
    ret
call_60B2
    ld   a,(ix+$0e)
    ret
call_60B6
    dec  (ix+$0c)
    jp   nz,call_60CE
    ld   (ix+$0c),$3C
    dec  (ix+$0d)
    ld   a,(ix+$0d)
    cp   $FF
    ret  nz
    ld   (ix+$0e),$FF
    ret
call_60CE
    ld   a,(ix+$0d)
    cp   $04
    ret  nc
    or   a
    jr   z,call_60E2
    ld   hl,data_60EF
    call call_0D89
    ld   a,(hl)
    ld   (ix+$0e),a
    ret
call_60E2
    ld   a,$02
    bit  2,(ix+$0c)
    jr   z,call_60EB
    inc  a
call_60EB
    ld   (ix+$0e),a
    ret
data_60EF
	BYTE $03,$03,$02,$02
call_60F3
    ld   a,(l_e75b)
    cp   $14
    ret  c
    ld   hl,l_e755
    ld   a,(hl)
    and  a
    ret  nz
    ld   (hl),$02
    ret
call_6102
    ld   a,(l_e64b)
    cp   $63
    jr   z,call_6110
    ld   hl,l_e755
    ld   a,(hl)
    and  a
    jr   nz,call_6112
call_6110
    xor  a
    ret
call_6112
    dec  (hl)
    scf
    ret
call_6115
    inc  (ix+$25)
    ld   a,(ix+$25)
    cp   $06
    jr   c,call_6127
    ld   (ix+$25),$00
    ld   (ix+$1b),$00
call_6127
    call call_60B6
    ld   a,(ix+$0e)
    ld   hl,data_6140
    call call_0D89
    ld   a,(ix+$1b)
    add  a,(hl)
    ld   b,a
call_6138
    ld   c,$1C
    ld   a,(ix+$07)
    jp   call_147D				;Draw bubbles
data_6140
	BYTE $64,$70,$7c,$88	
call_6144
    ld   a,(l_fc76)
    ld   hl,data_11CE
    call call_0DA7
    ld   a,(ix+$24)
    call call_0D84
    ld   a,(de)
    or   a
    jp   p,call_615E
    ld   (ix+$24),$00
    jr   call_6144
call_615E
    ld   (ix+$23),a
    inc  (ix+$24)
    ld   a,(ix+$23)
    or   a
    ret  z
    ld   b,a
call_616A
    push bc
    call call_1537
    call call_6175
    pop  bc
    djnz call_616A
    ret
call_6175
    ld   a,(ix+$0a)
    ld   hl,data_61F4
    call call_0DA7
    ex   de,hl
    jp   (hl)
call_6180
    ld   a,(ix+$02)
    and  $07
    jp   nz,call_618C
    call call_61E4
    ret  nz
call_618C
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    inc  hl
    inc  hl
    inc  (hl)
    ld   (ix+$0f),$01
    ret
call_619A
    ld   a,(ix+$02)
    and  $07
    jp   nz,call_61A6
    call call_61E4
    ret  nz
call_61A6
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    inc  hl
    inc  hl
    dec  (hl)
    ld   (ix+$0f),$03
    ret	
call_61B4
    ld   a,(ix+$01)
    and  $07
    jp   nz,call_61C0
    call call_61E4
    ret  nz
call_61C0
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    inc  (hl)
    ld   (ix+$0f),$00
    ret
call_61CC
    ld   a,(ix+$01)
    and  $07
    jp   nz,call_61D8
    call call_61E4
    ret  nz
call_61D8
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    dec  (hl)
    ld   (ix+$0f),$02	
call_61E3
    ret
call_61E4
    ld   a,(ix+$01)
    ld   h,(ix+$02)
    call call_174C
    cp   (ix+$0a)
    ld   (ix+$0a),a
    ret

	
data_61F4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_6180,HIGH call_6180
	BYTE	LOW call_619A,HIGH call_619A
	BYTE	LOW call_61CC,HIGH call_61CC
	BYTE	LOW call_61E3,HIGH call_61E3
	BYTE	LOW call_61E3,HIGH call_61E3
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
	BYTE	LOW call_61B4,HIGH call_61B4
call_6214
    ld   a,(l_fc76)
    ld   hl,data_622A
    call call_0D89
    ld   a,r
    and  $07
    add  a,(hl)
    ld   (ix+$0d),a
    ld   (ix+$0c),$01
    ret
data_622A
	BYTE $01,$08,$08,$08,$08,$08,$08,$08,$07,$07,$07,$07,$07,$07,$06,$06
	BYTE $06,$06,$06,$05,$05,$05,$05,$05,$04,$04,$04,$04,$03,$03,$03
call_6249
    ld   hl,l_e59b
    ld   a,(ix+$01)
    cp   $F8
    jp   nc,call_626C
    cp   $08
    ret  nc
    bit  7,(ix+$02)
    jp   nz,call_6265
    bit  2,(hl)
    jp   z,call_6281
    scf
    ret
call_6265
	bit  0,(hl)
    jp   z,call_6281
    scf
    ret
call_626C
    bit  7,(ix+$02)
    jp   nz,call_627A
    bit  6,(hl)
    jp   nz,call_6281
    scf
    ret
call_627A
    bit  4,(hl)
    jp   nz,call_6281
    scf
    ret
call_6281
    xor  a
    ret
call_6283
    ld   a,(ix+$13)
    and  a
    jr   z,call_62BD
    ex   af,af'
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,(hl)
    add  a,(ix+$13)
    ld   (hl),a
    call call_1537
    ex   af,af'
    jp   m,call_62A5
    call call_161F
    jp   nz,call_62B9
    jp   call_62AB
call_62A5
    call call_166B
    jp   nz,call_62B9
call_62AB
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,(hl)
    sub  (ix+$13)
    ld   (hl),a
    call call_1537
call_62B9
    ld   (ix+$13),$00
call_62BD
    ld   a,(ix+$14)
    and  a
    ret  z
    ex   af,af'
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    inc  hl
    inc  hl
    ld   a,(hl)
    add  a,(ix+$14)
    ld   (hl),a
    call call_1537
    ex   af,af'
    jp   m,call_62E0
    call call_15E9
    jp   nz,call_62F6
    jp   call_62E6
call_62E0
    call call_1604
    jp   nz,call_62F6
call_62E6
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    inc  hl
    inc  hl
    ld   a,(hl)
    sub  (ix+$14)
    ld   (hl),a
    call call_1537
call_62F6
    ld   (ix+$14),$00
    ret
	
call_62FB
	ld a,introbank
	call call_026C
    call intro_call_62FB
	jp call_029B
	
	
call_634A
    ld   hl,l_e75e
    ld   a,(hl)
    and  a
    jr   z,call_6358
    ld   (ix+$16),$00
    jp   call_6365
call_6358
    ld   hl,l_e764
    ld   a,(hl)
    and  a
    jr   nz,call_6361
    scf
    ret
call_6361
    ld   (ix+$16),$01
call_6365
    push hl
    inc  hl
    ld   a,(hl)
    and  $F8
    ld   e,a
    ld   (ix+$01),e
    inc  hl
    ld   a,(hl)
    and  $FE
    ld   d,a
    ld   (ix+$02),d
    inc  hl
    ld   a,(hl)
    ld   (ix+$0f),a
    inc  hl
    ld   a,(hl)
    ld   (ix+$12),a
    inc  hl
    ld   a,(hl)
    ld   (ix+$1f),a
    call call_1529
    ld   a,e
    sub  $08
    ld   (hl),a
    inc  hl
    inc  hl
    ld   a,d
    sub  $08
    ld   (hl),a
    inc  hl
    ld   (hl),$12
    call call_60A2
    call call_6214
    ld   hl,l_e75b
    inc  (hl)
    ld   a,(l_ed3d)
    and  a
    jr   nz,call_63A9
    set  2,(ix+$27)
call_63A9
    pop  hl
    ld   a,(hl)
    ld   (hl),$00
    cp   $02
    jr   z,call_63C3
    ld   (ix+$11),$01
    ld   (ix+$00),$02
    ld   c,$31
    call call_1350
    call call_65D0
    xor  a
    ret
call_63C3
    call call_159D
    set  7,(ix+$21)
    ld   a,$22        ;Enemy fireball
    ;ld   ($FA00),a   ;TODO - sound
    xor  a
call_63D0
    ret
call_63D1
    ld   a,$05
    bit  0,(ix+$20)
    jr   nz,call_63E5
    ld   de,$0A06
    call call_15CA
    jr   nz,call_63E5
    set  0,(ix+$20)
call_63E5
    add  a,a
    add  a,a
    inc  (ix+$0c)
    bit  3,(ix+$0c)
    jr   nz,call_63FC
    ld   b,$04
    bit  0,(ix+$16)
    jr   z,call_6406
    ld   b,$34
    jr   call_6406
call_63FC
    ld   b,$1C
    bit  0,(ix+$16)
    jr   z,call_6406
    ld   b,$4C
call_6406
    add  a,b
    ld   b,a
    call call_6138
    bit  0,(ix+$0f)
    jr   z,call_6429
    ld   b,(ix+$1f)
call_6414
    call call_1537
    push bc
    call call_15E9
    pop  bc
    ret  z
    call call_1529
    inc  hl
    inc  hl
    inc  (hl)
    djnz call_6414
    ld   a,$FF
    and  a
    ret
call_6429
    ld   b,(ix+$1f)
call_642C
    call call_1537
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    ld   l,a
    push bc
    call call_174B
    pop  bc
    ret  z
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   l,(ix+$01)
    push bc
    call call_174B
    pop  bc
    ret  z
    call call_1529
    inc  hl
    inc  hl
    dec  (hl)
    djnz call_642C
    ld   a,$FF
    and  a
    ret
call_645C
    call call_60B6
    ld   a,(ix+$0e)
    cp   $FF
    ret  z
    ld   de,$050A
    call call_15CA
    ld   hl,data_649B
    call call_0D89
    ld   a,(hl)
    add  a,a
    add  a,a
    ex   af,af'
    ld   a,(ix+$0e)
    add  a,(ix+$19)
    ld   hl,data_64A5
    call call_0D89
    ex   af,af'
    add  a,(hl)
    ld   b,a
    ld   c,$1D
    ld   a,(ix+$19)
    cp   $0C
    jr   c,call_6495
    ld   c,$1E
    cp   $1C
    jr   c,call_6495
    ld   c,$1D
call_6495
    ld   a,(ix+$07)
    jp   call_147D			;Draw 'captured baddie' bubbles 
data_649B
	BYTE $00,$00,$00,$00,$01,$02,$02,$02,$02,$01
data_64A5
	BYTE $04,$10,$1C,$28,$34,$40
	BYTE $4C,$58,$64,$70,$7C,$88
data_64B1
	BYTE $04,$10,$1C,$28,$34,$40,$4C,$58,$64,$70
	BYTE $7C,$88,$94,$A0,$AC,$B8,$94,$A0,$AC,$B8
	
call_64C5
    xor  a
    ret
call_64C7
    bit  2,(ix+$27)
    jp   nz,call_5FE4
    call call_1579
    ld   a,(l_e744)
    add  a,a
    ld   hl,data_64F3
    call call_0D89
    ld   b,(hl)
    inc  hl
    ld   c,(hl)
    ld   a,(ix+$07)
    call call_147D
    ld   (ix+$00),$00
    set  6,(ix+$21)
    set  2,(ix+$27)
    jp   call_602A
data_64F3
	BYTE $B0,$27,$E8,$2B,$B4,$27,$B8,$27,$BC,$27,$C0,$27,$D8,$27,$EC,$2B
	BYTE $E4,$2B,$E0,$2B,$48,$2B,$4C,$27,$50,$27,$54,$27,$58,$27,$5C,$27
	BYTE $60,$27,$64,$27,$68,$27,$6C,$27,$70,$27,$BC,$1C,$C0,$1C,$C4,$1C
	BYTE $C8,$10,$CC,$10,$D0,$10,$84,$24,$88,$24,$8C,$24,$90,$24,$9C,$27
	BYTE $DC,$2B,$74,$27,$AC,$27,$A8,$27,$CC,$27,$E0,$2B,$DC,$2B,$88,$27
	BYTE $98,$27,$F0,$24,$BC,$27,$AC,$1C,$A0,$28,$A8,$1C,$A4,$1C,$9C,$28
	BYTE $CC,$29,$D4,$29,$D8,$29

call_6559	
    bit  0,(ix+$27)
    jr   nz,call_65BC
    bit  6,(ix+$26)
    jr   nz,call_6591
    bit  1,(ix+$27)
    jp   nz,call_602A
    ld   b,$02
call_656E
    push bc
    call call_1537
    ld   a,(ix+$01)
    and  $07
    jr   nz,call_657F
    call call_1676
    jp   z,call_6589
call_657F
    call call_1529
    dec  (hl)
    pop  bc
    djnz call_656E
    jp   call_602A
call_6589
    pop  bc
    set  1,(ix+$27)
    jp   call_602A

call_6591
    ld   c,$1E
    bit  0,(ix+$16)
    jr   z,call_659B
    ld   c,$22
call_659B
    ld   b,$58
    ld   a,(ix+$07)
    call call_147D
    call call_482C
    ld   de,$0070
    call call_604C
    ld   c,$20
    call call_1350
    set  0,(ix+$27)
    ld   (ix+$10),$3C
    jp   call_602A


call_65BC
    ld   a,(l_fc85)
    bit  1,a
    nop
    nop
    dec  (ix+$10)
    jp   z,call_5FE4
    call call_1529
    inc  (hl)
    jp   call_602A
    ret

call_65D0
    ret

;66D1 to 660C nopped out in Redux!	

call_660D
    ld   a,(l_fc85)
    cp   $37
    jr   call_6616
    pop  de
    pop  af
call_6616
    call call_340B
    call call_1530
    ex   de,hl
    ld   hl,l_f557
    ld   a,(hl)
    and  a
    jp   nz,call_5FE4
    ld   (hl),$01
    inc  hl
    ld   (hl),e
    inc  hl
    ld   (hl),d
    inc  hl
    ld   a,(ix+$0f)
    ld   (hl),a
    jp   call_5FE4



call_6633
    call call_158B
    call call_1556
    ld   (ix+$00),$40
call_663D	
    ld   de,$0504
    call call_15CA
    ld   hl,data_669D
    call call_0D89
    ld   b,(hl)
    ld   c,$1C
    ld   a,(ix+$07)
    call call_147D
    call call_1529
    dec  (hl)
    ld   a,(hl)
    cp   $0A
    jp   c,call_5FE4
    call call_1537
    ld   a,(ix+$01)
    and  $07
    jp   nz,call_602A
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    call call_174C
    jp   z,call_602A
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jp   nz,call_602A
    ld   hl,l_f624
    bit  0,(hl)
    jp   nz,call_5FE4
    set  0,(hl)
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$0f)
    ld   (hl),a
    jp   call_5FE4
data_669D
	BYTE $94,$98,$9c,$98
call_66A1
;    ld   hl,$00B9
;    ld   bc,($0004)
;    or   a
;    sbc  hl,bc
;    jr   $66AF
;    push de
;    push hl
call_66AF
    call call_1529
    inc  hl
    inc  hl
    ld   a,$08
    bit  0,(ix+$0f)
    jr   z,call_66BE
    neg
call_66BE
    add  a,(hl)
    ld   (hl),a
    inc  hl
    ld   (hl),$15
    call call_1556
    ld   (ix+$00),$20
call_66CA
    bit  0,(ix+$1c)
    jr   nz,call_6720
    bit  5,(ix+$1a)
    jr   nz,call_6711
    call call_1537
    ld   de,$0504
    call call_15CA
    ld   hl,data_6751
    call call_0D89
    ld   b,(hl)
    ld   c,$1C
    ld   a,(ix+$07)
    call call_147D
    call call_1529
    inc  hl
    inc  hl
    bit  0,(ix+$0f)
    jr   z,call_6705
    dec  (hl)
    dec  (hl)
    dec  (hl)
    ld   a,(hl)
    cp   $04
    jp   c,call_5FE4
    jp   call_602A
call_6705
    inc  (hl)
    inc  (hl)
    inc  (hl)
    ld   a,(hl)
    cp   $F0
    jp   nc,call_5FE4
    jp   call_602A
call_6711
    call call_1556
    set  0,(ix+$1c)
    call call_1579
    ld   c,$33
    call call_1350
call_6720
    ld   de,$0706
    call call_15CA
    jr   z,call_6738
    add  a,a
    add  a,a
    add  a,$04
    ld   b,a
    ld   c,$1D
    ld   a,(ix+$07)
    call call_147D
    jp   call_602A
call_6738
    res  0,(ix+$1c)
    res  5,(ix+$1a)
    ld   a,(l_e64b)
    cp   $63
    jp   z,call_5FE4
    call call_1556
    call call_158B
    jp   call_602A
	
data_6751
	BYTE $A0,$A4,$A8,$A4
call_6755
    ld   hl,l_eb36
    ld   bc,$0020
    call clearbytes;$0D50
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e64b)
    cp   $63
    ret  c
    ld   hl,l_f446
    ld   (hl),$00
    ld   ix,l_eb36
    ld   (ix+$08),$00
    ld   hl,l_e255
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (ix+$09),$0F
    ld   (ix+$07),$10
    ld   (ix+$0c),$1E
    ld   ix,l_eb46
    ld   (ix+$08),$01
    ld   hl,l_e265
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (ix+$09),$1B
    ld   (ix+$07),$11
    ld   (ix+$0c),$22
    ld   hl,l_e255
    ld   de,$0010
    ld   b,$08
    jp   call_18A5



call_6D8B
    call call_634A
    jp   c,call_6D9B
    bit  7,(ix+$21)
    jp   nz,call_5CE8
    jp   call_5D96
call_6D9B 
    ld   a,(l_e75d)
    and  a
    jp   nz,call_602A
    ld   a,(l_ed3d)
    and  a
    jp   z,call_602A
    ld   a,(l_e59b)
    cp   $AA
    jp   z,call_602A
    ld   a,(l_e75b)
    cp   $10
    jp   nc,call_602A
    ld   a,(l_e380)
    bit  0,a
    jr   z,call_6DEC
call_6DC0
    ld   hl,l_e59b
    ld   a,(hl)
    and  $88
    cp   $88
    jr   z,call_6DEC
    bit  3,(hl)
    jr   nz,call_6DD4
    ld   e,$00
    bit  2,(hl)
    jr   z,call_6DD6
call_6DD4
    ld   e,$F0
call_6DD6
    call call_1529
    ld   (hl),e
    inc  hl
    inc  hl
    ld   a,r
    and  $0F
    add  a,$48
    ld   (hl),a
    inc  hl
    ld   (hl),$12
    ld   (ix+$0e),$00
    jr   call_6E16
call_6DEC
    ld   hl,l_e59b
    ld   a,(hl)
    and  $22
    cp   $22
    jr   z,call_6DC0
    bit  1,(hl)
    jr   nz,call_6E00
    ld   e,$00
    bit  0,(hl)
    jr   z,call_6E02
call_6E00
    ld   e,$F0
call_6E02
    call call_1529
    ld   (hl),e
    inc  hl
    inc  hl
    ld   a,r
    and  $0F
    add  a,$98
    ld   (hl),a
    inc  hl
    ld   (hl),$12
    ld   (ix+$0e),$01
call_6E16
    call call_1537
    call call_1530
    call call_6214
    call call_174B
    ld   (ix+$0a),a
    ld   a,(l_e75c)
    ld   (l_e75d),a
    ld   hl,l_e75b
    inc  (hl)
    ld   a,$25
    call call_0E22
    jr   nc,call_6E71
    ld   a,(l_f676)
    and  a
    jr   nz,call_6E82
    ld   a,(l_e380)
    and  $0F
    ld   de,l_e745
    call call_0D84
    ld   a,(de)
    ld   hl,data_6E50
    call call_0DA7
    ex   de,hl
    jp   (hl)

data_6E50
	BYTE	LOW call_6E5A,HIGH call_6E5A
	BYTE	LOW call_6ED9,HIGH call_6ED9
	BYTE	LOW call_6ED3,HIGH call_6ED3
	BYTE	LOW call_6EBB,HIGH call_6EBB
	BYTE	LOW call_6E61,HIGH call_6E61
call_6E5A
    ld   (ix+$00),$01
    jp   call_602A
call_6E61
    ld   a,(ix+$07)
    ld   bc,$C404
    call call_147D
    set  4,(ix+$21)
    jp   call_602A
call_6E71
    ld   iy,l_fc9d
    ld   a,(iy-$18)
    sub  $37
    nop
    set  5,(ix+$21)
    jp   call_602A
call_6E82
    ld   hl,l_f676
    dec  (hl)
;    ld   iy,$0026
;    ld   de,$00B9
;    ld   l,(iy-$22)
;    ld   h,(iy-$21)
;    xor  a
;    sbc  hl,de
;    jr   call_6E9B
;    pop  hl
;    pop  de
;    pop  af
call_6E9B
    ld   a,(l_fc7c)
    ld   (ix+$17),a
    add  a,a
    add  a,a
    add  a,$04
    ld   b,a
    ld   c,$35
    ld   a,(ix+$07)
    call call_147D
    call call_155E
    ld   (ix+$00),$08
    call call_0D14
    jp   call_602A
call_6EBB
    ld   a,i			;TODO - delete all 7 lines as skipped protection?
    ld   d,a
    ld   a,(l_fc00)
    ld   e,a
    ld   hl,$0B2E
    or   a
    sbc  hl,de
    jr   call_6ECD
;    push af
;    ex   (sp),ix
call_6ECD
     ld   (ix+$18),$01
     jr   call_6EDD
call_6ED3
    ld   (ix+$18),$02
    jr   call_6EDD
call_6ED9
    ld   (ix+$18),$03
call_6EDD
    ld   (ix+$05),$00
    call call_158B
    ld   (ix+$0d),$7F
    ld   (ix+$00),$10
    jp   call_602A

call_6EF8

	;call call_577F			;temp to test vs screen

	;ld a,(l_e737)
	;and a
	;jr nz,supertest
	;call call_59C4
;supertest

	ld   ix,l_eb57
    bit  0,(ix+$00)
    jp   nz,call_6F59
    ld   a,(l_e742)			;check if player 2 has completed EXTEND
    and  $3F				;all 6 lower bits set?
    cp   $3F
    jr   nz,call_6F1B		;if not skip to P2 check

    /*ld a,1;hl,MODULE2
    ld (music_module),a
    ld a,3
    ld (music_playing),a*/

    ld   hl,l_e742			;reset player 1 EXTEND bits
    ld   (hl),$00
    ld   hl,l_eb56			;and set EXTEND control var eb56 to 0
    ld   (hl),$00
    ld   de,$D020;D51C			screen loc - special sprite info
    jr   call_6F30			;call EXTEND rotate function for lefthand side
call_6F1B
    ld   a,(l_e743)			;check if player 2 has completed EXTEND
    and  $3F				;all 6 lower bits set?
    cp   $3F
    ret  nz					;if not return from function

    /*ld a,1;hl,MODULE2
    ld (music_module),a
    ld a,3
    ld (music_playing),a*/

    ld   hl,l_e743			;reset player 2 EXTEND bits
    ld   (hl),$00
    ld   hl,l_eb56			;and set EXTEND control var eb56 to 1
    ld   (hl),$01
    ld   de,$D110			;screen loc and fall to EXTEND rotate function for righthand side
call_6F30
    ld   (ix+$04),e
    ld   (ix+$05),d
    ld   c,$10
    call call_1350
    ld   a,$03
    call call_0008
    ld   a,$04
    call call_0008
    ld   a,$02
    call call_0008
    ld   hl,l_f66b
    ld   (hl),$00
    ;ld   hl,$0000
    ;ld   ($F9DE),hl		;TODO - palette
    ;ld   hl,$0000
    ;ld   ($F9FE),hl			;TODO - palette
	nextreg $43,%10100000        ; (R/W) 0x43 (67) => Palette Control - Sprites as it is the EXTEND flash
	nextreg $40,$ef                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$00		 
	nextreg $40,$ff                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $41,$00		 
    set  0,(ix+$00)
call_6F59
    call call_420B	
	
    inc  (ix+$01)
    ld   a,(ix+$01)
    cp   $05
    jr   nz,call_6F82
    ld   (ix+$01),$00
    inc  (ix+$02)
    ld   a,(ix+$02)
    cp   $06
    jr   nz,call_6F82
    ld   (ix+$02),$00
    inc  (ix+$03)
    ld   a,(ix+$03)
    cp   $07
    jr   z,call_6F92
call_6F82
    ld a,(l_e1cb)
	ld (intro_membackup),a
	ld a,(l_e1cc)
	ld (intro_membackup+1),a
	
	ld a,introbank
	call call_026C
	call intro_call_6F82
	call call_029B
	
	ld a,(intro_membackup)
	ld (l_e1cb),a
	ld a,(intro_membackup+1)
	ld (l_e1cc),a
	ret
	
call_6F92
call_6FBF
	call copy_extend_tiles2
	
	ld a,(l_e1cb)
	ld (intro_membackup),a
	ld a,(l_e1cc)
	ld (intro_membackup+1),a
	
	ld a,introbank
	call call_026C
	call intro_call_6FBF
	call call_029B
	
	ld a,(intro_membackup)
	ld (l_e1cb),a
	ld a,(intro_membackup+1)
	ld (l_e1cc),a
	
	xor  a
	call call_0018

	ret		;might not be needed at call_0018 redirects program flow
	
/*
call_7007		;EXTEND complete - moved to intro bank
	call copy_extend_tiles2
	
	ld a,(l_e1cb)
	ld (intro_membackup),a
	ld a,(l_e1cc)
	ld (intro_membackup+1),a
	
	ld a,introbank
	call call_026C
	call intro_call_7007
	call call_029B
	
	ld a,(intro_membackup)
	ld (l_e1cb),a
	ld a,(intro_membackup+1)
	ld (l_e1cc),a
	
	xor  a
	call call_0018
*/
/*
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
    xor  a
	call call_0018
*/
;	call copy_extend_tiles2
;	ld a,introbank
;	call call_026C
;	call intro_call_7015
;	call call_029B
	ret


intro_membackup
	BYTE $00,$00




/*
plotcredit
    cp 0
    jr nz,plotcreditnon0
    ld a,$20
plotcreditnon0
    push hl
    push de
    push bc
;    ex de,hl
    call plotletter
    pop bc
    pop de
    pop hl

    ret
*/

;space for tile data is $4000 to $7600
;therefore £3600 bytes
;in 4 bit mode each tile is $20 bytes so we have space 
;for $1b0 (432) tiles

copycoretiles
	nextreg $6F,$00				;tile definition start address = 0

	ld	a,gfxbank02
	call call_026C	;page in gfx bank 2
	ld hl,$C000		;start of Taito Logo tiles
	ld de,$4000		;start of screen tiles (ULA disabled)
	ld bc,$400		;32 tiles * 32 bytes
	ldir
	ld hl,$C400		;offset for font
	ld bc,$760	    ;59 tiles * 32 bytes
	ldir
	jp call_029B  ;restore bank
	;not ret as jp above rets


copyleveltiles
;we need to copy the tilemap for each level across
;tiles are from $204 to $3fc so gfx bank 1
;$204 is in bank 2 - tiles 4 through 508 (505 tiles)
;tilesmap start is $4b60
;offset is (((levelnum * 5) + 4) * 32) + C000

	
	nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	;first fill up all the remaining avaialable tiles after the core 91
	;from gfx bank 0 (the main tiles needed for the gameplay)
	ld	a,gfxbank00
	call call_026C_DI	;page in gfx bank 0
	ld de,$4b60
	ld hl,$CB60		;offset
	ld bc,$540		;42 tiles * 32 bytes
	ldir
	
	ld de,$4C00		;now copy the Vs numbers over second font at tile 0x60 (we don't use this)
	ld hl,$F4C0		;offset
	ld bc,$480		;36 tiles * 32 bytes
	ldir

    ld de,$4EC0		;now copy the lightning jar
	ld hl,$FCC0		;offset
	ld bc,$80		;4 tiles * 32 bytes
	ldir
	
	ld de,$5200
	ld hl,$D200		;offset
	ld bc,$2400		;120 tiles * 32 bytes
	ldir
	
	call call_029B_DI  ;restore bank
	
	

	ld	a,gfxbank01
	call call_026C_DI	;page in gfx bank 1
	ld  a,(l_e64b)		;level number
	ld  b,5
	call call_0DB1   ;a * b - returned in HL
	ld de,$0004
	add hl,de
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld de,$c000
	add hl,de	
	ld  a,(l_e64b)		;level number
	bit 0,a
	jr nz,oddlevel	
	ld de,$50a0			;load the level tiles into tile $85 133)
	;tiles $85 (133) through $8f (143) are blank in original ROM
	;ld hl,$FF00		;offset
	jr evenlevel
oddlevel
	ld de,$5140
evenlevel
	ld bc,$a0		;5 tiles * 32 bytes
	ldir
	jp call_029B_DI  ;restore bank
	

copy_todays_record_tiles
;we need to copy the tilemap for each level across
;tiles are from $204 to $3fc so gfx bank 1
;$204 is in bank 2 - tiles 4 through 508 (505 tiles)
;tilesmap start is $4b60
;offset is (((levelnum * 5) + 4) * 32) + C000

	
	nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	ld	a,gfxbank00
	call call_026C_DI	;page in gfx bank 0
	ld de,$5a00
	ld hl,$FA00		;offset
	ld bc,$400		;16 tiles * 32 bytes
	ldir
	jp call_029B_DI  ;restore bank
	


	
copy_extend_tiles2
;we need to copy the tilemap for each level across
;tiles are from $204 to $3fc so gfx bank 1
;$204 is in bank 2 - tiles 4 through 508 (505 tiles)
;tilesmap start is $4b60
;offset is (((levelnum * 5) + 4) * 32) + C000

	
	nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	ld	a,gfxbank21
	call call_026C_DI	;page in gfx bank 0
	ld de,$5a00
	ld hl,$E000		;offset
	ld bc,$1B00		;216 tiles * 32 bytes
	ldir
	jp call_029B_DI  ;restore bank
	

copy_intro_tiles
;we need to copy the tilemap for each level across
;tiles are from $204 to $3fc so gfx bank 1
;$204 is in bank 2 - tiles 4 through 508 (505 tiles)
;tilesmap start is $4b60
;offset is (((levelnum * 5) + 4) * 32) + C000

	
	nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	ld	a,gfxbank20
	call call_026C_DI	;page in gfx bank 0
	ld de,$4b60
	ld hl,$e000		;offset
	ld bc,$2000		;256 tiles * 32 bytes
	ldir
	call call_029B_DI  ;restore bank
	ld	a,gfxbank21
	call call_026C_DI	;page in gfx bank 0
	ld de,$6b60
	ld hl,$c000		;offset
	ld bc,$aa0		;85 tiles * 32 bytes
	ldir
	jp call_029B_DI  ;restore bank

    
copy_big_words_tiles
    nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	ld	a,gfxbank19
	call call_026C_DI	;page in gfx bank 0
	ld de,$4b60
	ld hl,$e700		;offset
	ld bc,$CC0		;256 tiles * 32 bytes
	ldir
	jp call_029B_DI  ;restore bank