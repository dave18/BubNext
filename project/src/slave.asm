
	org $c000
	
slave_call_0190
    ld   a,(l_e338)
    ld   hl,l_f66c
    cp   (hl)
    ld   (hl),a
    inc  hl
	;jr   slave_call_01B6
    jr   nz,slave_call_01B6
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    ret  c
    ld   hl,l_e800
    ld   de,l_e000
    ld   bc,$0800
slave_call_01A9
    ld   a,(hl)
    cpl
    ld   (de),a
    inc  hl
    inc  de
    dec  bc
    ld   a,c
    or   b
    jr   nz,slave_call_01A9
slave_call_01B3
    ;jp   slave_call_01B3			;Protection or error hang!
	jp   slave_call_01B8			;Bodge fix
slave_call_01B6
    ld   (hl),$00
slave_call_01B8
    ret
slave_call_01B9
    ld   a,(l_e737)
    and  a
    ret  nz
    ld   hl,l_e691
    bit  0,(hl)
    jr   z,slave_call_01E6
    inc  hl
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   c,$0A
    call slave_call_02B4			
    jr   nc,slave_call_01E6
    push hl
    call slave_call_020C
    pop  hl
    ex   de,hl
    ld   hl,l_e6a4
    bit  0,(hl)
    ret  z
    set  1,(hl)
    ex   de,hl
    ld   (hl),$02
    ld   hl,l_ed3d
    dec  (hl)
    ret
slave_call_01E6
    ld   hl,l_e6c3
    bit  0,(hl)
    ret  z
    inc  hl
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   c,$0A
    call slave_call_02B4
    ret  nc
    push hl
    call slave_call_0239
    pop  hl
    ex   de,hl
    ld   hl,l_e6d6
    bit  0,(hl)
    ret  z
    set  1,(hl)
    ex   de,hl
    ld   (hl),$02
    ld   hl,l_ed3d
    dec  (hl)
    ret
slave_call_020C					;should only be called when hit by enemy
    ld   a,(l_e690)
    and  a
    jp   nz,slave_call_0237
    ld   a,(l_e6b6)
    and  a
    jp   nz,slave_call_0237
    ld   a,(l_e6a4)
    and  a
    jp   nz,slave_call_0237
    ld   a,(l_e692)
    cp   $08
    jp   c,slave_call_0237
    cp   $F8
    jp   nc,slave_call_0237
    push hl
    ld   hl,l_e691				;flag that hit by hurry up ghost
    ld   (hl),$10
    pop  hl
    scf
    ret
slave_call_0237
    xor  a
    ret
slave_call_0239
    ld   a,(l_e690)
    and  a
    jp   nz,slave_call_0264
    ld   a,(l_e6e8)
    and  a
    jp   nz,slave_call_0264
    ld   a,(l_e6d6)
    and  a
    jp   nz,slave_call_0264
    ld   a,(l_e6c4)
    cp   $08
    jp   c,slave_call_0264
    cp   $F8
    jp   nc,slave_call_0264
    push hl
    ld   hl,l_e6c3
    ld   (hl),$10
    pop  hl
    scf
    ret
slave_call_0264
    xor  a
    ret
slave_call_0266
    ld   a,(l_e737)
    and  a
    ret  nz
    ld   hl,l_e691
    bit  0,(hl)
    jr   z,slave_call_0277
    ld   c,$01
    call slave_call_027F
slave_call_0277
    ld   hl,l_e6c3
    bit  0,(hl)
    ret  z
    ld   c,$FF
slave_call_027F
    inc  hl
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   b,$00
    ld   hl,l_ed21
slave_call_0288
    bit  3,(hl)
    jr   z,slave_call_02A9
    push hl
    inc  hl
    ld   a,(hl)
    sub  e
    jp   p,slave_call_0295
    neg
slave_call_0295
    cp   $10
    jr   nc,slave_call_02A8
    inc  hl
    ld   a,(hl)
    sub  d
    jp   p,slave_call_02A1
    neg
slave_call_02A1
    cp   $10
    jp   nc,slave_call_02A8
    inc  hl
    ld   (hl),c
slave_call_02A8
    pop  hl
slave_call_02A9
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  b
    ld   a,b
    cp   $07
    jr   nz,slave_call_0288
    ret
slave_call_02B4
    ld   b,$00
    ld   hl,l_ed21
slave_call_02B9
    bit  0,(hl)
    jr   z,slave_call_02D4
    push hl
    inc  hl
    ld   a,(hl)
    sub  e
    jp   p,slave_call_02C6
    neg
slave_call_02C6
    cp   c
    jr   nc,slave_call_02D2
    inc  hl
    ld   a,(hl)
    sub  d
    jp   p,slave_call_02D1
    neg
slave_call_02D1
    cp   c
slave_call_02D2
    pop  hl
    ret  c
slave_call_02D4
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  b
    ld   a,b
    cp   $07
    jr   nz,slave_call_02B9
    xor  a
    ret
slave_call_02E0			;check hurry up ghost collision
    ld   a,(l_e723)		
    cp   $29
    jr   z,slave_call_02ED
    ld   a,(l_f66b)		;seems to get set once player travel bubble bursts
    cp   $49
    ret  nz
slave_call_02ED
    ld   ix,l_f1c2
    bit  7,(ix+$00)
    jr   z,slave_call_032D
    ld   e,$0A
    call slave_call_036B
    jr   nc,slave_call_032D
    set  0,(ix+$00)
    and  a
    jr   nz,slave_call_0319
    res  1,(ix+$00)
    ld   a,(l_e723)
    cp   $29
    jp   nz,slave_call_020C
    ld   hl,l_e730
    ld   (hl),$01
    jp   slave_call_020C
slave_call_0319
    set  1,(ix+$00)
    ld   a,(l_e723)
    cp   $29
    jp   nz,slave_call_0239
    ld   hl,l_e730
    ld   (hl),$01
    jp   slave_call_0239
slave_call_032D
    ld   ix,l_f1d4
    bit  7,(ix+$00)
    ret  z
    ld   e,$0A
    call slave_call_036B
    ret  nc
    set  0,(ix+$00)
    and  a
    jr   nz,slave_call_0357
    res  1,(ix+$00)
    ld   a,(l_e723)
    cp   $29
    jp   nz,slave_call_020C
    ld   hl,l_e730
    ld   (hl),$01
    jp   slave_call_020C
slave_call_0357
    set  1,(ix+$00)
    ld   a,(l_e723)
    cp   $29
    jp   nz,slave_call_0239
    ld   hl,l_e730
    ld   (hl),$01
    jp   slave_call_0239
slave_call_036B
    ld   hl,l_e691
    bit  0,(hl)
    jr   z,slave_call_0393
    inc  hl
    ld   a,(hl)
    sub  (ix+$01)
    jp   p,slave_call_037C
    neg
slave_call_037C
    cp   e
    jr   nc,slave_call_0393
    inc  hl
    ld   a,(hl)
    sub  (ix+$02)
    jp   p,slave_call_0389
    neg
slave_call_0389
    cp   e
    jr   nc,slave_call_0393
    ld   a,(l_e699)
    ld   c,a
    ld   a,$00
    ret
slave_call_0393
    ld   hl,l_e6c3
    bit  0,(hl)
    jr   z,slave_call_03B9
    inc  hl
    ld   a,(hl)
    sub  (ix+$01)
    jp   p,slave_call_03A4
    neg
slave_call_03A4
    cp   e
    ret  nc
    inc  hl
    ld   a,(hl)
    sub  (ix+$02)
    jp   p,slave_call_03B0
    neg
slave_call_03B0
    cp   e
    ret  nc
    ld   a,(l_e6cb)
    ld   c,a
    ld   a,$01
    ret
slave_call_03B9
    xor  a
    ret

	 
slave_call_03BB
    ld   a,(l_e76b)
    and  a
    ret  z
    ld   a,(l_f5b6)
    and  a
    ret  nz
    ld   a,(l_f59e)
    and  a
    ret  nz
    ld   ix,l_e76c
    xor  a
slave_call_03CF
    push af
    ld   a,(ix+$00)
    bit  0,a
    jp   nz,slave_call_03FC
    bit  2,a
    jp   nz,slave_call_0433
    bit  3,a
    jp   nz,slave_call_047E
    bit  4,a
    jp   nz,slave_call_04B5
    bit  5,a
    jp   nz,slave_call_04EC
    ld   a,(ix+$21)
    bit  6,a
    jp   nz,slave_call_05FE
    bit  5,a
    jp   nz,slave_call_05C7
    jp   slave_call_0635
slave_call_03FC
    bit  0,(ix+$1a)
    jp   nz,slave_call_0635
    call slave_call_0772
    ld   iy,l_e691
    call slave_call_0664
    jr   nc,slave_call_0415
    ld   (ix+$16),$00
    jr   slave_call_0423
slave_call_0415
    ld   iy,l_e6c3
    call slave_call_0664
    jp   nc,slave_call_0635
    ld   (ix+$16),$01
slave_call_0423
    ld   a,(iy+$08)
    ld   (ix+$0f),a
    ld   (l_f674),a
    ld   (ix+$1a),$01
    jp   slave_call_0635
slave_call_0433
    bit  2,(ix+$1a)
    jp   nz,slave_call_0635
    call slave_call_0ABA
    jr   c,slave_call_046E
    call slave_call_0AF2
    jr   c,slave_call_046E
    call slave_call_0B2A
    jr   c,slave_call_046E
    call slave_call_0B76
    jr   c,slave_call_046E
    call slave_call_0772
    ld   iy,l_e691
    call slave_call_0664
    jr   nc,slave_call_0460
    ld   (ix+$16),$00
    jr   slave_call_046E
slave_call_0460
    ld   iy,l_e6c3
    call slave_call_0664
    jp   nc,slave_call_0635
    ld   (ix+$16),$01
slave_call_046E
    ld   a,(iy+$08)
    ld   (ix+$0f),a
    ld   (l_f674),a
    ld   (ix+$1a),$04
    jp   slave_call_0635
slave_call_047E
    bit  3,(ix+$1a)
    jp   nz,slave_call_0635
    call slave_call_0772
    ld   iy,l_e691
    call slave_call_0664
    jr   nc,slave_call_0497
    ld   (ix+$16),$00
    jr   slave_call_04A5
slave_call_0497
    ld   iy,l_e6c3
    call slave_call_0664
    jp   nc,slave_call_0635
    ld   (ix+$16),$01
slave_call_04A5
    ld   a,(iy+$08)
    ld   (ix+$0f),a
    ld   (l_f674),a
    ld   (ix+$1a),$08
    jp   slave_call_0635
slave_call_04B5
    bit  4,(ix+$1a)
    jp   nz,slave_call_0635
    call slave_call_0772
    ld   iy,l_e691
    call slave_call_0664
    jr   nc,slave_call_04CE
    ld   (ix+$16),$00
    jr   slave_call_04DC
slave_call_04CE
    ld   iy,l_e6c3
    call slave_call_0664
    jp   nc,slave_call_0635
    ld   (ix+$16),$01
slave_call_04DC
    ld   a,(iy+$08)
    ld   (ix+$0f),a
    ld   (l_f674),a
    ld   (ix+$1a),$10
    jp   slave_call_0635
slave_call_04EC
    bit  5,(ix+$1a)
    jp   nz,slave_call_0635
    bit  0,(ix+$1c)
    jp   nz,slave_call_0635
    ld   e,$0A
    call slave_call_036B
    jr   nc,slave_call_0552
    and  a
    jr   nz,slave_call_052B
    ld   a,(l_e6be)
    bit  4,a
    jr   nz,slave_call_0552
    ld   a,(l_e6b6)
    and  a
    jr   nz,slave_call_0552
    ld   a,(l_e6a4)
    and  a
    jr   nz,slave_call_0552
    ld   hl,l_e6ac
    bit  0,(hl)
    jp   nz,slave_call_0635
    set  0,(hl)
    inc  hl
slave_call_0522
    ld   (hl),$3C
    ld   (ix+$1a),$20
    jp   slave_call_0635
slave_call_052B
    ld   a,(l_e6f0)
    bit  4,a
    jr   nz,slave_call_0552
    ld   a,(l_e6e8)
    and  a
    jr   nz,slave_call_0552
    ld   a,(l_e6d6)
    and  a
    jr   nz,slave_call_0552
    ld   hl,l_e6de
    bit  0,(hl)
    jp   nz,slave_call_0635
    set  0,(hl)
    inc  hl
    ld   (hl),$3C
    ld   (ix+$1a),$20
    jp   slave_call_0635
slave_call_0552
    ld   a,(l_e64b)
    cp   $63
    jr   z,slave_call_057D
    ld   e,(ix+$01)
    ld   d,(ix+$02)
    ld   c,$0F
    call slave_call_02B4
    jp   nc,slave_call_0635
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$08
    ld   hl,l_ed3d
    dec  (hl)
    ld   hl,l_e5f4
    inc  (hl)
    ld   (ix+$1a),$20
    jp   slave_call_0635
slave_call_057D
    ld   hl,l_f296
    bit  0,(hl)
    jp   z,slave_call_0635
    inc  hl
    ld   a,(hl)
    sub  (ix+$01)
    jp   p,slave_call_058F
    neg
slave_call_058F
    cp   $2C
    jp   nc,slave_call_0635
    inc  hl
    ld   a,(hl)
    sub  (ix+$02)
    jp   p,slave_call_059E
    neg
slave_call_059E
    cp   $2C
    jp   nc,slave_call_0635
    ld   hl,l_f296
    set  7,(hl)
    ld   hl,l_f2a1
    inc  (hl)
    ld   (ix+$1a),$20
    jp   slave_call_0635
	call slave_call_0772
    ld   iy,l_e691
    call slave_call_0664
    ld   iy,l_e6c3
    call slave_call_0664
    jp   slave_call_0635
slave_call_05C7
    bit  5,(ix+$26)
    jp   nz,slave_call_0635
    call slave_call_0772
    ld   iy,l_e691
    call slave_call_0664
    jr   nc,slave_call_05E0
    ld   (ix+$16),$00
    jr   slave_call_05EE
slave_call_05E0
    ld   iy,l_e6c3
    call slave_call_0664
    jp   nc,slave_call_0635
    ld   (ix+$16),$01
slave_call_05EE
    ld   a,(iy+$08)
    ld   (ix+$0f),a
    ld   (l_f674),a
    set  5,(ix+$26)
    jp   slave_call_0635
slave_call_05FE
    bit  6,(ix+$26)
    jp   nz,slave_call_0635
    ld   hl,l_e691
    bit  0,(hl)
    jr   z,slave_call_061C
    call slave_call_0648
    jr   nc,slave_call_061C
    ld   (ix+$16),$00
    set  6,(ix+$26)
    jp   slave_call_0635
slave_call_061C
    ld   hl,l_e6c3
    bit  0,(hl)
    jp   z,slave_call_0635
    call slave_call_0648
    jp   nc,slave_call_0635
    ld   (ix+$16),$01
    set  6,(ix+$26)
    jp   slave_call_0635
slave_call_0635
    ld   (ix+$1e),$00
    ld   de,$0028
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_e76b
    cp   (hl)
    jp   nz,slave_call_03CF
    ret
slave_call_0648
    inc  hl
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   a,e
    sub  (ix+$01)
    jp   p,slave_call_0655
    neg
slave_call_0655
    cp   $10
    ret  nc
    ld   a,d
    sub  (ix+$02)
    jp   p,slave_call_0661
    neg
slave_call_0661
    cp   $10
    ret
slave_call_0664
    bit  0,(iy+$00)
    jr   nz,slave_call_066C
    xor  a
    ret
slave_call_066C
    ld   a,(iy+$23)
    cp   $03
    jp   z,slave_call_0743
    bit  0,(iy+$08)
    jp   z,slave_call_06DF
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_0686
    neg
slave_call_0686
    cp   $0C
    ret  nc
    ld   a,(iy+$02)
    add  a,$05
    sub  (ix+$02)
    jp   m,slave_call_069A
    cp   $12
    ret  nc
    jp   slave_call_09C7
slave_call_069A
    neg
    cp   $0A
    ret  nc
    ld   a,(iy+$23)
    and  a
    jr   nz,slave_call_06B0
    ld   a,(ix+$23)
    add  a,(iy+$20)
    neg
    ld   (iy+$22),a
slave_call_06B0
    ld   a,(iy+$20)
    add  a,(ix+$14)
    ld   (ix+$14),a
    set  0,(ix+$1e)
    ld   a,(iy+$09)
    ld   (ix+$16),a
    ld   (ix+$0f),$01
    ld   a,(iy+$23)
    cp   $01
    jr   nz,slave_call_06D5
    ld   (ix+$1b),$04
    jp   slave_call_06D9
slave_call_06D5
    ld   (ix+$1b),$08
slave_call_06D9
    ld   (ix+$25),$00
    xor  a
    ret
slave_call_06DF
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_06EA
    neg
slave_call_06EA
    cp   $0C
    ret  nc
    ld   a,(iy+$02)
    add  a,$FB
    sub  (ix+$02)
    jp   p,slave_call_0700
    neg
    cp   $12
    ret  nc
    jp   slave_call_09C7
slave_call_0700
    cp   $0A
    ret  nc
    ld   a,(iy+$23)
    and  a
    jr   nz,slave_call_0712
    ld   a,(ix+$23)
    add  a,(iy+$20)
    ld   (iy+$22),a
slave_call_0712
    ld   a,(iy+$20)
    neg
    add  a,(ix+$14)
    ld   (ix+$14),a
    set  0,(ix+$1e)
    ld   a,(iy+$09)
    ld   (ix+$16),a
    ld   (ix+$0f),$03
    ld   a,(iy+$23)
    cp   $01
    jr   nz,slave_call_0739
    ld   (ix+$1b),$04
    jp   slave_call_06D9
slave_call_0739
    ld   (ix+$1b),$08
    ld   (ix+$25),$00
    xor  a
    ret
slave_call_0743
    ld   a,(iy+$02)
    sub  (ix+$02)
    jp   p,slave_call_074E
    neg
slave_call_074E
    cp   $0C
    ret  nc
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_075C
    xor  a
    ret
slave_call_075C
    cp   $0C
    jp   c,slave_call_09C7
    cp   $16
    ret  nc
    set  0,(iy+$24)
    ld   (ix+$1b),$04
    ld   (ix+$25),$00
    xor  a
    ret
slave_call_0772
    ld   a,(ix+$0f)
    and  $0F
    add  a,a
    ld   hl,slave_data_0785
    add  a,l
    ld   l,a
    jr   nc,slave_call_0780
    inc  h
slave_call_0780
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ex   de,hl
    jp   (hl)
slave_data_0785
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_07A5,HIGH slave_call_07A5
	defb	LOW slave_call_07F7,HIGH slave_call_07F7
	defb	LOW slave_call_089C,HIGH slave_call_089C
	defb	LOW slave_call_07F6,HIGH slave_call_07F6
	defb	LOW slave_call_07F6,HIGH slave_call_07F6
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849	
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849
	defb	LOW slave_call_0849,HIGH slave_call_0849
slave_call_07A5
    ld   iy,l_e76c
    ld   a,(l_e76b)
    ld   b,a
slave_call_07AD
    ld   a,(ix+$21)
    bit  4,a
    jr   nz,slave_call_07BF
    bit  5,a
    jr   nz,slave_call_07BF
    ld   a,(iy+$00)
    and  $1D
    jr   z,slave_call_07EF
slave_call_07BF
    ld   a,(ix+$1d)
    cp   (iy+$1d)
    jr   z,slave_call_07EF
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_07D2
    neg
slave_call_07D2
    cp   $0D
    jr   nc,slave_call_07EF
    ld   a,(iy+$02)
    sub  (ix+$02)
    jp   m,slave_call_07EF
    cp   $0D
    jr   nc,slave_call_07EF
    inc  (iy+$14)
    bit  0,(iy+$1e)
    jr   z,slave_call_07EF
    inc  (iy+$14)
slave_call_07EF
    ld   de,$0028
    add  iy,de
    djnz slave_call_07AD
slave_call_07F6
    ret
slave_call_07F7
    ld   iy,l_e76c
    ld   a,(l_e76b)
    ld   b,a
slave_call_07FF
    ld   a,(ix+$21)
    bit  4,a
    jr   nz,slave_call_0811
    bit  5,a
    jr   nz,slave_call_0811
    ld   a,(iy+$00)
    and  $1D
    jr   z,slave_call_0841
slave_call_0811
    ld   a,(ix+$1d)
    cp   (iy+$1d)
    jr   z,slave_call_0841
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_0824
    neg
slave_call_0824
    cp   $0D
    jr   nc,slave_call_0841
    ld   a,(iy+$02)
    sub  (ix+$02)
    jp   p,slave_call_0841
    cp   $F3
    jr   c,slave_call_0841
    dec  (iy+$14)
    bit  0,(iy+$1e)
    jr   z,slave_call_0841
    dec  (iy+$14)
slave_call_0841
	ld   de,$0028
    add  iy,de
    djnz slave_call_07FF
    ret	
slave_call_0849
    ld   iy,l_e76c
    ld   a,(l_e76b)
    ld   b,a
slave_call_0851
    ld   a,(ix+$21)
    bit  4,a
    jr   nz,slave_call_0863
    bit  5,a
    jr   nz,slave_call_0863
    ld   a,(iy+$00)
    and  $1D
    jr   z,slave_call_0894
slave_call_0863
    ld   a,(ix+$1d)
    cp   (iy+$1d)
    jr   z,slave_call_0894
    ld   a,(iy+$02)
    sub  (ix+$02)
    jp   p,slave_call_0876
    neg
slave_call_0876
    cp   $0D
    jr   nc,slave_call_0894
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   m,slave_call_0894
    cp   $0D
    jr   nc,slave_call_0894
    inc  (iy+$13)
    bit  0,(iy+$1e)
    jp   z,slave_call_0894
    inc  (iy+$13)
slave_call_0894
    ld   de,$0028
    add  iy,de
    djnz slave_call_0851
    ret
slave_call_089C
    ld   iy,l_e76c
    ld   a,(l_e76b)
    ld   b,a
slave_call_08A4
    ld   a,(ix+$21)
    bit  4,a
    jp   nz,slave_call_08B7
    bit  5,a
    jr   nz,slave_call_08B7
    ld   a,(iy+$00)
    and  $1D
    jr   z,slave_call_08E8
slave_call_08B7
    ld   a,(ix+$1d)
    cp   (iy+$1d)
    jr   z,slave_call_08E8
    ld   a,(iy+$02)
    sub  (ix+$02)
    jp   p,slave_call_08CA
    neg
slave_call_08CA
    cp   $0D
    jr   nc,slave_call_08E8
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_08E8
    cp   $F3
    jr   c,slave_call_08E8
    dec  (iy+$13)
    bit  0,(iy+$1e)
    jp   z,slave_call_08E8
    dec  (iy+$13)
slave_call_08E8
    ld   de,$0028
    add  iy,de
    djnz slave_call_08A4
    ret
slave_call_08F0
    ld   a,(l_e76b)
    and  a
    ret  z
    ld   hl,l_f66f
    bit  0,(hl)
    jp   z,slave_call_094E
    ld   (hl),$00
    ld   ix,l_e76c
    ld   a,(l_e76b)
    ld   b,a
slave_call_0907
    bit  5,(ix+$21)
    jr   nz,slave_call_0914
    ld   a,(ix+$00)
    and  $1D
    jr   z,slave_call_0947
slave_call_0914
    ld   a,(ix+$1a)
    and  a
    jr   nz,slave_call_0947
    ld   hl,l_f670
    ld   a,(hl)
    cp   (ix+$1d)
    jr   z,slave_call_0947
    inc  hl
    ld   a,(hl)
    sub  (ix+$01)
    jp   p,slave_call_092D
    neg
slave_call_092D
    cp   $14
    jr   nc,slave_call_0947
    inc  hl
    ld   a,(hl)
    sub  (ix+$02)
    jp   p,slave_call_093B
    neg
slave_call_093B
    cp   $14
    jr   nc,slave_call_0947
    ld   a,(l_f674)
    ld   (ix+$0f),a
    jr   slave_call_0968
slave_call_0947
    ld   de,$0028
    add  ix,de
    djnz slave_call_0907
slave_call_094E
    ld   hl,l_f673
    ld   (hl),$00
    ld   hl,l_f677
    ld   a,(hl)
    and  a
    jp   z,slave_call_095E
    inc  hl
    ld   (hl),$01
slave_call_095E
    ld   hl,l_f679
    ld   a,(hl)
    and  a
    ret  z
    inc  hl
    ld   (hl),$01
    ret
slave_call_0968
    ld   hl,l_f66f
    ld   (hl),$01
    inc  hl
    ld   a,(ix+$1d)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    inc  hl
    bit  2,(ix+$00)
    jr   z,slave_call_099E
    inc  (hl)
    ld   a,(hl)
    dec  a
    ld   (ix+$22),a
    cp   $02
    jr   c,slave_call_099E
    ex   de,hl
    ld   hl,l_f676
    inc  (hl)
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,slave_call_099D
    ld   hl,l_f676
    inc  (hl)
slave_call_099D
    ex   de,hl
slave_call_099E
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$16),a
    bit  2,(ix+$00)
    jr   z,slave_call_09B3
    add  a,a
    ld   e,a
    ld   d,$00
    ld   hl,l_f677
    add  hl,de
    inc  (hl)
slave_call_09B3
    bit  5,(ix+$21)
    jr   z,slave_call_09BF
    set  5,(ix+$26)
    scf
    ret
slave_call_09BF
    ld   a,(ix+$00)
    ld   (ix+$1a),a
    scf
    ret


	
	
slave_call_09C7
	ld   hl,l_f66f
    bit  0,(hl)
    jp   nz,slave_call_0A2E
    ld   (hl),$01
    inc  hl
    ld   a,(ix+$1d)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    inc  hl
    bit  2,(ix+$00)
    jr   z,slave_call_0A02
    inc  (hl)
    ld   a,(hl)
    dec  a
    ld   (ix+$22),a
    cp   $02
    jr   c,slave_call_0A02
    ex   de,hl
    ld   hl,l_f676
    inc  (hl)
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,slave_call_0A01
    ld   hl,l_f676
    inc  (hl)
slave_call_0A01
    ex   de,hl
slave_call_0A02
    inc  hl
    inc  hl
    ld   a,(iy+$09)
    ld   (ix+$16),a
    ld   (hl),a
    bit  2,(ix+$00)
    jr   z,slave_call_0A1A
    add  a,a
    ld   e,a
    ld   d,$00
    ld   hl,l_f677
    add  hl,de
    inc  (hl)
slave_call_0A1A
    bit  5,(ix+$21)
    jr   z,slave_call_0A26
    set  5,(ix+$26)
    scf
    ret
slave_call_0A26
    ld   a,(ix+$00)
    ld   (ix+$1a),a
    scf
    ret
slave_call_0A2E
    xor  a
    ret
slave_call_0A30
    ld   a,(l_f47c)
    and  a
    ret  z
    ld   ix,l_f47e
    ld   b,$08
slave_call_0A3B
    push bc
    bit  0,(ix+$00)
    jr   z,slave_call_0A5E
    ld   e,(ix+$01)
    ld   d,(ix+$02)
    ld   c,$0F
    call slave_call_02B4
    jr   nc,slave_call_0A5E
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$06
    ld   hl,l_ed3d
    dec  (hl)
    ld   (ix+$00),$02
slave_call_0A5E
    ld   de,$0009
    add  ix,de
    pop  bc
    djnz slave_call_0A3B
    ret
slave_call_0A67
    ld   a,(l_f4cb)
    and  a
    ret  z
    ld   ix,l_f4ce
    ld   b,$08
slave_call_0A72
    push bc
    bit  0,(ix+$00)
    jr   z,slave_call_0A95
    ld   e,(ix+$01)
    ld   d,(ix+$02)
    ld   c,$0F
    call slave_call_02B4
    jr   nc,slave_call_0A95
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$06
    ld   hl,l_ed3d
    dec  (hl)
    ld   (ix+$00),$02
slave_call_0A95
    ld   de,$0008
    add  ix,de
    pop  bc
    djnz slave_call_0A72
    ret
slave_call_0A9E
    ld   a,(l_f595)
    and  a
    ret  z
    ret  m
    ld   de,(l_f597)
    ld   c,$18
    call slave_call_02B4
    ret  nc
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$08
    ld   hl,l_ed3d
    dec  (hl)
    ret
slave_call_0ABA
    ld   a,(l_f47c)
    and  a
    jr   z,slave_call_0AF0
    ld   iy,l_f47e
    ld   b,$08
slave_call_0AC6
    bit  0,(iy+$00)
    jr   z,slave_call_0AE9
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_0AD7
    neg
slave_call_0AD7
    cp   $10
    jr   nc,slave_call_0AE9
    ld   a,(iy+$02)
    sub  (ix+$02)
    jp   p,slave_call_0AE6
    neg
slave_call_0AE6
    cp   $10
    ret  c
slave_call_0AE9
    ld   de,$0009
    add  iy,de
    djnz slave_call_0AC6
slave_call_0AF0
    xor  a
    ret
slave_call_0AF2
    ld   a,(l_f4cb)
    and  a
    jr   z,slave_call_0B28
    ld   iy,l_f4ce
    ld   b,$08
slave_call_0AFE
    bit  0,(iy+$00)
    jr   z,slave_call_0B21
    ld   a,(iy+$01)
    sub  (ix+$01)
    jp   p,slave_call_0B0F
    neg
slave_call_0B0F
    cp   $10
    jr   nc,slave_call_0B21
    ld   a,(iy+$02)
    sub  (ix+$02)
    jp   p,slave_call_0B1E
    neg
slave_call_0B1E
    cp   $10
    ret  c
slave_call_0B21
    ld   de,$0008
    add  iy,de
    djnz slave_call_0AFE
slave_call_0B28
    xor  a
    ret
slave_call_0B2A
    ld   a,(l_f595)
    and  a
    ret  z
    ret  m
    ld   de,(l_f597)
    ld   a,(ix+$01)
    sub  e
    jp   p,slave_call_0B3D
    neg
slave_call_0B3D
    cp   $10
    ret  nc
    ld   a,(ix+$02)
    sub  d
    jp   p,slave_call_0B49
    neg
slave_call_0B49
    cp   $10
    ret
slave_call_0B4C
    ld   a,(l_f5ac)
    and  a
    ret  z
    ld   ix,l_f5ad
    bit  0,(ix+$00)
    ret  z
    ld   e,(ix+$01)
    ld   d,(ix+$02)
    ld   c,$0F
    call slave_call_02B4
    ret  nc
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$06
    ld   hl,l_ed3d
    dec  (hl)
    ld   (ix+$00),$02
    ret
slave_call_0B76
    ld   a,(l_f5ac)
    and  a
    ret  z
    ret  m
    ld   de,(l_f5ae)
    ld   a,(ix+$01)
    sub  e
    jp   p,slave_call_0B89
    neg
slave_call_0B89
    cp   $10
    ret  nc
    ld   a,(ix+$02)
    sub  d
    jp   p,slave_call_0B95
    neg
slave_call_0B95
    cp   $10
    ret
slave_call_0B98
   ld   a,(l_e737)
   and  a
   ret  nz
   ld   ix,l_ecaa
   ld   b,$07
slave_call_0BA3
    push bc
    bit  0,(ix+$00)
    jr   z,slave_call_0BC6
    bit  2,(ix+$00)
    jr   nz,slave_call_0BC6
    ld   e,$08
    call slave_call_036B
    jr   nc,slave_call_0BC6
    and  a
    jr   nz,slave_call_0BBF
    call slave_call_0BFC
    jr   slave_call_0BC2
slave_call_0BBF
    call slave_call_0C21
slave_call_0BC2
    set  1,(ix+$00)
slave_call_0BC6
    ld   de,$0011
    add  ix,de
    pop  bc
    djnz slave_call_0BA3
    ret
slave_call_0BCF
    ld   a,(l_e737)
    and  a
    ret  nz
    ld   ix,l_eb99
    ld   b,$08
slave_call_0BDA
    push bc
    bit  0,(ix+$00)
    jr   z,slave_call_0BF3
    ld   e,$08
    call slave_call_036B
    jr   nc,slave_call_0BF3
    and  a
    jr   nz,slave_call_0BF0
    call slave_call_0BFC
    jr   slave_call_0BF3
slave_call_0BF0
    call slave_call_0C21
slave_call_0BF3
    ld   de,$0012
    add  ix,de
    pop  bc
    djnz slave_call_0BDA
    ret
slave_call_0BFC
    ld   a,(l_e690)
    and  a
    ret  nz
    ld   a,(l_e6b6)
    and  a
    ret  nz
    ld   a,(l_e6a4)
    and  a
    ret  nz
    ld   a,(l_e692)
    cp   $08
    ret  c
    cp   $F0
    ret  nc
    push hl
    ld   hl,l_e6aa
    ld   (hl),$01
    ld   hl,l_e691
    ld   (hl),$10
    pop  hl
    ret
slave_call_0C21
    ld   a,(l_e690)
    and  a
    ret  nz
    ld   a,(l_e6e8)
    and  a
    ret  nz
    ld   a,(l_e6d6)
    and  a
    ret  nz
    ld   a,(l_e6c4)
    cp   $08
    ret  c
    cp   $F0
    ret  nc
    push hl
    ld   hl,l_e6dc
    ld   (hl),$01
    ld   hl,l_e6c3
    ld   (hl),$10
    pop  hl
    ret
slave_call_0C46
    ld   a,(l_e737)
    and  a
    ret  nz
    ld   ix,l_ec29
    ld   b,$08
slave_call_0C51
    push bc
    bit  0,(ix+$00)
    jr   z,slave_call_0C70
    bit  3,(ix+$00)
    jr   nz,slave_call_0C70
    ld   e,$08
    call slave_call_036B
    jr   nc,slave_call_0C70
    and  a
    jr   nz,slave_call_0C6D
    call slave_call_020C
    jr   slave_call_0C70
slave_call_0C6D
    call slave_call_0239
slave_call_0C70
    ld   de,$0010
    add  ix,de
    pop  bc
    djnz slave_call_0C51
    ret
slave_call_0C79
    ld   a,(l_e737)
    and  a
    ret  nz
    ld   ix,l_f3ce
    ld   b,$07
slave_call_0C84
    push bc
    bit  0,(ix+$00)
    jr   z,slave_call_0C9D
    ld   e,$08
    call slave_call_036B
    jr   nc,slave_call_0C9D
    and  a
    jr   nz,slave_call_0C9A
    call slave_call_020C
    jr   slave_call_0C9D
slave_call_0C9A
    call slave_call_0239
slave_call_0C9D
    ld   de,$0011
    add  ix,de
    pop  bc
    djnz slave_call_0C84
    ret
slave_call_0CA6
    ld   ix,l_f367
    ld   b,$08
slave_call_0CAC
    push bc
    bit  0,(ix+$00)
    jr   z,slave_call_0CC5
    ld   e,$08
    call slave_call_036B
    jr   nc,slave_call_0CC5
    and  a
    jr   nz,slave_call_0CC2
    call slave_call_020C
    jr   slave_call_0CC5
slave_call_0CC2
    call slave_call_0239
slave_call_0CC5
    ld   de,$000C
    add  ix,de
    pop  bc
    djnz slave_call_0CAC
    ret
slave_call_0CCE
    ld   ix,l_f296
    ld   a,(ix+$00)
    bit  0,a
    jr   nz,slave_call_0CED
    bit  1,a
    ret  z
    bit  2,a
    ret  nz
    ld   e,$24
    call slave_call_036B
    ret  nc
    ld   (ix+$0d),a
    set  2,(ix+$00)
    ret
slave_call_0CED
    ld   e,$24
    call slave_call_036B
    ret  nc
    and  a
    jr   nz,slave_call_0CF9
    jp   slave_call_020C
slave_call_0CF9
    jp   slave_call_0239




joyresult    BYTE   0
joyresult2    BYTE   0
;input 1 byte at l_ff02 - bits:
;0 = Joy left	- active low
;1 = Joy Right	- active low
;2 = Coin 2		- active high
;3 = Coin 1		- active high
;4 = Button 2	- active low
;5 = Button 1	- active low
;6 = Start 1	- active low
;7 = N/A		- active low - Should always be 1
slave_getinput    
    ld a,(control_status)
    cp 8
    jp z,change_options
    cp 2
    jp nc,control_redefine
    cp 1
    jp z,change_inputs
    ld a,(p1_control)       ;check Player 1 control option
    cp $00                  
    jr nz,p1_not_kemp_1_up
	ld bc,kempston1         ;code exec for input method 0 & 1
    in a,(c)
    jr p1_input_done
p1_not_kemp_1_up
    cp $01
    jr nz,p1_not_kemp_1
	ld bc,kempston1         ;code exec for input method 0 & 1
    in a,(c)
    res 3,a
    bit 5,a
    jr z,p1_input_done
    set 3,a
    jr p1_input_done
p1_not_kemp_1
    cp $02
    jr nz,p1_not_kemp_2_up
	ld bc,kempston2         ;code exec for input method 0 & 1
    in a,(c)
    jr p1_input_done
p1_not_kemp_2_up
    cp $01
    jr nz,p1_not_kemp_2
	ld bc,kempston2         ;code exec for input method 0 & 1
    in a,(c)
    res 3,a
    bit 5,a
    jr z,p1_input_done
    set 3,a
    jr p1_input_done
p1_not_kemp_2
    cp $04
    jr nz,p1_not_md_1
    ld bc,kempston1         ;code exec for input method 0 & 1
    in a,(c)
    res 3,a
    bit 5,a
    jr z,p1_input_done
    set 3,a
    jr p1_input_done
p1_not_md_1
    cp $05
    jr nz,p1_not_md_2
    ld bc,kempston2         ;code exec for input method 0 & 1
    in a,(c)
    res 3,a
    bit 5,a
    jr z,p1_input_done
    set 3,a
    jr p1_input_done
p1_not_md_2
    call p1_getkeyboard
p1_input_done
    ld (joyresult),a

    ld a,(p2_control)       ;check Player 1 control option
    cp $00                  
    jr nz,p2_not_kemp_1_up
	ld bc,kempston1         ;code exec for input method 0 & 1
    in a,(c)
    jr p2_input_done
p2_not_kemp_1_up
    cp $01
    jr nz,p2_not_kemp_1
	ld bc,kempston1         ;code exec for input method 0 & 1
    in a,(c)
    bit 5,a
    jr z,p2_input_done
    set 3,a
    jr p2_input_done
p2_not_kemp_1
    cp $02                  
    jr nz,p2_not_kemp_2_up
	ld bc,kempston2         ;code exec for input method 0 & 1
    in a,(c)
    jr p2_input_done
p2_not_kemp_2_up
    cp $03
    jr nz,p2_not_kemp_2
	ld bc,kempston2         ;code exec for input method 0 & 1
    in a,(c)
    bit 5,a
    jr z,p2_input_done
    set 3,a
    jr p2_input_done
p2_not_kemp_2
    cp $04
    jr nz,p2_not_md_1
    ld bc,kempston1         ;code exec for input method 0 & 1
    in a,(c)
    bit 5,a
    jr z,p2_input_done
    set 3,a
    jr p2_input_done
p2_not_md_1
    cp $05
    jr nz,p2_not_md_2
    ld bc,kempston2         ;code exec for input method 0 & 1
    in a,(c)
    bit 5,a
    jr z,p2_input_done
    set 3,a
    jr p2_input_done
p2_not_md_2
    call p2_getkeyboard
p2_input_done
    ld (joyresult2),a
		
	ld hl,l_ff02		;input 1 byte
	ld a,$f3
	ld (hl),a
	ld a,(joyresult)    
	call checkjoyresult
    
	ld hl,l_ff03		;input 1 byte
	ld a,$f3
	ld (hl),a
	ld a,(joyresult2)    
    call checkjoyresult

    call system_keys

    ret

checkjoyresult
    bit 0,a ;test right
    jr z,p1_moveleft
    res 1,(hl)				;clear left bit of input					

p1_moveleft
    bit 1,a ;test left
    jr z,p1_fire1
	res 0,(hl)
p1_fire1
    bit 3,a ;test up
	jr z,p1_fire2
    res 4,(hl)			;jump
p1_fire2
    bit 4,a ;test fire2
	jr z,pastdirection
    res 5,(hl)			;fire


    jr pastdirection
    


    
pastdirection
    ret

p1_getkeyboard
    ;break
    ld d,$00        ;nothing pressed
    ld bc,(p1_key_left)
    in e,(c)            ;read keyboard row/col
    ld a,(p1_key_left+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p1_key_left
    set 1,d
no_p1_key_left
    ld bc,(p1_key_right)
    in e,(c)            ;read keyboard row/col
    ld a,(p1_key_right+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p1_key_right
    set 0,d
no_p1_key_right
    ld bc,(p1_key_jump)
    in e,(c)            ;read keyboard row/col
    ld a,(p1_key_jump+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p1_key_jump
    set 3,d
no_p1_key_jump
    ld bc,(p1_key_fire)
    in e,(c)            ;read keyboard row/col
    ld a,(p1_key_fire+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p1_key_fire
    set 4,d
no_p1_key_fire
    ld a,d
    ret

p2_getkeyboard
    ;break
    ld d,$00        ;nothing pressed
    ld bc,(p2_key_left)
    in e,(c)            ;read keyboard row/col
    ld a,(p2_key_left+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p2_key_left
    set 1,d
no_p2_key_left
    ld bc,(p2_key_right)
    in e,(c)            ;read keyboard row/col
    ld a,(p2_key_right+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p2_key_right
    set 0,d
no_p2_key_right
    ld bc,(p2_key_jump)
    in e,(c)            ;read keyboard row/col
    ld a,(p2_key_jump+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p2_key_jump
    set 3,d
no_p2_key_jump
    ld bc,(p2_key_fire)
    in e,(c)            ;read keyboard row/col
    ld a,(p2_key_fire+2)    ;get actual value
    or e
    and $1f
    cp $1f
    jr z,no_p2_key_fire
    set 4,d
no_p2_key_fire
    ld a,d
    ret

system_keys
    ;break
    ld bc,$F7FE         ;1 to 5
    ld hl,l_ff02        ;p1 input
    in a,(c)            ;read val
    and $1f
    bit 3,a
    jr nz,no_p1_coin
    set 3,(hl)			;insert coin
no_p1_coin
    bit 0,a 
	jr nz,no_p1_start
    res 6,(hl)			;start game p1
no_p1_start
    bit 4,a
    jr nz,no_p2_coin
    set 2,(hl)			;insesrt coin 2
no_p2_coin
    ld hl,l_ff03
    bit 1,a
    jr nz,no_p2_start
    res 6,(hl)			;start game p2
no_p2_start
    ld a,(options_control)
    cp 0
    ret z               ;don't allow options if game if running
    ld bc,$EFFE         ;6 to 7
    in a,(c)            ;read val
    and $1f
    bit 2,a
    jp z,configure_controls
    bit 1,a
    jp z,configure_options
    ret

/*
jumpup   
moveright
moveleft
retpoint
    ret
*/
p1_control
    BYTE $06
    ;0/1=kemp 1/2 button joystick port A  2/3=kemp 1/2 button joystick Port B  4=MD Port A, 5=MD Port B,  6=keyboard
p2_control
    BYTE $06
    ;0/1=kemp 1/2 button joystick port A  2/3=kemp 1/2 button joystick Port B  4=MD Port A, 5=MD Port B,  6=keyboard

p1_key_left    ;bc val - in val
    BYTE $FE,$FE,$FD,2,"Z "        ;default z
p1_key_right    ;bc val - in val
    BYTE $FE,$FE,$FB,2,"X "        ;default x
p1_key_jump    ;bc val - in val
    BYTE $FE,$FB,$FE,2,"Q "       ;default q
p1_key_fire    ;bc val - in val
    BYTE $FE,$FD,$FE,2,"A "        ;default a
p2_key_left    ;bc val - in val
    BYTE $FE,$7F,$F7,2,"N "        ;default n
p2_key_right    ;bc val - in val
    BYTE $FE,$7F,$FB,2,"M "        ;default m
p2_key_jump    ;bc val - in val
    BYTE $FE,$DF,$FE,2,"P "        ;default p
p2_key_fire    ;bc val - in val
    BYTE $FE,$BF,$FD,2,"L "        ;default l

control_status
    BYTE $00

configure_controls
    ld   hl,control_config_data_1
    ld   de,$0830
    ld   c,$40    
	call Slave_Write_Layer2_Text
    ld   hl,control_config_data_2
    ld   de,$2018
    ld   c,$20    
	call Slave_Write_Layer2_Text
    ld   hl,control_config_data_3
    ld   de,$20a0
    ld   c,$50    
	call Slave_Write_Layer2_Text
    ld   hl,control_config_data_5
    ld   de,$6030
    ld   c,$40    
	call Slave_Write_Layer2_Text
    ld   hl,control_config_data_7
    ld   de,$4010
    ld   c,$00    
	call Slave_Write_Layer2_Text
    ld   hl,control_config_data_8
    ld   de,$4098
    ld   c,$00    
	call Slave_Write_Layer2_Text
    ld   hl,control_config_data_9
    ld   de,$b010
    ld   c,$00    
	call Slave_Write_Layer2_Text
    ld   hl,control_config_data_10
    ld   de,$b098
    ld   c,$00    
	call Slave_Write_Layer2_Text

    ld  hl,control_config_data_6
    ld  de,$7018
    ld b,4
configure_controls_loop
    push bc
    push hl
    push de
    ld c,$20
    call Slave_Write_Layer2_Text
    pop de
    pop hl
    push hl
    push de
    ld e,$a0
    ld c,$50
    call Slave_Write_Layer2_Text
    pop hl
    ld de,$1000
    add hl,de
    ex de,hl
    pop hl
    ld bc,$0006
    add hl,bc
    pop bc
    djnz configure_controls_loop
    call control_show_info
    nextreg $14,$e0			   ;change layer 2 mask
    ld a,1
    ld (control_status),a
    ld (control_timer),a
    ret

control_show_info
    ld a,(p1_control)
    ld b,a
    add a,a
    add a,a
    add a,a
    add a,a     ;*16
    ld d,0
    ld e,a
    ld hl,control_config_data_4
    add hl,de
    ld   de,$3000
    ld   c,$20    
	call Slave_Write_Layer2_Text

    ld a,(p2_control)
    ld b,a
    add a,a
    add a,a
    add a,a
    add a,a     ;*16
    ld d,0
    ld e,a
    ld hl,control_config_data_4
    add hl,de
    ld   de,$3088
    ld   c,$50    
	call Slave_Write_Layer2_Text

    ld hl,p1_key_left+3
    ld de,$7050
    ld c,$00
    call Slave_Write_Layer2_Text
    ld hl,p1_key_right+3
    ld de,$8050
    ld c,$00
    call Slave_Write_Layer2_Text
    ld hl,p1_key_jump+3
    ld de,$9050
    ld c,$00
    call Slave_Write_Layer2_Text
    ld hl,p1_key_fire+3
    ld de,$a050
    ld c,$00
    call Slave_Write_Layer2_Text

    ld hl,p2_key_left+3
    ld de,$70D8
    ld c,$00
    call Slave_Write_Layer2_Text
    ld hl,p2_key_right+3
    ld de,$80D8
    ld c,$00
    call Slave_Write_Layer2_Text
    ld hl,p2_key_jump+3
    ld de,$90D8
    ld c,$00
    call Slave_Write_Layer2_Text
    ld hl,p2_key_fire+3
    ld de,$a0D8
    ld c,$00
    call Slave_Write_Layer2_Text

    ret

change_inputs
    ;break
    ld a,(control_timer)
    cp 0
    jr z,change_inputs_1
    inc a
    and $0f
    ld (control_timer),a
    ret 
change_inputs_1
    ld bc,$F7FE         ;1 to 5
    in a,(c)            ;read val
    and $1f
    cp $1f
    jr z,change_input_end_2
    bit 0,a
    jr nz,no_change_inp_1
    ld a,(p1_control)
    inc a
    cp 7
    jr c,no_p1_overflow
    ld a,0
no_p1_overflow
    ld (p1_control),a
    jr change_input_end
no_change_inp_1
    bit 1,a
    jr nz,no_change_inp_2
    ld a,(p2_control)
    inc a
    cp 7
    jr c,no_p2_overflow
    ld a,0
no_p2_overflow
    ld (p2_control),a
    jr change_input_end
no_change_inp_2
    bit 2,a
    jr nz,no_redef_1
    ld a,2
    ld (control_status),a
    jr change_input_end
no_redef_1
    bit 3,a
    jr nz,change_input_end
    ld a,3
    ld (control_status),a
change_input_end
    ld a,1
    ld (control_timer),a
change_input_end_2
    ld bc,$EFFE         ;6 to 0
    in a,(c)            ;read val
    and $1f
    bit 0,a             ;exit control changes
    jr z,control_change_exit
    call control_show_info
    ret

control_change_exit
    ld a,0
    ld (control_status),a
    call slave_layer2_clear_screen
    nextreg $14,$00			   ;change layer 2 mask
    ;change Next Ports for correct controller
    ld bc,$243b         ;select peripheral 1 setting
    ld a,$05
    out (c),a
    ld bc,$253b
  ;  break
    ld a,(p1_control)
    cp 2
    jr c,changep1tokemp1
    cp 4
    jr c,changep1tokemp2
    jr z,changep1tomd1
    cp 5
    jr z,changep1tomd2
    jr control_change_p2_settings
changep1tokemp1
    in a,(c)
    and %00110111
    or  %01000000
    out (c),a
    jr control_change_p2_settings
changep1tokemp2
    in a,(c)
    and %00110111
    or  %00001000
    out (c),a
    jr control_change_p2_settings
changep1tomd1
    in a,(c)
    and %00110111
    or  %01001000
    out (c),a
    jr control_change_p2_settings
changep1tomd2
    in a,(c)
    and %00110111
    or  %10001000
    out (c),a
control_change_p2_settings
    ld a,(p2_control)
    cp 2
    jr c,changep2tokemp1
    cp 4
    jr c,changep2tokemp2
    jr z,changep2tomd1
    cp 5
    jr z,changep2tomd2
    jr control_change_final_exit
changep2tokemp1
    in a,(c)
    and %11001101
    or  %00010000
    out (c),a
    jr control_change_final_exit
changep2tokemp2
    in a,(c)
    and %11001101
    or  %00000010
    out (c),a
    jr control_change_final_exit
changep2tomd1
    in a,(c)
    and %11001101
    or  %00010010
    out (c),a
    jr control_change_final_exit
changep2tomd2
    in a,(c)
    and %11001101
    or  %00100010
    out (c),a
control_change_final_exit
    ret

control_redefine
    ld a,(control_timer)
    cp 0
    jr z,control_redefine_1
    inc a
    and $0f
    ld (control_timer),a
    ret 
control_redefine_1
    call control_show_info
    ;control status
    ;2 = refefine P1 keys
    ;3 = refefine P2 keys
    ld a,(control_status)
    cp 3
    jr z,control_redefine_p2

    ld   hl,control_config_data_11
    ld   de,$6030
    ld   c,$40    
	call Slave_Write_Layer2_Text

    ld de,$7050
    ld hl,p1_key_left
    call control_get_new_keys

    ret

control_redefine_p2

    ld   hl,control_config_data_12
    ld   de,$6030
    ld   c,$40    
	call Slave_Write_Layer2_Text

    ld de,$70D8
    ld hl,p2_key_left
    call control_get_new_keys

    ret

control_get_new_keys
    push hl
 /*   ld a,(control_current_key)
    ld b,$10
    call call_0DB1  ;a * b into HL
    ld h,l
    ld l,0
    add hl,de
    ex de,hl
    ld   hl,control_config_data_13
    ld   c,$00    
	call Slave_Write_Layer2_Text*/
    ld a,(control_current_key)
    ld b,6          ;size of structure entry
    call call_0DB1  ;a * b into HL	;80 bytes per row
    pop bc          ;retrieve control structure start into BC
    add hl,bc       ;structure offset into HL
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a,'?'
    ld (hl),a
    inc hl
    ld a,' '
    ld (hl),a
    pop hl


    call check_for_valid_key
    ret

check_for_valid_key
    ld bc,$FEFE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ld bc,$FDFE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ld bc,$FBFE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ld bc,$F7FE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ld bc,$EFFE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ld bc,$DFFE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ld bc,$BFFE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ld bc,$7FFE
    in a,(c)
    and $1f
    cp $1f
    jr nz,control_store_key
    ret

control_store_key
    ld (hl),c
    inc hl
    ld (hl),b
    inc hl
    ld (hl),a
    inc hl
    inc hl
    push hl
    call control_lookup_key_char
    pop hl
    ld (hl),d
    inc hl
    ld (hl),e
    ld a,1
    ld (control_timer),a
    ld a,(control_current_key)
    inc a
    ld (control_current_key),a
    cp 4
    jr z,control_redefine_finished
    ret

control_redefine_finished
    ld a,0
    ld (control_current_key),a
    ld a,1
    ld (control_status),a
    ret

control_lookup_key_char
    ;xor $1f     ;get value of key pressed
    ld e,a
    ld d,b
    ld a,0
control_lookup_loop_1
    rrc b
    jr nc,control_lookup_found_row
    inc a
    jr control_lookup_loop_1
control_lookup_found_row
    ;a now has the key row num
    ld b,10
    call call_0DB1  ;a * b into HL
    ld a,0
control_lookup_loop_2
    rrc e
    jr nc,control_lookup_found_col
    inc a
    jr control_lookup_loop_2
control_lookup_found_col
    add a,a
    add a,l
    ;now a contains offset into char table
    ld hl,control_char_table
    ld e,a
    ld d,0
    add hl,de
    ld d,(hl)
    inc hl
    ld e,(hl)
    ret

control_char_table
    BYTE "CSZ X C V "
    BYTE "A S D F G "
    BYTE "Q W E R T "
    BYTE "1 2 3 4 5 "
    BYTE "0 9 8 7 6 "
    BYTE "P O I U Y "
    BYTE "ENL K J H "
    BYTE "SPSSM N B "

control_current_key
    BYTE 0

control_timer
    BYTE 0

control_config_data_1
    BYTE $12,"CONFIGURE CONTROLS"
control_config_data_2
    BYTE $8,"PLAYER 1"
control_config_data_3
    BYTE $8,"PLAYER 2"
control_config_data_4
    BYTE $0f,"JOY A  1 BUTTON"
    BYTE $0f,"JOY A  2 BUTTON"
    BYTE $0f,"JOY B  1 BUTTON"
    BYTE $0f,"JOY B  2 BUTTON"
    BYTE $0f,"MEGADRIVE PAD A"
    BYTE $0f,"MEGADRIVE PAD B"
    BYTE $0f,"   KEYBOARD    "

control_config_data_5
    BYTE $14,"  KEY DEFINITIONS   "
control_config_data_6
    BYTE $05,"LEFT "
    BYTE $05,"RIGHT"
    BYTE $05,"JUMP "
    BYTE $05,"FIRE "

control_config_data_7
    BYTE $0b,"1 TO CHANGE"
control_config_data_8
    BYTE $0b,"2 TO CHANGE"
control_config_data_9
    BYTE $0b,"3 TO CHANGE"
control_config_data_10
    BYTE $0b,"4 TO CHANGE"

control_config_data_11
    BYTE $14,"PLAYER 1 SELECT KEYS"
control_config_data_12
    BYTE $14,"PLAYER 2 SELECT KEYS"

configure_options
    ld   hl,option_data_1
    ld   de,$0848
    ld   c,$40    
    call Slave_Write_Layer2_Text

    ld   hl,option_data_2
    ld   de,$2818
    ld   c,$20    
    call Slave_Write_Layer2_Text

    ld   hl,option_data_3
    ld   de,$4008
    ld   bc,$0500
    ;ld   bc,$0400
configure_options_loop_1
    push bc
    push hl
    push de
    call Slave_Write_Layer2_Text
    pop hl
    ld bc,$1000
    add hl,bc
    ex de,hl
    pop hl
    ld bc,$0010
    add hl,bc
    pop bc
    djnz configure_options_loop_1

    ld   hl,option_data_4
    ld   de,$9840
    ld   c,$40    
    call Slave_Write_Layer2_Text

    call get_dip_values

    call options_show_values

    nextreg $14,$e0			   ;change layer 2 mask
    ld a,8
    ld (control_status),a
    ld a,1
    ld (control_timer),a
    ret

options_show_values
    ld a,(option_difficulty)
    ld b,$0A
    call call_0DB1  ;a * b into HL	;80 bytes per row
    ld de,option_data_5
    add hl,de
    ld   de,$4088
    ld   c,$50    
	call Slave_Write_Layer2_Text

    ld a,(option_bonus)
    ld b,$0e
    call call_0DB1  ;a * b into HL	;80 bytes per row
    ld de,option_data_6
    add hl,de
    ld   de,$5088
    ld   c,$50    
	call Slave_Write_Layer2_Text

    ld a,(option_lives)
    ld b,$02
    call call_0DB1  ;a * b into HL	;80 bytes per row
    ld de,option_data_7
    add hl,de
    ld   de,$6088
    ld   c,$50    
	call Slave_Write_Layer2_Text

    /*ld a,(option_speed)
    ld b,$0a
    call call_0DB1  ;a * b into HL	;80 bytes per row
    ld de,option_data_8
    add hl,de
    ld   de,$7088
    ld   c,$50    
	call Slave_Write_Layer2_Text
*/
    ld bc,$243b
    ld a,09
    out (c),a    ;Select register #09  (peripheral 4)
    ld bc,$253b
    in a,(c)
    and $03
    ld b,$05
    call call_0DB1  ;a * b into HL	;80 bytes per row
    ld de,option_data_11
    add hl,de
    ld   de,$8088
    ld   c,$50    
	call Slave_Write_Layer2_Text

    ld bc,$243b
    ld a,05
    out (c),a    ;Select register #05  (peripheral 1)
    ld bc,$253b
    in a,(c)
	and $04		;check which refresh rate is currently used
    jr z,option_50hz
    ld hl,option_data_10    
    ld   de,$7088
    ld   c,$50    
	call Slave_Write_Layer2_Text

    ret
option_50hz
    ld hl,option_data_9
    ld   de,$7088
    ld   c,$50    
	call Slave_Write_Layer2_Text
    ret

    

change_options
    ;break
    ld a,(control_timer)
    cp 0
    jr z,change_options_1
    inc a
    and $0f
    ld (control_timer),a
    ret 
change_options_1
    ld bc,$F7FE         ;1 to 5
    in a,(c)            ;read val
    and $1f
    cp $1f
    jr z,options_input_end_2
    bit 0,a
    jr nz,no_change_diff
    ld a,(option_difficulty)
    inc a
    cp 4
    jr c,no_diff_overflow
    ld a,0
no_diff_overflow
    ld (option_difficulty),a
    jr options_input_end
no_change_diff
    bit 1,a
    jr nz,no_change_bonus
    ld a,(option_bonus)
    inc a
    cp 4
    jr c,no_bonus_overflow
    ld a,0
no_bonus_overflow
    ld (option_bonus),a
    jr options_input_end
no_change_bonus
    bit 2,a
    jr nz,no_change_lives
    ld a,(option_lives)
    inc a
    cp 4
    jr c,no_lives_overflow
    ld a,0
no_lives_overflow
    ld (option_lives),a
    jr options_input_end
no_change_lives
/*    bit 3,a
    jr nz,no_change_speed
    ld a,(option_speed)
    inc a
    cp 4
    jr c,no_speed_overflow
    ld a,0
no_speed_overflow
    ld (option_speed),a
    jr options_input_end
no_change_speed*/
    bit 3,a
    jr nz,options_no_freq
    ld bc,$243b
    ld a,05
    out (c),a    ;Select register #05  (peripheral 1)
    ld bc,$253b
    in a,(c)
    xor 4
    out (c),a
options_no_freq
    bit 4,a
    jr nz,options_input_end
    ld bc,$243b
    ld a,09
    out (c),a    ;Select register #09  (peripheral 4)
    ld bc,$253b
    in a,(c)
    ld d,a
    and $FC
    ld e,a
    ld a,d
    inc a
    and $03
    or e
    out (c),a
options_input_end
    ld a,1
    ld (control_timer),a
options_input_end_2
    ld bc,$EFFE         ;6 to 0
    in a,(c)            ;read val
    and $1f
    bit 0,a             ;exit control changes
    jr z,change_options_exit
    call options_show_values
    ret

change_options_exit
    ld a,0
    ld (control_status),a
    call slave_layer2_clear_screen
    nextreg $14,$00			   ;change layer 2 mask
    call set_dip_values
    ret

get_dip_values
    ld a,(l_ff01)
    and $03
    ld (option_difficulty),a
    ld a,(l_ff01)
    and $0c
    srl a
    srl a
    ld (option_bonus),a
    ld a,(l_ff01)
    and $30
    srl a
    srl a
    srl a
    srl a
    ld (option_lives),a
    ld a,(l_ff01)
    and $c0
    rlca
    rlca
    ld (option_speed),a
    ret

set_dip_values
    ;break
    ;ld a,(option_speed)
    ;rrca        ;move to top 2 bits
    ;rrca
    ;ld b,a
    ld a,(option_lives)
    sla a
    sla a
    sla a
    sla a
    ;or b
    ld b,a
    ld a,(option_bonus)
    sla a
    sla a
    or b
    ld b,a
    ld a,(option_difficulty)
    or b
    or %01000000
    ld (l_ff01),a
    ret


option_difficulty
    BYTE $00
option_bonus
    BYTE $00
option_lives
    BYTE $00
option_speed
    BYTE $00

option_data_1
    BYTE $0e,"SELECT OPTIONS"

option_data_2
    BYTE $19,"USE NUMBER KEYS TO CHANGE"

option_data_3
    BYTE $0f,"1. DIFFICULTY  "
    BYTE $0f,"2. BONUS LIFE  "
    BYTE $0f,"3. NUMBER LIVES"
    BYTE $0f,"4. REFRESH RATE"
    BYTE $0f,"5. SCANLINES   "

option_data_4
    BYTE $0f,"PRESS 0 TO EXIT"

option_data_5
    BYTE $09,"VERY HARD"
    BYTE $09,"HARD     "
    BYTE $09,"EASY     "
    BYTE $09,"NORMAL   "
    
option_data_6
    BYTE $0d,"50K 250K 500K"
    BYTE $0d,"40K 200K 500K"
    BYTE $0d,"20K 80K 300K "
    BYTE $0d,"30K 100K 400K"
    
option_data_7
    BYTE $01,"2"
    BYTE $01,"1"
    BYTE $01,"5"
    BYTE $01,"3"

/*option_data_8
    BYTE $09,"NORMAL   "
    BYTE $09,"MEDIUM   "
    BYTE $09,"HIGH     "
    BYTE $09,"VERY HIGH"
*/
option_data_9
    BYTE $04,"50HZ"

option_data_10
    BYTE $04,"60HZ"

option_data_11
    BYTE $04,"NONE"
    BYTE $04,"75% "
    BYTE $04,"50% "
    BYTE $04,"25% "


Slave_Write_Layer2_Num
	call call_1028
	
	ld 	(Slave_oldstack),sp
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
    jr   nz,Slave_Write_Layer2_Num2
    ld   a,b
    cp   $30
    jr   nz,Slave_Write_Layer2_Num1
    ld   b,$00
Slave_Write_Layer2_Num1
	xor  a
Slave_Write_Layer2_Num2
    ld	 c,0
	ld 	 l,d
	ld   d,iyh
	ld	 e,iyl
	call Slave_Layer2_Write_Char
	
	ld	 de,$0008
	add  iy,de
	ld	 a,b
	ld   d,iyh
	ld	 e,iyl
	call Slave_Layer2_Write_Char
	
	ld	 de,$0008
	add  iy,de
	ld	 a,l
	ld   d,iyh
	ld	 e,iyl
	call Slave_Layer2_Write_Char
    
	
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(Slave_oldstack)
	ret

	
Slave_Write_Layer2_Text
	ld 	(Slave_oldstack),sp
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
Slave_Write_Layer2_Text_Loop
	
	
	ld   a,(hl)
    ;ld   (de),a
    inc  hl
	call Slave_Layer2_Write_Char
	
	
    ;inc  de
    ;ld   a,c
	;ld   (de),a
	;inc  de
    djnz Slave_Write_Layer2_Text_Loop
	
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(Slave_oldstack)
	ret

Slave_Layer2_Write_Char			;write a letter to Layer 2
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
Slave_Layer2_Write_Char_Loop2
	push de
	push bc
	ld b,4
Slave_Layer2_Write_Char_Loop
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
	djnz Slave_Layer2_Write_Char_Loop
	pop bc
	pop de
	inc d
	djnz Slave_Layer2_Write_Char_Loop2
	pop de
	ld hl,$0008
	add hl,de
	ex de,hl
	pop bc
	pop hl
	ret

slave_layer2_clear_screen
	
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
	ret

Slave_oldstack
    BYTE $00,$00
    
slave_ay_music
    cp 0
    jr z,slave_ay_silence
    cp 2
    jr z,slave_ay_new_module
    call MUSIC_PLAY
    ret
slave_ay_silence
    call MUSIC_MUTE
    ret

slave_ay_new_module
    ld a,1
    ld (music_playing),a
    ld hl,(music_module)
    call MUSIC_MOD_START
    ret
    

    ORG MUSIC_START
    incbin "../data/bb_0_1.bin"
    ORG MODULE1
    incbin "../data/bb_0_2.bin"