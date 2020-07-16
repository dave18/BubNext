
    org $C000
    

bank0_call_8001
    ret  z
    bit  4,(ix+$00)
    ret  z
    dec  (hl)
    ret
    
bank0_data_8009
    BYTE $90,$27,$88,$27,$8C,$27,$98,$27,$94,$24,$98,$24,$9C,$28,$A0,$28
    BYTE $A4,$1C,$A8,$1C,$AC,$1C


bank0_data_801F
    BYTE $04,$14,$24,$34,$44,$54,$64,$74
bank0_data_8027    
    BYTE $48,$70,$78,$7C,$80,$84,$88,$8C
    BYTE $90,$94,$98
bank0_data_8032    
    BYTE $50,$00,$00,$01,$00,$02,$00,$03,$00,$04,$00,$05,$00
    BYTE $06,$00,$07,$00,$08,$00,$09,$00,$10,$00,$CC,$CF,$CC,$CF,$CF,$CF
    BYTE $CF,$FC,$FF,$FF,$FF,$F3,$3F,$B3,$3B,$BB,$BB,$BB,$8B,$B8,$B8,$B8
    BYTE $B8,$88,$B8,$88,$00


bank0_data_8064    ;special enemy death pattern for ???
    BYTE $02,$01,$03,$02,$05,$02,$08,$06,$0B,$02,$10,$05,$13,$01,$18,$08
    BYTE $1B,$01,$1E,$01,$1F,$01,$02,$01,$03,$02,$05,$02,$08,$06,$0B,$02
    BYTE $0D,$02,$0E,$01,$0F,$02,$10,$01,$99

    
bank0_data_808D     ;special enemy death pattern for ???
    BYTE $02,$01,$03,$03,$05,$03,$08,$0B,$0B,$03,$10,$07,$13,$01,$18,$0D
    BYTE $1B,$01,$1E,$01,$1F,$01,$02,$01,$03,$03,$05,$03,$08,$0B,$0B,$03
    BYTE $0D,$02,$0E,$01,$0F,$02,$10,$01,$99
    
bank0_data_80B6    ;special enemy death pattern for ???
    BYTE $02,$03,$03,$07,$05,$07,$08
    BYTE $17,$0B,$07,$0D,$07,$0E,$03,$0F,$07,$10,$04,$99

bank0_data_80C9                     ;enemy death spin/fall patterns
	BYTE LOW bank0_data_80D7,HIGH bank0_data_80D7
	BYTE LOW bank0_data_80EA,HIGH bank0_data_80EA
	BYTE LOW bank0_data_80FD,HIGH bank0_data_80FD
	BYTE LOW bank0_data_8110,HIGH bank0_data_8110
	BYTE LOW bank0_data_8127,HIGH bank0_data_8127
	BYTE LOW bank0_data_813A,HIGH bank0_data_813A
	BYTE LOW bank0_data_814D,HIGH bank0_data_814D
bank0_data_80D7
	BYTE $01,$02,$02,$01,$03,$01,$05,$01,$08,$02,$0B,$01,$0D,$01,$0E,$01,$0F,$02,$99
bank0_data_80EA
	BYTE $02,$01,$03,$02,$05,$02,$08,$06,$0B,$02,$0D,$02,$0E,$01,$0F,$02,$10,$01,$99
bank0_data_80FD
	BYTE $03,$02,$05,$01,$06,$01,$07,$01,$08,$06,$09,$01,$0A,$01,$0B,$01,$0D,$02,$99
bank0_data_8110
	BYTE $02,$01,$03,$02,$05,$02,$06,$01,$07,$01,$08,$03,$09,$01,$0A,$01,$0B,$02,$0D,$02,$0E,$01,$99
bank0_data_8127
	BYTE $01,$02,$02,$01,$03,$01,$05,$01,$08,$02,$0B,$01,$0D,$01,$0E,$01,$0F,$02,$99
bank0_data_813A
	BYTE $02,$01,$03,$02,$05,$02,$08,$06,$0B,$02,$0D,$02,$0E,$01,$0F,$02,$10,$01,$99
bank0_data_814D	
	BYTE $03,$02,$05,$01,$06,$01,$07,$01,$08,$06,$09,$01,$0A,$01,$0B,$01,$0D,$02,$99
bank0_data_8160    
	BYTE LOW bank0_data_816E,HIGH bank0_data_816E
	BYTE LOW bank0_data_8171,HIGH bank0_data_8171
	BYTE LOW bank0_data_8178,HIGH bank0_data_8178
	BYTE LOW bank0_data_8183,HIGH bank0_data_8183
	BYTE LOW bank0_data_818E,HIGH bank0_data_818E
	BYTE LOW bank0_data_819B,HIGH bank0_data_819B
	BYTE LOW bank0_data_81A8,HIGH bank0_data_81A8
bank0_data_816E
	BYTE $0E,$01,$99
bank0_data_8171
	BYTE $0B,$02,$0D,$02,$0E,$01,$99
bank0_data_8178
	BYTE $08,$06,$09,$02,$0B,$02,$0D,$02,$0E,$01,$99
bank0_data_8183	
	BYTE $08,$08,$09,$03,$0B,$03,$0D,$03,$0E,$01,$99
bank0_data_818E
	BYTE $09,$01,$08,$04,$09,$04,$0B,$04,$0D,$04,$0E,$01,$99
bank0_data_819B	
	BYTE $09,$02,$08,$04,$09,$05,$0B,$05,$0D,$05,$0E,$01,$99
bank0_data_81A8
	BYTE $08,$06,$09,$02,$0B,$02,$0D,$02,$0E,$01,$99
    
bank0_call_81B3
    ld   hl,l_ec29
    ld   bc,$0081
    jp   clearbytes;$0D50
bank0_call_81BC
    ld   a,(l_fc7a)
    and  a
    ret  nz
    call call_1530
    ld   a,h
    add  a,$1C
    ld   h,a
    call call_174B
    jr   z,bank0_call_81F4
    call call_1530
    ld   a,h
    sub  $1C
    ld   h,a
    call call_174B
    jr   z,bank0_call_81F4
    ld   a,(l_f44e)
    and  a
    jr   z,bank0_call_81F9
    ld   l,(ix+$1e)
    ld   h,(ix+$1f)
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    call resetframetimer;call_1556
    ld   (ix+$1d),a
    ld   (ix+$1c),a
bank0_call_81F4
    res  1,(ix+$19)
    ret
bank0_call_81F9
    ld   de,$0605
    call frametimer;call_15CA
    jr   nz,bank0_call_8213
    set  4,(ix+$19)
    res  1,(ix+$19)
    call resetframetimer;call_1556
    ld   (ix+$1d),a
    ld   (ix+$1c),a
    ret
bank0_call_8213
    call mul16;call_0D6D
bank0_call_8216
    push af
    ld   b,a
    bit  7,(ix+$00)
    jr   nz,bank0_call_8229
    ld   a,(l_e349)
    and  a
    ld   a,b
    jr   nz,bank0_call_8229
    add  a,$54
    jr   bank0_call_822B
bank0_call_8229
    add  a,$5C
bank0_call_822B
    ld   b,a
    ld   c,$1C
    ld   a,(ix+$22)
    bit  1,(ix+$08)
    jr   z,bank0_call_823C
    call call_147D
    jr   bank0_call_823F
bank0_call_823C
    call call_149C
bank0_call_823F
    pop  af
    ld   b,a
    bit  7,(ix+$00)
    jr   nz,bank0_call_8252
    ld   a,(l_e349)
    and  a
    ld   a,b
    jr   nz,bank0_call_8252
    add  a,$58
    jr   bank0_call_8254
bank0_call_8252
    add  a,$60
bank0_call_8254
    ld   b,a
    ld   c,$1C
    ld   a,(ix+$0a)
    bit  1,(ix+$08)
    jr   z,bank0_call_8265
    call call_147D
    jr   bank0_call_8268
bank0_call_8265
    call call_149C
bank0_call_8268
    call loadhlfromspritestruct;call_1529
    ld   e,(ix+$1e)
    ld   d,(ix+$1f)
    ld   a,(hl)
    ld   (de),a
    inc  hl
    inc  hl
    inc  de
    inc  de
    ld   a,(ix+$08)
    cp   $03
    ld   a,(hl)
    jr   z,bank0_call_8283
    add  a,$10
    jr   bank0_call_8285
bank0_call_8283
    sub  $10
bank0_call_8285
    ld   (de),a
    ret
    
bank0_call_8287    
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $8295
;    push ix
    ld   a,(l_ed40)
    and  a
    ret  z
    ld   ix,l_ec29
    ld   hl,l_eeac
    xor  a
bank0_call_82A2
    push af
    push hl
    ld   a,$19
    call adda2hl;$0D89
    bit  4,(hl)
    jp   z,bank0_call_8400
    bit  2,(ix+$00)
    jp   nz,bank0_call_83D5
    bit  0,(ix+$00)
    jp   nz,bank0_call_82FB
    pop  hl
    push hl
    ld   a,$22
    call adda2hl;$0D89
    ld   a,(hl)
    ld   (ix+$0a),a
    pop  hl
    push hl
    ld   a,$1E
    call adda2hl;$0D89
    ld   a,(hl)
    ld   (ix+$03),a
    inc  hl
    ld   a,(hl)
    ld   (ix+$04),a
    pop  hl
    push hl
    ld   a,$20
    call adda2hl;$0D89
    ld   a,(hl)
    ld   (ix+$07),a
    pop  hl
    push hl
    ld   a,$0C
    call adda2hl;$0D89
    ld   a,(hl)
    add  a,$04
    cp   $1E
    ld   (ix+$0c),a
    jr   c,bank0_call_82F7
    ld   (ix+$0c),$1E
bank0_call_82F7
    set  0,(ix+$00)
bank0_call_82FB
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_8400
    call bank0_call_885A
    call bank0_call_8838
    bit  3,(ix+$00)
    jp   nz,bank0_call_837F
    ld   a,(ix+$07)
    ld   hl,bank0_data_8442
    call call_0DA7
    ex   de,hl
    jp   (hl)       ;look up at $8442 fixed
bank0_call_831A
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_8394
    ld   b,a
bank0_call_8322
    push bc
    call loadhl2;$1537
    ld   a,(ix+$02)
    and  $07
    jp   nz,bank0_call_8333
    call bank0_call_8417
    jr   z,bank0_call_833F
bank0_call_8333
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_8322
    jp   bank0_call_8394
bank0_call_833F
    pop  bc
    call resetframetimer;call_1556
    ld   (ix+$00),$04
    ld   c,$0E
    call call_1350      ;add projectile hitting wall sound effect to queue
    jp   bank0_call_8400
bank0_call_834F
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_8394
    ld   b,a
bank0_call_8357
    push bc
    call loadhl2;1537
    ld   a,(ix+$02)
    and  $07
    jp   nz,bank0_call_8373
    call call_15E9
    jr   z,bank0_call_833F
    ld   a,(ix+$01)
    ld   h,(ix+$02)
    call call_174C
    jr   z,bank0_call_833F
bank0_call_8373
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_8357
    jp   bank0_call_8394
bank0_call_837F
    call call_1387
    call loadhlfromspritestruct;$1529
    ld   a,(ix+$01)
    ld   (hl),a
    cp   $0A
    jp   c,bank0_call_83F5
    inc  hl
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
bank0_call_8394
    bit  7,(ix+$0e)
    jr   bank0_call_83A0
    ld   a,(l_e349)
    and  a
    jr   z,bank0_call_83A5
bank0_call_83A0
    ld   de,$0304
    jr   bank0_call_83A8
bank0_call_83A5
    ld   de,$0504
bank0_call_83A8
    call frametimer;$15CA
    call mul16;$0D6D
    add  a,$04
    ld   b,a
    ld   c,$1C
    ld   a,(ix+$0a)
    bit  1,(ix+$07)
    jr   z,bank0_call_83C1
    call call_147D
    jr   bank0_call_83C4
bank0_call_83C1
    call call_149C
bank0_call_83C4
    inc  (ix+$0f)
    bit  0,(ix+$0f)
    jr   z,bank0_call_8400
    ld   e,$04
    call call_13F0
    jp   bank0_call_8400
bank0_call_83D5
    ld   de,$0A03
    call frametimer;$15CA
    jr   z,bank0_call_83EC
    add  a,a
    add  a,a
    add  a,$A4
    ld   b,a
    ld   c,$1C
    ld   a,(ix+$0a)
    call call_147D
    jr   bank0_call_8400
bank0_call_83EC
    pop  hl
    push hl
    ld   a,$19
    call adda2hl;$0D89
    res  4,(hl)
bank0_call_83F5
    call loadhlfromspritestruct;$1529
    xor  a
    ld   (hl),a
    inc  hl
    inc  hl
    ld   (hl),a
    ld   (ix+$00),a
bank0_call_8400
    ld   de,$0010
    add  ix,de
    pop  hl
    ld   a,$23
    call adda2hl;$0D89
    ex   de,hl
    pop  af
    inc  a
    ld   hl,l_ed40
    cp   (hl)
    ex   de,hl
    jp   nz,bank0_call_82A2
    ret

bank0_call_8417    
    ld   a,(ix+$02)
    and  $07
    ret  nz
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    ret  z
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    ret  z
    ld   a,(ix+$01)
    ld   h,(ix+$02)
    jp   call_174C


bank0_data_8442
    BYTE LOW bank0_call_837F, HIGH bank0_call_837F
    BYTE LOW bank0_call_834F, HIGH bank0_call_834F
    BYTE LOW bank0_call_837F, HIGH bank0_call_837F
    BYTE LOW bank0_call_831A, HIGH bank0_call_831A

bank0_call_844A
    ld   hl,l_ecaa
    ld   bc,$0077
    call clearbytes;$0D50
    ld   a,(l_ed3e)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  0,a
    ret  z
    ld   ix,l_ecaa
    xor  a
bank0_call_8463
    push af
    add  a,a
    ld   hl,(l_ed44)
    ld   (ix+$03),l
    ld   (ix+$04),h
    push hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   (l_ed44),hl
    pop  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$0a),a
    inc  hl
    inc  hl
    ld   (hl),$13
    ld   de,$0011
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed3e
    cp   (hl)
    jr   nz,bank0_call_8463
    ret
    
bank0_call_848E    
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $849C
;    push ix
    ld   a,(l_ed3e)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  0,a
    ret  z
    ld   ix,l_ecaa
    ld   hl,l_f2aa
    xor  a
bank0_call_84AF
    push af
    push hl
    ld   a,(l_f44e)
    and  a
    jp   nz,bank0_call_8585
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_8592
    ld   a,(l_f590)
    and  a
    jp   nz,bank0_call_8585
    call bank0_call_8879
    bit  0,(ix+$00)
    jp   nz,bank0_call_8517
    bit  2,(hl)
    jp   nz,bank0_call_8585
    bit  1,(hl)
    jp   nz,bank0_call_8585
    bit  3,(hl)
    jp   nz,bank0_call_8585
    ld   a,$0E
    call adda2hl;$0D89
    bit  1,(hl)
    jp   z,bank0_call_8592
    ld   (ix+$0c),$0F
    pop  hl
    push hl
    ld   a,$03
    call adda2hl;$0D89
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    call loadhlfromspritestruct;$1529
    ld   a,(de)
    sub  $10
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    inc  de
    ld   a,(de)
    ld   (hl),a
    ld   a,(ix+$0a)
    ld   b,$C4
    ld   c,$1E
    call call_147D
    set  0,(ix+$00)
    ld   c,$1D      ;add invader fire sound effect to queue
    call call_1350
bank0_call_8517
    bit  2,(ix+$00)
    jp   nz,bank0_call_856B
    bit  1,(ix+$00)
    jr   z,bank0_call_852E
    set  2,(ix+$00)
    call resetframetimer;call_1556
    jp   bank0_call_856B
bank0_call_852E
    call bank0_call_8838
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_8556
    ld   b,a
bank0_call_8539
    push bc
    call loadhl2;$1537
    ld   a,(ix+$01)
    cp   $18
    jr   nc,bank0_call_854F
    pop  bc
    set  2,(ix+$00)
    call resetframetimer;call_1556
    jp   bank0_call_856B
bank0_call_854F
    call loadhlfromspritestruct;$1529
    dec  (hl)
    pop  bc
    djnz bank0_call_8539
bank0_call_8556
    ld   de,$0302
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,$C4
    ld   b,a
    ld   c,$1E
    ld   a,(ix+$0a)
    call call_147D
    jr   bank0_call_8592
bank0_call_856B
    ld   de,$0506
    call frametimer;$15CA
    jr   z,bank0_call_8585
    ld   b,$CC
    bit  0,a
    jr   z,bank0_call_857B
    ld   b,$D0
bank0_call_857B
    ld   c,$1E
    ld   a,(ix+$0a)
    call call_147D
    jr   bank0_call_8592
bank0_call_8585
    call call_154C
    xor  a
    ld   (ix+$01),a
    ld   (ix+$02),a
    ld   (ix+$00),a
bank0_call_8592
    ld   de,$0011
    add  ix,de
    pop  hl
    ld   a,$19
    call adda2hl;$0D89
    ex   de,hl
    pop  af
    inc  a
    ld   hl,l_ed3e
    cp   (hl)
    ex   de,hl
    jp   nz,bank0_call_84AF
    ret


    
bank0_call_85A9
     call call_0020;rst  $20
     ld   hl,l_fc7a
     ld   (hl),$00
     ld   hl,l_fc7b
     ld   (hl),$00
     ld   hl,$0258
     ld   (l_fc78),hl
;     ld   hl,$044D
;     ld   de,($0B2E)
;     or   a
;     sbc  hl,de
;     jr   $85C8
;     push ix
     ld   hl,l_ed21
     ld   bc,$0028
     call clearbytes;$0D50
     ld   de,l_e26d
     ld   (l_ed44),de
     ld   hl,l_e59c
     ld   de,l_ed3e
     ld   b,$03
bank0_call_85E0
     ld   a,(hl)
     call div16;$0D62
     ld   (de),a
     inc  de
     ld   a,(hl)
     and  $0F
     ld   (de),a
     inc  de
     inc  hl
     djnz bank0_call_85E0
     xor  a
     ld   b,$06
     ld   hl,l_ed3e
bank0_call_85F4
     add  a,(hl)
     inc  hl
     djnz bank0_call_85F4
     ld   (l_ed3d),a
     ld   de,$000C
     ld   b,$0E
     ld   hl,l_e26d
     call call_18A5             ;set sprite numbers
     call bank0_call_89B9
     call bank0_call_8EFB
     call bank0_call_927D
     call bank0_call_9639
     call bank0_call_9893
     call bank0_call_9DD2       ;set x pos y pos and patterns
     call bank0_call_A108
     call bank0_call_B0F0
     call bank0_call_A59D
     call bank0_call_B939
     call bank0_call_81B3
     call call_79E9
     call bank0_call_BBCF
     call bank0_call_844A
     call bank0_call_A847
     ld   a,(l_e64b)
     cp   $63
     jp   z,bank0_call_8673
bank0_call_863B
     call call_0020;rst  $20
     ld   hl,l_ed21					;demo jumps here once player bubble bursts and player is reshown in starting position
     ld   de,l_fc01					;C615 in assembled code
     ld   bc,$001C
     ldir
     call bank0_call_8A18
     call bank0_call_B14A
     call bank0_call_8F4E
     call bank0_call_92F1
     call bank0_call_9695
     call bank0_call_98E5
     call bank0_call_9E33
     call bank0_call_A150
     call bank0_call_A5FF
     call bank0_call_8287
     call call_7A27
     call bank0_call_BC15
     call bank0_call_848E
     call bank0_call_8691
     jr   bank0_call_863B
bank0_call_8673
     ld   a,$00
  ;   ld   ($FA00),a
     ld (music_playing),a
     ld   hl,l_ed3d
     ld   (hl),$01
     ld   a,$05
     call call_0018;rst  $18
     ld   c,$09      ;add boss music to queue
     call call_1350
     ld   a,$B4
     call call_0018;rst  $18
bank0_call_8688
     call call_0020;rst  $20
     call bank0_call_A8C7
     call bank0_call_B97A
     jr   bank0_call_8688
bank0_call_8691
     ld   hl,l_fc7a
     bit  7,(hl)
     jr   z,bank0_call_869D
     ld   (hl),$01
     jp   call_0B82
bank0_call_869D
     ld   hl,l_fc7b
     bit  0,(hl)
     ret  z
     ld   (hl),$00
     jp   call_0B43
     
bank0_call_86A8
    call bank0_call_86BD
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    inc  hl
    bit  1,(ix+$00)
    ret  nz
    ld   (hl),c
    ret


bank0_call_86BD
    ld   a,(ix+$09)
    add  a,a
    add  a,a
    ld   hl,l_ed21
    jp   adda2hl;$0D89

bank0_call_86C8
    call bank0_call_86BD
    bit  7,(hl)
    jr   nz,bank0_call_86D1
    xor  a
    ret
bank0_call_86D1
    call loadhlfromspritestruct;$1529
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    ld   (ix+$01),$00
    ld   (ix+$02),$00
    ld   (ix+$00),$04
    scf
    ret


bank0_call_86E8
    call bank0_call_86BD
    bit  6,(hl)
    jr   nz,bank0_call_86F1
    xor  a
    ret
bank0_call_86F1
    ld   (ix+$0e),$00
    ex   de,hl
    call loadhlfromspritestruct;$1529
    inc  de
    ld   a,(de)
    sub  $08
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    sub  $08
    ld   (hl),a
    ld   (ix+$00),$02
    ld   hl,l_ed47
    inc  (hl)
    scf
    ret

bank0_call_870F
    call bank0_call_86BD
    bit  5,(hl)
    jr   nz,bank0_call_8718
    xor  a
    ret
bank0_call_8718
    res  5,(hl)
    set  0,(hl)
    ld   (ix+$07),$02
    ld   (ix+$0e),$20
    ld   (ix+$18),$00
    ld   (ix+$00),$A1
    ex   de,hl
    call loadhlfromspritestruct;$1529
    inc  de
    ld   a,(de)
    cp   $F0
    jr   nc,bank0_call_873E
    cp   $20
    jr   c,bank0_call_873E
    sub  $08
    jr   bank0_call_8740
bank0_call_873E
    ld   a,$20
bank0_call_8740
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    sub  $08
    ld   (hl),a
    ld   b,a
    sub  $E8
    jr   c,bank0_call_8751
    ld   (hl),$E8
    jr   bank0_call_8758
bank0_call_8751
    ld   a,b
    sub  $18
    jr   nc,bank0_call_8758
    ld   (hl),$18
bank0_call_8758
    call loadhl2;$1537
    call call_0AE3
    scf
    ret
bank0_call_8760
    ret
bank0_call_8761    
    ld   a,(ix+$01)
    and  $07
    ret  nz
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    sub  $08
    jp   call_174C  
bank0_call_8772
    ld   a,(ix+$01)
    and  $07
    ret  nz
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    sub  $09
    jp   call_174C
bank0_call_8786
    ld   a,(ix+$01)
    and  $07
    ret  nz
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    sub  $09
    jp   call_174C
bank0_call_879A    
    ld   a,(ix+$02)
    and  $07
    ret  nz
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    jp   call_174C
bank0_call_87AC    
    ld   a,(ix+$02)
    and  $07
    ret  nz
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    jp   call_174C
bank0_call_87BE
     call call_0D14
     ld   a,(ix+$09)
     ld   b,a
     add  a,a
     add  a,b
     ld   hl,l_e5a9
     call adda2hl;$0D89
     ld   a,(hl)
     ld   (ix+$10),a
     inc  hl
     ld   b,(hl)
     inc  hl
     ld   a,(hl)
     ld   (ix+$11),a
     call loadhlfromspritestruct;$1529
     inc  hl
     inc  hl
     ld   (hl),b
     ld   (ix+$12),$B4
     ld   a,(ix+$09)
     ld   b,a
     ld   hl,l_e5c2
     ld   a,b
     and  a
     ld   a,(hl)
     jr   z,bank0_call_87F1
bank0_call_87EE
     rrca
     djnz bank0_call_87EE
bank0_call_87F1
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    bit  0,a
    ret  z
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    ret

bank0_call_8805    
    dec  (ix+$10)
    ret  nz
    ld   (ix+$10),$01
    ld   a,(ix+$11)
    call loadhlfromspritestruct;$1529
    cp   (hl)
    jr   z,bank0_call_8821
    dec  (hl)
    call loadhl2;$1537
    ld   c,(ix+$17)
    call bank0_call_86A8
    ret
bank0_call_8821
    ld   a,(l_e64b)
    or   a
    jr   z,bank0_call_8833
    cp   $64
    jr   z,bank0_call_8833
    dec  (ix+$12)
    ld   a,(ix+$12)
    or   a
    ret  nz
bank0_call_8833
    set  5,(ix+$00)
    ret




bank0_call_8838			
    ld   a,(ix+$0c)			;causing crash as ix+$0c is return value higher than 2a which is beyond jump table
stophere2
	cp	$2b
	jr nc,stophere2
    ld   hl,data_11CE
    call call_0DA7      ;double A and add to HL
    ld   a,(ix+$0b)
    call adda2de;$0D84
    ld   a,(de)
    or   a
    jp   p,bank0_call_8853
    ld   (ix+$0b),$00
    jp   bank0_call_8838
bank0_call_8853
    ld   (ix+$0d),a
    inc  (ix+$0b)
    ret

     
     
bank0_call_885A
    ld   a,(l_f44e)
    and  a
    jr   z,bank0_call_8865
    call bank0_call_8EDF
    xor  a
    ret
bank0_call_8865
    bit  7,(ix+$00)
    jr   nz,bank0_call_8877
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_8877
    ld   a,(l_e5a0)
    ld   (ix+$0c),a
bank0_call_8877
    scf
    ret
    
bank0_call_8879
    ld   a,(l_e691)
    and  $02
    ld   b,a
    ld   a,(l_e6c3)
    and  $02
    or   b
    jr   z,bank0_call_888B
    res  7,(ix+$00)
bank0_call_888B
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_88BB
    bit  7,(ix+$00)
    jr   nz,bank0_call_88A2
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_88A2
    res  6,(ix+$0e)
    ret
bank0_call_88A2
    bit  6,(ix+$0e)
    ret  nz
    set  6,(ix+$0e)
    ld   a,(l_e5a0)
    add  a,$06
    cp   $28
    jr   c,bank0_call_88B6
    ld   a,$28
bank0_call_88B6
    ld   (ix+$0c),a
    jr   bank0_call_88C4
bank0_call_88BB
    bit  7,(ix+$0e)
    ret  nz
    set  7,(ix+$0e)
bank0_call_88C4
    call resetframetimer;$1556
    ld   (ix+$0b),$00
    ret

bank0_call_88CC
    call bank0_call_86BD
    bit  1,(hl)
    jr   z,bank0_call_88F5
    ld   a,(ix+$02)
    sub  $78
    ld   (ix+$08),$01
    jr   c,bank0_call_88E2
    ld   (ix+$08),$03
bank0_call_88E2
    set  4,(ix+$00)
    set  1,(ix+$00)
    ld   (ix+$0e),$00
    ld   c,$25              ;add bubble burst sound effect to queue
    call call_1350
    scf
    ret
bank0_call_88F5
    bit  2,(hl)
    jr   z,bank0_call_8918
    call resetframetimer;$1556
    ld   (ix+$0e),$04
    set  1,(ix+$00)
    ld   c,$25              ;add bubble burst sound effect to queue
    call call_1350
    ld   b,$00
    ld   c,$1C
    ld   a,(ix+$0a)
    call call_147D
    call call_1579
    scf
    ret
bank0_call_8918
    bit  4,(hl)
    jr   nz,bank0_call_891E
    xor  a
    ret
bank0_call_891E
    ld   a,(ix+$02)
    sub  $78
    ld   (ix+$08),$01
    jr   c,bank0_call_892D
    ld   (ix+$08),$03
bank0_call_892D
    set  6,(ix+$00)
    set  1,(ix+$00)
    ld   (ix+$0e),$00
    ld   c,$25
    call call_1350             ;add bubble burst sound effect to queue
    scf
    ret
bank0_call_8940
    ld   l,(ix+$10)
    ld   h,(ix+$11)
    ld   a,(hl)
    cp   $88					;end marker for data at $9ceb?
    jr   nz,bank0_call_895A     ;jr to routine to increase pointer within $9ceb data if not end marker
    set  2,(ix+$18)
    res  7,(ix+$18)
    ld   (ix+$12),$00
    jp   bank0_call_89A4
bank0_call_895A
    cp   $99
    ret  z
    or   a
    jr   z,bank0_call_896A
    bit  1,(ix+$08)
    jr   z,bank0_call_896A
    ld   b,a
    ld   a,$20
    sub  b
bank0_call_896A
    call call_109C
    ld   a,(ix+$12)
    call adda2de;$0D84
    ld   a,(de)
    ld   b,a
    call loadhlfromspritestruct;$1529
    bit  0,b
    jr   z,bank0_call_8984
    bit  3,b
    jr   nz,bank0_call_8983
    inc  (hl)
    jr   bank0_call_8984
bank0_call_8983
    dec  (hl)
bank0_call_8984
    bit  4,b
    jr   z,bank0_call_8992
    inc  hl
    inc  hl
    bit  7,b
    jr   nz,bank0_call_8991
    inc  (hl)
    jr   bank0_call_8992
bank0_call_8991
    dec  (hl)
bank0_call_8992
    inc  (ix+$12)
    inc  de
    ld   a,(de)
    cp   $88
    jr   z,bank0_call_899C
    ret
bank0_call_899C					
    ld   (ix+$12),$00
    dec  (ix+$13)
    ret  nz
bank0_call_89A4			;increase pointer in $9ceb data
    ld   l,(ix+$10)
    ld   h,(ix+$11)
    inc  hl
    inc  hl
    ld   (ix+$10),l
    ld   (ix+$11),h
    inc  hl
    ld   a,(hl)
    ld   (ix+$13),a
    inc  a
    ret
bank0_call_89B9
     ld   hl,l_ed49
     ld   bc,$00AF
     call clearbytes;0D50
     ld   a,(l_ed3e)
     and  a
     ret  z
     ld   a,(l_e5a4)
     bit  0,a
     ret  nz
     ld   ix,l_ed49
     xor  a
bank0_call_89D2
     push af
     add  a,a
     ld   hl,(l_ed44)
     ld   (ix+$03),l
     ld   (ix+$04),h
     push hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     ld   (l_ed44),hl
     pop  hl
     inc  hl
     ld   a,(hl)
     ld   (ix+$0a),a
     inc  hl
     inc  hl
     ld   (hl),$12
     ld   a,(l_ed46)
     ld   (ix+$09),a
     inc  a
     ld   (l_ed46),a
     ld   (ix+$16),$78
     call bank0_call_95E8
     ld   (ix+$17),$00
     ld   a,(l_e5a0)
     ld   (ix+$0c),a
     ld   de,$0019
     add  ix,de
     pop  af
     inc  a
     ld   hl,l_ed3e
     cp   (hl)
     jr   nz,bank0_call_89D2
     ret
     

bank0_call_8A18     
    ld   a,(l_ed3e)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  0,a
    ret  nz
    ld   ix,l_ed49
    xor  a
bank0_call_8A28
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_8E31
    ld   a,(ix+$00)
    bit  2,a
    jp   nz,bank0_call_8A68
    bit  1,a
    jp   nz,bank0_call_8A74
    call bank0_call_88CC
    jp   c,bank0_call_8E31
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_8A7A
    ld   a,(ix+$0a)
    ld   bc,$641D
    call call_147D
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    ld   (ix+$07),$02
    set  0,(ix+$00)
    jp   bank0_call_8E31
bank0_call_8A68
    call bank0_call_86E8
    jp   c,bank0_call_8E31
    call bank0_call_870F
    jp   bank0_call_8E31
bank0_call_8A74
    call call_7BFD
    jp   bank0_call_8E31

bank0_call_8A7A
    call loadhl2;$1537
    ld   c,$00
    call bank0_call_86A8
    call bank0_call_86C8
    jp   c,bank0_call_8E31
    call bank0_call_885A
    jp   nc,bank0_call_8DEA
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_8E31
    bit  5,(ix+$00)
    jr   nz,bank0_call_8AA4
    call bank0_call_8805
    jp   bank0_call_8DEA
bank0_call_8AA4
    bit  0,(ix+$18)
    jr   bank0_call_8AC6
    ld   hl,bank0_data_8E6B
    bit  7,(ix+$00)
    jr   nz,bank0_call_8ABB
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_8ABB
    jr   bank0_call_8ABE
bank0_call_8ABB
    ld   hl,bank0_data_8E6C
bank0_call_8ABE
    ld   c,$1D
    call bank0_call_915D
    jp   bank0_call_8E31
bank0_call_8AC6
    ld   a,(ix+$07)
    ld   hl,bank0_data_8E5F
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_8AD1
    call bank0_call_8AD7
    jp   bank0_call_8DEA
bank0_call_8AD7
    call bank0_call_8C0E
    ret  nc
    ld   a,(ix+$0d)
    or   a
    ret  z
    ld   b,a
bank0_call_8AE1
    push bc
    call loadhl2;$1537
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   nz,bank0_call_8AF9
    inc  (ix+$14)
    jp   bank0_call_8B57
bank0_call_8AF9
    ld   a,(ix+$17)
    cp   $03
    jr   z,bank0_call_8B0E
    call bank0_call_91B9
    jr   z,bank0_call_8B0E
    call bank0_call_917A
    jr   z,bank0_call_8B16
    bit  7,(hl)
    jr   nz,bank0_call_8B16
bank0_call_8B0E
    call call_1676
    jp   nz,bank0_call_8CD7
    jr   bank0_call_8B1B
bank0_call_8B16
    call bank0_call_8772
    jr   nz,bank0_call_8B2C
bank0_call_8B1B
    set  1,(ix+$0e)
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_8AE1
    call bank0_call_8E40
    ret
bank0_call_8B2C
    pop  bc
    call bank0_call_917A
    jr   nz,bank0_call_8B49
    call bank0_call_91E2
    jr   nz,bank0_call_8B49
    ld   de,bank0_data_9625
    set  7,(ix+$18)
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    ld   a,(hl)
    sub  $02
    ld   (hl),a
    jr   bank0_call_8B4C
bank0_call_8B49
    ld   de,bank0_data_8E74
bank0_call_8B4C
    call bank0_call_93F6
    ld   (ix+$07),$05
    call bank0_call_8940
    ret
bank0_call_8B57
    pop  bc
    bit  0,(ix+$14)
    jr   z,bank0_call_8B62
    call bank0_call_918F
    ret  nz
bank0_call_8B62
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    ret
bank0_call_8B6B    
    call bank0_call_8B71
    jp   bank0_call_8DEA
bank0_call_8B71    
    ld   a,(l_fc85)    ;security check???
    bit  0,a
    jr   bank0_call_8B7A   ;non conditional so SC bypassed
    exx
    ex   (sp),hl
bank0_call_8B7A
    call bank0_call_8C0E
    ret  nc
    ld   a,(ix+$0d)
    or   a
    ret  z
    ld   b,a
bank0_call_8B84
    push bc
    call loadhl2;$1537
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   nz,bank0_call_8B9C
    inc  (ix+$14)
    jp   bank0_call_8BFA
bank0_call_8B9C
    ld   a,(ix+$17)
    cp   $03
    jr   z,bank0_call_8BB1
    call bank0_call_91B9
    jr   z,bank0_call_8BB1
    call bank0_call_917A
    jr   z,bank0_call_8BB9
    bit  7,(hl)
    jr   nz,bank0_call_8BB9
bank0_call_8BB1
    call call_1676
    jp   nz,bank0_call_8CD7
    jr   bank0_call_8BBE
bank0_call_8BB9
    call bank0_call_8786
    jr   nz,bank0_call_8BCF
bank0_call_8BBE
    set  1,(ix+$0e)
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_8B84
    call bank0_call_8E40
    ret
bank0_call_8BCF
    pop  bc
    call bank0_call_917A
    jr   nz,bank0_call_8BEC
    call bank0_call_91E2
    jr   nz,bank0_call_8BEC
    ld   de,bank0_data_9625
    set  7,(ix+$18)
    call loadhlfromspritestruct;\$1529
    inc  hl
    inc  hl
    ld   a,(hl)
    add  a,$02
    ld   (hl),a
    jr   bank0_call_8BEF
bank0_call_8BEC
    ld   de,bank0_data_8E74
bank0_call_8BEF
    call bank0_call_93F6
    ld   (ix+$07),$04
    call bank0_call_8940
    ret
bank0_call_8BFA
    pop  bc
    bit  0,(ix+$14)
    jr   z,bank0_call_8C05
    call bank0_call_918F
    ret  z
bank0_call_8C05
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    ret
bank0_call_8C0E
    ld   a,(ix+$14)
    cp   $3C
    ret  c
    ld   de,bank0_data_9625
    call bank0_call_93F6
    set  7,(ix+$18)
    set  0,(ix+$18)
    ld   (ix+$14),$00
    ld   (ix+$07),$04
    ld   (ix+$08),$01
    xor  a
    ret
bank0_call_8C30
    call bank0_call_8C36
    jp   bank0_call_8DEA
bank0_call_8C36
    res  1,(ix+$0e)
    ld   a,(ix+$0d)
    or   a
    ret  z
    ld   b,a
bank0_call_8C40
    push bc
    call loadhl2;$1537
    ld   a,(ix+$02)
    cp   $19
    jp   c,bank0_call_8CD7
    bit  7,(ix+$18)
    jp   nz,bank0_call_8CA8
    bit  2,(ix+$18)
    jp   z,bank0_call_8C8A
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_8CD7
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jp   z,bank0_call_8CD7
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jp   z,bank0_call_8CD7
bank0_call_8C8A
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   nz,bank0_call_8CA8
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jr   z,bank0_call_8CB1
bank0_call_8CA8
    call bank0_call_8940
    jr   z,bank0_call_8CD7
    pop  bc
    djnz bank0_call_8C40
    ret
bank0_call_8CB1
    pop  bc
    inc  (ix+$14)
    ld   a,(ix+$14)
    cp   $03
    jr   c,bank0_call_8CC0
    set  2,(ix+$18)
bank0_call_8CC0
    ld   (ix+$08),$01
    ld   (ix+$07),$04
    ret
bank0_call_8CC9
    pop  bc
    res  2,(ix+$18)
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    ret
bank0_call_8CD7
    pop  bc
    inc  (ix+$14)
    res  2,(ix+$18)
    ld   (ix+$07),$02
    ret
bank0_call_8CE4    
    call bank0_call_8CEA
    jp   bank0_call_8DEA
bank0_call_8CEA
    res  1,(ix+$0e)
    ld   a,(ix+$0d)
    or   a
    ret  z
    ld   b,a
bank0_call_8CF4
    push bc
    call loadhl2;$1537
    ld   a,(ix+$02)
    cp   $E8
    jp   nc,bank0_call_8CD7
    bit  7,(ix+$18)
    jp   nz,bank0_call_8D5B
    bit  2,(ix+$18)
    jr   z,bank0_call_8D3D
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_8CD7
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jp   z,bank0_call_8CD7
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jp   z,bank0_call_8CD7
bank0_call_8D3D
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   nz,bank0_call_8D5B
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jr   z,bank0_call_8D65
bank0_call_8D5B
    call bank0_call_8940
    jp   z,bank0_call_8CD7
    pop  bc
    djnz bank0_call_8CF4
    ret
bank0_call_8D65
    pop  bc
    inc  (ix+$14)
    ld   a,(ix+$14)
    cp   $03
    jr   c,bank0_call_8D74
    set  2,(ix+$18)
bank0_call_8D74
    ld   (ix+$08),$03
    ld   (ix+$07),$05
    ret
bank0_call_8D7D
    pop  bc
    res  2,(ix+$18)
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    ret
bank0_call_8D8B
    call bank0_call_8D91
    jp   bank0_call_8DEA
bank0_call_8D91
    res  2,(ix+$18)
    res  7,(ix+$18)
    call loadhl2;$1537
    ld   a,(ix+$01)
    cp   $E0
    jr   nc,bank0_call_8DAD
    call bank0_call_8E89
    jr   z,bank0_call_8DAD
    call call_1676
    jr   z,bank0_call_8DB6
bank0_call_8DAD
    call loadhlfromspritestruct;$1529
    dec  (hl)
    res  1,(ix+$0e)
    ret
bank0_call_8DB6
    call resetframetimer;$1556
    set  1,(ix+$0e)
    res  5,(ix+$0e)
    ld   a,(ix+$02)
    cp   $19
    jp   c,bank0_call_8DD8
    ld   a,(ix+$02)
    cp   $E8
    jp   nc,bank0_call_8DE1
    ld   a,(ix+$08)
    ld   (ix+$07),a
    ret
bank0_call_8DD8
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    ret
bank0_call_8DE1
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    ret
bank0_call_8DEA
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_8E16
    bit  7,(ix+$00)
    jr   nz,bank0_call_8E04
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_8E04
    bit  4,(ix+$0e)
    jr   nz,bank0_call_8E16
    jr   bank0_call_8E25
bank0_call_8E04
    ld   hl,bank0_data_8E6C
    ld   de,(bank0_data_8E72)
    ld   c,$1D
    call bank0_call_913C
    call call_420B
    jp   bank0_call_8E31
bank0_call_8E16
    ld   hl,bank0_data_8E6D
    ld   de,(bank0_data_8E70)
    ld   c,$1D
    call bank0_call_913C
    jp   bank0_call_8E31
bank0_call_8E25
    ld   hl,bank0_data_8E6B
    ld   de,(bank0_data_8E6E)
    ld   c,$1D
    call bank0_call_913C
bank0_call_8E31
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed3e
    cp   (hl)
    jp   nz,bank0_call_8A28
    ret
bank0_call_8E40
    dec  (ix+$15)
    jr   nz,bank0_call_8E50
    call bank0_call_95E8
    ld   a,(ix+$18)
    xor  $02
    ld   (ix+$18),a
bank0_call_8E50
    bit  1,(ix+$18)
    jp   nz,bank0_call_8E5B
    call bank0_call_9500
    ret
bank0_call_8E5B
    call bank0_call_957A
    ret

    
bank0_data_8E5F
    BYTE LOW bank0_call_8DEA,HIGH bank0_call_8DEA
    BYTE LOW bank0_call_8B6B,HIGH bank0_call_8B6B
    BYTE LOW bank0_call_8D8B,HIGH bank0_call_8D8B
    BYTE LOW bank0_call_8AD1,HIGH bank0_call_8AD1
    BYTE LOW bank0_call_8CE4,HIGH bank0_call_8CE4
    BYTE LOW bank0_call_8C30,HIGH bank0_call_8C30

bank0_data_8E6B
    BYTE $64
bank0_data_8E6C
    BYTE $7C
bank0_data_8E6D    
    BYTE $94
bank0_data_8E6E
    BYTE $04,$06
bank0_data_8E70    
    BYTE $04,$0A
bank0_data_8E72    
    BYTE $04,$04
bank0_data_8E74    
    BYTE $00,$01,$03,$02,$05,$02,$07
    BYTE $01,$08,$05,$88,$00,$08,$05,$09,$02,$0B,$02,$0D,$02,$99
bank0_call_8E89    
    bit  5,(ix+$0e)
    jr   nz,bank0_call_8E99
    ld   a,(ix+$01)
    and  $07
    jr   z,bank0_call_8E99
    xor  a
    or   a
    ret
bank0_call_8E99
    ld   a,(ix+$02)
    add  a,$04
    ld   h,a
    ld   a,(ix+$01)
    sub  $04
    call call_174C
    ret  z
    ld   a,(ix+$02)
    sub  $04
    ld   h,a
    ld   a,(ix+$01)
    sub  $04
    call call_174C
    ret  z
    bit  5,(ix+$0e)
    jr   nz,bank0_call_8EC1
    ld   a,$01
    or   a
    ret
bank0_call_8EC1
    ld   a,(ix+$02)
    add  a,$04
    ld   h,a
    ld   a,(ix+$01)
    add  a,$04
    call call_174C
    ret  z
    ld   a,(ix+$02)
    sub  $04
    ld   h,a
    ld   a,(ix+$01)
    add  a,$04
    call call_174C
    ret
bank0_call_8EDF
    call loadhl2;$1537
    set  5,(ix+$0e)
    call bank0_call_8E89
    res  5,(ix+$0e)
    jr   z,bank0_call_8EF3
    call call_1676
    ret  z
bank0_call_8EF3
    call loadhlfromspritestruct;$1529
    dec  (hl)
    ld   a,$01
    and  a
    ret
     

bank0_call_8EFB
     ld   hl,l_edf8
     ld   bc,$00AF
     call clearbytes;$0D50
     ld   a,(l_ed3f)
     and  a
     ret  z
     ld   ix,l_edf8
     xor  a
bank0_call_8F0E
     push af
     ld   hl,(l_ed44)
     ld   (ix+$03),l
     ld   (ix+$04),h
     push hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     ld   (l_ed44),hl
     pop  hl
     inc  hl
     ld   a,(hl)
     ld   (ix+$0a),a
     inc  hl
     inc  hl
     ld   (hl),$12
     ld   a,$08
     call call_189D
     ld   (ix+$0c),a
     ld   a,(l_ed46)
     ld   (ix+$09),a
     inc  a
     ld   (l_ed46),a
     ld   (ix+$17),$01
     ld   de,$0019
     add  ix,de
     pop  af
     inc  a
     ld   hl,l_ed3f
     cp   (hl)
     jr   nz,bank0_call_8F0E
     ret

bank0_call_8F4E
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $8F5C
;    push ix
    ld   a,(l_ed3f)
    and  a
    ret  z
    ld   ix,l_edf8
    xor  a
bank0_call_8F66
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_912D
    ld   a,(ix+$00)
    bit  2,a
    jp   nz,bank0_call_8FAA
    bit  1,a
    jp   nz,bank0_call_8FB6
    call bank0_call_88CC
    jp   c,bank0_call_912D
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_8FBC
    ld   a,(ix+$0a)
    ld   bc,$981F
    call call_147D
    set  1,(ix+$0e)
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    set  0,(ix+$00)
    ld   (ix+$07),$02
    jp   bank0_call_912D
bank0_call_8FAA
    call bank0_call_86E8
    jp   c,bank0_call_912D
    call bank0_call_870F
    jp   bank0_call_912D
bank0_call_8FB6
    call call_7BFD
    jp   bank0_call_912D
bank0_call_8FBC    
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$12
    call loadhl2;$1537
    ld   c,$01
    call bank0_call_86A8
    call bank0_call_86C8
    jp   c,bank0_call_912D
    call bank0_call_885A
    jp   nc,bank0_call_90C2
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_912D
    bit  5,(ix+$00)
    jr   nz,bank0_call_8FEE
    call bank0_call_8805
    jp   bank0_call_90C2
bank0_call_8FEE
    bit  0,(ix+$18)
    jr   z,bank0_call_9010
    ld   hl,bank0_data_922D
    bit  7,(ix+$00)
    jr   nz,bank0_call_9005
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_9005
    jr   bank0_call_9008
bank0_call_9005
    ld   hl,bank0_data_9231
bank0_call_9008
    ld   c,$1F
    call bank0_call_915D
    jp   bank0_call_912D
bank0_call_9010    
    ld   a,(ix+$07)
    ld   hl,bank0_data_9218
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_901B
    res  2,(ix+$18)
    res  7,(ix+$18)
    call loadhl2;$1537
    ld   a,(ix+$01)
    cp   $E0
    jr   nc,bank0_call_9038
    call bank0_call_8E89
    jr   z,bank0_call_9038
    call call_1676
    jp   z,bank0_call_903F
bank0_call_9038
    call loadhlfromspritestruct;1529
    dec  (hl)
    jp   bank0_call_90C2
bank0_call_903F
    res  5,(ix+$0e)
    set  0,(ix+$0e)
    call bank0_call_917A
    jr   nz,bank0_call_9064
    call bank0_call_91E2
    jr   nz,bank0_call_9064
    ld   de,bank0_data_9625
    ld   a,(ix+$01)
    ld   (ix+$0f),a
    set  0,(ix+$18)
    set  7,(ix+$18)
    jr   bank0_call_9078
bank0_call_9064
    bit  7,(hl)
    jr   nz,bank0_call_9094
    ld   de,bank0_data_8E74
    bit  1,(ix+$14)
    jr   z,bank0_call_9078
    ld   (ix+$14),$00
    ld   de,bank0_data_9224
bank0_call_9078
    call bank0_call_93F6
    ld   a,(ix+$02)
    cp   $19
    jp   c,bank0_call_90A0
    ld   a,(ix+$02)
    cp   $E8
    jp   nc,bank0_call_90AB
    ld   a,(ix+$08)
    ld   (ix+$07),a
    jp   bank0_call_90C2
bank0_call_9094
    ld   de,bank0_data_8E74
    call bank0_call_93F6
    call bank0_call_918F
    jp   nz,bank0_call_90AB
bank0_call_90A0
    ld   (ix+$07),$04
    ld   (ix+$08),$01
    jp   bank0_call_90C2
bank0_call_90AB
    ld   (ix+$07),$05
    ld   (ix+$08),$03
    jp   bank0_call_90C2
bank0_call_90B6
    call bank0_call_8C36
    jp   bank0_call_90C2
bank0_call_90BC
    call bank0_call_8CEA
    jp   bank0_call_90C2
bank0_call_90C2
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_9105
    bit  7,(ix+$00)
    jr   nz,bank0_call_90DC
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_90DC
    bit  4,(ix+$0e)
    jr   nz,bank0_call_9105
    jr   bank0_call_9114
bank0_call_90DC
  ;  ld   a,i
  ;  ld   h,a
  ;  ld   a,($FC00)
  ;  ld   l,a
  ;  ld   de,$0B2E
  ;  or   a
  ;  sbc  hl,de
  ;  jr   $90ED
  ;  push iy
bank0_call_90ED
    ld   hl,bank0_data_9233
    ld   de,(bank0_data_9239)
    bit  0,(ix+$0e)
    jr   z,bank0_call_90FD
    ld   hl,bank0_data_9231
bank0_call_90FD
    ld   c,$1F
    call bank0_call_913C
    jp   bank0_call_912D
bank0_call_9105
    ld   hl,bank0_data_9235
    ld   de,(bank0_data_923D)
    ld   c,$1F
    call bank0_call_913C
    jp   bank0_call_912D
bank0_call_9114
    ld   hl,bank0_data_922F
    ld   de,(bank0_data_923B)
    bit  0,(ix+$0e)
    jr   z,bank0_call_9128
    ld   hl,bank0_data_922D
    ld   de,(bank0_data_923F)
bank0_call_9128
    ld   c,$1F
    call bank0_call_913C    
bank0_call_912D
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed3f
    cp   (hl)
    jp   nz,bank0_call_8F66
    ret
bank0_call_913C
    call frametimer;$15CA
    jr   nz,bank0_call_9148
    res  0,(ix+$0e)
    jp   bank0_call_913C
bank0_call_9148
    add  a,a
    add  a,a
    add  a,(hl)
    ld   b,a
    ld   a,(ix+$0a)
    bit  1,(ix+$08)
    jr   z,bank0_call_9159
    call call_147D
    ret
bank0_call_9159
    call call_149C
    ret
bank0_call_915D
    ld   de,$0F02
    call frametimer;15CA
    jr   z,bank0_call_9175
    bit  0,a
    ld   a,(ix+$0a)
    ld   b,(hl)
    jr   z,bank0_call_9171
    call call_149C
    ret
bank0_call_9171
    call call_147D
    ret
bank0_call_9175
    res  0,(ix+$18)
    ret
bank0_call_917A    
    ld   hl,l_fc27
    ld   a,(ix+$09)
    add  a,a
    add  a,a
    add  a,a
    call adda2hl;$0D89
    call bank0_call_91A6
    bit  7,(hl)
    ret  nz
    bit  0,(hl)
    ret
bank0_call_918F
    ld   hl,l_fc27
    ld   a,(ix+$09)
    add  a,a
    add  a,a
    add  a,a
    call adda2hl;$0D89
    inc  hl
    inc  hl
    call bank0_call_91A6
    bit  7,(hl)
    ret  nz
    bit  0,(hl)
    ret
bank0_call_91A6
    bit  0,(ix+$09)
    ld   a,(l_e5d7)
    jr   z,bank0_call_91B4
    bit  1,a
    ret  z
    inc  hl
    ret
bank0_call_91B4
     bit  0,a
     ret  nz
     inc  hl
     ret
bank0_call_91B9
    bit  0,(ix+$09)
    ld   a,(l_e5d7)
    jr   z,bank0_call_91D2
    bit  1,a
    jr   nz,bank0_call_91CC
    ld   a,(l_e691)
    bit  0,a
    ret
bank0_call_91CC
    ld   a,(l_e6c3)
    bit  0,a
    ret
bank0_call_91D2
    bit  0,a
    jr   nz,bank0_call_91DC
    ld   a,(l_e6c3)
    bit  0,a
    ret
bank0_call_91DC
    ld   a,(l_e691)
    bit  0,a
    ret
bank0_call_91E2
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    add  a,$04
    call call_174C
    ret  z
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    add  a,$0C
    call call_174C
    jr   nz,bank0_call_9200
    ld   (ix+$0f),$00
    ret
bank0_call_9200
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    add  a,$14
    call call_174C
    ret  z
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    add  a,$1C
    call call_174C
    ret
    
bank0_data_9218
    BYTE LOW bank0_call_90C2,HIGH bank0_call_90C2
    BYTE LOW bank0_call_90BC,HIGH bank0_call_90BC
    BYTE LOW bank0_call_901B,HIGH bank0_call_901B
    BYTE LOW bank0_call_90B6,HIGH bank0_call_90B6
    BYTE LOW bank0_call_90BC,HIGH bank0_call_90BC
    BYTE LOW bank0_call_90B6,HIGH bank0_call_90B6
bank0_data_9224
    BYTE $03,$04,$08,$04,$88,$00,$0D,$04,$99
bank0_data_922D
    BYTE $98,$9C
bank0_data_922F    
    BYTE $A0,$A4
bank0_data_9231
    BYTE $A8,$AC
bank0_data_9233    
    BYTE $B0,$B4
bank0_data_9235    
    BYTE $B8,$BC,$C0,$C4
bank0_data_9239    
    BYTE $02,$02
bank0_data_923B    
    BYTE $02,$03
bank0_data_923D
    BYTE $02,$06
bank0_data_923F    
    BYTE $02,$08
bank0_call_9241    
    ret
bank0_data_9242    
    BYTE $00,$00,$00,$00,$00


bank0_call_927D
     ld   hl,l_eeac
     ld   bc,$00F5
     call clearbytes;$0D50
     ld   a,(l_ed40)
     and  a
     ret  z
     ld   a,(l_e5a4)
     bit  4,a
     ret  nz
     ld   ix,l_eeac
     xor  a
bank0_call_9296
     push af
     ld   b,a
     ld   hl,(l_ed44)
     ld   (ix+$03),l
     ld   (ix+$04),h
     push hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     ld   (l_ed44),hl
     pop  hl
     inc  hl
     ld   a,(hl)
     ld   (ix+$0a),a
     inc  hl
     inc  hl
     ld   (hl),$14
     ld   a,(l_ed46)
     ld   (ix+$09),a
     inc  a
     ld   (l_ed46),a
     ld   (ix+$17),$02
     ld   (ix+$16),$3C
     call bank0_call_95E8
     ld   hl,(l_ed44)
     ld   (ix+$1e),l
     ld   (ix+$1f),h
     push hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     ld   (l_ed44),hl
     pop  hl
     inc  hl
     ld   a,(hl)
     ld   (ix+$22),a
     inc  hl
     inc  hl
     ld   (hl),$14
     ld   de,$0023
     add  ix,de
     pop  af
     inc  a
     ld   hl,l_ed40
     cp   (hl)
     jr   nz,bank0_call_9296
     ret
     
     
bank0_call_92F1
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $92FF
;    push ix
    ld   a,(l_ed40)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  4,a
    ret  nz
    ld   ix,l_eeac
    xor  a
bank0_call_930F
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_94CC
    ld   a,(ix+$00)
    bit  2,a
    jp   nz,bank0_call_935F
    bit  1,a
    jp   nz,bank0_call_936B
    call bank0_call_88CC
    jr   nc,bank0_call_9343
    bit  1,(ix+$19)
    jp   z,bank0_call_94CC
    ld   l,(ix+$1e)
    ld   h,(ix+$1f)
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    ld   (ix+$19),$00
    jp   bank0_call_94CC
bank0_call_9343
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_9371
    ld   (ix+$07),$01
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    set  0,(ix+$00)
    jp   bank0_call_94CC
bank0_call_935F
    call bank0_call_86E8
    jp   c,bank0_call_94CC
    call bank0_call_870F
    jp   bank0_call_94CC
bank0_call_936B
    call call_7BFD
    jp   bank0_call_94CC
bank0_call_9371
    ld   c,$02
    call bank0_call_86A8
    call bank0_call_86C8
    jr   nc,bank0_call_9395
    bit  1,(ix+$19)
    jp   z,bank0_call_94CC
    ld   l,(ix+$1e)
    ld   h,(ix+$1f)
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    ld   (ix+$19),$00
    jp   bank0_call_94CC
bank0_call_9395
    call bank0_call_885A
    jp   nc,bank0_call_9435
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_94CC
    bit  5,(ix+$00)
    jr   nz,bank0_call_93B1
    call bank0_call_8805
    jp   bank0_call_9435
bank0_call_93B1
    bit  1,(ix+$19)
    jr   z,bank0_call_93BD
    call bank0_call_81BC
    jp   bank0_call_94CC
bank0_call_93BD
    bit  0,(ix+$18)
    jr   z,bank0_call_93DF
    ld   hl,bank0_data_9636
    bit  7,(ix+$00)
    jr   nz,bank0_call_93D4
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_93D4
    jr   bank0_call_93D7
bank0_call_93D4
    ld   hl,bank0_data_9637
bank0_call_93D7
    ld   c,$1C
    call bank0_call_915D
    jp   bank0_call_94CC
bank0_call_93DF
    ld   a,(ix+$07)
    ld   hl,bank0_data_95F9
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_93EA
    call bank0_call_8AD7
    call call_7B94
    call nz,bank0_call_95C9
    jp   bank0_call_9435
    res  2,(ix+$18)
    ld   (ix+$10),e
    ld   (ix+$11),d
    inc  de
    ld   a,(de)
    ld   (ix+$13),a
    xor  a
    ld   (ix+$12),a
    ld   (ix+$05),a
    ld   (ix+$06),a
    ret
    

bank0_call_93F6
    res  2,(ix+$18)
    ld   (ix+$10),e
    ld   (ix+$11),d
    inc  de
    ld   a,(de)
    ld   (ix+$13),a
    xor  a
    ld   (ix+$12),a
    ld   (ix+$05),a
    ld   (ix+$06),a
    ret
bank0_call_9410
    call bank0_call_8B71
    call call_7B94
    call nz,bank0_call_95C9
    jp   bank0_call_9435
bank0_call_941C
    call bank0_call_8C36
    jp   bank0_call_9435
bank0_call_9422
    call bank0_call_8CEA
    jp   bank0_call_9435
bank0_call_9428
    res  0,(ix+$0e)
    call bank0_call_8D91
    call call_7B94
    call nz,bank0_call_95C9
bank0_call_9435
    ld   c,$1C
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_9473
    bit  7,(ix+$00)
    jr   nz,bank0_call_9451
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_9451
    bit  4,(ix+$0e)
    jr   nz,bank0_call_9473
    jr   bank0_call_949A
bank0_call_9451
    ld   de,$0202
    call frametimer;call_15CA
    ld   b,a
    call mul16;call_0D6D
    bit  0,(ix+$0e)
    jr   nz,bank0_call_946F
    add  a,$0C
    jr   bank0_call_94B9
    bit  1,(ix+$19)
    jr   z,bank0_call_946F
    add  a,$4C
    jr   bank0_call_94B9
bank0_call_946F
    add  a,$2C
    jr   bank0_call_94B9
bank0_call_9473
    ld   a,(l_f44e)
    and  a
    jr   z,bank0_call_949A
    ld   de,$0F02
    call frametimer;call_15CA
    call mul16;call_0D6D
    bit  0,(ix+$0e)
    jr   nz,bank0_call_9496
    add  a,$10
    jr   bank0_call_94B9
    bit  1,(ix+$19)
    jr   z,bank0_call_9496
    add  a,$50
    jr   bank0_call_94B9
bank0_call_9496
    add  a,$30
    jr   bank0_call_94B9
bank0_call_949A
    ld   de,$0502
    call frametimer;$15CA
    call mul16;$0D6D
    bit  0,(ix+$0e)
    jr   nz,bank0_call_94B7
    add  a,$08
    jr   bank0_call_94B9
    bit  1,(ix+$19)
    jr   z,bank0_call_94B7
    add  a,$48
    jr   bank0_call_94B9
bank0_call_94B7
    add  a,$28
bank0_call_94B9
    ld   b,a
    ld   a,(ix+$0a)
    bit  1,(ix+$08)
    jr   z,bank0_call_94C9
    call call_147D
    jp   bank0_call_94CC
bank0_call_94C9
    call call_149C
bank0_call_94CC
    ld   de,$0023
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed40
    cp   (hl)
    jp   nz,bank0_call_930F
    ret

bank0_call_9500    
    ld   a,(ix+$01)
    cp   $20
    ret  z
    call bank0_call_91B9
    ret  z
;    ld   a,i
;    ld   h,a
;    ld   a,($FC00)
;    ld   l,a
;    ld   de,$0B2E
;    or   a
;    sbc  hl,de
;    jr   $951B
;    push iy
bank0_call_951B
    ld   hl,l_fc2b
    ld   a,(ix+$09)
    add  a,a
    add  a,a
    add  a,a
    call adda2hl;$0D89
    call bank0_call_91A6
    ld   a,(hl)
    cp   $20
    ret  nc
    ld   (ix+$0f),$01
    call bank0_call_917A
    jr   z,bank0_call_953D
    xor  a
    bit  7,(hl)
    ret  z
    scf
    ret
bank0_call_953D
    call bank0_call_918F
    jr   z,bank0_call_9548
    bit  7,(hl)
    jr   z,bank0_call_9561
    xor  a
    ret
bank0_call_9548
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   a,(hl)
    cp   $10
    jr   nc,bank0_call_9557
    set  1,(ix+$18)
    xor  a
    ret
bank0_call_9557
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    xor  a
    ret
bank0_call_9561
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   a,(hl)
    cp   $10
    jr   nc,bank0_call_9570
    set  1,(ix+$18)
    xor  a
    ret
bank0_call_9570
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    xor  a
    ret
bank0_call_957A
    call bank0_call_91B9
    jr   z,bank0_call_958A
    call bank0_call_917A
    jr   z,bank0_call_958A
    xor  a
    bit  7,(hl)
    ret  z
    scf
    ret
bank0_call_958A
    ld   (ix+$15),$02
    call bank0_call_91E2
    ret  nz
    ld   de,bank0_data_9625
    set  7,(ix+$18)
    ld   a,(ix+$0f)
    cp   (ix+$01)
    ld   a,(ix+$01)
    ld   (ix+$0f),a
    jr   nz,bank0_call_95AE
    ld   de,bank0_data_9628
    ld   (ix+$0f),$00
bank0_call_95AE
    bit  1,(ix+$08)
    ld   (ix+$07),$05
    jr   nz,bank0_call_95BC
    ld   (ix+$07),$04
bank0_call_95BC
    call bank0_call_93F6
    set  0,(ix+$18)
    set  7,(ix+$18)
    xor  a
    ret
bank0_call_95C9
    bit  4,(ix+$19)
    ret  nz
    bit  2,(ix+$07)
    ret  nz
    xor  a
    call resetframetimer;$1556
    ld   (ix+$1c),a
    ld   (ix+$1d),a
    ld   a,(ix+$08)
    ld   (ix+$20),a
    set  1,(ix+$19)
    ret
bank0_call_95E8
    ld   a,(ix+$09)
    inc  a
    ld   b,a
    ld   a,$0A
    ld   c,(ix+$16)
bank0_call_95F2
    add  a,c
    djnz bank0_call_95F2
    ld   (ix+$15),a
    ret
bank0_data_95F9
    BYTE LOW bank0_call_9435,HIGH bank0_call_9435
    BYTE LOW bank0_call_9410,HIGH bank0_call_9410
    BYTE LOW bank0_call_9428,HIGH bank0_call_9428
    BYTE LOW bank0_call_93EA,HIGH bank0_call_93EA
    BYTE LOW bank0_call_9422,HIGH bank0_call_9422
    BYTE LOW bank0_call_941C,HIGH bank0_call_941C

bank0_data_9625
    BYTE $00,$28,$99
bank0_data_9628    
    BYTE $01,$06,$02,$01,$03,$01,$08,$02,$88,$00,$99,$08,$04,$99
bank0_data_9636    
    BYTE $38
bank0_data_9637    
    BYTE $3C,$40


bank0_call_9639
     ld   hl,l_efa1
     ld   bc,$00BE
     call clearbytes;$0D50
     ld   a,(l_ed41)
     and  a
     ret  z
     ld   ix,l_efa1
     xor  a
bank0_call_964C
     push af
     ld   b,a
     ld   hl,(l_ed44)
     ld   (ix+$03),l
     ld   (ix+$04),h
     push hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     ld   (l_ed44),hl
     pop  hl
     inc  bc
     inc  hl
     ld   a,(hl)
     ld   (ix+$0a),a
     inc  hl
     inc  hl
     ld   (hl),$17
     ld   a,(l_ed46)
     ld   (ix+$09),a
     inc  a
     ld   (l_ed46),a
     ld   (ix+$17),$03
     ld   (ix+$16),$78
     call bank0_call_95E8
     ld   a,$08
     call call_189D
     ld   (ix+$0c),a
     ld   de,$001B
     add  ix,de
     pop  af
     inc  a
     ld   hl,l_ed41
     cp   (hl)
     jr   nz,bank0_call_964C
     ret


bank0_call_9695
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $96A3
;    push ix
    ld   a,(l_ed41)
    and  a
    ret  z
    ld   ix,l_efa1
    xor  a
bank0_call_96AD
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_97DD
    ld   a,(ix+$00)
    bit  2,a
    jp   nz,bank0_call_96F6
    bit  1,a
    jp   nz,bank0_call_9702
    call bank0_call_88CC
    jr   nc,bank0_call_96D5
    bit  3,(ix+$18)
    jp   z,bank0_call_97DD
    set  5,(ix+$18)
    jp   bank0_call_97DD
bank0_call_96D5
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_9708
    ld   (ix+$07),$02
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    set  0,(ix+$00)
    ld   hl,l_f05e
    ld   (hl),$02
    jp   bank0_call_97DD
bank0_call_96F6
    call bank0_call_86E8
    jp   c,bank0_call_97DD
    call bank0_call_870F
    jp   bank0_call_97DD
bank0_call_9702
    call call_7BFD
    jp   bank0_call_97DD
bank0_call_9708
    call loadhl2;call_1537
    ld   c,$03
    call bank0_call_86A8
    call bank0_call_86C8
    jp   nc,bank0_call_971D
    set  5,(ix+$18)
    jp   bank0_call_97DD
bank0_call_971D
    call bank0_call_885A
    jp   nc,bank0_call_9793
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_97DD
    bit  5,(ix+$00)
    jr   nz,bank0_call_9739
    call bank0_call_8805
    jp   bank0_call_9793
bank0_call_9739
    bit  0,(ix+$18)
    jr   z,bank0_call_975B
    ld   hl,bank0_data_9889
    bit  7,(ix+$00)
    jr   nz,bank0_call_9750
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_9750
    jr   bank0_call_9753
bank0_call_9750
    ld   hl,bank0_data_988A
bank0_call_9753
    ld   c,$1E
    call bank0_call_915D
    jp   bank0_call_97DD
bank0_call_975B
    ld   a,(ix+$07)
    ld   hl,bank0_data_987D
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_9766
    call bank0_call_8AD7
    call call_7B94
    call nz,bank0_call_981C
    jp   bank0_call_9793
bank0_call_9772
    call bank0_call_8B71
    call call_7B94
    call nz,bank0_call_981C
    jp   bank0_call_9793
bank0_call_977E
    call bank0_call_8C36
    jp   bank0_call_9793
bank0_call_9784
    call bank0_call_8CEA
    jp   bank0_call_9793
bank0_call_978A
    call bank0_call_8D91
    call call_7B94
    call nz,bank0_call_981C
bank0_call_9793
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_97BF
    bit  7,(ix+$00)
    jr   nz,bank0_call_97AD
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_97AD
    bit  4,(ix+$0e)
    jr   nz,bank0_call_97BF
    jr   bank0_call_97CE
bank0_call_97AD
    ld   hl,bank0_data_988A
    call bank0_call_984D
    ld   de,(bank0_data_9891)
    ld   c,$1E
    call bank0_call_913C
    jp   bank0_call_97DD
bank0_call_97BF
    ld   hl,bank0_data_988B
    ld   de,(bank0_data_988F)
    ld   c,$1E
    call bank0_call_913C
    jp   bank0_call_97DD
bank0_call_97CE
    ld   hl,bank0_data_9889
    call bank0_call_984D
    ld   de,(bank0_data_988D)
    ld   c,$1E
    call bank0_call_913C
bank0_call_97DD
    ld   de,$001B
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed41
    cp   (hl)
    jp   nz,bank0_call_96AD
    ret
    
bank0_call_981C
    bit  1,(ix+$0e)
    ret  z
    bit  4,(ix+$18)
    ret  nz
    bit  3,(ix+$18)
    ret  nz
    ld   a,(l_f05e)
    and  a
    jr   nz,bank0_call_9832
    ret
bank0_call_9832
    call resetframetimer;$1556
    set  4,(ix+$18)
    ld   hl,l_f05e
    dec  (hl)
;    ld   a,i
;    ld   h,a
;    ld   a,($FC00)
;    ld   l,a
;    ld   de,$0B2E
;    or   a
;    sbc  hl,de
    ret
;    push iy
bank0_call_984D
    bit  4,(ix+$18)
    ret  z
    bit  1,(ix+$0e)
    ret  z
    inc  (ix+$19)
    bit  3,(ix+$19)
    ret  nz
    ld   a,(ix+$05)
    cp   $02
    ld   hl,bank0_data_988C
    ret  nz
    res  4,(ix+$18)
    set  3,(ix+$18)
    ld   c,$22      ;add enemy fireball sound effect to queue
    call call_1350
    xor  a
    call resetframetimer;$1556
    ld   (ix+$19),a
    ret


bank0_data_987D
    BYTE LOW bank0_call_9793,HIGH bank0_call_9793
    BYTE LOW bank0_call_9772,HIGH bank0_call_9772
    BYTE LOW bank0_call_978A,HIGH bank0_call_978A
    BYTE LOW bank0_call_9766,HIGH bank0_call_9766
    BYTE LOW bank0_call_9784,HIGH bank0_call_9784
    BYTE LOW bank0_call_977E,HIGH bank0_call_977E

bank0_data_9889
    BYTE $04
bank0_data_988A   
    BYTE $1C
bank0_data_988B    
    BYTE $34
bank0_data_988C    
    BYTE $7C
bank0_data_988D    
    BYTE $04,$06
bank0_data_988F
    BYTE $04,$0A
bank0_data_9891    
    BYTE $04,$04

bank0_call_9893
     ld   hl,l_f05f
     ld   bc,$00AF
     call clearbytes;$0D50
     ld   a,(l_ed42)
     and  a
     ret  z
     ld   ix,l_f05f
     xor  a
bank0_call_98A6
     push af
     add  a,a
     ld   hl,(l_ed44)
     ld   (ix+$03),l
     ld   (ix+$04),h
     push hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     ld   (l_ed44),hl
     pop  hl
     inc  hl
     ld   a,(hl)
     ld   (ix+$0a),a				;this is what increases l_f082 ($3682)
     inc  hl
     inc  hl
     ld   (hl),$12
     ld   a,(l_ed46)
     ld   (ix+$09),a
     inc  a
     ld   (l_ed46),a
     ld   (ix+$17),$04
     ld   a,(l_e5a0)
     ld   (ix+$0c),a
     ld   de,$0019
     add  ix,de
     pop  af
     inc  a
     ld   hl,l_ed42
     cp   (hl)
     jr   nz,bank0_call_98A6
     ret
     

bank0_call_98E5     
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $98F3
;    push ix
    ld   a,(l_ed42)
    and  a
    ret  z
    ld   ix,l_f05f
    xor  a
bank0_call_98FD
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_9BA3
    ld   a,(ix+$00)
    bit  2,a
    jr   z,bank0_call_9913
    set  5,(ix+$18)
    jp   bank0_call_9943
bank0_call_9913
    bit  1,a
    jp   nz,bank0_call_9957
    call bank0_call_88CC
    jp   c,bank0_call_9BA3
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_995D
    ld   a,(ix+$0a)
    ld   bc,$681F
    call call_147D
    ld   (ix+$07),$03
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    set  0,(ix+$00)
    jp   bank0_call_9BA3
bank0_call_9943
    call bank0_call_86E8
    jp   c,bank0_call_9BA3
    call bank0_call_870F
    set  5,(ix+$18)
    res  6,(ix+$18)
    jp   bank0_call_9BA3
bank0_call_9957
    call call_7BFD
    jp   bank0_call_9BA3
bank0_call_995D
    call loadhl2;call_1537
    ld   c,$04
    call bank0_call_86A8
    call bank0_call_86C8
    jp   c,bank0_call_9BA3
    call bank0_call_885A
    jp   nc,bank0_call_9B5A
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_9BA3
    bit  5,(ix+$00)
    jr   nz,bank0_call_9987
    call bank0_call_8805
    jp   bank0_call_9B5A
bank0_call_9987
    bit  5,(ix+$18)
    jr   z,bank0_call_99A2
    call bank0_call_8E89
    jr   z,bank0_call_9998
    res  5,(ix+$18)
    jr   bank0_call_99A2
bank0_call_9998
    call loadhlfromspritestruct;call_1529
    dec  (hl)
    call loadhl2;call_1537
    jp   bank0_call_9B5A
bank0_call_99A2
    ld   a,(ix+$01)
    cp   $22
    jr   nc,bank0_call_99AF
    call loadhlfromspritestruct;call_1529
    inc  (hl)
    jr   bank0_call_99BA
bank0_call_99AF
    ld   a,(ix+$01)
    cp   $D0
    jr   c,bank0_call_99BA
    call loadhlfromspritestruct;call_1529
    dec  (hl)
bank0_call_99BA
    bit  4,(ix+$18)
    jp   nz,bank0_call_9B40
    ld   a,(ix+$07)
    ld   hl,bank0_data_9CCF
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_99CC
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_9B20
    ld   b,a
bank0_call_99D4
    push bc
    call bank0_call_9CB1
    jr   z,bank0_call_9A11
    call bank0_call_9C57
    jr   z  ,bank0_call_99FA
    call loadhlfromspritestruct;call_1529
    inc  (ix+$12)
    ld   a,(ix+$12)
    cp   $03
    jr   nz,bank0_call_99F1
    ld   (ix+$12),$00
    inc  (hl)
bank0_call_99F1
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_99D4
    jp   bank0_call_9B5A
bank0_call_99FA
    pop  bc
    set  4,(ix+$18)
    set  1,(ix+$18)
    ld   (ix+$12),$00
    ld   (ix+$08),$02
    ld   de,bank0_data_9D3F 
    jp   bank0_call_9B20
bank0_call_9A11
    pop  bc
    set  4,(ix+$18)
    set  2,(ix+$18)
    ld   (ix+$08),$00
    ld   de,bank0_data_9D54   
    jp   bank0_call_9B20
bank0_call_9A24
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_9B20
    ld   b,a
bank0_call_9A2C
    push bc
    call bank0_call_9CC0
    jr   z,bank0_call_9A6C
    call bank0_call_9C66
    jr   z,bank0_call_9A52
    call loadhlfromspritestruct;call_1529
    inc  (ix+$12)
    ld   a,(ix+$12)
    cp   $03
    jr   nz,bank0_call_9A49
    dec  (hl)
    ld   (ix+$12),$00
bank0_call_9A49
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_9A2C
    jp   bank0_call_9B5A
bank0_call_9A52
    pop  bc
    call bank0_call_9D96
    set  4,(ix+$18)
    set  1,(ix+$18)
    ld   (ix+$12),$00
    ld   (ix+$08),$03
    ld   de,bank0_data_9D69
    jp   bank0_call_9B20
bank0_call_9A6C
    pop  bc
    set  4,(ix+$18)
    set  3,(ix+$18)
    ld   (ix+$12),$00
    ld   (ix+$08),$01
    ld   de,bank0_data_9D7E
    jp   bank0_call_9B20
bank0_call_9A83
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_9B20
    ld   b,a
bank0_call_9A8B
    push bc
    call bank0_call_9C93
    jr   z,bank0_call_9AC8
    call bank0_call_9C75
    jr   z,bank0_call_9AB1
    call loadhlfromspritestruct;call_1529
    inc  (ix+$12)
    ld   a,(ix+$12)
    cp   $03
    jr   nz,bank0_call_9AA8
    inc  (hl)
    ld   (ix+$12),$00
bank0_call_9AA8
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_9A8B
    jp   bank0_call_9B5A
bank0_call_9AB1
    pop  bc
    set  4,(ix+$18)
    set  0,(ix+$18)
    ld   (ix+$12),$00
    ld   (ix+$08),$01
    ld   de,bank0_data_9CEB
    jp   bank0_call_9B20
bank0_call_9AC8
    pop  bc
    set  4,(ix+$18)
    set  2,(ix+$18)
    ld   (ix+$12),$00
    ld   (ix+$08),$03
    ld   de,bank0_data_9D00
    jp   bank0_call_9B20
bank0_call_9ADF
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_9B20
    ld   b,a
bank0_call_9AE7
    push bc
    call bank0_call_9CA2
    jr   z,bank0_call_9B29
    call bank0_call_9C84
    jr   z,bank0_call_9B0C
    call loadhlfromspritestruct;call_1529
    inc  (ix+$12)
    ld   a,(ix+$12)
    cp   $03
    jr   nz,bank0_call_9B04
    dec  (hl)
    ld   (ix+$12),$00
bank0_call_9B04
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_9AE7
    jr   bank0_call_9B5A
bank0_call_9B0C
    pop  bc
    set  4,(ix+$18)
    set  0,(ix+$18)
    ld   (ix+$12),$00
    ld   (ix+$08),$00
    ld   de,bank0_data_9D15
bank0_call_9B20
    ld   (ix+$10),e
    ld   (ix+$11),d
    jp   bank0_call_9B5A		
bank0_call_9B29
    pop  bc
    set  4,(ix+$18)
    set  3,(ix+$18)
    ld   (ix+$12),$00
    ld   (ix+$08),$02
    ld   de,bank0_data_9D2A
    jp   bank0_call_9B20
bank0_call_9B40
    call bank0_call_9C0E
    call bank0_call_9BB2
    call loadhl2;call_1537
;    ld   a,i
;    ld   h,a
;    ld   a,($FC00)
;    ld   l,a
;    ld   de,$0B2E
;    or   a
;    sbc  hl,de
;    jr   $9B5A
;    push iy
bank0_call_9B5A
    ld   c,$1F
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_9B83
    bit  7,(ix+$00)
    jr   nz,bank0_call_9B76
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_9B76
    bit  4,(ix+$0e)
    jr   nz,bank0_call_9B83
    jr   bank0_call_9B8F
bank0_call_9B76
    ld   de,$0204
    call frametimer;call_15CA
    add  a,a
    add  a,a
    ld   b,a
    add  a,$78
    jr   bank0_call_9B99
bank0_call_9B83
    ld   de,$0504
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,$88
    jr   bank0_call_9B99
bank0_call_9B8F
    ld   de,$0304
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,$68
bank0_call_9B99
    ld   b,a
    ld   a,(ix+$0a)
    call call_147D
    jp   bank0_call_9BA3
bank0_call_9BA3
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed42
    cp   (hl)
    jp   nz,bank0_call_98FD
    ret
bank0_call_9BB2    
    ld   l,(ix+$10)
    ld   h,(ix+$11)
    push hl
    inc  hl
    ld   (ix+$10),l
    ld   (ix+$11),h
    pop  hl
    ld   a,(hl)
    ld   hl,bank0_data_9CD7
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_9BCA
    call loadhlfromspritestruct;1529
    inc  (hl)
    ret
bank0_call_9BCF    
    call loadhlfromspritestruct;$1529
    inc  (hl)
    inc  hl
    inc  hl
    inc  (hl)
    ret
bank0_call_9BD7
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    inc  (hl)
    ret
bank0_call_9BDE
    call loadhlfromspritestruct;1529
    dec  (hl)
    inc  hl
    inc  hl
    inc  (hl)
    ret
bank0_call_9BE6
    call loadhlfromspritestruct;1529
    dec  (hl)
    ret
bank0_call_9BEB
    call loadhlfromspritestruct;1529
    dec  (hl)
    inc  hl
    inc  hl
    dec  (hl)
    ret
bank0_call_9BF3
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    dec  (hl)
    ret
bank0_call_9BFA
    call loadhlfromspritestruct;1529
    inc  (hl)
    inc  hl
    inc  hl
    dec  (hl)
    ret
bank0_call_9C02
    ret
bank0_call_9C03
    ld   a,(ix+$08)
    ld   (ix+$07),a
    ld   (ix+$18),$00
    ret
bank0_call_9C0E    
    bit  0,(ix+$18)
    jr   nz,bank0_call_9C27
    bit  1,(ix+$18)
    jr   nz,bank0_call_9C2D
    bit  2,(ix+$18)
    jr   nz,bank0_call_9C33
    bit  3,(ix+$18)
    jr   nz,bank0_call_9C39
    ret
bank0_call_9C27
    call bank0_call_87AC
    jr   z,bank0_call_9C3F
    ret
bank0_call_9C2D
    call bank0_call_879A
    jr   z,bank0_call_9C3F
    ret
bank0_call_9C33
    call bank0_call_9C4C
    jr   z,bank0_call_9C3F
    ret
bank0_call_9C39
    call bank0_call_8761
    jr   z,bank0_call_9C3F
    ret
bank0_call_9C3F
    ld   a,(ix+$07)
    xor  $02
    ld   (ix+$07),a
    ld   (ix+$18),$00
    ret
bank0_call_9C4C
    call call_1530
    ld   a,l
    add  a,$08
    ld   l,a
    call call_174B
    ret
bank0_call_9C57
    call call_1530
    ld   a,l
    add  a,$0C
    ld   l,a
    ld   a,h
    sub  $08
    ld   h,a
    call call_174B
    ret

bank0_call_9C66
    call call_1530
    ld   a,l
    sub  $0C
    ld   l,a
    ld   a,h
    sub  $08
    ld   h,a
    call call_174B
    ret
bank0_call_9C75    
    call call_1530
    ld   a,l
    add  a,$0C
    ld   l,a
    ld   a,h
    add  a,$08
    ld   h,a
    call call_174B
    ret
bank0_call_9C84
    call  call_1530
    ld   a,l
    sub  $0C
    ld   l,a
    ld   a,h
    add  a,$08
    ld   h,a
    call call_174B
    ret
bank0_call_9C93    
    call call_1530
    ld   a,l
    add  a,$08
    ld   l,a
    ld   a,h
    add  a,$0C
    ld   h,a
    call call_174B
    ret
bank0_call_9CA2
    call call_1530
    ld   a,l
    sub  $08
    ld   l,a
    ld   a,h
    add  a,$0C
    ld   h,a
    call call_174B
    ret
bank0_call_9CB1
    call call_1530
    ld   a,l
    add  a,$08
    ld   l,a
    ld   a,h
    sub  $0C
    ld   h,a
    call call_174B
    ret
bank0_call_9CC0
    call call_1530
    ld   a,l
    sub  $08
    ld   l,a
    ld   a,h
    sub  $0C
    ld   h,a
    call call_174B
    ret


bank0_data_9CCF
    BYTE LOW bank0_call_9A83,HIGH bank0_call_9A83
    BYTE LOW bank0_call_9ADF,HIGH bank0_call_9ADF
    BYTE LOW bank0_call_9A24,HIGH bank0_call_9A24
    BYTE LOW bank0_call_99CC,HIGH bank0_call_99CC
bank0_data_9CD7
    BYTE LOW bank0_call_9BCA,HIGH bank0_call_9BCA
    BYTE LOW bank0_call_9BCF,HIGH bank0_call_9BCF
    BYTE LOW bank0_call_9BD7,HIGH bank0_call_9BD7
    BYTE LOW bank0_call_9BDE,HIGH bank0_call_9BDE
    BYTE LOW bank0_call_9BE6,HIGH bank0_call_9BE6
    BYTE LOW bank0_call_9BEB,HIGH bank0_call_9BEB
    BYTE LOW bank0_call_9BF3,HIGH bank0_call_9BF3
    BYTE LOW bank0_call_9BFA,HIGH bank0_call_9BFA
	BYTE LOW bank0_call_9C02,HIGH bank0_call_9C02
	BYTE LOW bank0_call_9C03,HIGH bank0_call_9C03



bank0_data_9CEB
    BYTE $01,$02,$02,$02,$02,$01,$02,$02,$02,$01,$03,$02,$02,$02,$03,$02
    BYTE $02,$02,$02,$03,$09
bank0_data_9D00    
    BYTE $01,$00,$00,$00,$00,$01,$00,$00,$00,$01,$07,$00,$00,$00,$07,$00
    BYTE $00,$00,$00,$07,$09
bank0_data_9D15    
    BYTE $03,$02,$02,$02,$02,$03,$02,$02,$02,$03,$01,$02,$02,$02,$01,$02
    BYTE $02,$02,$02,$01,$09
bank0_data_9D2A    
    BYTE $03,$04,$04,$04,$04,$03,$04,$04,$04,$03,$05,$04,$04,$04,$05,$04
	BYTE $04,$04,$04,$05,$09
bank0_data_9D3F
    BYTE $07,$06,$06,$06,$06,$07,$06,$06,$06,$07,$05,$06,$06,$06,$05,$06
    BYTE $06,$06,$06,$05,$09
bank0_data_9D54    
    BYTE $07,$00,$00,$00,$00,$07,$00,$00,$00,$07,$01,$00,$00,$00,$01,$00
    BYTE $00,$00,$00,$01,$09
bank0_data_9D69    
    BYTE $05,$06,$06,$06,$06,$05,$06,$06,$06,$05,$07,$06,$06,$06,$07,$06
    BYTE $06,$06,$06,$07,$09
bank0_data_9D7E   
    BYTE $05,$04,$04,$04,$04,$05,$04,$04,$04,$05,$03,$04,$04,$04,$03,$04
	BYTE $04,$04,$04,$03,$09,$68,$78,$88
    
    
bank0_call_9D96    
    ret
bank0_call_9D97    
    BYTE $00,$00,$00,$00,$00


bank0_call_9DD2
     ld   hl,l_f113
     ld   bc,$00AF
     call clearbytes;$0D50
     ld   a,(l_ed43)
     and  a
     ret  z
     ld   ix,l_f113
     xor  a
bank0_call_9DE5
     push af
     add  a,a
     ld   hl,(l_ed44)
     ld   (ix+$03),l
     ld   (ix+$04),h
     push hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     ld   (l_ed44),hl
     pop  hl
     inc  hl
     ld   a,(hl)
     ld   (ix+$0a),a
     inc  hl
     inc  hl
     ld   (hl),$15
     ld   a,(l_ed46)
     ld   (ix+$09),a
     inc  a
     ld   (l_ed46),a
     ld   (ix+$17),$05
     ld   a,(l_e5a0)
     ld   (ix+$0c),a
     ld   de,$0019
     add  ix,de
     pop  af
     inc  a
     ld   hl,l_ed43
     cp   (hl)
     jr   nz,bank0_call_9DE5
;     ld   a,i
;     ld   h,a
;     ld   a,($FC00)
;     ld   l,a
;     ld   de,$0B2E
;     or   a
;     sbc  hl,de
     ret
     
bank0_call_9E33
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $9E41
;    push ix
    ld   a,(l_ed43)
    and  a
    ret  z
    ld   ix,l_f113
    xor  a
bank0_call_9E4B
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_A094
    ld   a,(ix+$00)
    bit  2,a
    jp   nz,bank0_call_9E7E
    bit  1,a
    jp   nz,bank0_call_9E8A
    call bank0_call_88CC
    jp   c,bank0_call_A094
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_9E90
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    set  0,(ix+$00)
    jp   bank0_call_A094
bank0_call_9E7E
    call bank0_call_86E8
    jp   c,bank0_call_A094
    call bank0_call_870F
    jp   bank0_call_A094
bank0_call_9E8A
    call call_7BFD
    jp   bank0_call_A094
bank0_call_9E90
    ld   c,$05
    call bank0_call_86A8
    call bank0_call_86C8
    jp   c,bank0_call_A094
    call bank0_call_885A
    jp   nc,bank0_call_A045
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_A094
    bit  5,(ix+$00)
    jr   nz,bank0_call_9EB7
    call bank0_call_8805
    jp   bank0_call_A045
bank0_call_9EB7
    ld   a,(ix+$07)
    ld   hl,bank0_data_A0FB
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_9EC2
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_A045
    ld   b,a
bank0_call_9ECA
    push bc
    call loadhl2;call_1537
    ld   h,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    add  a,$07
    call call_174C
    jr   z,bank0_call_9F0A
    ld   a,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_9F0A
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jp   z,bank0_call_9F19
    call loadhlfromspritestruct;$1529
    inc  (hl)
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_9ECA
    jp   bank0_call_A045
bank0_call_9F0A
    pop  bc
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    call bank0_call_A0A3
    jp   bank0_call_A045
bank0_call_9F19
    pop  bc
    ld   (ix+$07),$03
    call bank0_call_A0A3
    jp   bank0_call_A045
bank0_call_9F24
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_A045
    ld   b,a
bank0_call_9F2C
    push bc
    call loadhl2;$1537
    ld   h,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    add  a,$07
    call call_174C
    jr   z,bank0_call_9F6B
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_9F6B
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jr   z,bank0_call_9F7A
    call loadhlfromspritestruct;$1529
    inc  (hl)
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_9F2C
    jp   bank0_call_A045
bank0_call_9F6B
    pop  bc
    ld   (ix+$07),$04
    ld   (ix+$08),$03
    call bank0_call_A0A3
    jp   bank0_call_A045
bank0_call_9F7A
    pop  bc
    ld   (ix+$07),$00
    call bank0_call_A0A3
    jp   bank0_call_A045
bank0_call_9F85
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_A045
    ld   b,a
bank0_call_9F8D
    push bc
    call loadhl2;$1537
    ld   h,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    sub  $07
    call call_174C
    jp   z,bank0_call_9FCF
    ld   a,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jp   z,bank0_call_9FCF
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jp   z,bank0_call_9F6B
    call loadhlfromspritestruct;$1529
    dec  (hl)
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_9F8D
    jp   bank0_call_A045
bank0_call_9FCF
    pop  bc
    ld   (ix+$07),$00
    ld   (ix+$08),$01
    call bank0_call_A0A3
    jp   bank0_call_A045
bank0_call_9FDE
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_A045
    ld   b,a
bank0_call_9FE6
    push bc
    call loadhl2;$1537
    ld   h,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    sub  $07
    call call_174C
    jp   z,bank0_call_A028
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jp   z,bank0_call_A028
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jp   z,bank0_call_9F0A
    call loadhlfromspritestruct;$1529
    dec  (hl)
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_9FE6
    jp   bank0_call_A045
bank0_call_A028
    pop  bc
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    call bank0_call_A0A3
    jp   bank0_call_A045
bank0_call_A037
    call loadhl2;$1537
    call bank0_call_8EDF
    jr   nz,bank0_call_A045
    ld   a,(ix+$08)
    ld   (ix+$07),a
bank0_call_A045
    ld   c,$1C
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_A068
    bit  7,(ix+$00)
    jr   nz,bank0_call_A05B
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_A05B
    jr   bank0_call_A074
bank0_call_A05B
    ld   de,$0502
    call frametimer;$15CA
    add  a,a
    add  a,a
    ld   b,a
    add  a,$D4
    jr   bank0_call_A07E
bank0_call_A068
    ld   de,$0A02
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,$DC
    jr   bank0_call_A07E
bank0_call_A074
    ld   de,$0802
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,$CC
bank0_call_A07E
    ld   b,a
    ld   a,(ix+$0a)
    bit  1,(ix+$08)
    jr   z,bank0_call_A08E
    call call_147D
    jp   bank0_call_A094
bank0_call_A08E
    call call_149C
    jp   bank0_call_A094
bank0_call_A094
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed43
    cp   (hl)
    jp   nz,bank0_call_9E4B
    ret
bank0_call_A0A3    
    inc  (ix+$14)
    ld   a,(ix+$14)
    cp   $01
    jr   nz,bank0_call_A0BA
    ld   a,(ix+$01)
    ld   (ix+$10),a
    ld   a,(ix+$02)
    ld   (ix+$0f),a
    ret
bank0_call_A0BA
    cp   $03
    ret  nz
    ld   (ix+$14),$00
    ld   a,(ix+$01)
    ld   b,(ix+$10)
    cp   b
    ld   (ix+$10),$00
    ret  nz
    ld   a,(ix+$02)
    ld   b,(ix+$0f)
    cp   b
    ld   (ix+$0f),$00
    ret  nz
    ld   a,(ix+$07)
    cp   $01
    jr   z,bank0_call_A0E7
    cp   $04
    jr   z,bank0_call_A0EF
    inc  a
    jr   bank0_call_A0F4
bank0_call_A0E7
    inc  a
    inc  a
    ld   (ix+$08),$03
    jr   bank0_call_A0F4
bank0_call_A0EF
    xor  a
    ld   (ix+$08),$01
bank0_call_A0F4
    ld   (ix+$07),a
    call bank0_call_9241
    ret
bank0_data_A0FB
    BYTE LOW bank0_call_9FDE,HIGH bank0_call_9FDE
    BYTE LOW bank0_call_9F24,HIGH bank0_call_9F24
    BYTE LOW bank0_call_A037,HIGH bank0_call_A037
    BYTE LOW bank0_call_9F85,HIGH bank0_call_9F85
    BYTE LOW bank0_call_9EC2,HIGH bank0_call_9EC2

bank0_call_A108
    ld   hl,l_f1c2
    ld   bc,$0025
    call clearbytes ;$0D50
    ld   ix,l_f1c2
    xor  a
    ld   de,$000A
bank0_call_A119
    push af
    ld   (ix+$09),a
    add  a,a
    add  a,a
    ld   hl,l_e2a5
    call adda2hl;$0D89
    ld   (ix+$03),l
    ld   (ix+$04),h
    inc  hl
    ld   a,d
    call mul32;call_0D6C
    or   e
    ld   (hl),a
    ld   (ix+$0a),a
    inc  d
    ld   a,d
    cp   $04
    jr   nz,bank0_call_A13E
    ld   d,$00
    inc  e
bank0_call_A13E
    inc  hl
    inc  hl
    ld   (hl),$13
    ex   de,hl
    ld   de,$0012
    add  ix,de
    ex   de,hl
    pop  af
    inc  a
    cp   $02
    jr   nz,bank0_call_A119
    ret

bank0_call_A150    
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $A15E
;    push ix
    ld   ix,l_f1c2
    xor  a
bank0_call_A163
    push af
    ld   a,(l_e343)
    and  a
    jr   nz,bank0_call_A170
    call call_154C
    jp   bank0_call_A4B1
bank0_call_A170
    bit  3,(ix+$0e)
    jp   nz,bank0_call_A452
    bit  2,(ix+$00)
    jp   nz,bank0_call_A3FC
    bit  0,(ix+$00)
    jp   z,bank0_call_A1A7
    ld   b,$00
    bit  1,(ix+$00)
    jr   z,bank0_call_A18F
    ld   b,$01
bank0_call_A18F
    ld   a,(ix+$09)
    cp   b
    jp   z,bank0_call_A1B8
    ld   a,(l_f1cb)
    ld   b,a
    ld   a,(l_f1dd)
    ld   (l_f1cb),a
    ld   a,b
    ld   (l_f1dd),a
    jp   bank0_call_A1B8
bank0_call_A1A7
    ld   hl,l_e691
    bit  0,(ix+$09)
    jr   z,bank0_call_A1B3
    ld   hl,l_e6c3
bank0_call_A1B3
    bit  1,(hl)
    jp   z,bank0_call_A1CB
bank0_call_A1B8
    set  2,(ix+$00)
    ld   a,(l_e723)
    and  a
    jr   nz,bank0_call_A1C5
    call call_1579
bank0_call_A1C5
    call resetframetimer;call_1556
    jp   bank0_call_A3FC
bank0_call_A1CB
    ld   hl,l_ed3d
    ld   a,(hl)
    and  a
    jr   nz,bank0_call_A1DF
    set  2,(ix+$00)
    call call_1579
    call resetframetimer;call_1556
    jp   bank0_call_A3FC
bank0_call_A1DF
    bit  7,(ix+$00)
    jp   nz,bank0_call_A306
    ld   hl,l_e5d7
    bit  0,(ix+$09)
    jr   nz,bank0_call_A1F6
    bit  0,(hl)
    jp   z,bank0_call_A4B1
    jr   bank0_call_A1FB
bank0_call_A1F6
    bit  1,(hl)
    jp   z,bank0_call_A4B1
bank0_call_A1FB
    ld   a,(l_e723)
    and  a
    jr   z,bank0_call_A210
    call loadhlfromspritestruct;$1529
    ld   (hl),$78
    inc  hl
    inc  hl
    ld   (hl),$78
    inc  hl
    ld   (hl),$15
    jp   bank0_call_A2CA
bank0_call_A210
    bit  0,(ix+$09)
    jr   nz,bank0_call_A269
    ld   hl,l_e5d7
    bit  0,(hl)
    jp   z,bank0_call_A4B1
    ld   hl,l_e692
    ld   a,(hl)
    sub  $78
    jr   nc,bank0_call_A248
    ld   (ix+$11),$06
    ld   hl,l_e6c3
    bit  0,(hl)
    jp   z,bank0_call_A2B7
    inc  hl
    inc  hl
    ld   a,(hl)
    sub  $80
    jp   nc,bank0_call_A2B7
    dec  hl
    ld   a,(hl)
    sub  $78
    jp   c,bank0_call_A2B7
    ld   (ix+$11),$00
    jp   bank0_call_A2B7
bank0_call_A248
    ld   (ix+$11),$04
    ld   hl,l_e6c3
    bit  0,(hl)
    jr   z,bank0_call_A2B7
    inc  hl
    inc  hl
    ld   a,(hl)
    sub  $80
    jp   nc,bank0_call_A2B7
    dec  hl
    ld   a,(hl)
    sub  $78
    jp   nc,bank0_call_A2B7
    ld   (ix+$11),$02
    jp   bank0_call_A2B7
bank0_call_A269
    ld   hl,l_e5d7
    bit  1,(hl)
    jp   z,bank0_call_A4B1
    ld   hl,l_e6c4
    ld   a,(hl)
    sub  $78
    jr   nc,bank0_call_A29A
    ld   (ix+$11),$00
    ld   hl,l_e691
    bit  0,(hl)
    jr   z,bank0_call_A2B7
    inc  hl
    inc  hl
    ld   a,(hl)
    sub  $80
    jp   c,bank0_call_A2B7
    dec  hl
    ld   a,(hl)
    sub  $78
    jp   c,bank0_call_A2B7
    ld   (ix+$11),$06
    jp   bank0_call_A2B7
bank0_call_A29A
    ld   (ix+$11),$02
    ld   hl,l_e691
    bit  0,(hl)
    jr   z,bank0_call_A2B7
    inc  hl
    inc  hl
    ld   a,(hl)
    sub  $80
    jr   c,bank0_call_A2B7
    dec  hl
    ld   a,(hl)
    sub  $78
    jp   c,bank0_call_A2B7
    ld   (ix+$11),$04
bank0_call_A2B7
    ld   a,(ix+$11)
    call loadhlfromspritestruct;$1529
    ld   bc,bank0_data_A2FE
    call call_0D7F
    ld   a,(bc)
    ld   (hl),a
    inc  bc
    inc  hl
    inc  hl
    ld   a,(bc)
    ld   (hl),a
bank0_call_A2CA
    set  7,(ix+$00)
    set  3,(ix+$00)
    set  2,(ix+$0e)
    ld   (ix+$08),$01
    ld   (ix+$0c),$0A
    ld   (ix+$10),$3A
    ld   hl,l_f1e6
    ld   (hl),$B4
    ld   hl,l_e723
    bit  0,(hl)
    jr   z,bank0_call_A2F6
    ld   c,$19      ;add ghost appear sound effect to queue
    call call_1350
    jp   bank0_call_A4B1
bank0_call_A2F6
    ld   c,$2A      ;add ghost appear sound effect to queue
    call call_1350
    jp   bank0_call_A4B1
bank0_data_A2FE
    BYTE $C0,$D8,$20,$D8,$20,$18,$C0,$18
bank0_call_A306
    call loadhl2;call_$1537
    bit  2,(ix+$0e)
    jp   nz,bank0_call_A3FC
bank0_call_A310
    ld   a,(ix+$0c)
stophere1
	cp	$2b
	jr nc,stophere1
    ld   hl,data_11CE
    call call_0DA7
    ld   a,(ix+$0b)
    call adda2de;$0D84
    ld   a,(de)
    or   a
    jp   p,bank0_call_A32B
    ld   (ix+$0b),$00
    jp   bank0_call_A310
bank0_call_A32B
    ld   (ix+$0d),a
    inc  (ix+$0b)
    ld   a,(ix+$10)
    sub  $3A
    jr   c,bank0_call_A367
    ld   a,(ix+$00)
    xor  $08
    ld   (ix+$00),a
    inc  (ix+$0f)
    ld   b,(ix+$0f)
    ld   hl,l_f1e6
    ld   a,(hl)
    and  a
    jr   z,bank0_call_A355
    sub  b
    jp   nc,bank0_call_A3CD
    dec  (hl)
    dec  (hl)
    dec  (hl)
    dec  (hl)
bank0_call_A355
    ld   (ix+$0f),$00
    ld   (ix+$10),$00
    ld   a,(ix+$0c)
    sub  $1E
    jr   nc,bank0_call_A367
    inc  (ix+$0c)
bank0_call_A367
     call bank0_call_A4C6
     jp   z,bank0_call_A3CD
     ld   a,(ix+$07)
     ld   hl,bank0_data_A4BE
     call call_0DA7
     ex   de,hl
     jp   (hl)
bank0_call_A378
    ld   a,(l_fc85)
    bit  5,a
    jr   nz,bank0_call_A380
    nop
bank0_call_A380								;code for Hurry Up Ghost
    call loadhlfromspritestruct;$1529
    ld   a,(hl)
    ld   b,(ix+$0d)
    add  a,b
    ld   (hl),a
    ld   a,(ix+$10)
    add  a,b
    ld   (ix+$10),a
    jp   bank0_call_A3CD
bank0_call_A393
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   b,(ix+$0d)
    add  a,b
    ld   (hl),a
    ld   a,(ix+$10)
    add  a,b
    ld   (ix+$10),a
    jp   bank0_call_A3CD
bank0_call_A3A8
    call loadhlfromspritestruct;$1529
    ld   a,(hl)
    ld   b,(ix+$0d)
    sub  b
    ld   (hl),a
    ld   a,(ix+$10)
    add  a,b
    ld   (ix+$10),a
    jp   bank0_call_A3CD
bank0_call_A3BB
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   b,(ix+$0d)
    sub  b
    ld   (hl),a
    ld   a,(ix+$10)
    add  a,b
    ld   (ix+$10),a
bank0_call_A3CD
    ld   de,$0802
    call frametimer;$15CA
    add  a,a
    add  a,a
    ld   hl,l_e723
    bit  0,(hl)
    jr   nz,bank0_call_A3E2
    add  a,$E4
    ld   c,$1C
    jr   bank0_call_A3E6
bank0_call_A3E2
    add  a,$F8
    ld   c,$3C
bank0_call_A3E6
    ld   b,a
    ld   a,(ix+$0a)
    bit  1,(ix+$08)
    jr   z,bank0_call_A3F6
    call call_147D
    jp   bank0_call_A4B1
bank0_call_A3F6
    call call_149C
    jp   bank0_call_A4B1
bank0_call_A3FC
    ld   (ix+$02),$00
    ld   de,$0A03
    ld   a,(l_e723)
    and  a
    jr   z,bank0_call_A40C
    ld   de,$1403
bank0_call_A40C
    call frametimer;$15CA
    jr   nz,bank0_call_A48D
    bit  2,(ix+$00)
    jr   nz,bank0_call_A41D
    res  2,(ix+$0e)
    jr   bank0_call_A481
bank0_call_A41D
    call call_154C
    xor  a
    ld   (l_f1e6),a
    ld   (ix+$00),a
    ld   (ix+$0e),a
    ld   (ix+$05),a
    ld   (ix+$06),a
    ld   (ix+$01),a
    ld   (ix+$02),a
    ld   (ix+$10),a
    ld   (ix+$0c),a
    ld   (ix+$0b),a
    ld   (ix+$0d),a
    set  3,(ix+$0e)
    res  7,(ix+$00)
    ld   hl,l_f1e6
    ld   (hl),$3C
    jp   bank0_call_A4B1
bank0_call_A452
    ld   hl,l_f1c2
    ld   a,(hl)
    and  $80
    ld   b,a
    ld   a,$12
    call adda2hl;$0D89
    ld   a,(hl)
    and  $80
    or   b
    jp   nz,bank0_call_A4B1
    ld   hl,l_e343
    ld   (hl),$00
    ld   hl,l_f1c2
    ld   (hl),$00
    ld   hl,l_f1d0
    ld   (hl),$00
    ld   hl,l_f1d4
    ld   (hl),$00
    ld   hl,l_f1e2
    ld   (hl),$00
    jp   bank0_call_A4B1
bank0_call_A481
    ld   a,(l_e723)
    and  a
    jr   nz,bank0_call_A48A
    call call_158B
bank0_call_A48A
    call resetframetimer;call_1556
bank0_call_A48D
    bit  2,(ix+$00)
    jr   z,bank0_call_A497
    ld   b,a
    ld   a,$02
    sub  b
bank0_call_A497
    add  a,a
    add  a,a
    ld   hl,l_e723
    bit  0,(hl)
    jr   nz,bank0_call_A4A6
    add  a,$B0
    ld   c,$24
    jr   bank0_call_A4AA
bank0_call_A4A6
    add  a,$EC
    ld   c,$3C
bank0_call_A4AA
    ld   b,a
    ld   a,(ix+$0a)
    call call_147D
bank0_call_A4B1
    ld   de,$0012
    add  ix,de
    pop  af
    inc  a
    cp   $02
    jp   nz,bank0_call_A163
    ret
bank0_data_A4BE
    BYTE LOW bank0_call_A378,HIGH bank0_call_A378
    BYTE LOW bank0_call_A393,HIGH bank0_call_A393
    BYTE LOW bank0_call_A3A8,HIGH bank0_call_A3A8
    BYTE LOW bank0_call_A3BB,HIGH bank0_call_A3BB
bank0_call_A4C6    
    ld   a,(ix+$09)
    and  a
    jr   nz,bank0_call_A4D3
    ld   hl,l_e691
    call bank0_call_A4DA
    ret
bank0_call_A4D3
    ld   hl,l_e6c3
    call bank0_call_A4DA
    ret
bank0_call_A4DA
    bit  0,(hl)
    ret  z
    bit  3,(ix+$00)
    jr   z,bank0_call_A53F
    ld   a,(ix+$01)
    cp   $A7
    jr   c,bank0_call_A4F3
    inc  hl
    ld   a,(hl)
    dec  hl
    sub  $49
    jr   nc,bank0_call_A523
    jr   bank0_call_A4FE
bank0_call_A4F3
    cp   $49
    jr   nc,bank0_call_A523
    inc  hl
    ld   a,(hl)
    dec  hl
    sub  $A7
    jr   c,bank0_call_A523
bank0_call_A4FE
    ld   a,(ix+$02)
    cp   $58
    jr   c,bank0_call_A516
    cp   $5A
    jr   c,bank0_call_A511
    cp   $A8
    jr   c,bank0_call_A516
    cp   $AA
    jr   nc,bank0_call_A516
bank0_call_A511
    ld   (ix+$10),$3A
    ret
bank0_call_A516
    ld   (ix+$10),$00
    ld   a,(ix+$02)
    cp   $A8
    jr   c,bank0_call_A536
    jr   bank0_call_A52D
bank0_call_A523
    inc  hl
    inc  hl
    ld   a,(ix+$02)
    sub  (hl)
    jr   z,bank0_call_A599
    jr   c,bank0_call_A536
bank0_call_A52D
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    ret
bank0_call_A536
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    ret
bank0_call_A53F
    ld   a,(ix+$02)
    cp   $50
    jr   c,bank0_call_A586
    cp   $60
    jr   c,bank0_call_A552
    cp   $A0
    jr   c,bank0_call_A586
    cp   $B0
    jr   nc,bank0_call_A586
bank0_call_A552
    ld   a,(ix+$01)
    cp   $48
    jr   nc,bank0_call_A56E
    inc  hl
    ld   a,(hl)
    dec  hl
    cp   $A7
    jp   c,bank0_call_A586
    ld   (ix+$07),$02
    ld   (ix+$08),$03
    ld   (ix+$10),$00
    ret
bank0_call_A56E
    cp   $A8
    jr   c,bank0_call_A586
    inc  hl
    ld   a,(hl)
    dec  hl
    cp   $49
    jr   nc,bank0_call_A586
    ld   (ix+$07),$00
    ld   (ix+$08),$03
    ld   (ix+$10),$00
    ret
bank0_call_A586
    inc  hl
    ld   a,(ix+$01)
    sub  (hl)
    jr   z,bank0_call_A599
    jr   c,bank0_call_A594
    ld   (ix+$07),$02
    ret
bank0_call_A594
    ld   (ix+$07),$00
    ret
bank0_call_A599
    inc  (ix+$10)
    ret
bank0_call_A59D
    ld   hl,l_f1e7
    ld   bc,$00AF
    call clearbytes;$0D50
    ld   a,(l_ed40)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  4,a
    ret  z
    ld   ix,l_f1e7
    xor  a
bank0_call_A5B6
    push af
    ld   b,a
    add  a,a
    ld   hl,(l_ed44)
    ld   (ix+$03),l
    ld   (ix+$04),h
    push hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   (l_ed44),hl
    pop  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$0a),a
    inc  hl
    inc  hl
    ld   (hl),$17
    ld   a,(l_ed46)
    ld   (ix+$09),a
    inc  a
    ld   (l_ed46),a
    ld   (ix+$17),$07
    ld   (ix+$16),$00
    call bank0_call_95E8
    ld   a,$08
    call call_189D
    ld   (ix+$0c),a
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed40
    cp   (hl)
    jr   nz,bank0_call_A5B6
    ret


bank0_call_A5FF
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $A60D
;    push ix
    ld   a,(l_ed40)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  4,a
    ret  z
    ld   ix,l_f1e7
    xor  a
bank0_call_A61D
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_A7AA
    ld   a,(ix+$00)
    bit  2,a
    jp   nz,bank0_call_A654
    bit  1,a
    jp   nz,bank0_call_A660
    call bank0_call_88CC
    jp   c,bank0_call_A7AA
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_A666
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    set  0,(ix+$00)
    ld   (ix+$07),$02
    jp   bank0_call_A7AA
bank0_call_A654
    call bank0_call_86E8
    jp   c,bank0_call_A7AA
    call bank0_call_870F
    jp   bank0_call_A7AA
bank0_call_A660
    call call_7BFD
    jp   bank0_call_A7AA
bank0_call_A666
    ld   c,$07
    call bank0_call_86A8
    call bank0_call_86C8
    jp   c,bank0_call_A7AA
    call bank0_call_885A
    jp   nc,bank0_call_A6E4
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_A7AA
    bit  5,(ix+$00)
    jr   nz,bank0_call_A68D
    call bank0_call_8805
    jp   bank0_call_A6E4
bank0_call_A68D
    ld   a,(ix+$18)
    bit  4,a
    jp   nz,bank0_call_A6E4
    bit  3,a
    jp   nz,bank0_call_A6E4
    ld   a,(ix+$07)
    ld   hl,bank0_data_A80C
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_A6A5
    call bank0_call_8AD7
    call call_7B94
    call nz,bank0_call_A7E4
    jp   bank0_call_A6E4
bank0_call_A6B1
    call bank0_call_8B71
    call call_7B94
    call nz,bank0_call_A7E4
    jp   bank0_call_A6E4
bank0_call_A6BD
    set  5,(ix+$18)
    call bank0_call_8C36
    jp   bank0_call_A6E4
bank0_call_A6C7
    set  5,(ix+$18)
    call bank0_call_8CEA
    jp   bank0_call_A6E4
bank0_call_A6D1
    call bank0_call_8D91
    bit  1,(ix+$0e)
    jr   z,bank0_call_A6E4
    res  5,(ix+$18)
    call call_7B94
    call nz,bank0_call_A7E4
bank0_call_A6E4
    ld   hl,bank0_data_A82E
    ld   a,(l_f44e)
    and  a
    jr   z,bank0_call_A6F6
    ld   hl,bank0_data_A846
    res  5,(ix+$18)
    jr   bank0_call_A705
bank0_call_A6F6
    bit  7,(ix+$00)
    jr   nz,bank0_call_A702
    ld   a,(l_e349)
    and  a
    jr   z,bank0_call_A705
bank0_call_A702
    ld   hl,bank0_data_A83A
bank0_call_A705
    bit  5,(ix+$18)
bank0_call_A709
    jr   z,bank0_call_A724
    ld   de,$0502
    call frametimer;$15CA
    or   a
    jr   nz,bank0_call_A71B
    ld   a,(hl)
    add  a,$04
    ld   b,a
    jp   bank0_call_A796
bank0_call_A71B
    ld   a,$0B
    call adda2hl;$0D89
    ld   b,(hl)
    jp   bank0_call_A796
bank0_call_A724
    bit  6,(ix+$18)
    jr   z,bank0_call_A752
    ld   de,$0A01
    call frametimer;$15CA
    jr   nz,bank0_call_A74D
    res  6,(ix+$18)
    ld   de,bank0_data_9625       
	;ld   de,$9625       
    call bank0_call_93F6
    bit  1,(ix+$08)
    ld   (ix+$07),$04
    jr   z,bank0_call_A7AA
    ld   (ix+$07),$05
    jp   bank0_call_A7AA
bank0_call_A74D
    inc  hl
    inc  hl
    ld   b,(hl)
    jr   bank0_call_A796
bank0_call_A752
    ld   de,$0503
    bit  6,(ix+$0e)
    jr   z,bank0_call_A75E
    ld   de,$0503				;why isn't this 0303 - bootleg says 0503 - maybe check original
bank0_call_A75E    
    bit  4,(ix+$18)
    jr   nz,bank0_call_A76D
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,(hl)
    ld   b,a
    jr   bank0_call_A796
bank0_call_A76D
    ld   de,$050B
    bit  6,(ix+$0e)
    jr   z,bank0_call_A779
    ld   de,$030B
bank0_call_A779
    call frametimer;$15CA
    jr   z,bank0_call_A788
    cp   $01
    jr   nz,bank0_call_A791
    set  3,(ix+$18)
    jr   z,bank0_call_A791
bank0_call_A788
    res  4,(ix+$18)
    call resetframetimer;call_1556
    jr   bank0_call_A7AA
bank0_call_A791
    inc  a
    call adda2hl;$0D89
    ld   b,(hl)
bank0_call_A796
    ld   a,(ix+$0a)
    ld   c,$33
    bit  1,(ix+$08)
    jr   z,bank0_call_A7A7
    call call_147D
    jp   bank0_call_A7AA
bank0_call_A7A7
    call call_149C
bank0_call_A7AA
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed40
    cp   (hl)
    jp   nz,bank0_call_A61D
    ret
    
    
bank0_call_A7E4    
;    ld   a,i
;    ld   h,a
;    ld   a,($FC00)
;    ld   l,a
;    ld   de,$0B2E
;    or   a
;    sbc  hl,de
;    jr   $A7F5
;    push iy
bank0_call_A7F5
    bit  2,(ix+$07)
    ret  nz
    bit  4,(ix+$18)
    ret  nz
    bit  3,(ix+$18)
    ret  nz
    call resetframetimer;$1556
    set  4,(ix+$18)
    ret
bank0_data_A80C
    BYTE LOW bank0_call_A6E4,HIGH bank0_call_A6E4
    BYTE LOW bank0_call_A6B1,HIGH bank0_call_A6B1
    BYTE LOW bank0_call_A6D1,HIGH bank0_call_A6D1
    BYTE LOW bank0_call_A6A5,HIGH bank0_call_A6A5
    BYTE LOW bank0_call_A6C7,HIGH bank0_call_A6C7
    BYTE LOW bank0_call_A6BD,HIGH bank0_call_A6BD

bank0_data_A82E
    BYTE $04,$10,$18,$20,$28,$20,$28,$30,$38,$30,$38,$3C
bank0_data_A83A    
    BYTE $64,$70,$78,$80
    BYTE $88,$80,$88,$90,$98,$90,$98,$9C
bank0_data_A846    
    BYTE $A0
bank0_call_A847

/*    ld hl,l_e278-3
    ld b,16*4
bank0_call_A847_1_3
    ld a,0
    ld (hl),a
    inc hl
    ;inc hl
    ;inc hl
    ;inc hl
    djnz bank0_call_A847_1_3*/

/*    ld hl,$8100         ;hack clear gfx before boss appears
    ld b,$80
bank0_call_A847_1_2
    ld a,(hl)
    or $02
    ld (hl),a
    inc hl
    djnz bank0_call_A847_1_2
*/
    ld   hl,l_f296
    ld   bc,$0014
    call clearbytes;$0D50
    ld   a,(l_e64b)
    cp   $63
    ret  nz
    ld   ix,l_f296
    ld   hl,l_e275
    ld   de,$000C
    ld   b,$10
    call call_18A5
/*
    ;need to move this to nearer when the boss should actuall be displayed
    ld   de,bank0_data_AF0C     ;boss sprite data
    ld   hl,l_e275
    ld   b,$10
    ld   c,$18                  ;boss sprite bank
    call bank0_call_AEAD
*/


 
    ld hl,pattern_bank;$8100         ;hack clear gfx before boss appears
    ld b,$80
bank0_call_A847_1
    ;ld a,(hl)
    ;or $02
    ld a,0
    ld (hl),a
    inc hl
    djnz bank0_call_A847_1

    

    

    ld   hl,l_e28d
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   hl,bank0_data_A887

    nextreg $43,%00100000
    nextreg $40,$90
    ld b,$20
bank0_call_A847_2
    call call_0B30_update_entry
    djnz bank0_call_A847_2
;    ld   de,l_f920         
 ;   ld   bc,$0040
  ;  ldir      
    ret
    
bank0_data_A887 
    BYTE $FF,$F0,$00,$00,$F7,$70,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
    BYTE $0C,$F0,$F0,$70,$F0,$00,$FF,$00,$F8,$00,$F9,$90,$D4,$00,$00,$00
    BYTE $FF,$F0,$00,$00,$0D,$F0,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
    BYTE $0C,$F0,$80,$F0,$08,$F0,$FF,$00,$F8,$00,$0F,$F0,$D4,$00,$00,$00


bank0_call_A8C7
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $A8D5
;    push ix
    ld   ix,l_f296
    ld   a,(ix+$00)
    bit  5,a
    ret  nz
    bit  4,a
    jp   nz,bank0_call_ABA5
    bit  1,a
    jp   nz,bank0_call_AAB0
    bit  0,a
    jr   nz,bank0_call_A91B
    ld   de,$0306
    call frametimer;$15CA
    jr   z,bank0_call_A913
    bit  0,a
    jr   nz,bank0_call_A906
    ;ld   hl,$70FB
    nextreg $43,%10110000
    nextreg $40,$EF
    nextreg $44,$F5
    nextreg $44,$01
    nextreg $40,$FF
    nextreg $44,$F5
    nextreg $44,$01
    nextreg $40,$0F
    nextreg $44,$F5
    nextreg $44,$01
    nextreg $4C,$00
   ; ld   (l_f9de),hl 
    ;ld   hl,$70FB
   ; ld   (l_f9fe),hl 
    ret
bank0_call_A906
    nextreg $43,%10110000
    nextreg $40,$EF
    nextreg $44,$00
    nextreg $44,$00
    nextreg $40,$FF
    nextreg $44,$00
    nextreg $44,$00
    nextreg $40,$0F
    nextreg $44,$00
    nextreg $44,$00
    nextreg $4C,$0F
  ;  ld   hl,$0000
  ;  ld   ($F9DE),hl  
  ;  ld   hl,$0000
  ;  ld   ($F9FE),hl  
    ret
bank0_call_A913
    call resetframetimer;$1556
    
    ;boss set up code moved here as it is just after screen flash finishes
    ld   de,bank0_data_AF0C     ;boss sprite data
    ld   hl,l_e275
    ld   b,$10
    ld   c,$18                  ;boss sprite bank
    call bank0_call_AEAD

bank0_call_A916
    set  0,(ix+$00)
    ret
bank0_call_A91B
    ld   a,(l_f3c9)
    and  a
    jr   nz,bank0_call_A939
    ld   hl,l_f3c8
    inc  (hl)
    ld   a,(hl)
    sub  $78
    jr   c,bank0_call_A939
    ld   hl,l_f3c9
    ld   (hl),$01
    ld   hl,l_f3c8
    ld   (hl),$00
    ld   c,$15      ;add boss fire sound effect to queue
    call call_1350
bank0_call_A939
    call bank0_call_AE9C
    ld   a,(l_e691)
    bit  1,a
    jr   z,bank0_call_A948
    ld   hl,l_f3ca
    ld   (hl),$08
bank0_call_A948
    ld   a,(ix+$0b)
    cp   $01
    jr   nz,bank0_call_A960
    ld   a,(l_f3ca)
    cp   $07
    jr   nz,bank0_call_A960
    ld   a,(l_f3c9)
    and  a
    jr   z,bank0_call_A960
    ld   (ix+$0b),$50
bank0_call_A960
    ld   a,(ix+$0b)
    sub  $50
    jr   c,bank0_call_A98E
    ld   a,(ix+$02)
    cp   $80
    jr   c,bank0_call_A98E
    cp   $88
    jr   nc,bank0_call_A98E
    ld   (ix+$00),$02
    ld   hl,l_f3c9
    ld   (hl),$00
    ld   b,$08
    ld   hl,l_e2d5
bank0_call_A980
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    inc  hl
    inc  hl
    djnz bank0_call_A980
    call resetframetimer;1556
    ret
bank0_call_A98E
    bit  3,(ix+$00)
    jr   z,bank0_call_A99A
    call bank0_call_AB62
    jp   bank0_call_A9FD
bank0_call_A99A    
    ld   de,$0502
    call frametimer;$15CA
    call mul16;$0D6D
    ld   b,a
    ld   hl,bank0_data_AF4C
    call adda2hl;$0D89
    ld   c,$30
    bit  0,(ix+$08)
    jr   z,bank0_call_A9B9
    ld   a,b
    ld   hl,bank0_data_AF8C
    call adda2hl;$0D89
bank0_call_A9B9
    ld   e,$0C
    bit  1,(ix+$07)
    ld   b,$10
    jr   nz,bank0_call_A9F0
    ld   a,(ix+$05)
    call mul16;$0D6D
    ld   hl,bank0_data_AF6C
    call adda2hl;$0D89
    bit  0,(ix+$08)
    jr   z,bank0_call_A9E1
    ld   a,(ix+$05)
    call mul16;$0D6D
    ld   hl,bank0_data_AFAC
    call adda2hl;$0D89
bank0_call_A9E1
    call bank0_call_AE73
    jr   nc,bank0_call_A9EB
    ld   hl,bank0_data_AF6C
    ld   c,$29
bank0_call_A9EB
    call call_14E4
    jr   bank0_call_A9FD
bank0_call_A9F0
    call bank0_call_AE73
    jr   nc,bank0_call_A9FA
    ld   hl,bank0_data_AF4C
    ld   c,$29
bank0_call_A9FA
    call call_14C0
bank0_call_A9FD
    ld   a,(ix+$07)
    ld   hl,bank0_data_AAA8
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_AA08    
    call bank0_call_AECD
    ret  nc
    call bank0_call_AEE2
    ret  nc
bank0_call_AA10
    ld   b,$10
    ld   hl,l_e275
bank0_call_AA15
    inc  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AA1E
    inc  (hl)
    inc  (hl)
bank0_call_AA1E
    inc  hl
    inc  hl
    inc  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AA29
    inc  (hl)
    inc  (hl)
bank0_call_AA29
    inc  hl
    inc  hl
    djnz bank0_call_AA15
    ret
bank0_call_AA2E
    ld   a,(l_fc85)
    bit  2,a
    jr   nz,bank0_call_AA36
    nop
bank0_call_AA36
    call bank0_call_AECD
    ret  nc
    call bank0_call_AEF7
    ret  c
    ld   b,$10
    ld   hl,l_e275
bank0_call_AA43
    dec  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AA4C
    dec  (hl)
    dec  (hl)
bank0_call_AA4C
    inc  hl
    inc  hl
    inc  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AA57
    inc  (hl)
    inc  (hl)
bank0_call_AA57
    inc  hl
    inc  hl
    djnz bank0_call_AA43
    ret
bank0_call_AA5C
    call bank0_call_AEBC
    ret  c
    call bank0_call_AEF7
    ret  c
    ld   b,$10
    ld   hl,l_e275
bank0_call_AA69
    dec  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AA72
    dec  (hl)
    dec  (hl)
bank0_call_AA72
    inc  hl
    inc  hl
    dec  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AA7D
    dec  (hl)
    dec  (hl)
bank0_call_AA7D
    inc  hl
    inc  hl
    djnz bank0_call_AA69
    ret
bank0_call_AA82
    call bank0_call_AEBC
    ret  c
    call bank0_call_AEE2
    ret  nc
bank0_call_AA8A
    ld   b,$10
    ld   hl,l_e275
bank0_call_AA8F
    inc  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AA98
    inc  (hl)
    inc  (hl)
bank0_call_AA98
    inc  hl
    inc  hl
    dec  (hl)
    bit  3,(ix+$00)
    jr   z,bank0_call_AAA3
    dec  (hl)
    dec  (hl)
bank0_call_AAA3
    inc  hl
    inc  hl
    djnz bank0_call_AA8F
    ret
bank0_data_AAA8
    BYTE LOW bank0_call_AA08,HIGH bank0_call_AA08
    BYTE LOW bank0_call_AA2E,HIGH bank0_call_AA2E
    BYTE LOW bank0_call_AA5C,HIGH bank0_call_AA5C
    BYTE LOW bank0_call_AA82,HIGH bank0_call_AA82    
    
bank0_call_AAB0
    call bank0_call_AB27
    ld   de,$0A02
    call frametimer;$15CA
    call mul16;$0D6D
    ld   hl,bank0_data_AF8C
    call adda2hl;$0D89
    ld   c,$32
    ld   b,$10
    ld   e,$0C
    bit  1,(ix+$07)
    jr   nz,bank0_call_AADF
    ld   a,(ix+$05)
    call mul16;$0D6D
    ld   hl,bank0_data_AFAC
    call adda2hl;$0D89
    call call_14E4
    jr   bank0_call_AAE2
bank0_call_AADF
    call call_14C0
bank0_call_AAE2
    bit  2,(ix+$00)
    jr   z,bank0_call_AB00
    ld   c,$27      ;add bubble burst (3) sound effect to queue
    call call_1350
    ld   (ix+$00),$50
    ld   a,(ix+$02)
    sub  $80
    jr   c,bank0_call_AAFC
    ld   (ix+$00),$10
bank0_call_AAFC
    call resetframetimer;1556
    ret
bank0_call_AB00    
    inc  (ix+$0c)
    ld   a,(ix+$0c)
    sub  $3C
    ret  c
    ld   (ix+$0c),$00
    inc  (ix+$0e)
    ld   a,(ix+$0e)
    sub  $06
    ret  c
    ld   (ix+$00),$09
    call resetframetimer;$1556
    ld   (ix+$0c),a
    ld   (ix+$0e),a
    ld   (ix+$0b),a
    ret
bank0_call_AB27
    ld   de,$0505
    call bank0_call_AB42
    ld   hl,bank0_data_AB38
    ;call call_0DA7
    call call_0D89      ;just add A to HL, don't store into DE as 0DA7 would
    ;ld   (l_f998),de   ;Palette
    nextreg $43,%10100000   ;colour cycle for super drunk captured bubble
    nextreg $40,$CC
    call call_0B30_update_entry
    ret
bank0_data_AB38
    BYTE $FF,$F0,$FF,$F0,$F8,$80,$F6,$70,$F0,$00
bank0_call_AB42    
    inc  (ix+$10)
    ld   a,(ix+$10)
    cp   d
    jp   nz,bank0_call_AB5E
    ld   (ix+$10),$00
    inc  (ix+$0f)
    ld   a,(ix+$0f)
    cp   e
    ret  nz
    xor  a
    ld   (ix+$0f),$00
    ret
bank0_call_AB5E
    ld   a,(ix+$0f)
    ret
bank0_call_AB62
    ld   de,$0A02
    call frametimer;$15CA
    call mul16;$0D6D
    ld   hl,bank0_data_AF4C
    call adda2hl;$0D89
    ld   c,$26
    ld   b,$10
    ld   e,$0C
    bit  1,(ix+$07)
    jr   nz,bank0_call_AB97
    ld   a,(ix+$05)
    call mul16;$0D6D
    ld   hl,bank0_data_AF6C
    call adda2hl;0D89
    call bank0_call_AE73
    jr   nc,bank0_call_AB93
    ld   hl,bank0_data_AF6C
    ld   c,$29
bank0_call_AB93
    call call_14E4
    ret
bank0_call_AB97
    call bank0_call_AE73
    jr   nc,bank0_call_ABA1
    ld   hl,bank0_data_AF4C
    ld   c,$29
bank0_call_ABA1
    call call_14C0
    ret


bank0_call_ABA5    
    ld   a,(l_e5db)
    and  a
    jr   z,bank0_call_ABB2
    ld   a,(l_e5d7)
    cp   $03
    jr   z,bank0_call_AC22
bank0_call_ABB2
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,(hl)
    ld   (ix+$01),a
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$02),a
    ld   de,$0504
    call frametimer;$15CA
    cp   $02
    jr   z,bank0_call_ABD0
    cp   $03
    jr   nz,bank0_call_ABD2
bank0_call_ABD0
    sub  $02
bank0_call_ABD2
    call mul16;$0D6D
    ld   b,a
    ld   hl,bank0_data_AF4C
    ld   a,(ix+$05)
    sub  $02
    jr   c,bank0_call_ABE3
    ld   hl,bank0_data_AF8C
bank0_call_ABE3
    ld   a,b
    call adda2hl;$0D89
    ld   c,$29
    ld   b,$10
    ld   e,$0C
    call call_14C0
    ld   a,(ix+$02)
    sub  $20
    jr   c,bank0_call_AC05
    ld   a,(ix+$02)
    sub  $E0
    jr   nc,bank0_call_AC05
    ld   a,(ix+$01)
    sub  $D0
    jr   c,bank0_call_AC18
bank0_call_AC05
    ld   hl,l_e275
    ld   bc,$0040
    call clearbytes;$0D50
    ld   (ix+$00),$20
    ld   hl,l_ed3d
    ld   (hl),$00
    ret
bank0_call_AC18
    bit  6,(ix+$00)
    jp   nz,bank0_call_AA10
    jp   bank0_call_AA8A
bank0_call_AC22
    ld   hl,l_e2c5
    ld   (hl),$18
    inc  hl
    inc  hl
    ld   (hl),$20
    ld   hl,l_e2b5
    ld   (hl),$18
    inc  hl
    inc  hl
    ld   (hl),$D0
    bit  2,(ix+$12)
    jp   nz,bank0_call_AD2B
    bit  1,(ix+$12)
    jp   nz,bank0_call_ACA1
    bit  0,(ix+$12)
    jr   nz,bank0_call_AC82
    ld   hl,l_e2d5
    ld   de,$0012
    ld   b,$04
    call call_18A5
    ld   hl,l_e2d5
    ld   b,$04
bank0_call_AC58
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    inc  hl
    ld   (hl),$18
    inc  hl
    djnz bank0_call_AC58
    set  0,(ix+$12)
    ld   e,$0C
    ld   b,$10
    ld   c,$33
    ld   hl,bank0_data_AFCC
    bit  1,(ix+$07)
    jr   nz,bank0_call_AC7E
    ld   hl,bank0_data_AFDC
    call call_14E4
    ret
bank0_call_AC7E
    call call_14C0
    ret
bank0_call_AC82    
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,(hl)
    cp   $39
    jr   c,bank0_call_ACA1
    ld   b,$10
    ld   hl,l_e275
bank0_call_AC92
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz bank0_call_AC92
    call resetframetimer;1556
    ld   (ix+$13),$03
    ret
bank0_call_ACA1
    call bank0_call_AE9C
    ld   de,bank0_data_AF3C
    bit  1,(ix+$07)
    jr   nz,bank0_call_ACB0
    ld   de,bank0_data_AF44
bank0_call_ACB0
    ld   hl,l_e2d5
    ld   b,$04
bank0_call_ACB5
    ld   a,(de)
    ld   c,a
    ld   a,(ix+$01)
    sub  c
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    ld   c,a
    ld   a,(ix+$02)
    bit  1,(ix+$07)
    jr   z,bank0_call_ACCD
bank0_call_ACCA
    sub  c
    jr   bank0_call_ACD2
bank0_call_ACCD
    bit  0,b
    jr   z,bank0_call_ACCA
    add  a,c
bank0_call_ACD2
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    djnz bank0_call_ACB5
    ld   de,$0306
    bit  1,(ix+$12)
    jr   z,bank0_call_ACE4
    ld   de,$0A03
bank0_call_ACE4
    call frametimer;$15CA
bank0_call_ACE7
    bit  1,(ix+$12)
    jr   z,bank0_call_ACF2
    cp   $02
    jp   z,bank0_call_AE2C
bank0_call_ACF2
    cp   $05
    jp   z,bank0_call_AE2C
    add  a,a
    add  a,a
    ld   e,$12
    ld   b,$04
    ld   c,$33
    bit  1,(ix+$07)
    jr   nz,bank0_call_AD18
    ld   hl,bank0_data_B000
    bit  1,(ix+$12)
    jr   z,bank0_call_AD11
    ld   hl,bank0_data_B020
bank0_call_AD11
    call adda2hl;$0D89
    call call_14E4
    ret
bank0_call_AD18
    ld   hl,bank0_data_AFEC
    bit  1,(ix+$12)
    jr   z,bank0_call_AD24
    ld   hl,bank0_data_B018
bank0_call_AD24
    call adda2hl;$0D89
    call call_14C0
    ret
bank0_call_AD2B
    
    bit  7,(ix+$12)
    jp   z,bank0_call_ADF7  ;clouds
    bit  3,(ix+$12)
    jr   nz,bank0_call_AD8B ;Parents already drawn

    ;break
    ld   hl,l_e275    ;clear old sprite data
    ld b,$20
    ld a,$00
bank0_call_AD2B_1
    ld (hl),a
    inc hl
    djnz bank0_call_AD2B_1

    /*ld   hl,pattern_bank    ;clear old sprite data
    ld b,$80
    ld a,$00
bank0_call_AD2B_2
    ld (hl),a
    inc hl
    djnz bank0_call_AD2B_2
*/
    ld   hl,l_e295          ;draw parents
    ld   de,$000C
    ld   b,$04
    call call_18A5          ;set the gfx numbers for papa
    ld   hl,l_e295
    ld   de,bank0_data_AF34 ;y pos and x pos data for papa
    ld   b,$04
    ld   c,$18
    call bank0_call_AEAD    ;set the y pos, x pos and gfx bank
    ld   e,$0C
    ld   b,$04
    ld   c,$0F
    ld   hl,bank0_data_B02C ;papa gfx pattern data
    call call_14C0
    ld   hl,l_e2a5
    ld   de,$000D
    ld   b,$04
    call call_18A5          ;set the gfx numbers for apa
    ld   hl,l_e2a5
    ld   de,bank0_data_AF2C ;y pos and x pos data for mama
    ld   b,$04
    ld   c,$18
    call bank0_call_AEAD    ;set the y pos, x pos and gfx bank
    ld   e,$0D
    ld   b,$04
    ld   c,$0F
    ld   hl,bank0_data_B028 ;mama gfx pattern data
    call call_14C0
    set  3,(ix+$12)
    xor  a
    ld   (ix+$01),a
    ld   (ix+$02),a
    ;break
bank0_call_AD8B
    ld   hl,l_e295
    ld   a,(hl)
    cp   $28
    jr   z,bank0_call_ADA9
    ld   b,$04
bank0_call_AD95
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz bank0_call_AD95
    ld   hl,l_e2a5
    ld   b,$04
bank0_call_ADA1
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz bank0_call_ADA1
    ret
bank0_call_ADA9
    bit  5,(ix+$12)
    jr   nz,bank0_call_ADBC
    inc  (ix+$06)
    ld   a,(ix+$06)
    cp   $1E
    ret  nz
    set  5,(ix+$12)
bank0_call_ADBC
    inc  (ix+$02)
    ld   a,(ix+$02)
    cp   $07
    ret  nz
    ld   (ix+$02),$00
    inc  (ix+$01)
    ld   a,(ix+$01)
    cp   $05
    jr   z,bank0_call_ADDF
    ld   hl,l_e295
    ld   b,$04
bank0_call_ADD8
    inc  hl
    inc  hl
    dec  (hl)
    inc  hl
    inc  hl
    djnz bank0_call_ADD8
bank0_call_ADDF
    ld   hl,l_e2a5
    ld   b,$04
bank0_call_ADE4
    inc  hl
    inc  hl
    inc  (hl)
    inc  hl
    inc  hl
    djnz bank0_call_ADE4
    ld   a,(ix+$01)
    cp   $05
    ret  nz
    ld   hl,l_ed3d
    ld   (hl),$00
    ret
bank0_call_ADF7
    bit  6,(ix+$12)
    jr   nz,bank0_call_AE0A
    ld   hl,l_e275
    ld   de,bank0_data_B0D0
    ld   b,$10
    ld   c,$13
    call bank0_call_AEAD
bank0_call_AE0A
    ld   de,$050A
    call frametimer;$15CA
    jr   z,bank0_call_AE25
    call mul16;$0D6D
    ld   hl,bank0_data_B030
    call adda2hl;$0D89
    ld   e,$0C
    ld   b,$10
    ld   c,$24
    call call_14C0
    ret
bank0_call_AE25
    ;break
    set  7,(ix+$12)
    jp   bank0_call_AE53
bank0_call_AE2C
    ld   a,(ix+$06)
    cp   $01
    jr   nz,bank0_call_AE66
    dec  (ix+$13)
    ld   a,(ix+$13)
    or   a
    jr   nz,bank0_call_AE66
    ld   (ix+$13),$03
    bit  1,(ix+$12)
    jr   nz,bank0_call_AE4F
    set  1,(ix+$12)
    call resetframetimer;1556
    jr   bank0_call_AE66
bank0_call_AE4F
    set  2,(ix+$12)
bank0_call_AE53
    ld   b,$10
    ld   hl,l_e275
bank0_call_AE58
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    inc  hl
    inc  hl
    djnz bank0_call_AE58
    call resetframetimer;1556
    ret
bank0_call_AE66
    ld   e,$12
    ld   b,$04
    ld   c,$1F
    ld   hl,bank0_data_B014
    call call_14C0
    ret
bank0_call_AE73    
    ld   a,(l_f2a1)
    cp   $46
    jr   nc,bank0_call_AE82
    bit  7,(ix+$00)
    jr   nz,bank0_call_AE82
    xor  a
    ret
bank0_call_AE82
    bit  0,(ix+$05)
    jr   z,bank0_call_AE8A
    xor  a
    ret
bank0_call_AE8A
    inc  (ix+$11)
    ld   a,(ix+$11)
    sub  $06
    ret  c
    ld   (ix+$11),$00
    res  7,(ix+$00)
    ret
bank0_call_AE9C    
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,(hl)
    ld   (ix+$01),a
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$02),a
    ret


    
bank0_call_AEAD         ;update clouds when dragon transitions into parents?
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  hl
    ld   a,c
    ld   (hl),a
    inc  hl
    inc  de
    djnz bank0_call_AEAD
    ret
bank0_call_AEBC
    ld   a,(ix+$02)
    sub  $20
    sub  $0C
    ret  nc
    ld   a,(ix+$07)
    xor  $03
    ld   (ix+$07),a
    ret
bank0_call_AECD
    ld   a,(ix+$02)
    add  a,$20
    sub  $F0
    ret  c
    ld   a,(ix+$07)
    xor  $03
    ld   (ix+$07),a
    ld   hl,l_f3ca
    inc  (hl)
    ret
bank0_call_AEE2
    ld   a,(ix+$01)
    add  a,$20
    sub  $D8
    ret  c
    ld   a,(ix+$07)
    xor  $01
    ld   (ix+$07),a
    ld   (ix+$08),$01
    ret
bank0_call_AEF7
    ld   a,(ix+$01)
    sub  $20
    sub  $18
    ret  nc
    ld   a,(ix+$07)
    xor  $01
    ld   (ix+$07),a
    ld   (ix+$08),$00
    ret    
bank0_data_AF0C
    BYTE $90,$60,$90,$70,$90,$80,$90,$90,$80,$60,$80,$70,$80,$80,$80,$90
    BYTE $70,$60,$70,$70,$70,$80,$70,$90,$60,$60,$60,$70,$60,$80,$60,$90
bank0_data_AF2C
    BYTE $48,$60,$48,$70,$38,$60,$38,$70
bank0_data_AF34    
    BYTE $48,$80,$48,$90,$38,$80,$38,$90
bank0_data_AF3C
    BYTE $00,$18,$00,$08,$10,$18,$10,$08
bank0_data_AF44    
    BYTE $00,$08,$00,$08,$10,$08,$10,$08
bank0_data_AF4C
    BYTE $00,$04,$08,$0C,$10,$14,$18,$1C,$20,$24,$28,$2C,$30,$34,$38,$3C
    BYTE $40,$44,$48,$4C,$50,$54,$58,$5C,$60,$64,$68,$6C,$70,$74,$78,$7C
bank0_data_AF6C 
    BYTE $0C,$08,$04,$00,$1C,$18,$14,$10,$2C,$28,$24,$20,$3C,$38,$34,$30
    BYTE $4C,$48,$44,$40,$5C,$58,$54,$50,$6C,$68,$64,$60,$7C,$78,$74,$70
bank0_data_AF8C
    BYTE $80,$84,$88,$8C,$90,$94,$98,$9C,$A0,$A4,$A8,$AC,$B0,$B4,$B8,$BC
    BYTE $C0,$C4,$C8,$CC,$D0,$D4,$D8,$DC,$E0,$E4,$E8,$EC,$F0,$F4,$F8,$FC
bank0_data_AFAC
    BYTE $8C,$88,$84,$80,$9C,$98,$94,$90,$AC,$A8,$A4,$A0,$BC,$B8,$B4,$B0
    BYTE $CC,$C8,$C4,$C0,$DC,$D8,$D4,$D0,$EC,$E8,$E4,$E0,$FC,$F8,$F4,$F0
bank0_data_AFCC
    BYTE $04,$08,$0C,$10,$14,$18,$1C,$20,$24,$28,$2C,$30,$34,$38,$3C,$40
bank0_data_AFDC
    BYTE $10,$0C,$08,$04,$20,$1C,$18,$14,$30,$2C,$28,$24,$40,$3C,$38,$34
bank0_data_AFEC
    BYTE $84,$88,$8C,$90,$94,$98,$9C,$A0,$A4,$A8,$AC,$B0,$B4,$B8,$BC,$C0
    BYTE $C4,$C8,$CC,$D0    
bank0_data_B000    
    BYTE $88,$84,$90,$8C,$98,$94,$A0,$9C,$A8,$A4,$B0,$AC
    BYTE $B8,$B4,$C0,$BC,$C8,$C4,$D0,$CC
bank0_data_B014    
    BYTE $00,$00,$00,$00
bank0_data_B018    
    BYTE $D4,$D8,$DC,$E0
    BYTE $E4,$E8,$EC,$F0
bank0_data_B020    
    BYTE $D8,$D4,$E0,$DC,$E8,$E4,$F0,$EC
bank0_data_B028    
    BYTE $64,$68,$74,$78    ;mama sprite data
bank0_data_B02C
    BYTE $6C,$70,$7C,$80    ;papa sprite data
    
bank0_data_B030    
    BYTE $B0,$B0,$B0,$B0,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$B4,$B4,$B4,$B4,$B0,$B0,$B0,$B0,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$B8,$B8,$B8,$B8,$B4,$B4,$B4,$B4,$B0,$B0,$B0,$B0
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$B8,$B8,$B8,$B8,$B4,$B4,$B4,$B4
    BYTE $B0,$B0,$B0,$B0,$B0,$B0,$B0,$B0,$00,$00,$00,$00,$B8,$B8,$B8,$B8
    BYTE $B4,$B4,$B4,$B4,$B4,$B4,$B4,$B4,$B0,$B0,$B0,$B0,$00,$00,$00,$00
    BYTE $B8,$B8,$B8,$B8,$B8,$B8,$B8,$B8,$B4,$B4,$B4,$B4,$B0,$B0,$B0,$B0
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$B8,$B8,$B8,$B8,$B4,$B4,$B4,$B4
    BYTE $B0,$B0,$B0,$B0,$00,$00,$00,$00,$00,$00,$00,$00,$B8,$B8,$B8,$B8
    BYTE $B4,$B4,$B4,$B4,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $B8,$B8,$B8,$B8
bank0_data_B0D0    
    BYTE $38,$60,$48,$78,$30,$90,$18,$80,$30,$78,$44,$8C
    BYTE $20,$8C,$18,$74,$2C,$64,$38,$70,$38,$88,$20,$78,$44,$6C,$40,$80
    BYTE $24,$84,$2C,$6C


bank0_call_B0F0
    ld   hl,l_f2aa
    ld   bc,$00AF
    call clearbytes;$0D50
    ld   a,(l_ed3e)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  0,a
    ret  z
    ld   ix,l_f2aa
    xor  a
bank0_call_B109
    push af
    add  a,a
    ld   hl,(l_ed44)
    ld   (ix+$03),l
    ld   (ix+$04),h
    push hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   (l_ed44),hl
    pop  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$0a),a
    inc  hl
    inc  hl
    ld   (hl),$12
    ld   a,(l_ed46)
    ld   (ix+$09),a
    inc  a
    ld   (l_ed46),a
    ld   (ix+$17),$06
    ld   a,(l_e5a0)
    add  a,$04
    ld   (ix+$0c),a
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed3e
    cp   (hl)
    jr   nz,bank0_call_B109
    ret

bank0_call_B14A    
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $B158
;    push ix
    ld   a,(l_ed3e)
    and  a
    ret  z
    ld   a,(l_e5a4)
    bit  0,a
    ret  z
    ld   ix,l_f2aa
    xor  a
bank0_call_B168
    push af
    bit  3,(ix+$00)
    jp   nz,bank0_call_B32F
    ld   a,(ix+$00)
    bit  2,a
    jp   nz,bank0_call_B1A4
    bit  1,a
    jp   nz,bank0_call_B1B0
    call bank0_call_88CC
    jp   c,bank0_call_B32F
    call bank0_call_8879
    bit  0,(ix+$00)
    jr   nz,bank0_call_B1B6
    ld   a,(ix+$0a)
    ld   bc,$741D
    call call_147D
    call bank0_call_86BD
    ld   (hl),$01
    call bank0_call_87BE
    set  0,(ix+$00)
    jp   bank0_call_B32F
bank0_call_B1A4
    call bank0_call_86E8
    jp   c,bank0_call_B32F
    call bank0_call_870F
    jp   bank0_call_B32F
bank0_call_B1B0
    call call_7BFD
    jp   bank0_call_B32F
bank0_call_B1B6
    call loadhl2;call_1537
    ld   c,$06
    call bank0_call_86A8
    call bank0_call_86C8
    jp   c,bank0_call_B32F
    call bank0_call_885A
    jp   nc,bank0_call_B2EB
    bit  5,(ix+$00)
    jr   nz,bank0_call_B1D6
    call bank0_call_8805
    jp   bank0_call_B2EB
bank0_call_B1D6
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_B32F
    bit  1,(ix+$0e)
    jr   nz,bank0_call_B203
    inc  (ix+$16)
    ld   a,(ix+$16)
    cp   $78
    jr   c,bank0_call_B203
    call loadhlfromspritestruct;call_1529
    ld   a,(hl)
    cp   $D0
    jr   nc,bank0_call_B203
    ld   (ix+$16),$00
    set  1,(ix+$0e)
    call bank0_call_B8FD
bank0_call_B203
    ld   a,(ix+$07)
    ld   hl,bank0_data_B33E
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_B20E
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_B2EB
bank0_call_B215
    ld   b,a
bank0_call_B216
    push bc
    call loadhl2;$1537
    ld   a,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_B239
    call call_1676
    jr   nz,bank0_call_B245
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_B216
    jp   bank0_call_B2EB
bank0_call_B239
    pop  bc
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    jp   bank0_call_B2EB
bank0_call_B245
    pop  bc
    ld   (ix+$07),$02
    jp   bank0_call_B2EB
bank0_call_B24D
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_B2EB
    ld   b,a
bank0_call_B255
    push bc
    call loadhl2;$1537
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_B278
    call call_1676
    jr   nz,bank0_call_B284
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_B255
    jp   bank0_call_B2EB
bank0_call_B278
    pop  bc
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    jp   bank0_call_B2EB
bank0_call_B284
    pop  bc
    ld   (ix+$07),$02
    jp   bank0_call_B2EB
bank0_call_B28C
;    ld   a,i
;    ld   h,a
;    ld   a,($FC00)
;    ld   l,a
;    ld   de,$0B2E
;    or   a
;    sbc  hl,de
;    jr   bank0_call_B29D
;    push iy
bank0_call_B29D
    call loadhl2;1537
    ld   a,(ix+$01)
    cp   $E0
    jr   nc,bank0_call_B2BD
    and  $07
    jr   nz,bank0_call_B2BD
    ld   a,(ix+$01)
    ld   h,(ix+$02)
    call call_174C
    jp   z,bank0_call_B2BD
    call call_1676
    jp   z,bank0_call_B2D6
bank0_call_B2BD
    call loadhlfromspritestruct;$1529
    dec  (hl)
    bit  7,(ix+$00)
    jr   z,bank0_call_B2EB
    ld   a,(l_e349)
    and  a
    jr   z,bank0_call_B2EB
    ld   a,(hl)
    and  $07
    jp   z,bank0_call_B2EB
    dec  (hl)
    jr   bank0_call_B2EB
bank0_call_B2D6
    call bank0_call_918F
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    jr   z,bank0_call_B2EB
    ld   (ix+$07),$03
    ld   (ix+$08),$03
bank0_call_B2EB
    ld   a,(l_f44e)
    and  a
    jr   nz,bank0_call_B314
    bit  7,(ix+$00)
    jr   nz,bank0_call_B305
    ld   a,(l_e349)
    and  a
    jr   nz,bank0_call_B305
    bit  4,(ix+$0e)
    jr   nz,bank0_call_B314
    jr   bank0_call_B323
bank0_call_B305
    ld   hl,bank0_data_B347
    ld   de,(bank0_data_B349)
    ld   c,$1D
    call bank0_call_913C
    jp   bank0_call_B32F
bank0_call_B314
    ld   hl,bank0_data_B348
    ld   de,(bank0_data_B34D)
    ld   c,$1D
    call bank0_call_913C
    jp   bank0_call_B32F
bank0_call_B323
    ld   hl,bank0_data_B346
    ld   de,(bank0_data_B34B)
    ld   c,$1D
    call bank0_call_913C
bank0_call_B32F    
    ld   de,$0019
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed3e
    cp   (hl)
    jp   nz,bank0_call_B168
    ret

    
bank0_data_B33E    
    BYTE LOW bank0_call_B2EB,HIGH bank0_call_B2EB
    BYTE LOW bank0_call_B24D,HIGH bank0_call_B24D
    BYTE LOW bank0_call_B28C,HIGH bank0_call_B28C
    BYTE LOW bank0_call_B20E,HIGH bank0_call_B20E

bank0_data_B346
    BYTE $74
bank0_data_B347    
    BYTE $8C
bank0_data_B348    
    BYTE $A4
bank0_data_B349    
    BYTE $02,$02
bank0_data_B34B
    BYTE $02,$04
bank0_data_B34D    
    BYTE $02,$06
bank0_call_B34F
    ;break
	call bank0_call_B391    ;clear some vars for the starfield
    ld   hl,l_f448
    ld   (hl),$00
    call call_0330
    call call_0300
    ld   hl,l_f458
    inc  (hl)
;    ld   iy,$0038
;    bit  3,(iy-$36)
;    jr   nz,$B36D
;    push de
;    push bc
bank0_call_B36D
    call bank0_call_BEA9        ;crumble level 100 walls
    ret
bank0_call_B370
    call bank0_call_B39A        ;update starfield/shooting star
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,bank0_call_B389
    ld   a,$04                  ;need to find oout what sound this is
    ;ld   ($FA00),a				;TODO sound
    ld   a,$03
    call call_0018
    ld   c,$14      ;add good ending music to queue
    call call_1350
    jr   bank0_call_B38E
bank0_call_B389
    ld   c,$2B      ;add bad ending music to queue
    call call_1350
bank0_call_B38E
    jp   call_563F
	
;oode below is for the start screen (bubbles spinning) duplicated in intro_bank
bank0_call_B391
    ld   hl,l_f359
    ld   bc,$0009
    jp   call_0D50
bank0_call_B39A
    ld   a,(l_e5d7)
    cp   $03
    ret  nz
    ld   bc,$0258
bank0_call_B3A3
    call call_0020
    push bc
    call bank0_call_BF61            ;shooting star
    pop  bc
    dec  bc
    ld   a,c
    or   b
    jr   nz,bank0_call_B3A3
    ret
bank0_call_B3AF
    ld   a,(l_e5d7)
    cp   $03
    ret  nz
bank0_call_B3B5
    call call_0431
    ;ld   hl,$F960
    ;ld   bc,$0020
    ;call call_0D50 
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tiles
    nextreg $40, $B0                  ; (R/W) 0x40 (64) => Palette Index
    ld   b,$10
bank0_call_B3B5_loop
	nextreg $44,$00
	nextreg $44,$00
	djnz bank0_call_B3B5_loop
	;nextreg $40, $11                  ; (R/W) 0x40 (64) => Palette Index
	;nextreg $44,$00
	;nextreg $44,$00
    call call_02D6
    call call_0020
    ld   hl,$76F8;CD08
    ld   de,bank0_data_B3F2
    ld   bc,$1A0C
    ;ld   a,$2D
    ;call call_0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
    ld   hl,$76F8+$18;$D008
    ld   de,bank0_data_B52A
    ld   bc,$1A0C
    ;ld   a,$2D
    ;call call_0EC6
	ex af,af'
	ld a,11*16	;gfx atrtibute
	ex af,af'
	ld a,$5B
	call call_0EC6_Adjusted
    ld   hl,$76F8+$18+$18;$D308
    ld   de,bank0_data_B662
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
bank0_data_B3F2
	BYTE $00,$01,$02,$03,$04,$05,$06,$03,$04,$05,$06,$07,$08,$09,$0A,$0B
	BYTE $0C,$0D,$0E,$0B,$0C,$0D,$0E,$0C,$0F,$10,$11,$12,$13,$14,$15,$0F
	BYTE $10,$11,$0B,$16,$14,$17,$18,$19,$1A,$1B,$1C,$14,$17,$18,$1D,$1E
	BYTE $1F,$20,$21,$22,$23,$05,$06,$1F,$20,$21,$03,$04,$24,$25,$07,$12
	BYTE $26,$0D,$0E,$24,$25,$07,$0B,$0C,$27,$28,$29,$0B,$16,$14,$15,$27
	BYTE $28,$29,$0B,$16,$2A,$2B,$2C,$1D,$1E,$1B,$1C,$2A,$2B,$2C,$1D,$1E
	BYTE $00,$01,$02,$03,$04,$05,$06,$00,$01,$02,$03,$04,$08,$09,$0A,$0B
	BYTE $0C,$0D,$0E,$08,$09,$0A,$0B,$0C,$16,$14,$15,$2D,$16,$14,$15,$2D
	BYTE $29,$0B,$16,$14,$1E,$1B,$1C,$2E,$1E,$1B,$1C,$2E,$2C,$1D,$1E,$1B
	BYTE $04,$05,$06,$07,$04,$05,$06,$07,$02,$03,$04,$05,$0C,$0D,$0E,$0C
	BYTE $0C,$0D,$0E,$0C,$0A,$0B,$0C,$0D,$2F,$30,$31,$32,$33,$34,$35,$2F
	BYTE $30,$31,$32,$33,$36,$34,$35,$2F,$30,$34,$35,$2F,$30,$31,$32,$33
	BYTE $37,$38,$39,$3A,$3B,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42
	BYTE $43,$40,$41,$42,$43,$44,$45,$46,$47,$30,$3F,$48,$49,$4A,$4B,$4C
	BYTE $4D,$3F,$48,$49,$2F,$30,$31,$32,$33,$34,$35,$2F,$30,$31,$32,$33
	BYTE $3A,$3B,$3C,$3D,$3E,$38,$39,$3A,$3B,$3C,$3D,$3E,$42,$43,$44,$45
	BYTE $46,$40,$41,$42,$43,$44,$45,$46,$4B,$47,$30,$4E,$4F,$50,$2A,$2B
	BYTE $2C,$1D,$1E,$51,$35,$52,$4D,$53,$54,$55,$00,$01,$02,$03,$04,$56
	BYTE $39,$57,$58,$59,$5A,$35,$08,$09,$0A,$0B,$0C,$00,$41,$5B,$5C,$5D
	BYTE $5E,$5F,$0F,$10,$11,$12,$13,$60
bank0_data_B52A
	BYTE $61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70
	BYTE $71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,$79
	BYTE $7A,$7B,$7C,$7D,$80,$81,$82,$83,$84,$85,$86,$80,$81,$82,$83,$84
	BYTE $87,$88,$89,$76,$8A,$6C,$8B,$87,$88,$89,$76,$8A,$8C,$8D,$8E,$6A
	BYTE $8F,$78,$90,$8C,$8D,$8E,$76,$77,$79,$7A,$7B,$7C,$7D,$7E,$7F,$7C
	BYTE $7D,$7E,$7F,$8E,$80,$81,$82,$83,$84,$85,$86,$83,$84,$85,$86,$91
	BYTE $87,$88,$89,$76,$8A,$6C,$8B,$76,$8A,$6C,$8B,$92,$87,$88,$89,$76
	BYTE $8A,$6C,$8B,$87,$88,$89,$76,$8A,$93,$94,$95,$96,$94,$97,$93,$94
	BYTE $94,$97,$93,$94,$98,$62,$63,$64,$99,$9A,$98,$62,$99,$9A,$98,$62
	BYTE $9B,$6E,$6F,$70,$9C,$9D,$9B,$6E,$9C,$9D,$9B,$6E,$9E,$9F,$95,$A0
	BYTE $A1,$A2,$9E,$9F,$A1,$A2,$9E,$9F,$94,$95,$96,$A3,$A4,$97,$93,$94
	BYTE $95,$96,$A3,$A4,$62,$63,$64,$65,$66,$9A,$98,$62,$63,$64,$65,$66
	BYTE $6E,$6F,$70,$71,$72,$9D,$9B,$6E,$6F,$70,$71,$72,$9F,$95,$A0,$A5
	BYTE $A6,$A2,$9E,$9F,$95,$A0,$A5,$A6,$94,$95,$99,$A7,$A8,$97,$93,$A9
	BYTE $AA,$99,$A7,$A8,$62,$63,$AB,$AC,$AD,$9A,$98,$AE,$AF,$AB,$AC,$AD
	BYTE $6E,$6F,$B0,$B1,$9E,$9D,$9B,$B2,$B3,$B0,$B1,$9E,$9F,$95,$B4,$B5
	BYTE $B6,$A2,$9E,$B7,$AA,$B4,$B5,$B6,$94,$97,$93,$94,$95,$97,$93,$94
	BYTE $95,$96,$A3,$A4,$99,$9A,$98,$62,$63,$9A,$98,$62,$63,$64,$65,$66
	BYTE $9C,$9D,$9B,$6E,$6F,$9D,$9B,$6E,$6F,$70,$71,$72,$A1,$A2,$9E,$9F
	BYTE $95,$A2,$9E,$9F,$95,$A0,$A5,$A6
bank0_data_B662
	BYTE $00,$01,$02,$03,$00,$04,$05,$06,$07,$08,$09,$0A,$07,$0B,$0C,$0D
	BYTE $0E,$0F,$10,$11,$12,$13,$14,$0E,$10,$15,$16,$17,$18,$19,$1A,$10
	BYTE $1B,$01,$02,$1C,$1D,$1E,$1F,$1B,$20,$08,$09,$21,$12,$22,$23,$20
	BYTE $24,$0F,$10,$25,$07,$26,$27,$24,$28,$15,$16,$29,$2A,$2B,$2C,$28
	BYTE $06,$01,$02,$03,$00,$04,$05,$06,$0D,$08,$09,$0A,$07,$0B,$0C,$0D
	BYTE $2D,$0F,$10,$25,$2D,$0F,$10,$25,$2E,$15,$16,$29,$2E,$15,$16,$29
	BYTE $22,$01,$02,$03,$22,$01,$02,$03,$0A,$08,$09,$0A,$0A,$08,$09,$0A
	BYTE $2F,$30,$31,$32,$33,$34,$35,$2F,$2F,$30,$31,$35,$2F,$30,$31,$36
	BYTE $37,$38,$39,$3A,$37,$38,$39,$3B,$3C,$3D,$3E,$3F,$3C,$3D,$3E,$40
	BYTE $41,$42,$43,$44,$45,$40,$35,$46,$2F,$30,$31,$32,$33,$34,$35,$2F
	BYTE $37,$38,$39,$47,$48,$49,$3A,$37,$3C,$3D,$3E,$4A,$4B,$4C,$3F,$3C
	BYTE $2C,$28,$4D,$4E,$4F,$35,$46,$42,$05,$06,$50,$51,$52,$53,$54,$30
	BYTE $0C,$0D,$30,$55,$56,$57,$58,$38,$14,$0E,$59,$5A,$5B,$5C,$5D,$3D
;b732

;end of duplicated code


bank0_call_B8D3                 ;cycle heart palettes
    ld   hl,l_f35c
    inc  (hl)
    ld   a,(hl)
    cp   $02
    ret  nz
    ld   (hl),$00
    inc  hl
    inc  (hl)
    ld   a,(hl)
    cp   $06
    jr   nz,bank0_call_B8E6
    xor  a
    ld   (hl),a
bank0_call_B8E6
    ld   hl,bank0_data_B8F1
    ;call call_0DA7
    add a,a
    call call_0D89
    ;ld   ($F93A),de     ;palette
    push hl
    nextreg $43,%10100000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    nextreg $40,$9D                  ; (R/W) 0x40 (64) => Palette Index
    call call_0B30_update_entry
    pop hl
    nextreg $43,%10010000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    nextreg $40,$9D                  ; (R/W) 0x40 (64) => Palette Index
    call call_0B30_update_entry
    ret
bank0_data_B8F1
    BYTE $F0,$70,$F6,$70,$F7,$50,$F8,$00
    BYTE $FA,$00,$FF,$00
bank0_call_B8FD
    ret
    nop
    nop
    nop
    nop
    nop
    
    
    
    
bank0_call_B939
    ld   hl,l_f367
    ld   bc,$0067
    call clearbytes;$0D50
    ld   a,(l_e64b)
    cp   $63
    ret  nz
    ld   hl,l_e2d5
    ld   de,$0012
    ld   b,$08
    call call_18A5
    ld   hl,l_e2d5
    ld   ix,l_f367
    ld   b,$08
bank0_call_B95C
    ld   a,$08
    sub  b
    ld   (ix+$09),a
    ld   (ix+$03),l
    ld   (ix+$04),h
    inc  hl
    ld   a,(hl)
    ld   (ix+$0a),a
    inc  hl
    inc  hl
    ld   (hl),$17
    inc  hl
    ld   de,$000C
    add  ix,de
    djnz bank0_call_B95C
    ret
    
bank0_call_B97A
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $B988
;    push ix
    ld   ix,l_f367
    xor  a
bank0_call_B98D
    push af
    bit  0,(ix+$00)
    jr   nz,bank0_call_BA09
    ld   a,(l_f3c9)
    and  a
    jp   z,bank0_call_BA98
    bit  1,(ix+$00)
    jp   nz,bank0_call_BA98
    ld   a,(l_f29d)
    bit  1,a
    ld   (ix+$07),$00
    jr   z,bank0_call_B9B1
    ld   (ix+$07),$02
bank0_call_B9B1
    ld   a,(l_e5d7)
    bit  0,a
    ld   a,(l_e692)
    jr   nz,bank0_call_B9BE
    ld   a,(l_e6c4)
bank0_call_B9BE
    sub  $80
    jr   c,bank0_call_B9CE
    bit  1,(ix+$07)
    jr   z,bank0_call_B9D8
    set  0,(ix+$07)
    jr   bank0_call_B9D8
bank0_call_B9CE
    bit  1,(ix+$07)
    jr   nz,bank0_call_B9D8
    set  0,(ix+$07)
bank0_call_B9D8
    ld   de,l_f297
    ld   a,(de)
    sub  $10
    inc  de
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   (hl),a
    inc  hl
    inc  hl
    ld   a,(l_f29d)
    bit  1,a
    ld   a,(de)
    jr   z,bank0_call_B9F4
    sub  $20
    jr   bank0_call_B9F6
bank0_call_B9F4
    add  a,$10
bank0_call_B9F6
    ld   (hl),a
    set  0,(ix+$00)
    ld   (ix+$05),$00
    ld   (ix+$06),$00
    call bank0_call_BAC5
    jp   bank0_call_BA98
bank0_call_BA09
    call loadhl2;$1537
    call bank0_call_BAC5
    ld   a,(ix+$07)
    ld   hl,bank0_data_BBA7
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_BA1A
    call bank0_call_BB0E
    jp   c,bank0_call_BA98
    call bank0_call_BB2C
    jp   c,bank0_call_BA98
    call bank0_call_BAF4
    jp   c,bank0_call_BA98
    ld   a,(ix+$09)
    ld   hl,bank0_data_BBAF
    call adda2hl;$0D89
    call bank0_call_BB4A
    jr   bank0_call_BA98
bank0_call_BA3A
    call bank0_call_BB0E
    jp   c,bank0_call_BA98
    call bank0_call_BAD9
    jp   c,bank0_call_BA98
    call bank0_call_BAF4
    jp   c,bank0_call_BA98
    ld   a,(ix+$09)
    ld   hl,bank0_data_BBB7
    call adda2hl;$0D89
    call bank0_call_BB4A
    jr   bank0_call_BA98
bank0_call_BA5A
    call bank0_call_BAD9
    jp   c,bank0_call_BA98
    call bank0_call_BB2C
    jp   c,bank0_call_BA98
    call bank0_call_BAF4
    jp   c,bank0_call_BA98
    ld   a,(ix+$09)
    ld   hl,bank0_data_BBBF
    call adda2hl;0D89
    call bank0_call_BB4A
    jr   bank0_call_BA98
bank0_call_BA7A
    call bank0_call_BB0E
    jp   c,bank0_call_BA98
    call bank0_call_BAD9
    jp   c,bank0_call_BA98
    call bank0_call_BB2C
    jp   c,bank0_call_BA98
    ld   a,(ix+$09)
    ld   hl,bank0_data_BBC7
    call adda2hl;$0D89
    call bank0_call_BB4A
bank0_call_BA98
    ld   de,$000C
    add  ix,de
    pop  af
    inc  a
    cp   $08
    jp   nz,bank0_call_B98D
    ld   a,(l_f3c7)
    and  a
    ret  nz
    ld   ix,l_f367
    ld   b,$08
bank0_call_BAAF
    ld   (ix+$00),$00
    ld   de,$000C
    add  ix,de
    djnz bank0_call_BAAF
    ld   hl,l_f3c7
    ld   (hl),$08
    ld   hl,l_f3c9
    ld   (hl),$00
    ret
bank0_call_BAC5    
    ld   de,$0504
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,$40
    ld   b,a
    ld   c,$33
    ld   a,(ix+$0a)
    call call_147D
    ret
bank0_call_BAD9
    ld   a,(ix+$02)
    cp   $1A
    ret  nc
    call call_154C
    ld   (ix+$01),$00
    ld   (ix+$02),$00
    ld   (ix+$00),$02
    ld   hl,l_f3c7
    dec  (hl)
    scf
    ret    
bank0_call_BAF4
    ld   a,(ix+$01)
    cp   $22
    ret  nc
    call call_154C
    ld   (ix+$01),$00
    ld   (ix+$02),$00
    ld   (ix+$00),$02
    ld   hl,l_f3c7
    dec  (hl)
    ret
bank0_call_BB0E    
    ld   a,(ix+$02)
    cp   $E6
    jr   nc,bank0_call_BB17
    xor  a
    ret
bank0_call_BB17
    call call_154C
    ld   (ix+$01),$00
    ld   (ix+$02),$00
    ld   (ix+$00),$02
    ld   hl,l_f3c7
    dec  (hl)
    scf
    ret
bank0_call_BB2C
    ld   a,(ix+$01)
    cp   $CE
    jr   nc,bank0_call_BB35
    xor  a
    ret
bank0_call_BB35
    call call_154C
    ld   (ix+$01),$00
    ld   (ix+$02),$00
    ld   (ix+$00),$02
    ld   hl,l_f3c7
    dec  (hl)
    scf
    ret
bank0_call_BB4A
    push hl
    ld   a,(hl)
    call call_109C
    ld   a,(ix+$0b)
    inc  (ix+$0b)
    call adda2de;$0D84
    pop  hl
    ld   a,(de)
    cp   $88
    jr   nz,bank0_call_BB64
    ld   (ix+$0b),$00
    jr   bank0_call_BB4A
bank0_call_BB64
    call loadhlfromspritestruct;$1529
    bit  0,a
    jr   z,bank0_call_BB87
    bit  3,a
    jr   z,bank0_call_BB7C
    dec  (hl)
    dec  (hl)
    dec  (hl)
    ld   a,(l_f296)
    bit  3,a
    jr   z,bank0_call_BB87
    dec  (hl)
    jr   bank0_call_BB87
bank0_call_BB7C
    inc  (hl)
    inc  (hl)
    inc  (hl)
    ld   a,(l_f296)
    bit  3,a
    jr   z,bank0_call_BB87
    inc  (hl)
bank0_call_BB87
    ld   a,(de)
    bit  4,a
    ret  z
    inc  hl
    inc  hl
    bit  7,a
    jr   z,bank0_call_BB9C
    dec  (hl)
    dec  (hl)
    dec  (hl)
    ld   a,(l_f296)
    bit  3,a
    ret  z
    dec  (hl)
    ret
bank0_call_BB9C
    inc  (hl)
    inc  (hl)
    inc  (hl)
    ld   a,(l_f296)
    bit  3,a
    ret  z
    inc  (hl)
    ret
bank0_data_BBA7
    BYTE LOW bank0_call_BA1A,HIGH bank0_call_BA1A
    BYTE LOW bank0_call_BA3A,HIGH bank0_call_BA3A
    BYTE LOW bank0_call_BA5A,HIGH bank0_call_BA5A
    BYTE LOW bank0_call_BA7A,HIGH bank0_call_BA7A


bank0_data_BBAF
    BYTE $00,$02,$04,$06,$08,$0A,$0C,$0E
bank0_data_BBB7    
    BYTE $08,$0A,$0C,$0E,$10,$12,$14,$16
bank0_data_BBBF
    BYTE $10,$12,$14,$16,$18,$1A,$1C,$1E
bank0_data_BBC7    
    BYTE $18,$1A,$1C,$1E,$00,$02,$04,$06


        
bank0_call_BBCF
    ld   hl,l_f3ce    
    ld   bc,$0077
    call clearbytes;$0D50
    ld   a,(l_ed40)
    and  a
    ret  z
    ld   a,$0C
    call call_189D
    bit  4,a
    ret  z
    ld   ix,l_f3ce
    xor  a
bank0_call_BBEA
    push af
    add  a,a
    ld   hl,(l_ed44)
    ld   (ix+$03),l
    ld   (ix+$04),h
    push hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   (l_ed44),hl
    pop  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$0a),a
    inc  hl
    inc  hl
    ld   (hl),$17
    ld   de,$0011
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed40
    cp   (hl)
    jr   nz,bank0_call_BBEA
    ret
    
bank0_call_BC15
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $BC23
;    push ix
    ld   a,(l_ed40)
    and  a
    ret  z
    ld   a,$0C
    call call_189D
    bit  4,a
    ret  z
    ld   ix,l_f3ce
    ld   hl,l_f1e7
    xor  a
bank0_call_BC38
    push af
    push hl
    bit  7,(hl)
    jr   z,bank0_call_BC42
    set  7,(ix+$00)
bank0_call_BC42
    ld   a,(l_f44e)
    and  a
    jp   nz,bank0_call_BE60
    ld   a,(l_f590)
    and  a
    jp   nz,bank0_call_BE60
    ld   a,$0E
    call adda2hl;$0D89
    bit  2,(hl)
    jp   nz,bank0_call_BE60
    ld   a,$0A
    call adda2hl;$0D89
    bit  3,(hl)
    jp   z,bank0_call_BE78
    call bank0_call_8879
    bit  0,(ix+$00)
    jp   nz,bank0_call_BCBB
    ld   (ix+$0c),$1E
    pop  hl
    push hl
    ld   a,$08
    call adda2hl;$0D89
    ld   a,(hl)
    dec  hl
    ld   (hl),a
    ld   (ix+$07),a
    ld   (ix+$08),a
    pop  hl
    push hl
    ld   a,$03
    call adda2hl;$0D89
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    call loadhlfromspritestruct;$1529
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    inc  de
    bit  1,(ix+$08)
    ld   a,(de)
    jr   z,bank0_call_BCA4
    sub  $10
    ld   (hl),a
    ld   (ix+$10),a
    jr   bank0_call_BCAA
bank0_call_BCA4
    add  a,$10
    ld   (hl),a
    ld   (ix+$10),a
bank0_call_BCAA
    ld   a,(ix+$0a)
    ld   b,$00
    ld   c,$33
    call call_147D
    set  0,(ix+$00)
    jp  bank0_call_BE78
bank0_call_BCBB
    call bank0_call_8838
    bit  3,(ix+$00)
    jp   nz,bank0_call_BDEC
    bit  2,(ix+$00)
    jr   z,bank0_call_BCD1
    bit  1,(ix+$00)
    jr   z,bank0_call_BCEB
bank0_call_BCD1
    pop  hl
    push hl
    bit  2,(hl)
    jp   nz,bank0_call_BE60
    bit  1,(hl)
    jp   nz,bank0_call_BE60
    ld   a,(l_fc7a)
    and  a
    jp   nz,bank0_call_BE78
    bit  2,(ix+$00)
    jp   z,bank0_call_BDEC
bank0_call_BCEB
    ld   a,(ix+$07)
    ld   hl,bank0_data_BE8F
    call call_0DA7
    ex   de,hl
    jp   (hl)
bank0_call_BCF6
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_BDEC
    ld   b,a
bank0_call_BCFE
    push bc
    call loadhl2;$1537
    bit  1,(ix+$00)
    jr   z,bank0_call_BD15
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    ld   b,(hl)
    ld   a,(ix+$10)
    sub  b
    jp   nc,bank0_call_BDC6
bank0_call_BD15
    ld   a,(ix+$02)
    sub  $0D
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_BD3D
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_BD3D
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz bank0_call_BCFE
    jp   bank0_call_BDEC
bank0_call_BD3D
    pop  bc
    ld   (ix+$07),$01
    ld   (ix+$08),$01
    set  1,(ix+$00)
    ld   c,$1A      ;add bottle hitting wall sound effect to queue
    call call_1350
    pop  hl
    push hl
    bit  2,(hl)
    jp   nz,bank0_call_BE60
    bit  1,(hl)
    jp   nz,bank0_call_BE60
    jp   bank0_call_BDEC
bank0_call_BD5E
    ld   a,(ix+$0d)
    or   a
    jp   z,bank0_call_BDEC
    ld   b,a
bank0_call_BD66
    push bc
    call loadhl2;$1537
    bit  1,(ix+$00)
    jr   z,bank0_call_BD7D
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   b,(ix+$10)
    sub  b
    jp   nc,bank0_call_BDC6
bank0_call_BD7D
    ld   a,(ix+$02)
    add  a,$0C
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_BDA5
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,bank0_call_BDA5
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz bank0_call_BD66
    jp   bank0_call_BDEC
bank0_call_BDA5
    pop  bc
    ld   (ix+$07),$03
    ld   (ix+$08),$03
    set  1,(ix+$00)
    ld   c,$1A      ;add bottle hitting wall sound effect to queue
    call call_1350
    pop  hl
    push hl
    bit  2,(hl)
    jp   nz,bank0_call_BE60
    bit  1,(hl)
    jp   nz,bank0_call_BE60
    jp   bank0_call_BDEC
bank0_call_BDC6
    pop  bc
    set  3,(ix+$00)
    call resetframetimer;call_1556
    ld   a,(ix+$08)
    xor  $02
    ld   (ix+$08),a
    pop  hl
    push hl
    ld   a,$05
    call adda2hl;$0D89
    ld   (hl),$00
    inc  hl
    ld   (hl),$00
    ld   a,$12
    call adda2hl;$0D89
    set  6,(hl)
    jp   bank0_call_BE78
bank0_call_BDEC
    ld   hl,bank0_data_BE97
    bit  7,(ix+$00)
    jr   nz,bank0_call_BDFB
    ld   a,(l_e349)
    and  a
    jr   z,bank0_call_BDFE
bank0_call_BDFB
    ld   hl,bank0_data_BEA0
bank0_call_BDFE
    bit  3,(ix+$00)
    jr   z,bank0_call_BE11
    ld   de,$0A01
    call frametimer;$15CA
    jp   z,bank0_call_BE60
    ld   a,(hl)
    jp   bank0_call_BE4A
bank0_call_BE11
    ld   de,$0509
    bit  6,(ix+$0e)
    jr   z,bank0_call_BE1D
    ld   de,$0309
bank0_call_BE1D
    bit  2,(ix+$00)
    jr   nz,bank0_call_BE37
    call frametimer;$15CA
    jr   nz,bank0_call_BE31
    set  2,(ix+$00)
    call resetframetimer;call_1556
    jr   bank0_call_BE78
bank0_call_BE31
    call adda2hl;$0D89
    ld   a,(hl)
    jr   bank0_call_BE4A
bank0_call_BE37
    ld   de,$0204
    bit  6,(ix+$0e)
    jr   z,bank0_call_BE43
    ld   de,$0204
bank0_call_BE43
    call frametimer;$15CA
    add  a,a
    add  a,a
    add  a,$40
bank0_call_BE4A
    ld   b,a
    ld   c,$33
    ld   a,(ix+$0a)
    bit  1,(ix+$08)
    jr   z,bank0_call_BE5B
    call call_147D
    jr   bank0_call_BE78
bank0_call_BE5B
    call call_149C
    jr   bank0_call_BE78
bank0_call_BE60
    call call_154C
    call resetframetimer;call_1556
    ld   (ix+$01),a
    ld   (ix+$02),a
    ld   (ix+$00),a
    pop  hl
    push hl
    ld   a,$18
    call adda2hl;$0D89
    ld   (hl),$00
bank0_call_BE78
    ld   de,$0011
bank0_call_BE7B
    add  ix,de
    pop  hl
    ld   a,$19
    call adda2hl;$0D89
    ex   de,hl
    pop  af
    inc  a
    ld   hl,l_ed40
    cp   (hl)
    ex   de,hl
    jp   nz,bank0_call_BC38
    ret

bank0_data_BE8F
    BYTE LOW bank0_call_BDEC,HIGH bank0_call_BDEC
    BYTE LOW bank0_call_BD5E,HIGH bank0_call_BD5E
    BYTE LOW bank0_call_BDEC,HIGH bank0_call_BDEC
    BYTE LOW bank0_call_BCF6,HIGH bank0_call_BCF6
    
bank0_data_BE97
    BYTE $14,$1C,$24,$1C,$24,$2C,$34,$2C,$34
bank0_data_BEA0    
    BYTE $74,$7C,$84,$7C,$84,$8C,$94
    BYTE $8C,$94
bank0_call_BEA9
    ld   hl,l_f446
    ld   (hl),$04
    ld   hl,l_f445
    ld   (hl),$00
    ld   hl,l_f447
    ld   (hl),$00
bank0_call_BEB8
;    ld   bc,($0004)
;    ld   hl,$00B9
;    xor  a
;    sbc  hl,bc
;    jr   $BEC6
;    ex   (sp),ix
bank0_call_BEC6             ;crumbling wall rountine
    ld   a,$02
    call call_0018
bank0_call_BEC9
    /*ld   a,(l_f445)         ;column?
    call call_0D8E          ;A * 64 and into DE
    ld   a,(l_f446)         ;row
    add  a,a*/
    ld   a,(l_f446)         ;row?
    call call_0D8E          ;A * 64 and into DE
    ld h,0
    ld l,a
    add hl,hl				;x2
	add hl,hl				;x4
	add hl,hl				;x8
	add hl,hl				;x16
	add hl,de				;total is now a x 80



    ld   a,(l_f445)         ;column
    add  a,a                ;* 2
    ld   e,a
    ld   d,0
    add  hl,de

    ld   de,$7608-$50;$CD00
    ;call call_0D89          ;add A to HL
    add  hl,de

    push hl
    ld   a,(l_f445)     ;column
    add  a,a
    add  a,a
    add  a,a
    ld   h,a
    ld   a,(l_f446)
    add  a,a
    add  a,a
    add  a,a
    neg
    ld   l,a
    call call_174B
    pop  hl
    jr   nz,bank0_call_BF03
    ld   a,(l_f447)
    add  a,a
    ld   de,bank0_data_BF38
    call call_0D84
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    jr   bank0_call_BF03
bank0_call_BF03
    ld   hl,l_f445
    inc  (hl)
    ld   a,(hl)
    cp   $20
    jr   nz,bank0_call_BEC9
    ld   (hl),$00
    ld   hl,l_f447
    inc  (hl)
    ld   a,(hl)
    cp   $08
    jr   nz,bank0_call_BEB8
    ld   (hl),$00
    /*ld   a,(l_f445)
    call call_0D8E
    ld   a,(l_f446)
    add  a,a*/

    ld   a,(l_f446)         ;row?
    call call_0D8E          ;A * 64 and into DE
    ld h,0
    ld l,a
    add hl,hl				;x2
	add hl,hl				;x4
	add hl,hl				;x8
	add hl,hl				;x16
	add hl,de				;total is now a x 80

    ld   a,(l_f445)         ;column
    add  a,a                ;* 2
    ld   e,a
    ld   d,0
    add  hl,de

    ld   de,$7608-$50;$CD00
    ;call call_0D89
    add  hl,de
    call call_03FD
    ld   hl,l_f446
    inc  (hl)
    ld   a,(hl)
    cp   $1e; finish at row 30 for Next qq$20
    jp   nz,bank0_call_BEB8
    ld a,$20
    ld (hl),a   ;set l_f446 to 20 as game expects 32 rows
    ret
bank0_data_BF38        ;Crumbling wall data
	;BYTE $C0,$3D,$C1,$3D,$C2,$3D,$C3,$3D,$C4,$3D,$C5,$3D,$C6,$3D,$00,$00
    ;BYTE $80,$F0,$7F,$F0,$7E,$F0,$7D,$F0,$7C,$F0,$7B,$F0,$7A,$F0,$00,$00
    BYTE $7A,$F0,$7B,$F0,$7C,$F0,$7D,$F0,$7E,$F0,$7F,$F0,$80,$F0,$00,$00

    
bank0_call_BF48
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e34a)
    and  a
    ret  nz
    ld   a,(l_f448)
    bit  2,a
    ret  nz
    bit  1,a
    jr   nz,bank0_call_BFB5
    bit  0,a
    jr   nz,bank0_call_BF75
    ret
bank0_call_BF61
    ld   a,(l_e5d8)
    and  a
    ret  z
    ld   a,(l_f448)
    bit  2,a
    ret  nz
    bit  1,a
    jr   nz,bank0_call_BFB5
    ld   a,$03              ;need to find oout what sound this is
    ;ld   ($FA00),a         ;SOUND IO
bank0_call_BF75                 ;end screen shooting star

    ;break


    ;clear required sprite patterns from
    ;non shooting star sprite for skull pick up
    ld a,(l_e64b)   ;check level num
    cp $64
    jr z,bank0_call_BF75_2 ;skip if on level 100

    ld hl,l_e24d        
	;ld iy,sprite_attr  
	ld b,$07;4a
bank0_call_BF75_1
    ;ld (hl),$00
    inc hl
    ld (hl),$00
    inc hl
    ;ld (hl),$00
    inc hl
    ;ld (hl),$00
    inc hl
    djnz bank0_call_BF75_1

bank0_call_BF75_2

    ld   hl,l_e2d5
    ld   de,$0004
    ld   b,$07
    call call_18A5              ;set sprite gfx nums (byte 2)
    ld   de,bank0_data_BFE3
    ld   hl,l_e2d5
    ld   b,$07
bank0_call_BF88                 ;set starting coords
    ld   a,(de)
    ld   (hl),a
    inc  de
    inc  hl
    inc  hl
    ld   a,(de)
    ld   (hl),a
    inc  hl
    ld   (hl),$16
    inc  de
    inc  hl
    djnz bank0_call_BF88


    ld   hl,bank0_data_BFF8
    ld   a,(l_f448)
    bit  0,a
    jr   nz,bank0_call_BFA3
    ld   hl,bank0_data_BFF1
bank0_call_BFA3
    ld   bc,$071D
    ld   e,$04
    call call_14C0

    ;break
    ld a,0          ;3 lines are hack to stop erroneous graphic update
    ld (l_e24e),a
    ld (l_e252),a

   /* ;force sprite updates
    ld hl,pattern_bank
    ld b,$80
bank0_call_BFA3_1
    ld a,(hl)
    or $02
    ld (hl),a
    inc hl
    djnz bank0_call_BFA3_1
*/
    ld   hl,l_f448
    set  1,(hl)
    ld   c,$13      ;add shooting star sound effect to queue
    call call_1350
bank0_call_BFB5
    ld   b,$07
    ld   hl,l_e2d5
bank0_call_BFBA
    ld   a,(hl)
    and  a
    jr   z,bank0_call_BFC2
    dec  (hl)
    dec  (hl)
    dec  (hl)
    dec  (hl)
bank0_call_BFC2
    inc  hl
    inc  hl
    dec  (hl)
    dec  (hl)
    inc  hl
    inc  hl
    djnz bank0_call_BFBA
    ld   a,(l_e2d5)
    and  a
    ret  nz
    ld   hl,l_f448
    set  2,(hl)
    bit  7,(hl)
    ret  z
    set  6,(hl)
;    ld   hl,($0004)
;    ld   de,$00B9
;    or   a
;    sbc  hl,de
    ret

bank0_data_BFE3
    BYTE $FC,$C0,$FC,$D0,$EC,$C0,$EC,$D0,$DC,$B0,$DC,$C0,$CC,$B0
    
bank0_data_BFF1
    BYTE $C4,$CC,$C0,$C8,$B8,$BC,$B4
bank0_data_BFF8    
    BYTE $E0,$E8,$DC,$E4,$D4,$D8,$D0,$FF


