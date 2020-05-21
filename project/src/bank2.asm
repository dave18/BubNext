

SCREEN_REF EQU $76ae;$772e		;this is the reference point used to check screen locations

    org $c000
    
;bank2_data_8015

bank2_call_8000				;TODO - only first line of code added to pass security at $8B76
	 ld   a,(l_fc20)
	 jp bank2_call_8000
	 
	 
bank2_call_8016				;TODO - nothing here - used by security routine that has been bypassed
	jp bank2_call_8016
/*
    call bank2_call_82CB
    call bank2_call_83B3
    call bank2_call_8360
    ;ld   ($FA80),a
	nop
	nop
	nop
    jr   bank2_call_8016
    ld   b,$02
    ld   ix,bank2_data_8070
bank2_call_802A
    ld   l,(ix+$00)
    ld   h,(ix+$01)
    ld   e,(ix+$02)
    ld   d,(ix+$03)
bank2_call_8036
    ld   a,$FF
    ld   (hl),a
    cp   (hl)
    jr   nz,bank2_call_8062
    ld   a,$AA
    ld   (hl),a
    cp   (hl)
    jr   nz,bank2_call_8062
    ld   a,$55
    ld   (hl),a
    cp   (hl)
    jr   nz,bank2_call_8062
    xor  a
    ld   (hl),a
    cp   (hl)
    jr   nz,bank2_call_8062
    inc  hl
    dec  de
    ld   a,e
    or   d
    jr   nz,bank2_call_8036
    inc  ix
    inc  ix
    inc  ix
    inc  ix
    inc  ix
    inc  ix
    djnz bank2_call_802A
    ret
bank2_call_8062
    ld   l,(ix+$04)
    ld   h,(ix+$05)
    ld   de,$D020  ;TODO screen loc
	ld   c,$00
    ;jp   $0E9A
	ret  ;temp as we are not jping to e9a
	nop
	nop
	nop
bank2_data_8070
	BYTE $00,$C0,$00,$1D,$7C,$80,$00,$DD,$00,$03,$8D,$80
bank2_data_807C
	BYTE $10,"SCREEN RAM ERROR"
bank2_data_808D
	BYTE $10,"OBJECT RAM ERROR"
bank2_call_809E
    ret
bank2_call_809F
    ld   hl,l_f800
    ld   bc,$0200
    call call_0D50
    ld   hl,l_f802
    ld   de,bank2_data_8172
    ld   b,$10
bank2_call_80B0
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  de
    ld   a,$1F
    call call_0D89
    djnz bank2_call_80B0
    ld   ix,$7600;$C000
    ld   b,$10
bank2_call_80C4
    push ix
    push bc
    ld   b,$10
bank2_call_80C9
    ;ld   (ix+$00),$14
	nop
	nop
	nop
	nop
    ;ld   (ix+$40),$16
	nop
	nop
	nop
	nop
    ;ld   (ix+$02),$15
	nop
	nop
	nop
	nop
    ;ld   (ix+$42),$17
	nop
	nop
	nop
	nop
    inc  ix
    inc  ix
    inc  ix
    inc  ix
    djnz bank2_call_80C9
    pop  bc
    pop  ix
    ld   de,$0080
    add  ix,de
    djnz bank2_call_80C4
    ld   ix,bank2_data_8142
    ld   b,$10
bank2_call_80F3
    exx
    ld   l,(ix+$00)
    ld   h,(ix+$01)
    ld   e,(ix+$02)
    call bank2_call_812D
    inc  ix
    inc  ix
    inc  ix
    exx
    djnz bank2_call_80F3
*/

bank2_call_83E8
    ld   a,(l_e5d3)
    and  a
    jr   z,bank2_call_83F6
    ld   a,r
    and  $1F
    add  a,$14
    jr   bank2_call_8447
bank2_call_83F6
    ld   a,(levelnum)
    and  a
    jr   nz,bank2_call_8404
    ld   a,r
    and  $0F
bank2_call_8400
    add  a,$15
    jr   bank2_call_8447
bank2_call_8404
    ld   b,$03
    ld   hl,bank2_data_8463
bank2_call_8409 ;83E8_4
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   a,(de)
    and  a
    jr   nz,bank2_call_843C
    ld   a,$11
    call adda2hl
    djnz bank2_call_8409
    ld   a,(numplayers)
    cp   $03
    jr   z,bank2_call_842D
    ld   a,(l_f456)
    cp   $1E
    jr   c,bank2_call_8427
    ld   a,$1D
bank2_call_8427 ;83E8_6
    ld   c,a
    ld   a,$31
    sub  c
    jr   bank2_call_8447
bank2_call_842D ;83E8_5
    ld   a,(l_f456)
    cp   $28
    jr   c,bank2_call_8436
    ld   a,$27
bank2_call_8436 ;83E8_7
    ld   c,a
    ld   a,$3B
    sub  c
    jr   bank2_call_8447
bank2_call_843C ;83E8_3       ;error
     xor  a
     ld   (de),a
     inc  hl
     ld   a,r
     and  $0F
     call adda2hl
     ld   a,(hl)
bank2_call_8447 ;83E8_9
     ld   (l_f44c),a
     ld   hl,l_f44e
     ld   bc,$0009
     call clearbytes
     ld   hl,$01A4
     ld   a,(l_f44d)
     and  a
     jr   z,bank2_call_845F
     ld   hl,$00F0
bank2_call_845F ;83E8_8
     ld   (l_f450),hl
     ret
bank2_data_8463
    BYTE LOW l_f454,HIGH l_f454;$54,$F4
    BYTE $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$00,$01,$02,$03,$04,$05
    BYTE LOW l_f453,HIGH l_f453;$53,$F4
    BYTE $0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$0A,$0B,$0C,$0D,$0E,$0F
    BYTE LOW l_f452,HIGH l_f452;$52,$F4
    BYTE $01,$04,$07,$0A,$0D,$10,$13,$16,$19,$1C,$20,$23,$26,$29,$2C,$2F
;    BYTE $54,$F4,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$00,$01,$02,$03
;    BYTE $04,$05,$53,$F4,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$0A,$0B
;    BYTE $0C,$0D,$0E,$0F,$52,$F4,$01,$04,$07,$0A,$0D,$10,$13,$16,$19,$1C
;    BYTE $20,$23,$26,$29,$2C,$2F
    
bank2_call_8499
     ld   a,(l_e64b)
     cp   $63
     ret  z
     ld   a,(l_f44f)
     bit  3,a
     ret  nz
     bit  0,a
     jr   nz,bank2_call_84FD
     bit  1,a
     jp   nz,bank2_call_850C
     bit  2,a
     jp   nz,bank2_call_8533
     ld   hl,(l_f450)
     dec  hl
     ld   (l_f450),hl
     ld   a,l
     or   h
     ret  nz
     ld   hl,l_e599
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ld   hl,l_e2ad
     ld   (hl),e
     inc  hl
     ld   (hl),$09
     inc  hl
     ld   (hl),d
     inc  hl
     ld   (hl),$13
     ld   a,(l_f44c)
     ld   b,$05
     call call_0DB1
     ld   de,bank2_data_B389
     add  hl,de
     ld   b,(hl)
     inc  hl
     ld   c,(hl)
     ld   a,$09
     call call_147D
     ld   hl,$0258
     ld   (l_f450),hl
     ;ld   hl,($0B2E)
     ;ld   de,$044D
     ;ld   a,h
     ;cp   d
     ;jr   z,$84F5
     ;ld   i,a
bank2_call_84F5
     ld   hl,l_f44f
     ld   (hl),$00
     set  0,(hl)
     ret
bank2_call_84FD
     call bank2_call_A2C0
     ld   hl,(l_f450)
     dec  hl
     ld   (l_f450),hl
     ld   a,l
     or   h
     ret  nz
     jr   bank2_call_853D
bank2_call_850C
     call call_65D0
     ld   hl,(l_f450)
     dec  hl
     ld   (l_f450),hl
     ld   a,l
     or   h
     jr   z,bank2_call_8525
     ld   a,l
     and  $03
     cp   $03
     ret  nz
     ld   hl,l_e2ad
     inc  (hl)
     ret
bank2_call_8525
     ld   hl,$003C
     ld   (l_f450),hl
     ld   hl,l_f44f
     ld   (hl),$00
     set  2,(hl)
     ret
bank2_call_8533
     ld   hl,(l_f450)
     dec  hl
     ld   (l_f450),hl
     ld   a,l
     or   h
     ret  nz
     ld   hl,l_e2ad
     ld   bc,$0004
     call clearbytes
     ld   hl,l_f44f
     ld   (hl),$00
     set  3,(hl)
     ret
bank2_call_853D
     ld   hl,l_e2ad
     ld   bc,$0004
     call clearbytes;$0D50
     ld   hl,l_f44f
     ld   (hl),$00
     set  3,(hl)
     ret

bank2_call_854E
     ld   a,(l_f44f)
     bit  0,a
     ret  z
     ld   hl,l_e2ad
     ld   e,(hl)
     inc  hl
     inc  hl
     ld   d,(hl)
     ld   a,e
     add  a,$08
     ld   l,a
     ld   a,d
     add  a,$08
     ld   h,a
     call call_1444
     ret  nc
     ld   a,(l_f44c)
     ld   b,$05
     call call_0DB1
     ld   de,bank2_data_B38B
     add  hl,de
     push hl
     ld   b,(hl)
     ld   c,$1E
     ld   a,(ix+$09)
     and  a
     jr   z,bank2_call_857F
     ld   c,$22
bank2_call_857F
     ld   a,$09
     call call_147D
     pop  hl
     inc  hl
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     call call_41EC
     ld   c,$20
     call call_1350
     ld   hl,l_e5f7
     inc  (hl)
     ld   a,(l_f44c)
     cp   $36
     jr   c,bank2_call_85A0
     ld   hl,l_e609
     inc  (hl)
bank2_call_85A0
     ld   hl,$0078
     ld   (l_f450),hl
     ld   hl,l_f44f
     ld   (hl),$00
     set  1,(hl)
     ret

     
bank2_call_85AE
     ld   a,(l_f459)
     and  a
     jr   nz,bank2_call_85C4
     ld   hl,l_f45c
     ld   (hl),$00
     ld   hl,$9532            ;don't think this is an address
     ld   (l_f45a),hl
     ld   hl,l_f459
     ld   (hl),$01
bank2_call_85C4
     ld   de,(l_f45a)
     ld   a,(de)
     ld   hl,l_f45c
     add  a,(hl)
     ld   (hl),a
     inc  de
     inc  de
     ld   hl,bank2_data_B788
     or   a
     sbc  hl,de
     jr   z,bank2_call_85DD
     ld   (l_f45a),de
     ret
bank2_call_85DD
     ld   hl,l_f459
     ld   (hl),$00
     ld   a,(l_f45d)
     ld   hl,l_f45c
     cp   (hl)
     ret
errorpushaf
     jr errorpushaf
     push af
bank2_call_85EB
    ld   hl,l_f45f
    ld   bc,$0007
    call clearbytes
    ld   a,(l_e5d3)
    and  a
    jr   nz,bank2_call_8637
    ld   a,(levelnum)
    cp   $63
    jr   z,bank2_call_8637
    ld   hl,l_e612
    ld   a,(hl)
    and  a
    jr   z,bank2_call_8611
    dec  (hl)
    ld   a,(hl)
    add  a,$09
    ld   (l_f45e),a
    jr   bank2_call_8657
bank2_call_8611 ;85EB_2
    ld   b,$36
    ld   hl,bank2_data_B4F2
bank2_call_8616 ;85EB_5
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    inc  hl
    push hl
    push hl
    ld   a,(l_e5dc)
    ld   hl,bank2_data_8667           
    call adda2hl
    ld   a,(hl)
    pop  hl
    call adda2hl
    ld   a,(de)
    cp   (hl)
    pop  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    jr   nc,bank2_call_863D
    inc  hl
    dec  b
    jr   nz,bank2_call_8616
bank2_call_8637 ;85EB_1
    ld   hl,l_f45f
    set  3,(hl)
    ret
bank2_call_863D ;85EB_4
    ld   a,(hl)
    ld   (l_f463),a
    ld   a,b
    dec  a
    ld   (l_f45e),a
    xor  a
    ld   (de),a
    ld   a,b
    cp   $0F
    jr   nz,bank2_call_8657
    call bank2_call_90DD
    ld   hl,l_f513
    ld   (hl),$FF
    jr   bank2_call_8637
bank2_call_8657 ;85EB_3
    ld   hl,$02D0
    ld   a,(l_f44d)
    and  a
    jr   z,bank2_call_8663
    ld   hl,$00F0
bank2_call_8663 ;85EB_6
    ld   (l_f461),hl
    ret

bank2_data_8667
    BYTE $02,$02,$02,$02,$02,$03,$03,$03
    BYTE $01,$01,$01,$01,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00
    
bank2_call_8686
     ld   a,(l_f45f)
     bit  3,a
     ret  nz
     bit  0,a
     jr   nz,bank2_call_86E5
     bit  1,a
     jr   nz,bank2_call_86FF
     bit  2,a
     jp   nz,bank2_call_8723
     ld   hl,(l_f461)
     dec  hl
     ld   (l_f461),hl
     ld   a,l
     or   h
     ret  nz
     ld   a,(l_e34a)
     and  a
     jp   nz,bank2_call_872D
     ld   a,(l_ed3d)
     and  a
     jp   z,bank2_call_872D
     ld   hl,l_e5a2
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ld   hl,l_e2b1
     ld   (hl),e
     inc  hl
     ld   (hl),$29
     inc  hl
     ld   (hl),d
     inc  hl
     ld   (hl),$13
     ld   a,(l_f45e)
     ld   b,$05
     call call_0DB1
     ld   de,bank2_data_B66C
     add  hl,de
     ld   b,(hl)
     inc  hl
     ld   c,(hl)
     ld   a,$29
     call call_147D
     ld   hl,$0384
     ld   (l_f461),hl
     ld   hl,l_f45f
     ld   (hl),$00
     set  0,(hl)
     ret
bank2_call_86E5
     ld   a,(l_e34a)
     and  a
     jp   nz,bank2_call_872D
     ld   a,(l_ed3d)
     and  a
     jp   z,bank2_call_872D
bank2_call_86FF
     ld   hl,(l_f461)
     dec  hl
     ld   (l_f461),hl
     ld   a,l
     or   h
     ret  nz
     jr   bank2_call_872D
     ld   hl,(l_f461)
     dec  hl
     ld   (l_f461),hl
     ld   a,l
     or   h
     jr   z,bank2_call_8715
     ld   a,l
     and  $03
     cp   $03
     ret  nz
     ld   hl,l_e2b1
     inc  (hl)
     ret
bank2_call_8715
     ld   hl,$003C
     ld   (l_f461),hl
     ld   hl,l_f45f
     ld   (hl),$00
     set  2,(hl)
     ret
bank2_call_8723
     ld   hl,(l_f461)
     dec  hl
     ld   (l_f461),hl
     ld   a,l
     or   h
     ret  nz
bank2_call_872D
     ld   hl,l_e2b1
     ld   bc,$0004
     call clearbytes;$0D50
     ld   hl,l_f45f
     ld   (hl),$00
     set  3,(hl)
     ret
     
bank2_call_873E
     ld   a,(l_f45f)
     bit  0,a
     ret  z
     ld   hl,l_e2b1
     ld   e,(hl)
     inc  hl
     inc  hl
     ld   d,(hl)
     ld   a,e
     add  a,$08
     ld   l,a
     ld   a,d
     add  a,$08
     ld   h,a
     call call_1444
     ret  nc
     ld   a,(l_f45e)
     ld   b,$05
     call call_0DB1
     ld   de,bank2_data_B66E
     add  hl,de
     push hl
     ld   b,(hl)
     ld   c,$1E
     ld   a,(ix+$09)
     and  a
     jr   z,bank2_call_876F
     ld   c,$22
bank2_call_876F
     ld   a,$29
     call call_147D
     pop  hl
     inc  hl
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ld   a,(ix+$09)
     ld   (l_f460),a
     call call_41EC
     ld   hl,$0078
     ld   (l_f461),hl
     ld   hl,l_f45f
     ld   (hl),$00
     set  1,(hl)
     ld   c,$16
     call call_1350
     ld   hl,l_e5f6
     inc  (hl)
;     ld   hl,($0B2E)
;     ld   bc,$044D
;     ld   a,h
;     sub  b
;     jr   z,$87A6
;     ld   a,r
;     ld   i,a
     ld   a,(l_f45e)
     ld   hl,bank2_data_8AFF
     call call_0DA7
     ex   de,hl
	 jp	(hl)
	 
	 
bank2_data_8AFF
	BYTE LOW bank2_call_87B1,HIGH bank2_call_87B1
	BYTE LOW bank2_call_87BD,HIGH bank2_call_87BD
	BYTE LOW bank2_call_87C9,HIGH bank2_call_87C9
	BYTE LOW bank2_call_87DF,HIGH bank2_call_87DF
	BYTE LOW bank2_call_87FF,HIGH bank2_call_87FF
	BYTE LOW bank2_call_8819,HIGH bank2_call_8819
	BYTE LOW bank2_call_8822,HIGH bank2_call_8822
	BYTE LOW bank2_call_882C,HIGH bank2_call_882C
	BYTE LOW bank2_call_8836,HIGH bank2_call_8836
	BYTE LOW bank2_call_885C,HIGH bank2_call_885C
	BYTE LOW bank2_call_8879,HIGH bank2_call_8879
	BYTE LOW bank2_call_8893,HIGH bank2_call_8893
	BYTE LOW bank2_call_88BD,HIGH bank2_call_88BD
	BYTE LOW bank2_call_88D2,HIGH bank2_call_88D2
	BYTE LOW bank2_call_88F8,HIGH bank2_call_88F8
	BYTE LOW bank2_call_88F9,HIGH bank2_call_88F9
	BYTE LOW bank2_call_8901,HIGH bank2_call_8901
	BYTE LOW bank2_call_8909,HIGH bank2_call_8909
	BYTE LOW bank2_call_8911,HIGH bank2_call_8911
	BYTE LOW bank2_call_891E,HIGH bank2_call_891E
	BYTE LOW bank2_call_892F,HIGH bank2_call_892F
	BYTE LOW bank2_call_8938,HIGH bank2_call_8938
	BYTE LOW bank2_call_8941,HIGH bank2_call_8941
	BYTE LOW bank2_call_8953,HIGH bank2_call_8953
	BYTE LOW bank2_call_898E,HIGH bank2_call_898E
	BYTE LOW bank2_call_8997,HIGH bank2_call_8997
	BYTE LOW bank2_call_89AA,HIGH bank2_call_89AA
	BYTE LOW bank2_call_89BC,HIGH bank2_call_89BC
	BYTE LOW bank2_call_89C2,HIGH bank2_call_89C2
	BYTE LOW bank2_call_89C8,HIGH bank2_call_89C8
	BYTE LOW bank2_call_89E5,HIGH bank2_call_89E5
	BYTE LOW bank2_call_89F0,HIGH bank2_call_89F0
	BYTE LOW bank2_call_89FB,HIGH bank2_call_89FB
	BYTE LOW bank2_call_8A06,HIGH bank2_call_8A06
	BYTE LOW bank2_call_8A11,HIGH bank2_call_8A11
	BYTE LOW bank2_call_8A28,HIGH bank2_call_8A28
	BYTE LOW bank2_call_8A33,HIGH bank2_call_8A33
	BYTE LOW bank2_call_8A3E,HIGH bank2_call_8A3E
	BYTE LOW bank2_call_8A49,HIGH bank2_call_8A49
	BYTE LOW bank2_call_8A54,HIGH bank2_call_8A54
	BYTE LOW bank2_call_8A5F,HIGH bank2_call_8A5F
	BYTE LOW bank2_call_8A6A,HIGH bank2_call_8A6A
	BYTE LOW bank2_call_8A70,HIGH bank2_call_8A70
	BYTE LOW bank2_call_8A7B,HIGH bank2_call_8A7B
	BYTE LOW bank2_call_8A86,HIGH bank2_call_8A86
	BYTE LOW bank2_call_8A91,HIGH bank2_call_8A91
	BYTE LOW bank2_call_8AA3,HIGH bank2_call_8AA3
	BYTE LOW bank2_call_8AA9,HIGH bank2_call_8AA9
	BYTE LOW bank2_call_8AB1,HIGH bank2_call_8AB1
	BYTE LOW bank2_call_8AB7,HIGH bank2_call_8AB7
	BYTE LOW bank2_call_8AC2,HIGH bank2_call_8AC2
	BYTE LOW bank2_call_8ACD,HIGH bank2_call_8ACD
	BYTE LOW bank2_call_8AD8,HIGH bank2_call_8AD8
	BYTE LOW bank2_call_8AED,HIGH bank2_call_8AED
	

    ;BYTE $B1,$87,$BD,$87,$C9,$87,$DF,$87,$FF,$87,$19,$88,$22,$88,$2C,$88
    ;BYTE $36,$88,$5C,$88,$79,$88,$93,$88,$BD,$88,$D2,$88,$F8,$88,$F9,$88
    ;BYTE $01,$89,$09,$89,$11,$89,$1E,$89,$2F,$89,$38,$89,$41,$89,$53,$89
    ;BYTE $8E,$89,$97,$89,$AA,$89,$BC,$89,$C2,$89,$C8,$89,$E5,$89,$F0,$89
    ;BYTE $FB,$89,$06,$8A,$11,$8A,$28,$8A,$33,$8A,$3E,$8A,$49,$8A,$54,$8A
    ;BYTE $5F,$8A,$6A,$8A,$70,$8A,$7B,$8A,$86,$8A,$91,$8A,$A3,$8A,$A9,$8A
    ;BYTE $B1,$8A,$B7,$8A,$C2,$8A,$CD,$8A,$D8,$8A,$ED,$8A

bank2_call_87B1
     call bank2_call_85AE
     ld   hl,l_e5eb
     inc  (hl)
     ld   (ix+$31),$80
     ret
bank2_call_87BD
    call bank2_call_8B6B
    ld   hl,l_e5e9
    inc  (hl)
    ld   (ix+$2f),$06
    ret
bank2_call_87C9
    call bank2_call_8D64
    ld   hl,l_e5ea
    inc  (hl)
    ld   (ix+$2e),$05
;    ld   a,($0004)
;    ld   de,$00B9
;    sub  e
    ret ; z
    ;push af
    ;push ix
bank2_call_87DF
    call bank2_call_8F17
    ld   b,$03
    xor  a
    ld   hl,$0000
bank2_call_87E8
    add  a,(hl)
    inc  hl
    djnz bank2_call_87E8
    sub  $3E
    jr   z,bank2_call_87F2
    ;push ix
bank2_call_87F2
    ld   (ix+$30),$13
    ld   (ix+$2c),$01
    xor  a
    ld   (ix+$1f),a
    ret
bank2_call_87FF
    call bank2_call_932D
;    ld   a,($0002)
;    bit  3,a
;    jr   nz,bank2_call_880A
    ;push hl
bank2_call_880A
    ld   hl,l_e5ed
    inc  (hl)
    ld   hl,l_e341
    ld   (hl),$FF
    ld   hl,l_fc7a
    ld   (hl),$FF
    ret
bank2_call_8819
    call bank2_call_909A
    ld   hl,l_f59e
    ld   (hl),$01
    ret
bank2_call_8822
    call bank2_call_96A9
    ld   hl,l_e350
    ld   (hl),$03
    jr   bank2_call_883E
bank2_call_882C
    call bank2_call_A2C0
    ld   hl,l_e350
    ld   (hl),$05
    jr   bank2_call_883E
bank2_call_8836
    call bank2_call_A7E3
    ld   hl,l_e350
    ld   (hl),$07
bank2_call_883E
    ld   hl,l_e5ec
    inc  (hl)
    ld   a,$04
    call call_0008
    ld   a,$05
    call call_0008
    ld   a,$02
    call call_0008
    call call_18BB
    ld   a,$02
    call call_0010
    ld   hl,l_e34f
    ld   (hl),$01
    ld   hl,l_f452
    ld   (hl),$01
    ret
bank2_call_885C
    call bank2_call_B4B5
    ld   hl,l_f523
    ld   (hl),$01
    ld   hl,l_f521
    ld   (hl),$FF
    ld   hl,l_e737
    ld   (hl),$01
    ld   hl,l_e739
    ld   (hl),$03
    ld   hl,l_e341
    ld   (hl),$01
    ret
bank2_call_8879
    ld   hl,l_f523
    ld   (hl),$02
    ld   hl,l_f521
    ld   (hl),$FF
    ld   hl,l_e737
    ld   (hl),$01
    ld   hl,l_e739
    ld   (hl),$02
    ld   hl,l_e341
    ld   (hl),$01
    ret
bank2_call_8893
    ld   b,$03
    xor  a
    ld   hl,$0000
bank2_call_8899
    add  a,(hl)
    inc  hl
    djnz bank2_call_8899
    sub  $3E
    jr   z,bank2_call_88A3
    ;push ix
bank2_call_88A3
    ld   hl,l_f523
    ld   (hl),$00
    ld   hl,l_f521
    ld   (hl),$FF
    ld   hl,l_e737
    ld   (hl),$01
    ld   hl,l_e739
    ld   (hl),$01
    ld   hl,l_e341
    ld   (hl),$01
    ret
bank2_call_88BD
    ld   hl,l_f531
    ld   (hl),$FF
    ld   hl,l_e737
    ld   (hl),$01
    ld   hl,l_e739
    ld   (hl),$04
    ld   hl,l_e341
    ld   (hl),$01
    ret
bank2_call_88D2
;    ld   a,i
;    ld   d,a
;    ld   a,(l_fc00)
;    ld   e,a
;    ld   hl,$0B2E
;88DC: AF            xor  a
;88DD: ED 52         sbc  hl,de
;88DF: 28 02         jr   z,$88E3
;88E1: AF            xor  a
;88E2: DF            rst  $18
    ld   hl,l_f52b
    ld   (hl),$FF
    ld   hl,l_e737
    ld   (hl),$01
    ld   hl,l_e739
    ld   (hl),$00
    ld   hl,l_e341
    ld   (hl),$01
    ret
bank2_call_88F8
    ret
bank2_call_88F9
    call call_0AE3
    set  0,(ix+$2d)
    ret
bank2_call_8901
    call call_0D14
    set  1,(ix+$2d)
    ret
bank2_call_8909
    call call_1387
    set  2,(ix+$2d)
    ret
bank2_call_8911
    call call_24B1
    ld   hl,l_f590
    ld   (hl),$01
    ld   hl,l_e600
    inc  (hl)
    ret
bank2_call_891E
    call bank2_call_A433
    ld   hl,l_f595
    ld   (hl),$01
    set  4,(ix+$2d)
    ld   hl,l_e5ff
    inc  (hl)
    ret
bank2_call_892F
    set  6,(ix+$2d)
    ld   (ix+$28),$10
    ret
bank2_call_8938
    call bank2_call_8901
    call bank2_call_8909
    jp   bank2_call_88F9
bank2_call_8941
    call bank2_call_8901
    call bank2_call_8909
    call bank2_call_88F9
    call bank2_call_87B1
    call bank2_call_87BD
    jp   bank2_call_87C9
bank2_call_8953
    ld   b,$03
    xor  a
    ld   hl,$0000
bank2_call_8959
    add  a,(hl)
    inc  hl
    djnz bank2_call_8959
    sub  $3E
    jr   z,bank2_call_8963
;    push ix
bank2_call_8963
    ld   a,$05
    call call_0008
    ld   hl,l_e341
    ld   (hl),$01
    ld   hl,l_e20d
    ld   a,(l_e76b)
    add  a,a
    add  a,a
    ld   c,a
    ld   b,$00
    call call_0D50
    push ix
    call bank2_call_AA5E
    pop  ix
    ld   hl,l_f5b6
    ld   (hl),$01
    set  5,(ix+$2d)
    ld   hl,l_e602
    inc  (hl)
    ret
bank2_call_898E
    call bank2_call_87B1
    call bank2_call_87BD
    jp   bank2_call_87C9
bank2_call_8997
    ld   hl,l_e720
    ld   (hl),$01
    ld   hl,l_e601
    inc  (hl)
;    ld   a,($0005)
;    ld   de,$00B9
;    sub  d
    ret;  z
    ;pop  af
    ;pop  bc
bank2_call_89AA	
    push ix
    ld   hl,l_f47b
    ld   (hl),$00
    call bank2_call_8DA3
    pop  ix
    ld   hl,l_f47c
    ld   (hl),$01
    ret
bank2_call_89BC
    ld   hl,l_f676
    ld   (hl),$0A
    ret
bank2_call_89C2
    ld   hl,l_f5ac
    ld   (hl),$01
    ret
bank2_call_89C8
    ld   b,$03
    xor  a
    ld   hl,$0000
bank2_call_89CE
    add  a,(hl)
    inc  hl
    djnz bank2_call_89CE
    sub  $3E
    jr   z,bank2_call_89D8
;    push ix
bank2_call_89D8
    push ix
    call bank2_call_8F54
    pop  ix
    ld   hl,l_f4cb
    ld   (hl),$01
    ret
bank2_call_89E5
    ld   hl,l_f46d
    ld   (hl),$0A
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_89F0
    ld   hl,l_f46d
    ld   (hl),$09
    ld   hl,$f46b
    ld   (hl),$01
    ret
bank2_call_89FB
    ld   hl,l_f46d
    ld   (hl),$08
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A06
    ld   hl,l_f46d
    ld   (hl),$07
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A11
    ld   hl,l_f46d
    ld   (hl),$06
    ld   hl,l_f46b
    ld   (hl),$01
;    ld   hl,($0004)
;    ld   de,$00B9
    xor  a
;    sbc  hl,de
    ret ; z
;    exx
;     ex   (sp),hl
;     ret
bank2_call_8A28
    ld   hl,l_f46d
    ld   (hl),$05
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A33
    ld   hl,l_f46d
    ld   (hl),$04
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A3E
    ld   hl,l_f46d
    ld   (hl),$03
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A49
    ld   hl,l_f46d
    ld   (hl),$02
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A54
    ld   hl,l_f46d
    ld   (hl),$01
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A5F
    ld   hl,l_f46d
    ld   (hl),$00
    ld   hl,l_f46b
    ld   (hl),$01
    ret
bank2_call_8A6A
    ld   hl,l_e603
    ld   (hl),$01
    ret
bank2_call_8A70
    ld   hl,l_f464
    ld   (hl),$01
    ld   hl,l_f465
    ld   (hl),$30
    ret
bank2_call_8A7B
    ld   hl,l_f464
    ld   (hl),$01
    ld   hl,l_f465
    ld   (hl),$31
    ret
bank2_call_8A86
    ld   hl,l_f464
    ld   (hl),$01
    ld   hl,l_f465
    ld   (hl),$32
    ret
bank2_call_8A91
    push ix
    call bank2_call_8F54
    pop  ix
    ld   hl,l_f4cb
    ld   (hl),$01
    ld   hl,l_f4cd
    ld   (hl),$01
    ret
bank2_call_8AA3
    ld   hl,l_f44d
    ld   (hl),$01
    ret
bank2_call_8AA9
    ld   hl,l_e612
    ld   (hl),$03
    jp   bank2_call_88BD
bank2_call_8AB1
    ld   hl,l_f448
    ld   (hl),$81
    ret
bank2_call_8AB7
    ld   hl,l_e724
    ld   (hl),$00
    ld   hl,l_e723
    ld   (hl),$29
    ret
bank2_call_8AC2
    ld   hl,l_e724
    ld   (hl),$01
    ld   hl,l_e723
    ld   (hl),$29
    ret
bank2_call_8ACD
    ld   hl,l_e724
    ld   (hl),$02
    ld   hl,l_e723
    ld   (hl),$29
    ret
bank2_call_8AD8
    ld   a,(l_e64b)
    cp   $45
    ret  nc
    ld   b,a
    ld   a,$45
    sub  b
    ld   (l_e350),a
    ld   hl,l_e5dc
    ld   (hl),$1E
    jp   bank2_call_883E
bank2_call_8AED
    push ix
    call bank2_call_8F54
    pop  ix
    ld   hl,l_f4cb
    ld   (hl),$01
    ld   hl,l_f4cd
    ld   (hl),$FF
    ret



bank2_call_8B6B
     ld   a,(l_f466)
     and  a
     jr   nz,bank2_call_8B81
     ld   hl,l_f469
     ld   (hl),$00
     ld   hl,bank2_call_8000
     ld   (l_f467),hl
     ld   hl,l_f466
     ld   (hl),$01
bank2_call_8B81
     ld   de,(l_f467)
     ld   a,(de)
     ld   hl,l_f469
     add  a,(hl)
     ld   (hl),a
     inc  de
     ld   hl,$8401            ;doesn't seem to be an address
     or   a
     sbc  hl,de
     jr   z,bank2_call_8B99			;TODO - Protection??? 
     ld   (l_f467),de
     ret
bank2_call_8B99
     ld   hl,l_f466
     ld   (hl),$00
     ld   a,(l_f46a)
     ld   hl,l_f469
     cp   (hl)
     ret  z
     push hl
     ld   hl,l_f46b
     ld   bc,$000B
     jp   clearbytes;0D50


bank2_call_8BA7
    ld   hl,l_f46b
    ld   bc,$000B
    jp   clearbytes
    
    
bank2_call_8BB0
     ld   a,(l_e5d3)
     and  a
     ret  nz
     ld   a,(l_f46b)
     and  a
     ret  z
     ld   a,(l_ed3d)
     and  a
     ret  nz
     ld   a,(l_f46c)
     bit  0,a
     jp   nz,bank2_call_8C1D
     bit  2,a
     jp   nz,bank2_call_8CA4
     bit  3,a
     jp   nz,bank2_call_8C39
     bit  1,a
     ret  nz
     ld   hl,l_e2e5
     ld   de,$0008
     ld   b,$04
     call call_18A5
     ld   de,bank2_data_8D5C
     ld   hl,l_e2e5
     ld   b,$04
bank2_call_8BE7
     ld   a,(de)
     ld   (hl),a
     inc  de
     inc  hl
     inc  hl
     ld   a,(de)
     ld   (hl),a
     inc  hl
     inc  de
     ld   (hl),$16
     inc  hl
     djnz bank2_call_8BE7
     ld   a,(l_f46d)
     add  a,a
     add  a,a
     ld   hl,bank2_data_8D01
     call adda2hl;$0D89
     ld   a,(l_f46d)
     ld   de,bank2_data_8D2D
     call adda2de;$0D84
     ld   a,(de)
     ld   c,a
     ld   b,$04
     ld   e,$08
     call call_14C0
     ld   c,$1B
     call call_1350
     ld   hl,l_f46c
     ld   (hl),$01
     ret

bank2_call_8C1D     
     ld   hl,l_e2e5
     ld   b,$04
bank2_call_8C22
     dec  (hl)
     dec  (hl)
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     djnz bank2_call_8C22
     call bank2_call_909A
     ld   a,(l_e2e5)
     cp   $28
     ret  nz
     ld   hl,l_f46c
     ld   (hl),$02
     ret
     
bank2_call_8C39
     ld   hl,l_e2e5
     inc  hl
     inc  hl
     ld   a,(hl)
     add  a,$F0
     ld   (hl),a
     inc  hl
     ld   (hl),$16
     inc  hl
     inc  hl
     inc  hl
     ld   a,(hl)
     add  a,$F0
     ld   (hl),a
     inc  hl
     ld   (hl),$16
     inc  hl
     ld   a,(hl)
     add  a,$10
     ld   (hl),a
     inc  hl
     inc  hl
     ld   a,(hl)
     add  a,$10
     ld   (hl),a
     inc  hl
     ld   (hl),$16
     inc  hl
     ld   a,(hl)
     add  a,$10
     ld   (hl),a
     inc  hl
     inc  hl
     ld   a,(hl)
     add  a,$10
     ld   (hl),a
     inc  hl
     ld   (hl),$16
     ld   a,(l_f46d)
     ld   hl,bank2_data_8D38
     call adda2hl;$0D89
     ld   b,(hl)
     ld   c,$1D
     ld   a,(l_f46f)
     and  a
     jr   z,bank2_call_8C7F
     ld   c,$21
bank2_call_8C7F
     ld   a,$08
     call call_147D
     ld   hl,bank2_data_8D43
     ld   b,$03
     ld   c,$1F
     ld   a,(l_f46f)
     and  a
     jr   z,bank2_call_8C93
     ld   c,$23
bank2_call_8C93
     ld   de,$0108
     call call_14C2
     ld   hl,l_f46e
     ld   (hl),$64
     ld   hl,l_f46c
     ld   (hl),$04
     ret


bank2_call_8CA4
     ld   hl,l_f46e
     dec  (hl)
     jr   z,bank2_call_8CB8
     ld   hl,l_e2e5
     ld   b,$04
bank2_call_8CAF
     inc  (hl)
     inc  (hl)
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     djnz bank2_call_8CAF
     ret
bank2_call_8CB8
     ld   hl,l_e2e5
     ld   bc,$0010
     call clearbytes;$0D50
     ld   hl,l_f46b
     ld   (hl),$00
     ret
bank2_call_8CC7     
     ld   a,(l_f46c)
     bit  0,a
     jr   nz,bank2_call_8CD1
     bit  1,a
     ret  z
bank2_call_8CD1
     ld   hl,l_e2e5
     ld   e,(hl)
     inc  hl
     inc  hl
     ld   d,(hl)
     ld   l,e
     ld   a,d
     add  a,$10
     ld   h,a
     ld   bc,$1818
     call call_1447
     ret  nc
     ld   a,(l_f46d)
     ld   hl,bank2_data_8D46
     call call_0DA7
     call call_41EC
     ld   a,(ix+$09)
     ld   (l_f46f),a
     ld   c,$25
     call call_1350
     ld   hl,l_f46c
     ld   (hl),$08
     ret


bank2_data_8D01
    BYTE $6C,$70,$74,$78,$7C,$80,$84,$88,$BC,$C0,$C4,$C8,$AC,$B0,$B4,$B8
    BYTE $9C,$A0,$A4,$A8,$8C,$90,$94,$98,$CC,$D0,$D4,$D8,$4C,$50,$54,$58
    BYTE $EC,$F0,$F4,$F8,$DC,$E0,$E4,$E8,$5C,$60,$64,$68
    
bank2_data_8D2D
    BYTE $2A,$2A,$24,$24
    BYTE $24,$24,$1C,$2A,$1C,$1C,$2A
    
bank2_data_8D38
    BYTE $08,$08,$0C,$0C,$10,$10,$14,$18,$1C
    BYTE $20,$24
    
bank2_data_8D43
    BYTE $EC,$F0,$F4
bank2_data_8D46    
    BYTE $00,$10,$00,$10,$00,$20,$00,$20,$00,$30,$00
    BYTE $30,$00,$40,$00,$50,$00,$60,$00,$70,$00,$80


bank2_data_8D5C
    BYTE $00,$70,$00,$80,$F0,$70,$F0,$80

bank2_call_8D64
     ld  a,(l_f476)
     and  a
     jr   nz,bank2_call_8D7A
     ld   hl,l_f479
     ld   (hl),$00
     ld   hl,$8514
     ld   (l_f477),hl
     ld   hl,l_f476
     ld   (hl),$01
bank2_call_8D7A
     ld   de,(l_f477)
     ld   a,(de)
     ld   hl,l_f479
     add  a,(hl)
     ld   (hl),a
     inc  de
     inc  de
     inc  de
     inc  de
     ld   hl,$A8A8
     or   a
     sbc  hl,de
     jr   z,bank2_call_8D95
     ld   (l_f477),de
     ret
bank2_call_8D95
     ld   hl,l_f476
     ld   (hl),$00
     ld   a,(l_f47a)
     ld   hl,l_f479
     cp   (hl)
     ret  z
     push de
bank2_call_8DA3
     ld   a,(l_e5d3)
     and  a
     ret  nz
     ld   hl,l_f47c
     ld   bc,$004A
     call clearbytes;$0D50
     ld   ix,l_f47e
     xor  a
     ld   b,a
     ld   de,$0006
bank2_call_8DBA
     push af
bank2_call_8DBB
     add  a,a
     add  a,a
     ld   hl,l_e2d5
     call adda2hl;$0D89
     ld   (ix+$03),l
     ld   (ix+$04),h
     inc  hl
     ld   a,d
     call mul32;call_0D6C
     or   e
     ld   (hl),a
     ld   (ix+$07),a
     inc  d
     ld   a,d
     cp   $04
     jr   nz,bank2_call_8DDC
     ld   d,$00
     inc  e
bank2_call_8DDC
     inc  hl
     inc  hl
     ld   a,(l_f47b)
     and  a
     jr   nz,bank2_call_8DE8
     ld   (hl),$12
     jr   bank2_call_8DEA
bank2_call_8DE8
     ld   (hl),$13
bank2_call_8DEA
     ld   (ix+$06),b
     ld   a,b
     add  a,$14
     ld   b,a
     ex   de,hl
     ld   de,$0009
     add  ix,de
     ex   de,hl
     pop  af
     inc  a
     cp   $08
     jr   nz,bank2_call_8DBA
     ret
     
bank2_call_8DFF
     ld   a,(l_f47c)
     and  a
     ret  z
bank2_call_8E04
     ld   a,(l_e5d3)
     and  a
     ret  nz
     ld   hl,l_f47d
     ld   (hl),$00
     ld   ix,l_f47e
     ld   b,$08
bank2_call_8E14
     push bc
     ld   a,(ix+$00)
     bit  0,a
     jp   nz,bank2_call_8E67
     bit  1,a
     jp   nz,bank2_call_8EE9
     dec  (ix+$06)
     jp   nz,bank2_call_8F0C
     ld   a,(l_ed3d)
     and  a
     jp   z,bank2_call_8F0C
     ld   a,(l_e34a)
     and  a
     jp   nz,bank2_call_8F0C
     ld   hl,l_f47d
     bit  0,(hl)
     jp   nz,bank2_call_8F0C
     set  0,(hl)
     call loadhlfromspritestruct;$1529
     ld   (hl),$F0
     inc  hl
     inc  hl
     ld   a,(l_e37f)
     ld   (hl),a
     inc  hl
     res  6,(hl)
     ld   a,r
     and  $01
     ld   (ix+$08),a
     ld   a,(l_e723)
     and  a
     jr   nz,bank2_call_8E60
     ld   c,$1E
     call call_1350
bank2_call_8E60
     set  0,(ix+$00)
     jp   bank2_call_8F0C
bank2_call_8E67
     call loadhl2;call_1537
     call bank2_call_B4B5
     ld   a,(l_f47b)
     and  a
     jr   nz,bank2_call_8E93
     ld   de,$0406
     call frametimer;$15CA
     add  a,a
     add  a,a
     add  a,$C8
     ld   b,a
     ld   c,$2B
     ld   a,(ix+$07)
     bit  0,(ix+$08)
     jr   nz,bank2_call_8E8E
     call call_149C
     jr   bank2_call_8EA6
bank2_call_8E8E
     call call_147D
     jr   bank2_call_8EA6
bank2_call_8E93
     ;break
     ld   de,$0405
     call frametimer;15CA
     add  a,a
     add  a,a
     add  a,$D4
     ld   b,a
     ld   c,$1E
     ld   a,(ix+$07)
     call call_147D
bank2_call_8EA6
     call loadhlfromspritestruct;$1529
     dec  (hl)
     dec  (hl)
     dec  (hl)
     ld   a,(hl)
     cp   $FD
     jp   nc,bank2_call_8EDC
     inc  hl
     inc  hl
     bit  0,(ix+$06)
     jr   nz,bank2_call_8F0C
     bit  0,(ix+$08)
     jr   nz,bank2_call_8EC8
     inc  (hl)
     ld   a,(hl)
     cp   $FE
     jr   c,bank2_call_8F0C
     jr   bank2_call_8EDC
bank2_call_8EC8
     push hl
     dec  (hl)
     jp   p,bank2_call_8ED0
     inc  hl
     set  6,(hl)
bank2_call_8ED0
     pop  hl
     inc  hl
     bit  6,(hl)
     jr   z,bank2_call_8F0C
     dec  hl
     ld   a,(hl)
     cp   $F0
     jr   nc,bank2_call_8F0C
bank2_call_8EDC
     call call_154C
     ld   (ix+$00),$00
     ld   (ix+$06),$01
     jr   bank2_call_8F0C
bank2_call_8EE9
     ld   a,(l_f460)
     ld   (l_e5d6),a
     ld   de,$0250
     call call_2FB3
     ld   (ix+$00),$01
  ;   ld   hl,($0B2E)
  ;   ld   de,$044D
  ;   or   a
  ;   sbc  hl,de
  ;   jp   z,$8E67
     jp    bank2_call_8E67
;8F05: D5            push de
;8F06: E5            push hl
;8F07: C5            push bc
;8F08: DD E5         push ix
;8F0A: FD E5         push iy
bank2_call_8F0C
     ld   de,$0009
     add  ix,de
     pop  bc
     dec  b
     jp   nz,bank2_call_8E14
     ret




bank2_call_8F17    
     ld   a,(l_f4c6)
     and  a
     jr   nz,bank2_call_8F2D
     ld   hl,l_f4c9
     ld   (hl),$00
     ld   hl,$9341
     ld   (l_f4c7),hl
     ld   hl,l_f4c6
     ld   (hl),$01
bank2_call_8F2D
     ld   de,(l_f4c7)
     ld   a,(de)
     ld   hl,l_f4c9
     add  a,(hl)
     ld   (hl),a
     inc  de
     ld   hl,$C000
     or   a
     sbc  hl,de
     jr   z,bank2_call_8F45
     ld   (l_f4c7),de
     ret
bank2_call_8F45
     ld   hl,l_f4c6
     ld   (hl),$00
     ld   a,(l_f4ca)
     ld   hl,l_f4c9
     cp   (hl)
     ret  z
     ex   de,hl
jmphlstop
     jr jmphlstop
     BYTE "jmphlstop"
     jp   (hl)        ;TODO - how does this jump work
bank2_call_8F54
     ld   a,(l_e5d3)
     and  a
     ret  nz
     ld   hl,l_f4cb
     ld   bc,$0043
     call clearbytes;$0D50
     ld   ix,l_f4ce
     xor  a
     ld   b,a
     ld   de,$0006
bank2_call_8F6B
     push af
     add  a,a
     add  a,a
     ld   hl,l_e2d5
     call adda2hl;$0D89
     ld   (ix+$03),l
     ld   (ix+$04),h
     inc  hl
     ld   a,d
     call mul32;call_0D6C
     or   e
     ld   (hl),a
     ld   (ix+$06),a
     inc  d
     ld   a,d
     cp   $04
     jr   nz,bank2_call_8F8D
     ld   d,$00
     inc  e
bank2_call_8F8D
     inc  hl
     inc  hl
     ld   (hl),$13
     ld   (ix+$05),b
     ld   a,b
     add  a,$14
     ld   b,a
     ex   de,hl
     ld   de,$0008
     add  ix,de
     ex   de,hl
     pop  af
     inc  a
     cp   $08
     jr   nz,bank2_call_8F6B
     ret
     
bank2_call_8FA6
     ld   a,(l_f4cb)
     and  a
     ret  z
bank2_call_8FAB
     ld   a,(l_e5d3)
     and  a
     ret  nz
     ld   hl,l_f4cc
     ld   (hl),$00
     ld   ix,l_f4ce
     ld   b,$08
bank2_call_8FBB
     push bc
     ld   a,(ix+$00)
     bit  0,a
     jp   nz,bank2_call_9037
     bit  1,a
     jp   nz,bank2_call_907D
     dec  (ix+$05)
     jp   nz,bank2_call_908F
     ld   a,(l_ed3d)
     and  a
     jp   z,bank2_call_908F
     ld   a,(l_e34a)
     and  a
     jp   nz,bank2_call_908F
     ld   hl,l_f4cc
     bit  0,(hl)
     jp   nz,bank2_call_908F
     set  0,(hl)
     call loadhlfromspritestruct;$1529
     ld   (hl),$F0
     inc  hl
     inc  hl
     ld   a,(l_e37f)
     ld   (hl),a
     inc  hl
     res  6,(hl)
     and  $01
     ld   (ix+$07),a
     ld   a,(l_f4cd)
     and  a
     jp   m,bank2_call_9022
     jr   nz,bank2_call_9011
     ld   a,(l_e380)
     and  $0F
     add  a,a
     add  a,a
     add  a,$4C
     ld   b,a
     ld   c,$27
     jr   bank2_call_9025
bank2_call_9011
     ld   a,(l_e380)
     and  $07
     add  a,a
     ld   hl,data_64F3
     call adda2hl;$0D89
     ld   b,(hl)
     inc  hl
     ld   c,(hl)
     jr   bank2_call_9025
bank2_call_9022
     ld   bc,$EC02		;TODO - check if this should be l_ec02
bank2_call_9025
     ld   a,(ix+$06)
     call call_147D
     ld   c,$1E
     call call_1350
     set  0,(ix+$00)
     jp   bank2_call_908F
bank2_call_9037
     call loadhl2;1537
     call loadhlfromspritestruct;$1529
     dec  (hl)
     dec  (hl)
     dec  (hl)
     ld   a,(hl)
     cp   $FD
     jp   nc,bank2_call_9070
     inc  hl
     inc  hl
     bit  0,(ix+$05)
     jr   nz,bank2_call_908F
     bit  0,(ix+$07)
     jr   nz,bank2_call_905C
     inc  (hl)
     ld   a,(hl)
     cp   $FE
     jr   c,bank2_call_908F
     jr   bank2_call_9070
bank2_call_905C
     push hl
     dec  (hl)
     jp   p,bank2_call_9064
     inc  hl
     set  6,(hl)
bank2_call_9064
     pop  hl
     inc  hl
     bit  6,(hl)
     jr   z,bank2_call_908F
     dec  hl
     ld   a,(hl)
     cp   $F0
     jr   nc,bank2_call_908F
bank2_call_9070
     call call_154C
     ld   (ix+$00),$00
     ld   (ix+$05),$01
     jr   bank2_call_908F
bank2_call_907D
     ld   a,(l_f460)
     ld   (l_e5d6),a
     ld   de,$1000
     call call_2FB3
     ld   (ix+$00),$01
     jr   bank2_call_9037
bank2_call_908F
     ld   de,$0008
     add  ix,de
     pop  bc
     dec  b
     jp   nz,bank2_call_8FBB
     ret
bank2_call_909A
     ld   a,(l_f50e)
     and  a
     jr   nz,bank2_call_90B0
     ld   hl,l_f511
     ld   (hl),$00
     ld   hl,$A670
     ld   (l_f50f),hl
     ld   hl,l_f50e
     ld   (hl),$01
bank2_call_90B0
     ld   de,(l_f50f)
     ld   a,(de)
     ld   hl,l_f511
     add  a,(hl)
     ld   (hl),a
     inc  de
     inc  de
     inc  de
     inc  de
     inc  de
     inc  de
     inc  de
     inc  de
     ld   hl,$B150
     or   a
     sbc  hl,de
     ;jr   z,bank2_call_90CF			;TODO - protection?
     ld   (l_f50f),de
     ret
bank2_call_90CF
     ld   hl,l_f50e
     ld   (hl),$00
     ld   a,(l_f512)
     ld   hl,l_f511
     cp   (hl)
     ;ret  z
     ret
     ;push af




bank2_call_90DD
    ld   hl,l_f513
    ld   bc,$0006
    call clearbytes
    ld   hl,$0258
    ld   (l_f516),hl
    ret
    
bank2_call_90ED
     ld   a,(l_f513)
     and  a
     ret  z
bank2_call_90F2
     ld   a,(l_f514)
     bit  3,a
     ret  nz
     bit  0,a
     jr   nz,bank2_call_912E
     bit  1,a
     jr   nz,bank2_call_9153
     bit  2,a
     jr   nz,bank2_call_917F
     call bank2_call_85AE
     ld   hl,(l_f516)
     dec  hl
     ld   (l_f516),hl
     ld   a,l
     or   h
     ret  nz
     ld   hl,l_e5a2
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ld   hl,l_e2b1
     ld   (hl),e
     inc  hl
     ld   (hl),$29
     inc  hl
     ld   (hl),d
     inc  hl
     ld   (hl),$17
     ld   hl,$0384
     ld   (l_f516),hl
     ld   hl,l_f514
     set  0,(hl)
bank2_call_912E
     ld   hl,(l_f516)
     dec  hl
     ld   (l_f516),hl
     ld   a,l
     or   h
     jr   z,bank2_call_9192
     ld   hl,l_f515
     inc  (hl)
     ld   a,(hl)
     cp   $09
     jr   nz,bank2_call_9144
     ld   (hl),$00
bank2_call_9144
     ld   a,(l_f515)
     add  a,a
     add  a,a
     add  a,$94
     ld   b,a
     ld   c,$26
     ld   a,$29
     jp   call_147D
bank2_call_9153
     ld   hl,(l_f516)
     dec  hl
     ld   (l_f516),hl
     ld   a,l
     or   h
     jr   z,bank2_call_9164
     ld   hl,l_e2b3
     inc  (hl)
     inc  (hl)
     ret
bank2_call_9164
     ld   hl,$003C
     ld   (l_f516),hl
     ld   hl,l_f514
     ld   (hl),$00
     set  2,(hl)
;     ld   hl,$044D
;     ld   bc,($0B2E)
;     xor  a
;     sbc  hl,bc
;     ret  z
     ret
;917C: D9            exx
;917D: 08            ex   af,af'
;917E: E3            ex   (sp),hl
bank2_call_917F					;Gets here when Invincible Heart collected
     ld   hl,(l_f516)
     dec  hl
     ld   (l_f516),hl
     ld   a,l
     or   h
     ret  nz
     ;ld   hl,$0002				;$0002 in ROM contains $5E therefre Bit 3 = 1
     ;bit  3,(hl)
     ;jr   nz,bank2_call_9192
     ;ex   de,hl
;jphlstop2
;    jr jphlstop2			
;     jp   (hl)
bank2_call_9192
     ld   hl,l_e2b1
     ld   bc,$0004
     call clearbytes;$0D50
     ld   hl,l_f514
     ld   (hl),$00
     set  3,(hl)
     ret

bank2_call_91A3
     ld   a,(l_f514)
     bit  0,a
     ret  z
     ld   hl,l_e2b1
     ld   e,(hl)
     inc  hl
     inc  hl
     ld   d,(hl)
     ld   a,e
     add  a,$08
     ld   l,a
     ld   a,d
     add  a,$08
     ld   h,a
     call call_1444
     ret  nc
     push ix
     ld   ix,l_e691
     ld   (ix+$13),$01
     ld   hl,$0384
     ld   (ix+$14),l
     ld   (ix+$15),h
     ld   (ix+$16),$00
     ld   ix,l_e6c3
     ld   (ix+$13),$01
     ld   hl,$0384
     ld   (ix+$14),l
     ld   (ix+$15),h
     ld   (ix+$16),$00
     pop  ix
     ld   a,(ix+$09)
     ld   (l_e5d6),a
     ld   de,$0300
     call call_2FB3
     ld   hl,l_e2b4
     ld   (hl),$13
     ld   b,$7C
     ld   c,$1E
     ld   a,(ix+$09)
     and  a
     jr   z,bank2_call_9207
     ld   c,$22
bank2_call_9207
     ld   a,$29
     call call_147D
     ld   hl,l_f44e
     ld   (hl),$01
     ld   hl,l_f518
     ld   (hl),$01
     ld   hl,l_e341
     ld   (hl),$01
     ld   hl,l_e358
     ld   (hl),$01
     ld   a,$0A
;     ld   ($FA00),a
     ld   hl,$001E
     ld   (l_f516),hl
     ld   hl,l_f514
     ld   (hl),$00
     set  1,(hl)
     ret
     
bank2_call_9233     
     bit  0,(ix+$13)
     ret  z
     bit  1,(ix+$13)
     jr   z,bank2_call_9248
     res  1,(ix+$13)
     ld   de,$0100
     call call_41EC
bank2_call_9248
     ld   l,(ix+$14)
     ld   h,(ix+$15)
     dec  hl
     ld   a,l
     or   h
     jr   z,bank2_call_9295
     ld   (ix+$14),l
     ld   (ix+$15),h
     ld   de,$0078
     xor  a
     sbc  hl,de
     jr   nz,bank2_call_926B
     ld   hl,l_e358
     ld   (hl),$00
     ld   a,$30
;     ld   ($FA00),a
bank2_call_926B
     call bank2_call_8F17
     inc  (ix+$16)
     ld   a,(ix+$16)
     cp   $03
     jr   nz,bank2_call_927F
     ld   (ix+$16),$00
     inc  (ix+$17)
bank2_call_927F
     ld   c,$2E
     bit  0,(ix+$17)
     jr   nz,bank2_call_9291
     ld   c,$1E
     bit  0,(ix+$09)
     jr   z,bank2_call_9291
     ld   c,$22
bank2_call_9291
     ld   (ix+$1a),c
     ret

bank2_call_9295
     ld   c,$1E
     bit  0,(ix+$09)
     jr   z,bank2_call_929F
     ld   c,$22
bank2_call_929F
     ld   (ix+$1a),c
     res  0,(ix+$13)
     ld   hl,l_f44e
     ld   (hl),$00
     ld   hl,l_f518
     ld   (hl),$00
     ld   hl,l_e341
     ld   (hl),$00
     ret



bank2_call_92B6    
    ld   hl,l_f519
    ld   bc,$0003
    call clearbytes
    ld   a,(l_e603)
    and  a
    ret  z
    ld   a,(l_f463)
    and  a
    ret  z
    ld   hl,l_f519
    ld   (hl),$01
    ret

bank2_call_92CF
    ld   a,(l_f519)
    and  a
    ret  z
    ld   a,(l_e6ff)
    and  a
    ret  p
    ld   a,(l_f536)
    cp   $01
    ret  z
    ld   hl,l_f519
    bit  7,(hl)
    jr   nz,bank2_call_92ED
    set  7,(hl)
    ld   c,$28
    call call_1350
bank2_call_92ED
    call call_340B
    ld   hl,l_f51a
    inc  (hl)
    ld   a,(hl)
    cp   $03
    ret  nz
    ld   (hl),$00
    inc  hl
    inc  (hl)
    ld   a,(hl)
    cp   $0A
    jr   z,bank2_call_931F
    bit  0,(hl)
    jr   nz,bank2_call_9312
    ld   hl,$80F0
    ;ld   (l_f9de),hl           ;TODO - palette
    ld   hl,$80F0
    ;ld   (l_f9fe),hl           ;TODO - palette
    ret
bank2_call_9312
     ld   hl,$0000
    ; ld   (l_f9de),hl          ;TODO - palette
     ld   hl,$0000
    ; ld   (l_f9fe),hl          ;TODO - palette
     ret
bank2_call_931F
     ld   hl,l_f519
     ld   (hl),$00
     ld   hl,l_fc88
     dec  hl
     dec  hl
     dec  hl
     bit  0,(hl)
     ret  nz

    

bank2_call_932D
     ld   a,(l_f51c)
     and  a
     jr   nz,bank2_call_9343
     ld   hl,l_f51f
     ld   (hl),$00
     ld   hl,$8015			;TODO - Protection
     ld   (l_f51d),hl
     ld   hl,l_f51c
     ld   (hl),$01
bank2_call_9343
     ld   de,(l_f51d)
     ld   a,(de)
     ld   hl,l_f51f
     add  a,(hl)
     ld   (hl),a
     inc  de
     ld   hl,$8351  ;bank2_data_8351  ;TODO - think this is absolute value
     or   a
     sbc  hl,de
     jr   z,bank2_call_935B
     ld   (l_f51d),de
     ret
bank2_call_935B  
     ld   hl,l_f51c
     ld   (hl),$00
     ld   a,(l_f520)
     ld   hl,l_f51f
     cp   (hl)
     ret  z
     exx
jphlstop3
    jr jphlstop3
     jp   (hl)      ;TODO - is this ever called
bank2_call_936A
    ld   hl,l_f521
    ld   bc,$0005
    jp   clearbytes
    
bank2_call_9373
     ld   a,(l_f521)
     and  a
     ret  z
     ld   a,(l_f522)
     bit  0,a
     jr   nz,bank2_call_93F1
     bit  1,a
     jp   nz,bank2_call_9442
     bit  2,a
     jp   nz,bank2_call_9499
     bit  3,a
     jp   nz,bank2_call_9579
     bit  4,a
     jp   nz,bank2_call_95C7
     bit  5,a
     jp   nz,bank2_call_9615
     ld   hl,l_f524
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6              ;TODO - screen loc - player 1 score area
bank2_call_93A8               ;routine to place VS pick ups
     push bc
     push iy
     ld   b,$0D
bank2_call_93AD
     ;break
     ld   a,(iy+$00)          ;check all 4 squares are free
     or   (iy+$01)
     or   (iy+$02);$40)
     or   (iy+$03);$41)
     or   (iy+$50);$02)
     or   (iy+$51);$03)
     or   (iy+$52);$42)
     or   (iy+$53);$43)
     jr   nz,bank2_call_93D5
     ld   hl,l_e73c
     inc  (hl)
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$AA                              ;VS 3rd mode largest gfx
     call bank2_call_968B
bank2_call_93D5
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_93AD
     pop  iy
	 ld bc,$a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_93A8
     ld   hl,l_f522
     ld   (hl),$00
     set  0,(hl)
     ret
     
bank2_call_93F1
     call bank2_call_96A9
     ld   hl,l_f524
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6    ;TODO - screen loc - player 1 score area
bank2_call_9404
     push bc
     push iy
     ld   b,$0D
bank2_call_9409
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$AA               ;VS mode 3rd largest gfx
     cp   (iy+$00)
     jr   nz,bank2_call_9426
     ld   a,$00
     cp   (iy+$01)
     jr   nz,bank2_call_9426
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$9E               ;VS mode 2nd largest gfx
     call bank2_call_968B
bank2_call_9426
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_9409
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9404
     ld   hl,l_f522
     ld   (hl),$00
     set  1,(hl)
     ret
     
bank2_call_9442     
     call bank2_call_96A9
     ld   hl,l_f524
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6     ;TODO - screen loc  - player 1 score area
bank2_call_9455
     push bc
     push iy
     ld   b,$0D
bank2_call_945A
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$9E
     cp   (iy+$00)
     jr   nz,bank2_call_9477
     ld   a,$00
     cp   (iy+$01)
     jr   nz,bank2_call_9477
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$92               ;VS mode largest gfx
     call bank2_call_968B
bank2_call_9477
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_945A
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9455
     ld   hl,$0708
     ld   (l_f524),hl
     ld   hl,l_f522
     ld   (hl),$00
     set  2,(hl)
     ret

bank2_call_9499
     ld   hl,(l_f524)
     dec  hl
     ld   (l_f524),hl
     ld   a,l
     or   h
     jr   nz,bank2_call_94AC
     ld   hl,l_f522
     ld   (hl),$00
     set  3,(hl)
     ret
bank2_call_94AC
     ld   ix,l_e691
     bit  0,(ix+$00)
     jr   z,bank2_call_94C6
     call bank2_call_94EF
     jr   nc,bank2_call_94C6
     ld   hl,l_e73a
     inc  (hl)
     ld   hl,l_e5d6
     ld   (hl),$00
     jr   bank2_call_94DC
bank2_call_94C6
     ld   ix,l_e6c3
     bit  0,(ix+$00)
     ret  z
     call bank2_call_94EF
     ret  nc
     ld   hl,l_e73b
     inc  (hl)
     ld   hl,l_e5d6
     ld   (hl),$01
bank2_call_94DC
     ld   de,$0050
     call call_2FB3
     ld   c,$11
     call call_1350
     ld   hl,l_fc86
     dec  hl
     ld   a,(hl)
     sub  $37
     ret  z
bank2_call_94EF
     call call_1530
     inc  l
     call call_16C5
     inc  hl
     ld   a,(hl)
     cp   $00
     jr   nz,bank2_call_950C
     dec  hl
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$92               ;VS mode largest gfx
     ld   b,$04
bank2_call_9506
     cp   (hl)                ;check to see if collected
     jr   z,bank2_call_950E
     inc  a
     djnz bank2_call_9506




bank2_call_950C
     xor  a
     ret
bank2_call_950E
     push hl
     pop  iy
     xor  a
     ld   (iy+$00),a
     ld   (iy+$01),a
     ld   a,b
     cp   $04
     jr   z,bank2_call_953A
     cp   $03
     jr   z,bank2_call_954F
     cp   $02
     jr   z,bank2_call_9564
     xor  a
     ld   (iy-$4f),a;$01),a
     ld   (iy-$50),a;$02),a
     ld   (iy-$01),a;$3f),a
     ld   (iy-$02),a;$40),a
     ld   (iy-$51),a;$41),a
     ld   (iy-$52),a;$42),a
     scf
     ret
     
bank2_call_953A
     xor  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$01),a;$40),a
     ld   (iy+$02),a;$41),a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),a;$43),a
     scf
     ret

bank2_call_954F
     xor  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$4e),a;-$3d),a
     ld   (iy+$4f),a;-$3e),a
     ld   (iy-$01),a;$3f),a
     ld   (iy-$02),a;$40),a
     scf
     ret

bank2_call_9564
     xor  a
     ld   (iy-$50),a;$02),a
     ld   (iy-$4f),a;$01),a
     ld   (iy-$4d),a;+$3e),a
     ld   (iy-$4e),a;+$3f),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     scf
     ret


bank2_call_9579
     ld   hl,l_f524
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6      ;TODO - screen loc  - Player 1 score location
bank2_call_9589
     push bc
     push iy
     ld   b,$0D
bank2_call_958E
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$92
     cp   (iy+$00)
     jr   nz,bank2_call_95AB
     ld   a,$00
     cp   (iy+$01)
     jr   nz,bank2_call_95AB
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$9E               ;VS mode 2nd largest gfx
     call bank2_call_968B
bank2_call_95AB
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_958E
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9589
     ld   hl,l_f522
     ld   (hl),$00
     set  4,(hl)
     ret

bank2_call_95C7
     ld   hl,l_f524
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6          ;TODO - screen loc  - player 1 score location
bank2_call_95D7
     push bc
     push iy
     ld   b,$0D
bank2_call_95DC
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$9E
     cp   (iy+$00)
     jr   nz,bank2_call_95F9
     ld   a,$00
     cp   (iy+$01)
     jr   nz,bank2_call_95F9
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$AA               ;VS mode 3rd largest gfx
     call bank2_call_968B
bank2_call_95F9
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_95DC
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_95D7
     ld   hl,l_f522
     ld   (hl),$00
     set  5,(hl)
     ret

bank2_call_9615
     ld   hl,l_f524
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6      ;TODO screen loc		- player 1 score location
bank2_call_9625
     push bc
     push iy
     ld   b,$0D
bank2_call_962A
     ld   a,(l_f523)
     add  a,a
     add  a,a
     add  a,$AA               ;VS mode largest gfx
     cp   (iy+$00)
     jr   nz,bank2_call_9656
     ld   a,$00
     cp   (iy+$01)
     jr   nz,bank2_call_9656
     xor  a
     ld   (iy+$00),a
     ld   (iy+$01),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),a;$43),a
bank2_call_9656
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_962A
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9625
     ld   hl,l_f521
     ld   (hl),$00
     ld   hl,l_f522
     ld   (hl),$00
     ld   a,(l_e73e)
     and  a
     ret  nz
     ld   a,$05
     call call_0008; $08
     ld   hl,l_e20d
     ld   bc,$0060
     call clearbytes;$0D50
     ld   hl,l_e738
     ld   (hl),$02
     ret
     
bank2_call_968B
     ld   l,$00
     ld   (iy+$00),a
     ld   (iy+$01),l
     inc  a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),l;$41),l
     inc  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),l;$03),l
     inc  a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),l;$43),l
     ret
bank2_call_96A9
     ld   a,(l_f526)
     and  a
     jr   nz,bank2_call_96BF
bank2_call_96AF
     ld   hl,l_f529
     ld   (hl),$00
     ld   hl,$8000				;TODO - Protection
     ld   (l_f527),hl
     ld   hl,l_f526
     ld   (hl),$01
bank2_call_96BF
     ld   de,(l_f527)
     ld   a,(de)
     ld   hl,l_f529
     add  a,(hl)
     ld   (hl),a
     inc  de
     inc  de
     ld   hl,$8FCC				;TODO - Protection
     or   a
     sbc  hl,de
;testprot2
;	 jp testprot2
     jr   z,bank2_call_96D8
     ld   (l_f527),de
     ret
bank2_call_96D8
     ld   hl,l_f526
     ld   (hl),$00
     ld   a,(l_f52a)
     ld   hl,l_f529
     cp   (hl)
     ret  z
     push de
bank2_call_96E6
    ld   hl,l_f52b
    ld   bc,$0006
    jp   clearbytes   
    
bank2_call_96EF
     ld   a,(l_f52b)
     and  a
     ret  z
     ld   a,(l_f52c)
     bit  0,a
     jr   nz,bank2_call_975E
     bit  1,a
     jp   nz,bank2_call_97C2
     bit  2,a
     jp   nz,bank2_call_98FD
     bit  3,a
     jp   nz,bank2_call_9953
     ld   hl,l_f52d
     inc  (hl)
     ld   a,(hl)
     cp   $03
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6  ;TODO  Screen loc		- player 1 score location
bank2_call_971A
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_971F
     ;break
     ld   a,(iy+$00)          ;check if 4 blank squares
     or   (iy+$01)
     or   (iy+$02);$40)
     or   (iy+$03);$41)
     or   (iy+$50);$02)
     or   (iy+$51);$03)
     or   (iy+$52);$42)
     or   (iy+$53);$43)
     jr   nz,bank2_call_9742
     ld   hl,l_e73c
     inc  (hl)
     ld   a,$34                    ;Musical Notes
     call bank2_call_99C4
bank2_call_9742
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_971F
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_971A
     ld   hl,l_f52c
     ld   (hl),$00
     set  0,(hl)
     ret

bank2_call_975E
     ld   hl,l_f52d
     inc  (hl)
     ld   a,(hl)
     cp   $03
     ret  nz
     ld   (hl),$00
     ld   hl,l_f530
     inc  (hl)
     ld   a,(hl)
     cp   $07
     jr   z,bank2_call_97AF
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6    ;TODO - Screen loc		- player 1 score location
bank2_call_9777
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_977C
     ld   a,(l_f530)
     dec  a
     add  a,a
     add  a,a
     add  a,$34
     cp   (iy+$00)
     jr   nz,bank2_call_979A
     ld   a,$71;1D
     cp   (iy+$01)
     jr   nz,bank2_call_979A
     ld   a,(l_f530)
     add  a,a
     add  a,a
     add  a,$34
     call bank2_call_99C4
bank2_call_979A
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_977C
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9777
     ret

bank2_call_97AF
     ld   hl,$0708
     ld   (l_f52e),hl
     ld   hl,l_f530
     ld   (hl),$00
     ld   hl,l_f52c
     ld   (hl),$00
     set  1,(hl)
     ret
bank2_call_97C2
     ld   hl,(l_f52e)
     dec  hl
     ld   (l_f52e),hl
     ld   a,l
     or   h
     jp   z,bank2_call_9863
     ld   hl,l_f52d
     inc  (hl)
     ld   a,(hl)
     cp   $03
     jr   nz,bank2_call_9827
     ld   (hl),$00
     ld   hl,l_f530
     inc  (hl)
     ld   a,(hl)
     cp   $06
     jr   nz,bank2_call_97E4
     ld   (hl),$00
bank2_call_97E4
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6  ;TODO - screen loc	- player 1 score location
bank2_call_97EA
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_97EF
     ld   a,(l_f530)
     dec  a
     jp   p,bank2_call_97F8
     ld   a,$05
bank2_call_97F8
     add  a,a
     add  a,a
     add  a,$4C
     cp   (iy+$00)
     jr   nz,bank2_call_9812
     ld   a,$71;1D
     cp   (iy+$01)
     jr   nz,bank2_call_9812
     ld   a,(l_f530)
     add  a,a
     add  a,a
     add  a,$4C
     call bank2_call_99C4
bank2_call_9812
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_97EF
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_97EA
     ret
     
bank2_call_9827
     ld   ix,l_e691
     bit  0,(ix+$00)
     jr   z,bank2_call_9841
     call bank2_call_9873
     jr   nc,bank2_call_9841
     ld   hl,l_e73a
     inc  (hl)
     ld   hl,l_e5d6
     ld   (hl),$00
     jr   bank2_call_9857
bank2_call_9841
     ld   ix,l_e6c3
     bit  0,(ix+$00)
     ret  z
     call bank2_call_9873
     ret  nc
     ld   hl,l_e73b
     inc  (hl)
     ld   hl,l_e5d6
     ld   (hl),$01
bank2_call_9857
     ld   de,$0050
     call call_2FB3
     ld   c,$11
     call call_1350
     ret

     
bank2_call_9863
     ld   a,(l_f530)
     add  a,$07
     ld   (l_f530),a
     ld   hl,l_f52c
     ld   (hl),$00
     set  2,(hl)
     ret
     
bank2_call_9873
     call call_1530
     inc  l
     call call_16C5
     inc  hl
     ld   a,(hl)
     cp   $71;$1D                  ;changed
     jr   nz,bank2_call_9890
     dec  hl
     ld   a,(l_f530)
     add  a,a
     add  a,a
     add  a,$4C
     ld   b,$04
bank2_call_988A
     cp   (hl)
     jr   z,bank2_call_9892
     inc  a
     djnz bank2_call_988A
bank2_call_9890
     xor  a
     ret
bank2_call_9892
     push hl
     pop  iy
     xor  a
     ld   (iy+$00),a
     ld   (iy+$01),a
     ld   a,b
     cp   $04
     jr   z,bank2_call_98BE
     cp   $03
     jr   z,bank2_call_98D3
     cp   $02
     jr   z,bank2_call_98E8
     xor  a
     ld   (iy-$4f),a;$01),a
     ld   (iy-$50),a;$02),a
     ld   (iy-$01),a;$3f),a
     ld   (iy-$02),a;$40),a
     ld   (iy-$51),a;$41),a
     ld   (iy-$52),a;$42),a
     scf
     ret
bank2_call_98BE
     xor  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),a;$43),a
     scf
     ret
bank2_call_98D3
     xor  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$4e),a;-$3d),a
     ld   (iy+$4f),a;-$3e),a
     ld   (iy-$01),a;$3f),a
     ld   (iy-$02),a;$40),a
     scf
     ret
bank2_call_98E8
     xor  a
     ld   (iy-$50),a;$02),a
     ld   (iy-$4f),a;$01),a
     ld   (iy+$4e),a;$3e),a
     ld   (iy+$4f),a;$3f),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     scf
     ret



bank2_call_98FD
     ld   hl,l_f52d
     inc  (hl)
     ld   a,(hl)
     cp   $03
     ret  nz
     ld   (hl),$00
     ld   hl,l_f530
     dec  (hl)
     jr   z,bank2_call_994B
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6      ;TODO - Screen loc  - player 1 score location
bank2_call_9913
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_9918
     ld   a,(l_f530)
     add  a,a
     add  a,a
     add  a,$34
     cp   (iy+$00)
     jr   nz,bank2_call_9936
     ld   a,$71;1D
     cp   (iy+$01)
     jr   nz,bank2_call_9936
     ld   a,(l_f530)
     dec  a
     add  a,a
     add  a,a
     add  a,$34
     call bank2_call_99C4
bank2_call_9936
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_9918
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9913
     ret


bank2_call_994B
     ld   hl,l_f52c
     ld   (hl),$00
     set  3,(hl)
     ret
bank2_call_9953
     ld   hl,l_f52d
     inc  (hl)
     ld   a,(hl)
     cp   $03
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6  ;TODO - Screen Loc   - player 1 score location
bank2_call_9963
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_9968
     ld   a,$34                    ;musical notes
     cp   (iy+$00)
     jr   nz,bank2_call_998F
     ld   a,$71;1D
     cp   (iy+$01)
     jr   nz,bank2_call_998F
     xor  a
     ld   (iy+$00),a               
     ld   (iy+$01),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),a;$43),a
bank2_call_998F
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_9968
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9963
     ld   hl,l_f52b
     ld   (hl),$00
     ld   hl,l_f52c
     ld   (hl),$00
     ld   a,(l_e73e)
     and  a
     ret  nz
     ld   a,$05
     call call_0008;rst  $08
     ld   hl,l_e20d
     ld   bc,$0060
     call clearbytes;$0D50
     ld   hl,l_e738
     ld   (hl),$02
     ret
bank2_call_99C4               ;draw musical notes
     ld   l,$71;1D
     ld   (iy+$00),a
     ld   (iy+$01),l
     inc  a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),l;$41),l
     inc  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),l;$03),l
     inc  a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),l;$43),l
     ret


bank2_call_99E2
    ld   hl,l_f531
    ld   bc,$0005
    jp   clearbytes
    
bank2_call_99EB
     ld   a,(l_f531)
     and  a
     ret  z
     ld   a,(l_f532)
     bit  0,a
     jr   nz,bank2_call_9A5A
     bit  1,a
     jp   nz,bank2_call_9AC4
     bit  2,a
     jp   nz,bank2_call_9B98
     bit  3,a
     jp   nz,bank2_call_9BEE
     ld   hl,l_f533
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6      ;TODO - Screen loc  - player 1 score location
bank2_call_9A16
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_9A1B               ;check all 4 squares are free
     ;break
     ld   a,(iy+$00)
     or   (iy+$01)
     or   (iy+$02);$40)
     or   (iy+$03);$41)
     or   (iy+$50);$02)
     or   (iy+$51);$03)
     or   (iy+$52);$42)
     or   (iy+$53);$43)
     jr   nz,bank2_call_9A3E
     ld   hl,l_e73c
     inc  (hl)
     ld   a,$1C                    ;rainbows
     call bank2_call_9C5F
bank2_call_9A3E
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_9A1B
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9A16
     ld   hl,l_f532
     ld   (hl),$00
     set  0,(hl)
     ret
bank2_call_9A5A
     ld   hl,l_f533
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   hl,l_f535
     inc  (hl)
     ld   a,(hl)
     cp   $06
     jr   z,bank2_call_9AAB
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6      ;TODO - screen loc   - player 1 score location
bank2_call_9A73
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_9A78
     ld   a,(l_f535)
     dec  a
     add  a,a
     add  a,a
     add  a,$1C				;rainbows
     cp   (iy+$00)
     jr   nz,bank2_call_9A96
     ld   a,$71;1D
     cp   (iy+$01)
     jr   nz,bank2_call_9A96
     ld   a,(l_f535)
     add  a,a
     add  a,a
     add  a,$1C				;rainbows
     call bank2_call_9C5F
bank2_call_9A96
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_9A78
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9A73
     ret
     
bank2_call_9AAB
     ld   hl,$0708
     ld   (l_f533),hl
     ld   hl,l_f532
     ld   (hl),$00
     set  1,(hl)
;9AB8: 21 4D 04      ld   hl,$044D
;9ABB: ED 5B 2E 0B   ld   de,($0B2E)
;9ABF: AF            xor  a
;9AC0: ED 52         sbc  hl,de
;9AC2: C8            ret  z
;9AC3: F5            push af
     ret
     
bank2_call_9AC4
     ld   hl,(l_f533)
     dec  hl
     ld   (l_f533),hl
     ld   a,l
     or   h
     jr   nz,bank2_call_9AD7
     ld   hl,l_f532
     ld   (hl),$00
     set  2,(hl)
     ret
     
bank2_call_9AD7
     ld   ix,l_e691
     bit  0,(ix+$00)
     jr   z,bank2_call_9AF1
     call bank2_call_9B13
     jr   nc,bank2_call_9AF1
     ld   hl,l_e73a
     inc  (hl)
     ld   hl,l_e5d6
     ld   (hl),$00
     jr   bank2_call_9B07
bank2_call_9AF1
     ld   ix,l_e6c3
     bit  0,(ix+$00)
     ret  z
     call bank2_call_9B13
     ret  nc
     ld   hl,l_e73b
     inc  (hl)
     ld   hl,l_e5d6
     ld   (hl),$01
bank2_call_9B07
     ld   de,$0050
     call call_2FB3
     ld   c,$11
     call call_1350
     ret

bank2_call_9B13
     call call_1530
     inc  l
     call call_16C5
     inc  hl
     ld   a,(hl)
     cp   $71;1D                   ;changed
     jr   nz,bank2_call_9B2B
     dec  hl
     ld   a,$30
     ld   b,$04
bank2_call_9B25
     cp   (hl)
     jr   z,bank2_call_9B2D
     inc  a
     djnz bank2_call_9B25
bank2_call_9B2B
     xor  a
     ret
bank2_call_9B2D
     push hl
     pop  iy
     xor  a
     ld   (iy+$00),a
     ld   (iy+$01),a
     ld   a,b
     cp   $04
     jr   z,bank2_call_9B59
     cp   $03
     jr   z,bank2_call_9B6E
     cp   $02
     jr   z,bank2_call_9B83
     xor  a
     ld   (iy-$4f),a;$01),a
     ld   (iy-$50),a;$02),a
     ld   (iy-$01),a;$3f),a
     ld   (iy-$02),a;$40),a
     ;ld   (iy-$a1),a;$41),a		;todo - check these!
     ;ld   (iy-$a2),a;$42),a
     scf
     ret
bank2_call_9B59
     xor  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),a;$43),a
     scf
     ret
bank2_call_9B6E
     xor  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy-$52),a;$3d),a
     ld   (iy-$51),a;$3e),a
     ld   (iy-$01),a;$3f),a
     ld   (iy-$02),a;$40),a
     scf
     ret
bank2_call_9B83
     xor  a
     ld   (iy-$50),a;$02),a
     ld   (iy-$4f),a;$01),a
     ld   (iy-$4e),a;+$3e),a
     ld   (iy-$4d),a;+$3f),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     scf
     ret

bank2_call_9B98
     ld   hl,l_f533
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   hl,l_f535
     dec  (hl)
     jr   z,bank2_call_9BE6
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6      ;TODO - screen loc   - player 1 score location
bank2_call_9BAE
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_9BB3
     ld   a,(l_f535)
     add  a,a
     add  a,a
     add  a,$1C					;rainbows
     cp   (iy+$00)
     jr   nz,bank2_call_9BD1
     ld   a,$71;1D
     cp   (iy+$01)
     jr   nz,bank2_call_9BD1
     ld   a,(l_f535)
     dec  a
     add  a,a
     add  a,a
     add  a,$1C					;rainbows
     call bank2_call_9C5F
bank2_call_9BD1
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_9BB3
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9BAE
     ret
bank2_call_9BE6
     ld   hl,l_f532
     ld   (hl),$00
     set  3,(hl)
     ret
     
bank2_call_9BEE
     ld   hl,l_f533
     inc  (hl)
     ld   a,(hl)
     cp   $05
     ret  nz
     ld   (hl),$00
     ld   b,$0B
     ld   iy,SCREEN_REF;$CDC6          ;TODO - screen loc   - player 1 score location
bank2_call_9BFE
     push bc
     push iy
     ;break
     ld   b,$0D
bank2_call_9C03
     ld   a,$1C							;TODO - change to $70 if gfx attribute
     cp   (iy+$00)
     jr   nz,bank2_call_9C2A
     ld   a,$71;1D
     cp   (iy+$01)
     jr   nz,bank2_call_9C2A
     xor  a
     ld   (iy+$00),a
     ld   (iy+$01),a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),a;$41),a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),a;$03),a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),a;$43),a
bank2_call_9C2A
     ld   de,$4;$0080
     add  iy,de
     djnz bank2_call_9C03
     pop  iy
	 ld bc,$00a0
	 add iy,bc
     pop  bc
     ;inc  iy
     ;inc  iy
     ;inc  iy
     ;inc  iy
     djnz bank2_call_9BFE
     ld   hl,l_f531
     ld   (hl),$00
     ld   hl,l_f532
     ld   (hl),$00
     ld   a,(l_e73e)
     and  a
     ret  nz
     ld   a,$05
     call call_0008;rst  $08
     ld   hl,l_e20d
     ld   bc,$0060
     call clearbytes;0D50
     ld   hl,l_e738
     ld   (hl),$02
     ret

bank2_call_9C5F     
     ld   l,$71;$1D
     ld   (iy+$00),a
     ld   (iy+$01),l
     inc  a
     ld   (iy+$02),a;$40),a
     ld   (iy+$03),l;$41),l
     inc  a
     ld   (iy+$50),a;$02),a
     ld   (iy+$51),l;$03),l
     inc  a
     ld   (iy+$52),a;$42),a
     ld   (iy+$53),l;$43),l
     ret
     
bank2_call_9C7D
    ld   hl,l_f536
    ld   bc,$0015
    call clearbytes;$0D50
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e34f)
    and  a
    ret  nz
    ld   a,(l_e5f5)
    ld   hl,bank2_data_9D2E
    call adda2hl;$0D89
    ld   a,(l_e64b)
    cp   (hl)
    ret  c
    ld   hl,l_e20d
    ld   bc,$0078
    call clearbytes;$0D50
    ld   hl,l_e20d
    ld   de,$0000
    ld   b,$0F
    call call_18A5
    ld   hl,l_e249
    ld   de,$0004
    ld   b,$0F
    call call_18A5
    ld   de,bank2_data_9E94
    ld   hl,l_e20d
    ld   b,$1E
bank2_call_9CC5
    ld   a,(de)
    ld   (hl),a
    inc  de
    inc  hl
    inc  hl
    ld   a,(de)
    ld   (hl),a
    inc  de
    inc  hl
    ld   a,(de)
    ld   (hl),a
    inc  de
    inc  hl
    djnz bank2_call_9CC5
    ld   ix,l_f537
    ld   (ix+$07),$00
    ld   (ix+$09),$00
    ld   hl,l_e20d
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   hl,bank2_data_9F16        ;BYTE $04,$08,$0C,$10,$14,$18
    ld   c,$1C                     ;this is gfx for left hand 'HELP!!'
    ld   b,$06                     ;6 16x16 sprites
    ld   e,$01                     ;sprites 1,33,65,97,2,34
    call call_14C0            
    ld   b,$34                     ;lefthand sweat mark!
    ld   c,$1C
    ld   a,$43                     ;sprite 67
    call call_147D
    ld   ix,l_f541
    ld   (ix+$07),$04
    ld   (ix+$09),$01
    ld   hl,l_e249
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   hl,bank2_data_9F1C        ;BYTE $1C,$20,$24,$28,$2C,$30
    ld   c,$1C                     ;this is gfx for right hand 'HELP!!'
    ld   b,$06                     ;6 16x16 sprites
    ld   e,$05                     ;sprites 5,37,69,101,6,38
    call call_14C0
    ld   b,$38                     ;righthand sweat mark!
    ld   c,$1C
    ld   a,$47                     ;sprite 71
    call call_147D
    ld   hl,l_f536
    ld   (hl),$01
    ret


bank2_data_9D2E
    BYTE $0F,$1F,$2F,$3F,$4F,$5F,$FF
    

bank2_call_9D35
     ld   a,(l_f536)
     and  a
     ret  z
     ret  m
     ;break               ;big monsters holding hostages
     ld   ix,l_f537
     ld   b,$02
bank2_call_9D41
     push bc
     bit  2,(ix+$00)
     jp   nz,bank2_call_9E64
     call bank2_call_A2C0
     ld   de,$0508
     call frametimer;call_15CA
     bit  0,(ix+$09)
     jr   nz,bank2_call_9DAC
     ld   a,(ix+$05)
     ld   hl,bank2_data_9EEE
     call adda2hl;$0D89
     ld   a,(hl)
     add  a,a
     add  a,a
     ld   hl,bank2_data_9F06       ;BYTE $6C,$70,$84,$88,$74,$78,$8C,$90
     call adda2hl;$0D89            ;alternating captive bubble gfx
     ld   c,$0F
     ld   b,$04                    ;4 16x16 sprites
     ld   e,$00                    ;sprites 0, 32, 64, 96
     call call_14C0
     ld   hl,bank2_data_9EF6       ;BYTE $00,$00,$01,$01,$02,$02,$03,$03
     ld   a,(l_e5f5)
     cp   $03
     jr   c,bank2_call_9D80
     ld   hl,bank2_data_9EFE       ;BYTE $00,$00,$01,$01,$00,$00,$01,$01
bank2_call_9D80
     ld   a,(ix+$05)
     call adda2hl;0D89
     ld   a,(hl)
     add  a,a
     add  a,a
     push af
     ld   a,(l_e5f5)
     ld   hl,bank2_data_9F22
     call call_0DA7 ;double a, add to HL and load contents of HL into DE
     ex   de,hl     ;hl now has start of big enemy gfx data
     pop  af
     call adda2hl;$0D89
     ld   c,$1C
     ld   a,(l_e5f5)
     cp   $03
     jr   c,bank2_call_9DA3
     ld   c,$1D
bank2_call_9DA3
     ld   b,$04
     ld   d,$02
     ld   e,$02
     call call_14C2      ;update the big enemy of level 16
bank2_call_9DAC
     ld   a,(ix+$05)
     ld   hl,bank2_data_9EEE
     call adda2hl;$0D89
     ld   a,(hl)
     add  a,a
     add  a,a
     ld   hl,bank2_data_9F0E
     call adda2hl;0D89
     ld   c,$1B
     ld   b,$04
     ld   e,$04
     call call_14C0
     ld   hl,bank2_data_9EF6
     ld   a,(l_e5f5)
     cp   $03
     jr   c,bank2_call_9DD4
     ld   hl,bank2_data_9EFE
bank2_call_9DD4
    ld   a,(ix+$05)
    call adda2hl;$0D89
    ld   a,(hl)
    add  a,a
    add  a,a
    push af
    ld   a,(l_e5f5)
    ld   hl,bank2_data_9F22
    call call_0DA7
    ex   de,hl
    pop  af
    call adda2hl;$0D89
    ld   c,$1C
    ld   a,(l_e5f5)
    cp   $03
    jr   c,bank2_call_9DF7
    ld   c,$1D
bank2_call_9DF7
    ld   b,$04
    ld   d,$02
    ld   e,$06
    call call_14E6
    bit  1,(ix+$00)
    jr   z,bank2_call_9E1A
    inc  (ix+$08)
    ld   a,(ix+$08)
    cp   $78
    jr   nz,bank2_call_9E64
    set  0,(ix+$00)
    res  1,(ix+$00)
    jr   bank2_call_9E64
bank2_call_9E1A
    bit  0,(ix+$00)
    jr   nz,bank2_call_9E42
    ld   a,(l_fc85)
    and  $30
    jr   nz,bank2_call_9E28
    push de
bank2_call_9E28
    ld   b,$0F
    call loadhlfromspritestruct;$1529
bank2_call_9E2D
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz bank2_call_9E2D
    call loadhlfromspritestruct;$1529
    ld   a,(hl)
    cp   $70
    jr   nz,bank2_call_9E64
    set  1,(ix+$00)
    jr   bank2_call_9E64
bank2_call_9E42
    ld   b,$0F
    call loadhlfromspritestruct;$1529
bank2_call_9E47
    ld   a,(hl)
    cp   $F0
    jr   z,bank2_call_9E4D
    dec  (hl)
bank2_call_9E4D
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz bank2_call_9E47
    call loadhlfromspritestruct;$1529
    ld   a,$28
    call adda2hl;$0D89
    ld   a,(hl)
    cp   $F0
    jr   nz,bank2_call_9E64
    set  2,(ix+$00)
bank2_call_9E64
    ld   de,$000A
    add  ix,de
    pop  bc
    dec  b
    jp   nz,bank2_call_9D41
    ld   hl,l_f541
    bit  2,(hl)
    ret  z
    ld   hl,l_e20d
    ld   bc,$0078
    call clearbytes;0D50
    ld   hl,l_e5f5
    inc  (hl)
    ld   hl,l_f536
    ld   (hl),$FF
 ;   ld   a,i
 ;   ld   h,a
 ;   ld   a,($FC00)
 ;   ld   l,a
 ;   ld   de,$0B2E
 ;   or   a
 ;   sbc  hl,de
 ;   ret  z
    ret

bank2_data_9E94    
    BYTE $00,$28,$16,$00,$38,$16,$F0,$28,$16,$F0,$38,$16,$00,$48,$17,$00
    BYTE $58,$17,$00,$68,$17,$F0,$48,$17,$F0,$58,$17,$F0,$68,$17,$18,$28
    BYTE $17,$18,$38,$17,$08,$28,$17,$08,$38,$17,$18,$48,$17,$00,$B8,$16
    BYTE $00,$C8,$16,$F0,$B8,$16,$F0,$C8,$16,$00,$88,$17,$00,$98,$17,$00
    BYTE $A8,$17,$F0,$88,$17,$F0,$98,$17,$F0,$A8,$17,$18,$C8,$17,$18,$B8
    BYTE $17,$08,$C8,$17,$08,$B8,$17,$18,$A8,$17

bank2_data_9EEE    
    BYTE $00,$01,$00,$01,$00,$01
    BYTE $00,$01
    
bank2_data_9EF6
    BYTE $00,$00,$01,$01,$02,$02,$03,$03
    
bank2_data_9EFE
    BYTE $00,$00,$01,$01,$00,$00,$01,$01
    
bank2_data_9F06
    BYTE $6C,$70,$84,$88,$74,$78,$8C,$90
    
bank2_data_9F0E
    BYTE $04,$08,$1C,$20,$0C,$10,$24,$28

bank2_data_9F16    
    BYTE $04,$08,$0C,$10,$14,$18        ;lefthand 'HELP!!'
    
bank2_data_9F1C
    BYTE $1C,$20,$24,$28,$2C,$30        ;righthand 'HELP!!'
    
bank2_data_9F22
    BYTE LOW bank2_data_9F2E, HIGH bank2_data_9F2E
    BYTE LOW bank2_data_9F3E, HIGH bank2_data_9F3E
    BYTE LOW bank2_data_9F4E, HIGH bank2_data_9F4E
    BYTE LOW bank2_data_9F5E, HIGH bank2_data_9F5E
    BYTE LOW bank2_data_9F66, HIGH bank2_data_9F66
    BYTE LOW bank2_data_9F6E, HIGH bank2_data_9F6E
bank2_data_9F2E
    BYTE $3C,$40,$44,$48,$4C,$50,$54,$58,$5C,$60,$64,$68,$6C,$70,$74,$78
bank2_data_9F3E
    BYTE $7C,$80,$84,$88,$8C,$90,$94,$98,$9C,$A0,$A4,$A8,$AC,$B0,$B4,$B8
bank2_data_9F4E
    BYTE $BC,$C0,$C4,$C8,$CC,$D0,$D4,$D8,$DC,$E0,$E4,$E8,$EC,$F0,$F4,$F8
bank2_data_9F5E
    BYTE $04,$08,$0C,$10,$14,$18,$1C,$20
bank2_data_9F66
    BYTE $24,$28,$2C,$30,$34,$38,$3C,$40
bank2_data_9F6E
    BYTE $44,$48,$4C,$50,$54,$58,$5C,$60


bank2_call_9F76
    ld   hl,l_f54b
    ld   bc,$0040
    jp   clearbytes
    
    
bank2_call_9F7F
     ld   a,(l_f590)
     and  a
     ret  nz
     ld   a,(l_e723)
     and  a
     ret  nz
     ld   ix,l_f54b
     bit  0,(ix+$00)
     jp   nz,bank2_call_9FD9
     ld   hl,l_f557
     ld   a,(hl)
     cp   $01
     ret  nz
     ld   (ix+$04),l
     ld   (ix+$05),h
     ld   (hl),$FF
     inc  hl
     ld   a,(hl)
     and  $F8
     ld   (ix+$01),a
     inc  hl
     ld   a,(hl)
     and  $F8
     ld   (ix+$02),a
     inc  hl
     ld   a,(hl)
     and  $01
     ld   (ix+$03),a
     ld   (ix+$0b),a
     ld   hl,l_f558
     ld   b,$32			;reset water structure to inactive
bank2_call_9FC0
     ld   (hl),$FF
     inc  hl
     djnz bank2_call_9FC0
     ld   c,$1E
     call call_1350
     xor  a
     ld   (ix+$06),a
     ld   (ix+$07),a
     ld   (ix+$0a),a
     set  0,(ix+$00)
     ret

bank2_call_9FD9     
     inc  (ix+$0a)
     bit  0,(ix+$0a)
     ret  nz
     call bank2_call_A1A2
     call bank2_call_A224
     call bank2_call_A26D
     call bank2_call_8D64
     call call_166B
     jp   nz,bank2_call_A05C
     ld   a,(ix+$03)
bank2_call_9FF6
     cp   $01
     jp   z,bank2_call_A031
     cp   $00
     jp   z,bank2_call_A006
     ld   a,(ix+$0b)
     jp   bank2_call_9FF6
	 
	 ;water control structure is 13 bytes
	 ;00 =
	 ;01 = Start Row
	 ;02 = Start Column
	 ;03 = Start Control Code
	 ;04 = Seems to point to LSB of this structure
	 ;05 = Seems to point to MSB of this structure
	 ;06 = Controls which segment to skip when drawing
	 ;07
	 ;08 = Start Graphic Tile
	 ;09 = Start Graphic Tile Attribute
	 ;0a
	 ;0b
	 ;0c = FF - End Marker?
	 

bank2_call_A006	;starting graphic and control code
     ld   (ix+$08),$E1
     ld   (ix+$09),$70;$1C		;graphic for horizontal water flow end segment (right hand)
     ld   (ix+$03),$00			;code for draw lead segment
     ld   a,(ix+$02)
     add  a,$08
     ld   h,a
     ld   a,(ix+$01)
     call call_174C
     jp   nz,bank2_call_A026
     ld   (ix+$03),$01
     ret


bank2_call_A026
     ld   a,(ix+$02)			;Add 8 to column value for water start (as we move a whole tile at a time)
     add  a,$08
     ld   (ix+$02),a
     jp   bank2_call_A082

bank2_call_A031
     ld   (ix+$08),$E1
     ld   (ix+$09),$78;$5C		;graphic for horizontal water flow end segment (left hand) - Flipped X
     ld   (ix+$03),$01			;code for draw tail segment
     ld   a,(ix+$02)
     sub  $08
     ld   h,a
     ld   a,(ix+$01)
     call call_174C
     jp   nz,bank2_call_A051
     ld   (ix+$03),$00
     ret
bank2_call_A051
     ld   a,(ix+$02)		;Sub 8 from column value for water start (as we move a whole tile at a time)
     sub  $08
     ld   (ix+$02),a
     jp   bank2_call_A082
bank2_call_A05C
     ld   (ix+$08),$E0
     ld   (ix+$09),$74;$9C   ;graphic for vertical water flow end segment (upside down) - Flipped Y
     ld   (ix+$03),$02
     ld   a,(ix+$01)
     and  a
     jp   nz,bank2_call_A07D
     inc  (ix+$07)
     ld   a,(ix+$07)
     cp   $0A
     jp   z,bank2_call_A196
     jp   bank2_call_A082
bank2_call_A07D
     sub  $08				;Sub 8 from row value for water start (as we move down a whole tile at a time)
     ld   (ix+$01),a
bank2_call_A082
     ld   e,(ix+$04)
     ld   d,(ix+$05)
     inc  de
     ld   a,(ix+$06)
     ld   c,a
     add  a,a
     add  a,a
     add  a,c
     call adda2de;$0D84
     bit  1,(ix+$00)
     jp   z,bank2_call_A0B2
     push de
     inc  de
     ex   de,hl
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     inc  hl
     ld   c,(hl)
     inc  hl
     ld   b,(hl)
     ex   de,hl
     ld   a,b
     cp   $70;$1C
     jp   nz,bank2_call_A0AE
     ld   bc,$0000
bank2_call_A0AE
     ld   (hl),c
     inc  hl
     ld   (hl),b
     pop  de
bank2_call_A0B2
     push de
     ld   a,(l_e737)
     and  a
     jp   nz,bank2_call_A0C0
     call call_16C2
     jp   bank2_call_A0C3
bank2_call_A0C0
     call call_16E1
bank2_call_A0C3
					;ix points to l_f54b (at least on first hit)
     pop  de		;points to l_f558 (at least on first hit)
     push hl		;contain location of water flow start/next location
     ex   de,hl
     ld   a,(ix+$03) ;???What does this value mean - maybe water direction????
     ld   (hl),a
     inc  hl
     ld   (hl),e
     inc  hl
     ld   (hl),d	;l_f559 now holds the screen location
     inc  hl
     ld   a,(de)	;get the tile under the current location
     ld   (hl),a	;and store it in l_f55b
     inc  hl		
     inc  de		
     ld   a,(de)	;get the tile attribute for the current location
     ld   (hl),a	;and store in l_f55c
     pop  hl		;retrieve screen location into hl
     ld   a,(ix+$08);get tile held in water structure offset $08
     ld   (hl),a	;and draw to screen
     inc  hl	
     ld   a,(ix+$09);get tile atributes held in water structure offset $09
     ld   (hl),a	;and draw to screen
     ld   hl,l_f558 ;point HL to start of Water structure
     xor  a
	 
	 ;Water structure is 10 segments with 5 bytes per segment starting at l_f558
	 ;Byte 0 = Draw code
	 ;0=draw front segment. 1=draw tail segment  2=draw current + previous  FF = inactive marker?
	 ;Byte 1 = LSB of screen address that Water segment is written to
	 ;Byte 2 = MSB of screen address that Water segment is written to
	 ;Byte 3 =
	 ;Byte 4 =
	 
	 ;Structure ends at l_f589
	 
	 
bank2_call_A0E3
     push hl
     push af
     cp   (ix+$06)			;cp counter to offset in structure. Skips drawing either 1st or 2nd time round
     jp   z,bank2_call_A142 ;if counter matches jump to loop repeat logic (ie skip this segment)
     ld   a,(hl)
     cp   $FF				;not active marker ($FF) for segment list
     jp   z,bank2_call_A142 ;if not active jump to loop repeat logic
     ld   bc,$E470;$E41C                ;graphic for horizontal water flow
     cp   $02				;check if a single segment to draw
     jp   nz,bank2_call_A13A;if not then jump to draw segment (using horizontal graphic)
     pop  af				;retrieve counter
     push af				;and restore
     dec  a					;and go back 1 segment (as are drawing the trail)
     cp   $FF				;make sure we haven't tried to go back past 0!
     jp   nz,bank2_call_A109;if not jump to next bit
     add  a,$0A				;else set counter to one before end (so loop will end on next increase)
     cp   (ix+$06)			;do we need to process final segment of break out of loop
     jp   z,bank2_call_A142 ;if zero then break out of loop
bank2_call_A109
	;here we redraw the previous segment with a new graphic and then also draw the current one
     ld   c,a
     add  a,a
     add  a,a
     add  a,c				;multiply counter by  5
     ld   de,l_f558
     call adda2de;$0D84		;and calculate offset into Water structure l_f558
     ld   a,(de)			;get direction code for this segment
     ld   bc,$E570;$E51C      ;graphic for vertical water flow
     cp   $02
     jp   z,bank2_call_A13A  ;if this segment was already part of a corner draw then just draw new graphic
     cp   $FF					;check end marker	
     jp   z,bank2_call_A13A  ;if this segment was inactive then just draw new graphic
	 ;otherwise draw a corner
     ld   bc,$E370;$E31C      ;graphic for top corner water flow
     cp   $01				 ;check for corner?
     jp   z,bank2_call_A12C
     ld   bc,$E378;$E35C     ;graphic for top corner water flow - flipped X
bank2_call_A12C
     push hl
     ex   de,hl
     inc  hl
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ex   de,hl
     ld   (hl),b
     inc  hl
     ld   (hl),c
     pop  hl
     ld   bc,$E570;$E51C   ;graphic for vertical water flow - after a corner we must be going down!
bank2_call_A13A
     inc  hl
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ex   de,hl		;this + 4 lines above retrieve screen location into DE
     ld   (hl),b	;and write value in BC
     inc  hl
     ld   (hl),c
bank2_call_A142
     pop  af
     pop  hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     inc  a
     cp   $0A
     jp   nz,bank2_call_A0E3		;loop through water segments
     ld   a,(ix+$06)
     inc  a
     cp   $0A
     jp   nz,bank2_call_A159
     xor  a
bank2_call_A159
     ld   c,a
     add  a,a
     add  a,a
     add  a,c
     ld   hl,l_f558
     call adda2hl;$0D89
     ld   a,(hl)
     cp   $FF
     jp   z,bank2_call_A184
     ld   bc,$E070;$E01C    ;graphic for vertical water flow end segment
     cp   $02
     jp   z,bank2_call_A17C  
     ld   bc,$E178;$E15C	;graphic for horizontal water flow end segment (left hand) - Flipped X
     cp   $00
     jp   z,bank2_call_A17C
     ld   bc,$E170;$E11C   ;graphic for horizontal water flow end segment (right hand)
bank2_call_A17C
     inc  hl
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ex   de,hl
     ld   (hl),b
     inc  hl
     ld   (hl),c
bank2_call_A184
     inc  (ix+$06)
     ld   a,(ix+$06)
     cp   $0A
     ret  nz
     ld   (ix+$06),$00
     set  1,(ix+$00)
     ret
bank2_call_A196
     ld   l,(ix+$04)
     ld   h,(ix+$05)
     xor  a
     ld   (hl),a
     ld   (ix+$00),a
     ret
bank2_call_A1A2
     ld   hl,l_e691
     bit  0,(hl)
     jp   z,bank2_call_A1C8
     ld   a,(l_fc22)
     bit  4,a
     jp   z,bank2_call_A1C8
     ld   a,(l_e6b6)
     and  a
     jp   nz,bank2_call_A1C8
     call bank2_call_A20A
     jp   nc,bank2_call_A1C8
     ld   hl,l_e2c5
     ld   de,l_e69c
     call bank2_call_A1E3
bank2_call_A1C8
     ld   hl,l_e6c3
     bit  0,(hl)
     ret  z
     ld   a,(l_fc23)
     bit  4,a
     ret  z
     ld   a,(l_e6e8)
     and  a
     ret  nz
     call bank2_call_A20A
     ret  nc
     ld   hl,l_e2b5
     ld   de,l_e6ce
bank2_call_A1E3
     ld   a,(ix+$01)
     sub  $08
     ld   (hl),a
     inc  hl
     inc  hl
     ld   a,(ix+$01)
     and  a
     jp   z,bank2_call_A1F9
     ld   a,(ix+$02)
     sub  $08
     ld   (hl),a
     ret
bank2_call_A1F9
     ld   a,$01
     ld   (de),a
     ld   a,(ix+$02)
     bit  7,a
     jp   nz,bank2_call_A207
     ld   (hl),$50
     ret
bank2_call_A207
     ld   (hl),$A0
     ret
bank2_call_A20A
     inc  hl
     ld   a,(hl)
     sub  (ix+$01)
     jp   p,bank2_call_A214
     neg
bank2_call_A214
     cp   $10
     ret  nc
     inc  hl
     ld   a,(hl)
     sub  (ix+$02)
     jp   p,bank2_call_A221
     neg
bank2_call_A221
     cp   $10
     ret
bank2_call_A224
     ld   b,$00
     ld   hl,l_ed21
bank2_call_A229
     ld   a,(hl)
     and  $05
     jp   z,bank2_call_A24F
     push hl
     inc  hl
     ld   a,(hl)
     sub  (ix+$01)
     jp   p,bank2_call_A23A
     neg
bank2_call_A23A
     cp   $10
     jp   nc,bank2_call_A24B
     inc  hl
     ld   a,(hl)
     sub  (ix+$02)
     jp   p,bank2_call_A249
     neg
bank2_call_A249
     cp   $10
bank2_call_A24B
     pop  hl
     call c,bank2_call_A25B
bank2_call_A24F
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     inc  b
     ld   a,b
     cp   $07
     jp   nz,bank2_call_A229
     ret
bank2_call_A25B
     push hl
     ld   (hl),$04
     inc  hl
     ld   a,(ix+$01)
     ld   (hl),a
     inc  hl
     ld   a,(ix+$02)
     ld   (hl),a
     inc  hl
     ld   (hl),$07
     pop  hl
     ret
bank2_call_A26D
     ld   iy,l_ec29
     ld   b,$08
bank2_call_A273
     push bc
     bit  0,(iy+$00)
     jp   z,bank2_call_A2B7
     ld   a,(iy+$01)
     sub  (ix+$01)
     jp   p,bank2_call_A286
     neg
bank2_call_A286
     cp   $10
     jp   nc,bank2_call_A2B7
     ld   a,(iy+$02)
     sub  (ix+$02)
     jp   p,bank2_call_A296
     neg
bank2_call_A296
     cp   $10
     jp   nc,bank2_call_A2B7
     set  3,(iy+$00)
     ld   a,(ix+$01)
     ld   (iy+$01),a
     ld   a,(ix+$02)
     ld   (iy+$02),a
;     ld   hl,($0004)
;     ld   de,$00B9
;     or   a
;     sbc  hl,de
;     jp   nz,bank2_call_A2BF
bank2_call_A2B7
     ld   de,$0010
     add  iy,de
     pop  bc
     djnz bank2_call_A273
bank2_call_A2BF
     ret



bank2_call_A2C0
     ld   a,(l_f58b)
     and  a
     jr   nz,bank2_call_A2D6
     ld   hl,l_f58e
     ld   (hl),$00
     ld   hl,$9FC0
     ld   (l_f58c),hl
     ld   hl,l_f58b
     ld   (hl),$01
bank2_call_A2D6
     ld   de,(l_f58c)
     ld   a,(de)
     ld   hl,l_f58e
     add  a,(hl)
     ld   (hl),a
     inc  de
     ld   hl,$BABB			;TODO - protection
     or   a
     sbc  hl,de
     ;jr   z,bank2_call_A2EE
     ld   (l_f58c),de
     ret
bank2_call_A2EE
     ld   hl,l_f58b
     ld   (hl),$00
     ld   a,(l_f58f)
     ld   hl,l_f58e
     cp   (hl)
     ret  z
     push de
bank2_call_A2FC	
     ld   hl,l_f590
     ld   bc,$0005
     call clearbytes;$0D50
     ld   hl,l_f592
     ld   (hl),$1F
     ld   hl,l_f591
     ld   (hl),$02
     ret
bank2_call_A310    
     ld   a,(l_f590)
     and  a
     ret  z
     jp   m,bank2_call_A3C1
     call bank2_call_85AE
     ld   hl,l_f593
     inc  (hl)
     bit  0,(hl)
     ret  nz
     inc  hl
     bit  0,(hl)
     jr   nz,bank2_call_A32E
     set  0,(hl)
     ld   c,$12
     call call_1350
	;flood fill routine
bank2_call_A32E
     ld   a,(l_f591)     ;flood column
     add  a,a
     add  a,a
     add  a,a
     ld   h,a
     ld   a,(l_f592)     ;flood row
     add  a,a
     add  a,a
     add  a,a
     neg
     ld   l,a
     call call_174B      ;get map data as current row/column
     jr   z,bank2_call_A386   ;if zero skip draw routine
	 
/*
     ld   a,(l_f591)		;flood column
     call call_0D8E
	 add  a,a
     ld   a,(l_f592)		;flood row
     add  a,a				
     ld   bc,$7658;$CD00              ;TODO - screen locS
     call adda2hl;$0D89
     add  hl,de
*/
	 
	 ld   a,(l_f592)		;flood row
     call call_0D8E			;x 64 into DE
	 ld l,a
	 ld h,0
	 add hl,hl				;x2
	 add hl,hl				;x4
	 add hl,hl				;x8
	 add hl,hl				;x16
	 add hl,de				;total is now a x 80
     ld   a,(l_f591)		;flood column
     add  a,a				;x 2
	 ld   e,a
	 ld   d,0
	 add  hl,de
     ld   de,$75b8;$CD00              ;TODO - screen locS
     ;call adda2hl;$0D89	 
     add  hl,de
	 
     ld   (hl),$83;$C9						;Blue square for flood
     inc  hl
     ld   (hl),$70;$1D
	 
     ld   a,(l_f591)          ;flood column
     add  a,a
     add  a,a
     add  a,a
     ld   h,a
     ld   a,(l_f592)           ;flood row
     dec  a
     add  a,a
     add  a,a
     add  a,a
     neg
     ld   l,a
     call call_174B
     jr   z,bank2_call_A386
	 
/*
     ld   a,(l_f591)
     call call_0D8E
     ld   a,(l_f592)
     dec  a
     add  a,a
     ld   hl,$7608;$CD00     ;TODO - screen loc
     call adda2hl;0D89
     add  hl,de
*/
	 
	 ld   a,(l_f592)		;flood row
	 dec a
     call call_0D8E			;x 64 into DE
	 ld l,a
	 ld h,0
	 add hl,hl				;x2
	 add hl,hl				;x4
	 add hl,hl				;x8
	 add hl,hl				;x16
	 add hl,de				;total is now a x 80
     ld   a,(l_f591)		;flood column
     add  a,a				;x 2
	 ld   e,a
	 ld   d,0
	 add  hl,de
     ld   de,$75b8;$CD00              ;TODO - screen locS
     ;call adda2hl;$0D89	 
     add  hl,de
	 
     ld   (hl),$82;$C8			;top layer of flood
     inc  hl
     ld   (hl),$70;$1D
bank2_call_A386
     ld   hl,l_f591           ;flood column
     inc  (hl)                ;increase column
     ld   a,(hl)              ;load column value
     cp   $1E                 ;are we at last column (30)
     jr   nz,bank2_call_A32E  ;if not jump back to top of routine
     ld   (hl),$02            ;reset column to 2
     inc  hl                  ;change HL to point to flood row
     dec  (hl)                ;decrease flood row
     ld   a,(hl)              ;load row value
     cp   $04                 ;are we at row 4
     ret  nz                  ;return if not
     ld   a,$07               ;load 7 into a
     call call_18CF           ;update structure from l_ed21
     ld   hl,l_e76a           ;set some vars
     ld   (hl),$FF
     ld   hl,l_f590
     ld   (hl),$80
     ld   hl,l_f593
     ld   (hl),$00
     ld   hl,l_f594
     ld   (hl),$00
     ld   hl,l_ed3d
     ld   (hl),$00
     ld   iy,l_fc6d
     ld   a,(iy+$18)
     sub  $37
     ret  ;z        ;protection?
     push hl
     push af
bank2_call_A3C1
     ld   hl,l_f593
     inc  (hl)
     ld   a,(hl)
     cp   $19            ;timer for flood wave mirror
     ret  nz
     ld   (hl),$00
     inc  hl
     inc  (hl)
     bit  0,(hl)
     jr   nz,bank2_call_A402
     ld   a,(l_e59b)
     and  $C0
     cp   $80
     jr   z,bank2_call_A3E8
     ld   b,$04
     ld   hl,$770b;$CF49  ;TODO - screen loc
bank2_call_A3DF
     set  3,(hl)                        ;set mirror bit for flood top
     ld   a,$02;$40
     call adda2hl;$0D89
     djnz bank2_call_A3DF
bank2_call_A3E8
     ld   a,(l_e59b)
     and  $30
     cp   $20
     ret  z
     ld   b,$04
     ld   hl,$771f;$D1C9  ;TODO - screen loc
bank2_call_A3F5
     set  3,(hl)                        ;set mirror bit for flood top
     ld   a,$02;$40
     call adda2hl;_0D89
     djnz bank2_call_A3F5
     call bank2_call_932D
     ret
bank2_call_A402
     ld   a,(l_e59b)
     and  $C0
     cp   $80
     jr   z,bank2_call_A419
     ld   b,$04
     ld   hl,$770b;$CF49                  ;TODO - screen address
bank2_call_A410
     res  3,(hl)                        ;reset mirror bit for flood top
     ld   a,$02;40
     call adda2hl;$0D89
     djnz bank2_call_A410
bank2_call_A419
     ld   a,(l_e59b)
     and  $30
     cp   $20
     ret  z
     ld   b,$04                         
     ld   hl,$771f;$D1C9                  ;TODO - screen addres
bank2_call_A426
     res  3,(hl)                         ;reset mirror bit for flood top
     ld   a,$02;40
     call adda2hl;0D89
     djnz bank2_call_A426
     call bank2_call_8B6B
     ret
bank2_call_A433     
    push ix
    ld   hl,l_f595
    ld   bc,$0009
    call clearbytes;$0D50
    ld   ix,l_f596
    ld   hl,l_e2d5
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (ix+$07),$06
    ld   de,$0006
    ld   b,$08
bank2_call_A454
    inc  hl
    ld   a,d
    call mul32;call_0D6C
    or   e
    ld   (hl),a
    inc  d
    ld   a,d
    cp   $04
    jr   nz,bank2_call_A464
    ld   d,$00
    inc  e
bank2_call_A464
    inc  hl
    inc  hl
    ld   (hl),$14
    inc  hl
    djnz bank2_call_A454
;    ld   ix,call_0B0C
;    ld   hl,call_044C
;    inc  hl
;    ld   e,$4D;(ix+$22)
;    ld   d,$04;(ix+$23)
;    or   a
;    sbc  hl,de
;    ret  nz
    pop  ix
    ret




bank2_call_A480
     ld   a,(l_f595)
     and  a
     ret  z
     ret  m
     ld   ix,l_f596
     ld   a,(ix+$00)
     bit  0,a
     jp   nz,bank2_call_A501
     bit  1,a
     jp   nz,bank2_call_A541
     call bank2_call_8F17
     ld   a,(l_ed3d)
     and  a
     jp   z,bank2_call_A55C
     ld   a,(l_e34a)
     and  a
     jp   nz,bank2_call_A55C
     ld   de,$0604
     call frametimer;15CA
     jr   z,bank2_call_A4CE
     bit  0,a
     jr   nz,bank2_call_A4C1
     ld   hl,$00FF
     ;ld   (l_f9DE),hl       ;TODO - Palette Change
     ld   hl,$00FF
     ;ld   (l_f9fe),hl       ;TODO - Palette Change
     ret
bank2_call_A4C1
     ld   hl,$0000
     ;ld   ($F9DE),hl         ;TODO - Palette Changes
     ld   hl,$0000
     ;ld   ($F9FE),hl         ;TODO - Palette Changes
     ret
bank2_call_A4CE
     call resetframetimer;call_1556
     ld   (ix+$01),$E8
     ld   a,r
     add  a,a
     cp   $3C
     jr   nc,bank2_call_A4DE
     ld   a,$90
bank2_call_A4DE
     ld   (ix+$02),a
     ld   b,$08
     ld   de,l_e2d5
     ld   hl,bank2_data_A58B
bank2_call_A4E9
     ld   a,(hl)
     ld   (de),a
     inc  de
     inc  de
     inc  hl
     ld   a,(hl)
     add  a,(ix+$02)
     ld   (de),a
     inc  de
     inc  de
     inc  hl
     djnz bank2_call_A4E9
     ld   c,$23
     call call_1350
     set  0,(ix+$00)
bank2_call_A501
     ld   de,$0A04
     call frametimer;call_15CA
     ld   hl,bank2_data_A564
     call adda2hl;$0D89
     ld   a,(hl)
     ld   hl,bank2_data_A568
     call adda2hl;$0D89
     ld   bc,$081E
     call call_14BD
     ld   b,$08
     ld   hl,l_e2d5
bank2_call_A51F
     ld   a,(hl)
     sub  $06
     jr   nc,bank2_call_A525
     xor  a
bank2_call_A525
     ld   (hl),a
     inc  hl
     inc  hl
     dec  (hl)
     dec  (hl)
     inc  hl
     inc  hl
     djnz bank2_call_A51F
     ld   a,(ix+$01)
     sub  $06
     cp   $F0
     jr   z,bank2_call_A553
     ld   (ix+$01),a
     dec  (ix+$02)
     dec  (ix+$02)
     ret
bank2_call_A541
     ld   a,(l_f460)
     ld   (l_e5d6),a
     ld   de,$0500
     call call_2FB3
     ld   (ix+$00),$01
     jr   bank2_call_A501
bank2_call_A553
     call resetframetimer;call_1556
     ld   (ix+$00),a
     jp   bank2_call_A4C1
bank2_call_A55C
     ld   hl,l_f595
     ld   (hl),$FF
     jp   bank2_call_A4C1
     
bank2_data_A564
    BYTE $00,$08,$10,$08
bank2_data_A568
    BYTE $54,$58,$6C,$70,$84,$88,$9C,$A0,$5C,$60,$74,$78
    BYTE $8C,$90,$A4,$A8,$64,$68,$7C,$80,$94,$98,$AC,$B0,$FF,$0F,$FF,$0F
    BYTE $0F,$FF,$0F,$FF,$0F,$00,$88


bank2_data_A58B
    BYTE $F0,$F0,$00,$00,$E0,$F0,$F0,$00,$D0,$F0,$E0,$00,$C0,$F0,$D0,$00

bank2_call_A59B
    ld   hl,l_f59e
    ld   bc,$0009
    jp   clearbytes
    
bank2_call_A5A4
     ld   a,(l_f59e)
     and  a
     ret  z
     ld   ix,l_f59f
     ld   a,(ix+$00)
     bit  0,a
     jr   nz,bank2_call_A5E2
     bit  1,a
     jr   nz,bank2_call_A624
     bit  2,a
     jp   nz,bank2_call_A684
     bit  3,a
     jp   nz,bank2_call_A6F8
     bit  4,a
     jp   nz,bank2_call_A798
     ld   a,$0A
     call call_18CF
     ld   c,$12
     call call_1350
     ;ld   hl,($0004)
     ;ld   de,$00B9
     ;ld   a,l
     ;sub  e
     ;jr   z,bank2_call_A5DD
     ;add  ix,de
bank2_call_A5DD
     set  0,(ix+$00)
     ret
bank2_call_A5E2
     ld   a,$05
     call call_0008
     ld   hl,l_e20d
     ld   a,(l_e76b)
     add  a,a
     add  a,a
     ld   c,a
     ld   b,$00
     call clearbytes;$0D50
     inc  (ix+$06)
     ld   a,(ix+$06)
     cp   $08
     ret  nz
     ld   a,$00
     ld   bc,$041C
     call call_147D
     ld   a,$0A
     call call_189D
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ld   hl,l_e20d
     ld   (hl),e
     inc  hl
     ld   (hl),$00
     inc  hl
     ld   (hl),d
     inc  hl
     ld   (hl),$16
     xor  a
     ld   (ix+$06),a
     ld   (ix+$00),a
     set  1,(ix+$00)
     ret
bank2_call_A624
     inc  (ix+$06)
     ld   a,(ix+$06)
     cp   $08
     ret  nz
     ld   hl,bank2_data_A674
     ld   bc,$041C
     ld   e,$00
     call call_14C0
     ld   a,$0A
     call call_189D
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ld   b,$04
     ld   hl,l_e20d
bank2_call_A645
     ld   (hl),e
     inc  hl
     inc  hl
     ld   (hl),d
     inc  hl
     ld   (hl),$16
     inc  hl
     djnz bank2_call_A645
     ld   b,$04
     ld   hl,l_e20d
     ld   de,bank2_data_A678
bank2_call_A657
     ld   a,(de)
     add  a,(hl)
     ld   (hl),a
     inc  hl
     inc  de
     ld   a,(de)
     ld   (hl),a
     inc  hl
     inc  de
     ld   a,(de)
     add  a,(hl)
     ld   (hl),a
     inc  hl
     inc  hl
     inc  de
     djnz bank2_call_A657
     xor  a
     ld   (ix+$06),a
     ld   (ix+$00),a
     set  2,(ix+$00)
     ret
bank2_data_A674
    BYTE $08,$0C,$10,$14
bank2_data_A678
    BYTE $08,$00,$F8,$08
    BYTE $20,$08,$F8,$40,$F8,$F8,$60,$08
bank2_call_A684
     inc  (ix+$06)
     ld   a,(ix+$06)
     cp   $08
     ret  nz
     ld   hl,bank2_data_A6D4
     ld   bc,$091C
     ld   e,$00
     call call_14C0
     ld   a,$0A
     call call_189D
     ld   e,(hl)
     inc  hl
     ld   d,(hl)
     ld   b,$09
     ld   hl,l_e20d
bank2_call_A6A5
     ld   (hl),e
     inc  hl
     inc  hl
     ld   (hl),d
     inc  hl
     ld   (hl),$16
     inc  hl
     djnz bank2_call_A6A5
     ld   b,$09
     ld   hl,l_e20d
     ld   de,bank2_data_A6DD
bank2_call_A6B7
     ld   a,(de)
     add  a,(hl)
     ld   (hl),a
     inc  hl
     inc  de
     ld   a,(de)
     ld   (hl),a
     inc  hl
     inc  de
     ld   a,(de)
     add  a,(hl)
     ld   (hl),a
     inc  hl
     inc  hl
     inc  de
     djnz bank2_call_A6B7
     xor  a
     ld   (ix+$06),a
     ld   (ix+$00),a
     set  3,(ix+$00)
     ret

bank2_data_A6D4
    BYTE $18,$1C,$20,$24,$28,$2C,$30,$34,$38
bank2_data_A6DD
    BYTE $10,$00,$F0,$10,$20,$00,$10
    BYTE $40,$10,$00,$60,$F0,$00,$01,$00,$00,$21,$10,$F0,$41,$F0,$F0,$61
    BYTE $00,$F0,$02,$10


bank2_call_A6F8
    inc   (ix+$06)
    ld    a,(ix+$06)
    cp    $08
    ret  nz
    ld   hl,bank2_data_A748
    ld   bc,$141C
    ld   e,$00
    call call_14C0
    ld   a,$0A
    call call_189D
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   b,$14
    ld   hl,l_e20d
bank2_call_A719
    ld   (hl),e
    inc  hl
    inc  hl
    ld   (hl),d
    inc  hl
    ld   (hl),$16
    inc  hl
    djnz bank2_call_A719
    ld   b,$14
    ld   hl,l_e20d
    ld   de,bank2_data_A75C
bank2_call_A72B
    ld   a,(de)
    add  a,(hl)
    ld   (hl),a
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  de
    ld   a,(de)
    add  a,(hl)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    djnz bank2_call_A72B
    xor  a
    ld   (ix+$06),a
    ld   (ix+$00),a
    set  4,(ix+$00)
    ret

bank2_data_A748
    BYTE $3C,$40,$44,$48,$4C,$50,$54,$58,$5C,$60,$64,$68,$6C,$70,$74,$78
    BYTE $7C,$80,$84,$88
bank2_data_A75C
    BYTE $18,$00,$E8,$18,$20,$F8,$18,$40,$08,$18,$60,$18
    BYTE $08,$01,$E8,$08,$21,$F8,$08,$41,$08,$08,$61,$18,$F8,$02,$E8,$F8
    BYTE $22,$F8,$F8,$42,$08,$F8,$62,$18,$E8,$03,$E8,$E8,$23,$F8,$E8,$43
    BYTE $08,$E8,$63,$18,$28,$04,$00,$00,$24,$D8,$D8,$44,$00,$00,$64,$28


bank2_call_A798
    ld   de,$031E
    call frametimer;call_15CA
    jr   z,bank2_call_A7CF
    bit  0,a
    jr   nz,bank2_call_A7C2
    bit  1,a
    jr   nz,bank2_call_A7B5
    ld   hl,$00F0
    ;ld   (l_f9de),hl    ;TODO - Palette Entry
    ld   hl,$00F0
    ;ld   (l_f9fe),hl    ;TODO - Palette Entry
    ret
    
bank2_call_A7B5
     ld   hl,$00FF
     ;ld   (l_f9de),hl    ;TODO - Palette Entry
     ld   hl,$00FF
     ;ld   (l_f9fe),hl    ;TODO - Palette Entry
     ret
bank2_call_A7C2
     ld   hl,$0000
     ;ld   (l_f9de),hl    ;TODO - Palette Entry
     ld   hl,$0000
     ;ld   (l_f9fe),hl    ;TODO - Palette Entry
     ret
bank2_call_A7CF
     ld   hl,l_e20d
     ld   bc,$0050
     call clearbytes;$0D50
     ld   hl,l_f59e
     ld   (hl),$00
     ld   hl,l_ed3d
     ld   (hl),$00
     ret
     
bank2_call_A7E3     
     ld   a,(l_f5a7)
     and  a
     jr   nz,bank2_call_A7F9
     ld   hl,l_f5aa
     ld   (hl),$00
     ld   hl,bank2_call_8016  ;protection - reads rom for checksum purposes
     ld   (l_f5a8),hl
     ld   hl,l_f5a7
     ld   (hl),$01
bank2_call_A7F9
     ld   de,(l_f5a8)
     ld   a,(de)
     ld   hl,l_f5aa
     add  a,(hl)
     ld   (hl),a
     inc  de
     ld   hl,$8766			;TODO - Protection
     or   a
     sbc  hl,de
     ;jr   z,bank2_call_A811
     ld   (l_f5a8),de
     ret
bank2_call_A811
     ld   hl,l_f5a7
     ld   (hl),$00
     ld   a,(l_f5ab)
     ld   hl,l_f5aa
     cp   (hl)
     ret			;was ret  z	- assume part of protection
					;adds up all address bytes from 8016 to 8766 and
					;if checksum is 'D1' then hangs!
     ex   de,hl
jphlstop4
    jr jphlstop4
     jp   (hl)      ;TODO - hope we never get here???



bank2_call_A820    
    ld   hl,l_f5ac
    ld   bc,$000A
    jp   clearbytes
    
bank2_call_A829    
     ld   a,(l_f5ac)
     and  a
     ret  z
     ld   a,(l_e5d3)
     and  a
     ret  nz
     ld   ix,l_f5ad
     ld   a,(ix+$00)
     bit  0,a
     jp   nz,bank2_call_A867
     bit  1,a
     jp   nz,bank2_call_A9F7
     ld   hl,l_e2e5
     ld   (ix+$03),l
     ld   (ix+$04),h
     ld   a,(l_e5a2)
     ld   (hl),a
     inc  hl
     ld   (hl),$06
     inc  hl
     ld   a,(l_e5a3)
     ld   (hl),a
     inc  hl
     ld   (hl),$13
     call loadhl2;1537
     ld   (ix+$08),$03
     set  0,(ix+$00)
bank2_call_A867
     ld   a,(l_ed3d)
     and  a
     jp   z,bank2_call_AA19
     ld   de,$0405                 ;necklace picked up
     ;break
     call frametimer;15CA          ;returns A = (ix+$05)
     add  a,a
     add  a,a                      ; * 4
     add  a,$D4                    ;add to base sprite $ED4
     ld   b,a
     ld   c,$1E
     ld   a,$06                    ;use sprite num 6
     call call_147D
     ld   a,(ix+$08)
     cp   $1B
     jp   nc,bank2_call_A895
     cp   $13
     jp   nc,bank2_call_A92D
     cp   $0B
     jp   nc,bank2_call_A97C
     jp   bank2_call_A8E1
bank2_call_A895
     ld   b,$03
bank2_call_A897
     push bc
     call loadhl2;$1537  ;copy X,Y pos from base E20D sprite struct to IX data
     ld   a,(ix+$02)     ;bouncing ball X Pos
     sub  $03            ;3 pixels to the left
     ld   h,a
     ld   a,(ix+$01)     ;bouncing ball Y Pos
     add  a,$02          ;2 pixels up
     call call_174C      ;check map data at this location
     jp   z,bank2_call_A9C8
     ld   a,(ix+$02)     ;bouncing ball X Pos
     sub  $03            ;3 pixels to the left
     ld   h,a
     ld   a,(ix+$01)     ;bouncing ball Y Pos
     call call_174C      ;check map data at this location
     jp   z,bank2_call_A9C8
     ld   h,(ix+$02)     ;bouncing ball X Pos
     ld   a,(ix+$01)     ;bouncing ball Y Pos
     add  a,$03          ;3 pixels up
     call call_174C      ;check map data at this location
     jp   z,bank2_call_A9D1
     ld   a,(ix+$02)     ;bouncing ball X Pos
     sub  $02            ;2 pixels to the left
     ld   h,a
     ld   a,(ix+$01)     ;bouncing ball Y Pos
     add  a,$03          ;3 pixels up
     call call_174C      ;check map data at this location
     jp   z,bank2_call_A9D1
     call bank2_call_AA22
     pop  bc
     djnz bank2_call_A897
     ret
bank2_call_A8E1
     ld   b,$03
bank2_call_A8E3
     push bc
     call loadhl2;call_1537
     ld   a,(ix+$02)
     add  a,$03
     ld   h,a
     ld   a,(ix+$01)
     add  a,$02
     call call_174C
     jp   z,bank2_call_A9DA
     ld   a,(ix+$02)
     add  a,$03
     ld   h,a
     ld   a,(ix+$01)
     call call_174C
     jp   z,bank2_call_A9DA
     ld   h,(ix+$02)
     ld   a,(ix+$01)
     add  a,$03
     call call_174C
     jp   z,bank2_call_A9E3
     ld   a,(ix+$02)
     add  a,$02
     ld   h,a
     ld   a,(ix+$01)
     add  a,$03
     call call_174C
     jp   z,bank2_call_A9E3
     call bank2_call_AA22
     pop  bc
     djnz bank2_call_A8E3
     ret
bank2_call_A92D
     ld   b,$03
bank2_call_A92F
     push bc
     call loadhl2;1537
     ld   a,(ix+$02)
     sub  $03
     ld   h,a
     ld   a,(ix+$01)
     call call_174C
     jp   z,bank2_call_A9E3
     ld   a,(ix+$02)
     sub  $03
     ld   h,a
     ld   a,(ix+$01)
     sub  $02
     call call_174C
     jp   z,bank2_call_A9E3
     ld   h,(ix+$02)
     ld   a,(ix+$01)
     sub  $03
     call call_174C
     jp   z,bank2_call_A9DA
     ld   a,(ix+$02)
     sub  $02
     ld   h,a
     ld   a,(ix+$01)
     sub  $03
     call call_174C
     jp   z,bank2_call_A9DA
     call bank2_call_AA22
     pop  bc
     djnz bank2_call_A92F
     call bank2_call_85AE
     ret
bank2_call_A97C
     ld   b,$03
bank2_call_A97E
     push bc
     call loadhl2;$1537
     ld   a,(ix+$02)
     add  a,$03
     ld   h,a
     ld   a,(ix+$01)
     call call_174C
     jp   z,bank2_call_A9D1
     ld   a,(ix+$02)
     add  a,$03
     ld   h,a
     ld   a,(ix+$01)
     sub  $02
     call call_174C
     jp   z,bank2_call_A9D1
     ld   h,(ix+$02)
     ld   a,(ix+$01)
     sub  $03
     call call_174C
     jp   z,bank2_call_A9C8
     ld   a,(ix+$02)
     add  a,$02
     ld   h,a
     ld   a,(ix+$01)
     sub  $03
     call call_174C
     jp   z,bank2_call_A9C8
     call bank2_call_AA22
     pop  bc
     djnz bank2_call_A97E
     ret
bank2_call_A9C8
     ld   a,r
     and  $03
     add  a,$03
     jp   bank2_call_A9E9
bank2_call_A9D1
     ld   a,r
     and  $03
     add  a,$13
     jp   bank2_call_A9E9
bank2_call_A9DA
     ld   a,r
     and  $03
     add  a,$1B
     jp   bank2_call_A9E9
bank2_call_A9E3
     ld   a,r
     and  $03
     add  a,$0B
bank2_call_A9E9
     ld   (ix+$08),a
     ld   (ix+$07),$00
     ld   c,$24
     call call_1350
     pop  bc
     ret
bank2_call_A9F7
;     ld   hl,$044D
;     ld   de,($0B2E)
;     or   a
;     sbc  hl,de
;     jp   z,$AA06
;     push bc
;     push de
      jp   bank2_call_AA06
bank2_call_AA06
     ld   a,(l_f460)
     ld   (l_e5d6),a
     ld   de,$0800
     call call_2FB3
     ld   (ix+$00),$01
     jp   bank2_call_A867

bank2_call_AA19            
     call call_154C
     ld   hl,l_f5ac
     ld   (hl),$00
     ret
bank2_call_AA22
     ld   a,(ix+$08)          ;get movement pattern
     call call_109C           ;load DE with pattern address
     ld   a,(ix+$07)          ;get offset within pattern
     inc  (ix+$07)            ;increase it
     call adda2de;$0D84       ;add to pattern base
     ld   a,(de)              ;get pattern data
     cp   $88                 ;end of pattern marker?
     jp   nz,bank2_call_AA3E
     ld   (ix+$07),$00        ;is so, reset pattern offset
     jp   bank2_call_AA22     ;and go back and process pattern data
bank2_call_AA3E
     call loadhlfromspritestruct;call_$1529
     bit  0,a
     jp   z,bank2_call_AA50
     bit  3,a
     jp   nz,bank2_call_AA4F
     inc  (hl)
     jp   bank2_call_AA50
bank2_call_AA4F
     dec  (hl)
bank2_call_AA50
     inc  hl
     inc  hl
     bit  4,a
     ret  z
     bit  7,a
     jp   nz,bank2_call_AA5C
     inc  (hl)
     ret
bank2_call_AA5C
     dec  (hl)
     ret
bank2_call_AA5E
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   hl,l_f5b6
    ld   bc,$0059
    call call_0D50
    ld   ix,l_f5b7
    xor  a
bank2_call_AA71
    push af
    add  a,a
    add  a,a
    ld   hl,bank2_data_AAA5
    call call_0D89
    ld   a,(hl)
    ld   (ix+$08),a
    inc  hl
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   (ix+$03),e
    ld   (ix+$04),d
    inc  hl
    ld   a,(de)
    inc  hl
    inc  de
    ld   (de),a
    ld   (ix+$07),a
    inc  de
    inc  de
    ld   a,$15
    ld   (de),a
    ld   de,$000B
    add  ix,de
    pop  af
    inc  a
    cp   $08
    jr   nz,bank2_call_AA71
    ld   a,$09
    jp   call_18CF
bank2_data_AAA5
	BYTE $00,LOW l_e20d,HIGH l_e20d,$00
	BYTE $04,LOW l_e21d,HIGH l_e21d,$01
	BYTE $08,LOW l_e22d,HIGH l_e22d,$02
	BYTE $0C,LOW l_e23d,HIGH l_e23d,$03
	BYTE $10,LOW l_e24d,HIGH l_e24d,$04
	BYTE $14,LOW l_e25d,HIGH l_e25d,$05
	BYTE $18,LOW l_e2d5,HIGH l_e2d5,$06
	BYTE $1C,LOW l_e2e5,HIGH l_e2e5,$07
	;BYTE $00,$0D,$E2,$00
	;BYTE $04,$1D,$E2,$01
	;BYTE $08,$2D,$E2,$02
	;BYTE $0C,$3D,$E2,$03
	;BYTE $10,$4D,$E2,$04
	;BYTE $14,$5D,$E2,$05
	;BYTE $18,$D5,$E2,$06
	;BYTE $1C,$E5,$E2,$07

    
bank2_call_AAC5
    ld  a,(l_f5b6)
    and  a
    ret  z
    jp   m,bank2_call_AAE2
    call bank2_call_AB2E
    ld   hl,l_f604
    bit  4,(hl)
    ret  z
    ld   hl,l_f5b6
    ld   (hl),$FF
    ld   ix,l_f5b7
    jp   resetframetimer;call_1556
bank2_call_AAE2
    ld   ix,l_f5b7
    ld   de,$031E
    call frametimer;call_15CA
    jr   z,bank2_call_AB23
    bit  0,a
    jr   nz,bank2_call_AB10
    bit  1,a
    jr   nz,bank2_call_AB03
    ld   hl,$00F7
  ;  ld   (l_f9de),hl ;TODO palette
    ld   hl,$00F7
 ;   ld   (l_f9fe),hl ;TODO palette
    ret

bank2_call_AB03
     ld   hl,$00FF
 ;    ld   (l_f9de),hl  ;TODO palette
     ld   hl,$00FF
  ;   ld   (l_f9fe),hl  ;TODO palette
     ret
bank2_call_AB10
     ld   hl,$0000
    ; ld   (l_f9de),hl  ;TODO palette
     ld   hl,$0000
    ; ld   (l_f9fe),hl  ;TODO palette
;     ld   hl,$0002
;     bit  3,(hl)
;     ret  nz
;     push de
     ret
bank2_call_AB23
     ld   hl,l_f5b6
     ld   (hl),$00
     ld   hl,l_ed3d
     ld   (hl),$00
     ret
bank2_call_AB2E
     ld   ix,l_f5b7
     ld   b,$08
bank2_call_AB34
     push bc
     ld   a,(ix+$00)
     bit  1,a
     jp   nz,bank2_call_AB82
     bit  2,a
     jp   nz,bank2_call_ABC9
     bit  4,a
     jp   nz,bank2_call_AC72
     call loadhlfromspritestruct;call_1529
     ld   b,$04
     ld   (hl),$70
     inc  hl
     inc  hl
     ld   (hl),$78
     call loadhlfromspritestruct;call_1529
     ld   e,(ix+$07)
     ld   d,$00
     ld   b,$04
bank2_call_AB5C
     inc  hl
     ld   a,d
     call mul32;call_0D6C
     or   e
     ld   (hl),a
     inc  d
     ld   a,d
     cp   $04
     jr   nz,bank2_call_AB6C
     ld   d,$00
     inc  e
bank2_call_AB6C
     inc  hl
     inc  hl
     ld   (hl),$15
     inc  hl
     djnz bank2_call_AB5C
     ld   c,$12
     call call_1350
     call loadhl2;call_1537
     set  1,(ix+$00)
     jp   bank2_call_AC72
bank2_call_AB82
     ld   de,$0507
     call frametimer;call_15CA
     jr   z,bank2_call_AB9A
     add  a,a
     add  a,a
     add  a,$04
     ld   b,a
     ld   c,$1F
     ld   a,(ix+$07)
     call call_147D
     jp   bank2_call_AC72
bank2_call_AB9A
     call loadhlfromspritestruct;call_1529
     ld   de,bank2_data_ABC1
     ld   b,$04
bank2_call_ABA2
     ld   a,(de)
     add  a,(ix+$01)
     ld   (hl),a
     inc  hl
     inc  hl
     inc  de
     ld   a,(de)
     add  a,(ix+$02)
     ld   (hl),a
     inc  hl
     inc  hl
     inc  de
     djnz bank2_call_ABA2
     call resetframetimer;call_1556
     ld   (ix+$00),a
     set  2,(ix+$00)
     jp   bank2_call_AC72

bank2_data_ABC1
    BYTE $00,$F0,$00,$00,$F0,$F0,$F0,$00
    
bank2_call_ABC9
     ld   iy,l_fc5b
     bit  0,(iy+$2a)
     jr   nz,bank2_call_ABD4
     ex   (sp),hl
bank2_call_ABD4
     inc  (ix+$0a)
     ld   a,(ix+$0a)
     cp   $20
     jp   z,bank2_call_AC61
     call loadhl2;call_1537
     ld   de,$F002
     call frametimer;call_15CA
     add  a,a
     add  a,a
     ld   hl,bank2_data_AC59
     call adda2hl;$0D89
     ld   bc,$041F
     call call_14BD
     ld   a,(ix+$0a)
     and  $0F
     jr   nz,bank2_call_AC0A
     ld   a,(ix+$08)
     inc  a
     and  $1F
     ld   (ix+$08),a
     ld   (ix+$09),$00
bank2_call_AC0A
     ld   a,(ix+$08)
     call call_109C
     ld   a,(ix+$09)
     call adda2de;call_0D84
     ld   a,(de)
     cp   $88
     jr   nz,bank2_call_AC21
     ld   (ix+$09),$00
     jr   bank2_call_AC0A
bank2_call_AC21
     call loadhlfromspritestruct;call_1529
     ld   b,$04
bank2_call_AC26
     push hl
     bit  0,a
     jr   z,bank2_call_AC39
     bit  3,a
     jr   nz,bank2_call_AC35
     inc  (hl)
     inc  (hl)
     inc  (hl)
     inc  (hl)
     jr   bank2_call_AC39
bank2_call_AC35
     dec  (hl)
     dec  (hl)
     dec  (hl)
     dec  (hl)
bank2_call_AC39
     inc  hl
     inc  hl
     bit  4,a
     jr   z,bank2_call_AC4D
     bit  7,a
     jr   nz,bank2_call_AC49
     inc  (hl)
     inc  (hl)
     inc  (hl)
     inc  (hl)
     jr   bank2_call_AC4D
bank2_call_AC49
     dec  (hl)
     dec  (hl)
     dec  (hl)
     dec  (hl)
bank2_call_AC4D
     pop  hl
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     djnz bank2_call_AC26
     inc  (ix+$09)
     jr   bank2_call_AC72
bank2_data_AC59
     BYTE $20,$24,$30,$34,$28,$2C,$38,$3C
bank2_call_AC61
     call loadhlfromspritestruct;call_1529
     ld   bc,$0010
     call clearbytes;$0D50
     ld   (ix+$00),$00
     set  4,(ix+$00)
bank2_call_AC72
     call bank2_call_8D64
     ld   de,$000B
     add  ix,de
     pop  bc
     dec  b
     jp   nz,bank2_call_AB34
bank2_call_AC7F
     ret



bank2_call_AC80    ;Screen values for lightning jars
    ;break
    ld   hl,l_f60f
    ld   bc,$000C
    call clearbytes
    ld   a,(l_e64b)
    cp   $63
    ret  nz
    ld   ix,l_f611
    ld   hl,$7984;$CE98
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (ix+$01),$98
    ld   (ix+$02),$38
    ld   ix,l_f616
    ld   hl,$79A8;$D318
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (ix+$01),$98
    ld   (ix+$02),$C8
    ret
    
bank2_call_ACBA
    ld   a,(l_e64b)
    cp   $63
    ret  nz
    ld   a,(l_e6ff)
    and  a
    ret  p
    ld   a,(l_f536)
    cp   $01
    ret  z
    ld   ix,l_f611
    ;break
    ld   b,$02
bank2_call_ACD1
    push bc
    ld   a,(ix+$00)
    bit  0,a
    jr   nz,bank2_call_AD1F
    bit  1,a
    jp   nz,bank2_call_AD61
    call call_0AE3
    ld   e,(ix+$03)
    ld   d,(ix+$04)
    ld   hl,bank2_data_AD6C
    ld   bc,$0004
    ldir
    ld   e,(ix+$03)
    ld   d,(ix+$04)
    ld   a,$50
    call adda2de;$0D84
    ld   hl,bank2_data_AD70
    ld   bc,$0004
    ldir
;    ld   hl,($0004)
;    ld   bc,$00B9
;    xor  a
;    sbc  hl,bc
;    jr   z,$AD0E
;    push af
    nextreg $43,%00110000          ;tilemap
    nextreg $40,$E0                ;palette entry E0
    ld   hl,bank2_data_AD78
   ; ld   de,l_f9c0         ;TODO - palette at index E0
    ;ld   bc,$0020
    ld b,$10
bank2_call_ACD1_Loop
   call call_0B30_update_entry
   ; ldir
   djnz bank2_call_ACD1_Loop
    set  0,(ix+$00)
    jr   bank2_call_AD61
bank2_call_AD1F
    ld   bc,$0C0C
    call call_13F0
    jr   nc,bank2_call_AD61
    and  a
    jr   nz,bank2_call_AD34
    ld   (l_e5d6),a
    ld   hl,l_f60f
    ld   (hl),$01
    jr   bank2_call_AD3C
bank2_call_AD34
    ld   (l_e5d6),a
    ld   hl,l_f610
    ld   (hl),$01
bank2_call_AD3C
    ld   e,(ix+$03)
    ld   d,(ix+$04)
    ld   hl,bank2_data_AD74
    ld   bc,$0004
    ldir
    ld   e,(ix+$03)
    ld   d,(ix+$04)
    ld   a,$50
    call adda2de;$0D84
    ld   hl,bank2_data_AD74
    ld   bc,$0004
    ldir
    ld   (ix+$00),$02
bank2_call_AD61
    pop  bc
    ld   de,$0005
    add  ix,de
    dec  b
    jp   nz,bank2_call_ACD1
    ret
bank2_data_AD6C               ;Lightning Jar GFX
    BYTE $76,$E0,$77,$E0
bank2_data_AD70               ;Lightning Jar GFX
    BYTE $78,$E0,$79,$E0
bank2_data_AD74               ;Clear lightning Jar GFX
    BYTE $00,$00,$00,$00
bank2_data_AD78               ;Lightning Jar Palette
    BYTE $77,$00,$55,$00,$FF,$F0,$8B,$80,$8C,$00,$09,$00,$03,$00,$02,$00
    BYTE $04,$00,$07,$00,$08,$00,$0A,$00,$06,$00,$F3,$70,$05,$00,$00,$00

bank2_call_AD98
     ld   a,(ix+$1d)
     bit  7,a
     ret  nz
     bit  0,a
     jp   nz,bank2_call_ADE0
     bit  2,a
     jp   nz,bank2_call_AE59
     bit  3,a
     jp   nz,bank2_call_AE96
     bit  4,a
     jp   nz,bank2_call_AF0C
     bit  5,a
     jp   nz,bank2_call_AF7F
     ld   a,(l_e6ff)
     and  a
     ret  p
     ld   bc,$0010
     bit  0,(ix+$09)
     jp   nz,bank2_call_ADD1
     ld   hl,bank2_data_B14F
     ld   de,l_e2c5
     ldir
     jp   bank2_call_ADD9
bank2_call_ADD1
     ld   hl,bank2_data_B15F
     ld   de,l_e2b5
     ldir
bank2_call_ADD9
     call resetframetimer;$1556
     set  0,(ix+$1d)
bank2_call_ADE0
     ld   a,(l_e366)
     and  a
     jp   nz,bank2_call_AF74
     call bank2_call_8B6B
     call loadhl2;$1537
     ld   de,$0A02
     call frametimer;$15CA
     bit  0,(ix+$09)
     jp   nz,bank2_call_AE24
     ld   hl,bank2_data_B127
     bit  0,a
     jp   z,bank2_call_AE05
     ld   hl,bank2_data_B12B
bank2_call_AE05  
     ld   c,$1D
     call bank2_call_B072
     ld   b,$04
     ld   hl,l_e2c7
bank2_call_AE0F
     inc  (hl)
     inc  hl
     jp   nz,bank2_call_AE16
     res  6,(hl)
bank2_call_AE16
     inc  hl
     inc  hl
     inc  hl
     djnz bank2_call_AE0F
     ld   a,(l_e2c7)
     cp   $18
     ret  nz
     jp   bank2_call_AE4E
bank2_call_AE24
     ld   hl,bank2_data_B12F
     bit  0,a
     jp   z,bank2_call_AE2F
     ld   hl,bank2_data_B133
bank2_call_AE2F
     ld   c,$21
     call bank2_call_B072
     ld   b,$04
     ld   hl,l_e2b7
bank2_call_AE39     
     dec  (hl)
     ld   a,(hl)
     cp   $FF
     inc  hl
     jp   nz,bank2_call_AE43
     res  6,(hl)
bank2_call_AE43
     inc  hl
     inc  hl
     inc  hl
     djnz bank2_call_AE39
     ld   a,(l_e2b7)
     cp   $C8
     ret  nz
bank2_call_AE4E
     call resetframetimer;1556
     ld   (ix+$1d),a
     set  2,(ix+$1d)
     ret
bank2_call_AE59     
     ld   a,(l_e366)
     and  a
     jp   nz,bank2_call_AF74
     call loadhl2;$1537
     ld   de,$0704
     call frametimer;$15CA
     jp   z,bank2_call_AE8B
     ld   hl,bank2_data_B0DF
     bit  0,(ix+$09)
     jp   z,bank2_call_AE79
     ld   hl,bank2_data_B0E7
bank2_call_AE79
     call call_0DA7
     ex   de,hl
     ld   c,$21
     bit  0,(ix+$09)
     jp   nz,bank2_call_AE88
     ld   c,$1D
bank2_call_AE88
     jp   bank2_call_B072
bank2_call_AE8B
     call resetframetimer;$1556
     ld   (ix+$1d),a
     set  3,(ix+$1d)
     ret

bank2_call_AE96
     ld   a,(l_e366)
     and  a
     jp   nz,bank2_call_AF74
     call loadhl2;call_1537
     ld   a,(l_e5d3)
     and  a
     jp   nz,bank2_call_AEB2
     inc  (ix+$1e)
     ld   a,(ix+$1e)
     cp   $B4
     jp   z,bank2_call_AEFE
bank2_call_AEB2
     ld   de,$0A02
     call frametimer;$15CA
     bit  0,(ix+$09)
     jp   nz,bank2_call_AECD
     ld   hl,bank2_data_B10F
     bit  0,a
     jp   z,bank2_call_AEF0
     ld   hl,bank2_data_B113
     jp   bank2_call_AEF0
bank2_call_AECD
     ld   c,a
     ld   a,(l_e5d3)
     and  a
     jp   z,bank2_call_AEE4
     ld   a,c
     ld   hl,bank2_data_B11F
     bit  0,a
     jp   z,bank2_call_AEF0
     ld   hl,bank2_data_B123
     jp   bank2_call_AEF0
bank2_call_AEE4
     ld   a,c
     ld   hl,bank2_data_B117
     bit  0,a
     jp   z,bank2_call_AEF0
     ld   hl,bank2_data_B11B
bank2_call_AEF0
     ld   c,$21
     bit  0,(ix+$09)
     jp   nz,bank2_call_AEFB
     ld   c,$1D
bank2_call_AEFB
     jp   bank2_call_B072
bank2_call_AEFE
     call resetframetimer;$1556
     ld   (ix+$1d),a
     ld   (ix+$1e),a
     set  4,(ix+$1d)
     ret
bank2_call_AF0C
     ld   a,(l_e366)
     and  a
     jp   nz,bank2_call_AF74
     call loadhl2;$1537
     ld   de,$0A02
     call frametimer;$15CA
     bit  0,(ix+$09)
     jp   nz,bank2_call_AF4D
     ld   hl,bank2_data_B12F
     bit  0,a
     jp   z,bank2_call_AF2E
     ld   hl,bank2_data_B133
bank2_call_AF2E
     ld   c,$1D
     call bank2_call_B072
     ld   b,$04
     ld   hl,l_e2c7
bank2_call_AF38
     dec  (hl)
     inc  hl
     jp   p,bank2_call_AF3F
     set  6,(hl)
bank2_call_AF3F
     inc  hl
     inc  hl
     inc  hl
     djnz bank2_call_AF38
     ld   a,(l_e2c7)
     cp   $E0
     ret  nz
     jp   bank2_call_AF74
bank2_call_AF4D
     ld   hl,bank2_data_B127
     bit  0,a
     jp   z,bank2_call_AF58
     ld   hl,bank2_data_B12B
bank2_call_AF58
     ld   c,$21
     call bank2_call_B072
     ld   b,$04
     ld   hl,l_e2b7
bank2_call_AF62
     inc  (hl)
     inc  hl
     jp   nz,bank2_call_AF69
     set  6,(hl)
bank2_call_AF69
     inc  hl
     inc  hl
     inc  hl
     djnz bank2_call_AF62
     ld   a,(l_e2b7)
     cp   $10
     ret  nz
bank2_call_AF74
     call resetframetimer;$1556
     ld   (ix+$1d),a
     set  5,(ix+$1d)
     ret
bank2_call_AF7F     
     ld   a,(l_e366)
     and  a
     ret  z
     call loadhl2;$1537
     bit  0,(ix+$09)
     jp   nz,bank2_call_AF9C
     ld   hl,bank2_data_B16F
     ld   de,l_e2c5
     ld   bc,$0010
     ldir
     jp   bank2_call_AFA7
bank2_call_AF9C
     ld   hl,bank2_data_B17F
     ld   de,l_e2b5
     ld   bc,$0010
     ldir
bank2_call_AFA7
     ld   de,$0A02
     call frametimer;$15CA
     bit  0,(ix+$09)
     jp   nz,bank2_call_AFC6
     ld   hl,bank2_data_B13F
     bit  0,a
     jp   z,bank2_call_AFBF
     ld   hl,bank2_data_B143
bank2_call_AFBF
     ld   c,$1D
     ld   b,$04
     jp   call_14BD
bank2_call_AFC6
     ld   hl,bank2_data_B147
     bit  0,a
     jp   z,bank2_call_AFD1
     ld   hl,bank2_data_B14B
bank2_call_AFD1
     ld   c,$21
     ld   b,$04
     jp   call_14BD
bank2_call_AFD8
     call loadhl2;$1537
     bit  0,(ix+$1d)
     jp   nz,bank2_call_B009
     bit  0,(ix+$09)
     jp   nz,bank2_call_AFF7
     ld   hl,bank2_data_B16F
     ld   de,l_e2c5
     ld   bc,$0010
     ldir
     jp   bank2_call_B002
bank2_call_AFF7
     ld   hl,bank2_data_B17F
     ld   de,l_e2b5
     ld   bc,$0010
     ldir
bank2_call_B002
     call resetframetimer;$1556
     set  0,(ix+$1d)
bank2_call_B009     
     ld   a,(ix+$1e)
     cp   $5A
     jp   z,bank2_call_B014
     inc  (ix+$1e)
bank2_call_B014
     ld   a,(l_e6ff)
     and  a
     jp   z,bank2_call_B023
     ld   a,(ix+$1e)
     cp   $5A
     jp   z,bank2_call_B044
bank2_call_B023
     ld   de,$0A02
     call frametimer;$15CA
     ld   hl,bank2_data_B137
     bit  0,a
     jp   z,bank2_call_B034
     ld   hl,bank2_data_B13B
bank2_call_B034
     ld   c,$21
     bit  0,(ix+$09)
     jp   nz,bank2_call_B03F
     ld   c,$1D
bank2_call_B03F
     ld   b,$04
     jp   call_14BD
bank2_call_B044
     call resetframetimer;call_1556
     ld   (ix+$1d),a
     ld   (ix+$1e),a
     ld   (ix+$00),a
     ld   (ix+$1d),a
     bit  0,(ix+$09)
     jp   nz,bank2_call_B066
     ld   hl,l_e2c5
     ld   bc,$0010
     call clearbytes;$0D50
     jp   clearp1;call_3EB5
bank2_call_B066
     ld   hl,l_e2b5
     ld   bc,$0010
     call clearbytes;$0D50
     jp   clearp2;$3F39
bank2_call_B072
     ld   e,(ix+$07)
     ld   d,$00
     ld   b,$02
bank2_call_B079
     ld   a,d
     call mul32;call_0D6C
     or   e
     ex   af,af'
     inc  d
     ld   a,d
     cp   $04
     jp   nz,bank2_call_B089
     ld   d,$00
     inc  e
bank2_call_B089
     ex   af,af'
     push de
     push bc
     push hl
     ld   b,(hl)
     call call_147D
     pop  hl
     pop  bc
     pop  de
     inc  hl
     djnz bank2_call_B079
     ld   b,$02
bank2_call_B099
     ld   a,d
     call mul32;call_0D6C
     or   e
     ex   af,af'
     inc  d
     ld   a,d
     cp   $04
     jp   nz,bank2_call_B0A9
     ld   d,$00
     inc  e
bank2_call_B0A9
     ex   af,af'
     push de
     push bc
     push hl
     ld   b,(hl)
     bit  4,(ix+$1d)
     jp   nz,bank2_call_B0C8
     bit  0,(ix+$09)
     jp   nz,bank2_call_B0C2
     call call_149C
     jp   bank2_call_B0D8
bank2_call_B0C2
     call call_147D
     jp   bank2_call_B0D8
bank2_call_B0C8
     bit  0,(ix+$09)
     jp   nz,bank2_call_B0D5
     call call_147D
     jp   bank2_call_B0D8
bank2_call_B0D5
     call call_149C
bank2_call_B0D8
     pop  hl
     pop  bc
     pop  de
     inc  hl
     djnz bank2_call_B099
     ret

bank2_data_B0DF
    ;BYTE $EF,$B0,$F3,$B0,$F7,$B0,$FB,$B0
	BYTE LOW bank2_data_B0EF,HIGH bank2_data_B0EF
	BYTE LOW bank2_data_B0F3,HIGH bank2_data_B0F3
	BYTE LOW bank2_data_B0F7,HIGH bank2_data_B0F7
	BYTE LOW bank2_data_B0FB,HIGH bank2_data_B0FB
bank2_data_B0E7    
    ;BYTE $FF,$B0,$03,$B1,$07,$B1,$0B,$B1
	BYTE LOW bank2_data_B0FF,HIGH bank2_data_B0FF
	BYTE LOW bank2_data_B103,HIGH bank2_data_B103
	BYTE LOW bank2_data_B107,HIGH bank2_data_B107
	BYTE LOW bank2_data_B10B,HIGH bank2_data_B10B
	
bank2_data_B0EF
    BYTE $14,$18,$30,$2C
bank2_data_B0F3	
	BYTE $34,$38,$50,$4C
bank2_data_B0F7
	BYTE $3C,$40,$58,$54
bank2_data_B0FB
	BYTE $44,$48,$60,$5C
bank2_data_B0FF
    BYTE $14,$18,$2C,$30
bank2_data_B103
	BYTE $34,$38,$4C,$50
bank2_data_B107
	BYTE $3C,$40,$54,$58
bank2_data_B10B
	BYTE $44,$48,$5C,$60
bank2_data_B10F
    BYTE $04,$08,$80,$7C
bank2_data_B113
	BYTE $04,$08,$88,$84
bank2_data_B117    
    BYTE $04,$08,$7C,$80
bank2_data_B11B    
    BYTE $04,$08,$84,$88
bank2_data_B11F    
    BYTE $64,$68,$7C,$80
bank2_data_B123
     BYTE $6C,$70,$84,$88
bank2_data_B127
    BYTE $74,$78,$90,$8C
bank2_data_B12B    
    BYTE $94,$98,$B0,$AC
bank2_data_B12F
    BYTE $74,$78,$8C,$90
bank2_data_B133    
    BYTE $94,$98,$AC,$B0
bank2_data_B137
    BYTE $9C,$A0,$B4,$B8
bank2_data_B13B    
    BYTE $A4,$A8,$BC,$C0
bank2_data_B13F    
    BYTE $C4,$C8,$DC,$E0
bank2_data_B143    
    BYTE $C4,$C8,$E4,$E8
bank2_data_B147    
    BYTE $CC,$D0,$DC,$E0
bank2_data_B14B    
    BYTE $CC,$D0,$E4,$E8
bank2_data_B14F    
    BYTE $28,$18,$D0,$54,$28,$38,$E0,$54,$18,$58,$D0,$54,$18,$78,$E0,$54
bank2_data_B15F    
    BYTE $28,$19,$10,$54,$28,$39,$20,$54,$18,$59,$10,$54,$18,$79,$20,$54


bank2_data_B16F
    BYTE $28,$18,$18,$14,$28,$38,$28,$14,$18,$58,$18,$14,$18,$78,$28,$14
bank2_data_B17F
    BYTE $28,$19,$C8,$14,$28,$39,$D8,$14,$18,$59,$C8,$14,$18,$79,$D8,$14


bank2_call_B18F    ;Update the INSERT COIN messages at top during gameplay
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e351)
    and  a
    ret  nz
    ld   hl,l_f61d
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    jp   nz,bank2_call_B1A7
    ld   (hl),$00
    inc  hl
    inc  (hl)
bank2_call_B1A7
    ld   hl,l_e5d7
    bit  0,(hl)
    jp   nz,bank2_call_B278
    ld   a,(l_e366)
    and  a
    jp   nz,bank2_call_B1F0
    ld   hl,l_f61e
    bit  0,(hl)
    jp   nz,bank2_call_B1D7
    ld   hl,bank2_data_B339
    ld   de,$765a;$CD44
    ld   c,2*16;$08
    call call_0E9A
    ld   hl,bank2_data_B343
    ld   de,$76aa;$CD46
    ld   c,2*16;$08
    call call_0E9A
    jp   bank2_call_B278
bank2_call_B1D7
    ld   hl,bank2_data_B34D
    ld   de,$765a;$CD44
    ld   c,2*16;$08
    call call_0E9A
    ld   hl,bank2_data_B357
    ld   de,$76aa;$CD46
    ld   c,2*16;$08
    call call_0E9A
    jp   bank2_call_B278
bank2_call_B1F0
    ld   hl,l_f61e
    bit  0,(hl)
    jp   nz,bank2_call_B211
    ld   hl,bank2_data_B361
    ld   de,$765a;$CD44
    ld   c,4*16;$10
    call call_0E9A
    ld   hl,bank2_data_B36B
    ld   de,$76aa;$CD46
    ld   c,4*16;$10
    call call_0E9A
    jp   bank2_call_B227
bank2_call_B211
    ld   hl,bank2_data_B34D
    ld   de,$765a;$CD44
    ld   c,4*16;$10
    call call_0E9A
    ld   hl,bank2_data_B37F
    ld   de,$76aa;$CD46
    ld   c,4*16;$10
    call call_0E9A
bank2_call_B227
    ld   a,(l_fc22)
    bit  6,a
    jp   nz,bank2_call_B278
    ld   hl,l_e366
    dec  (hl)
    ld   hl,l_e5d7
    set  0,(hl)
    ld   hl,l_f61b
    ld   (hl),$01
    ld   hl,l_e5d6
    ld   (hl),$00
    call call_35FF
    call call_22DA
    call call_205E
    call call_3EB5
    call call_3FBD
    call call_0514
    ld   hl,l_e691
    ld   (hl),$04
    ld   hl,l_e5ef
    inc  (hl)
    ld   a,$16
    call call_0EE0
    ld   a,$06
    call call_0EE0
;    ld   a,($FC00)
;    ld   l,a
;    ld   a,i
;    ld   h,a
;    ld   bc,$0B2E
;    or   a
;    sbc  hl,bc
;    jp   z,$B278
;    push hl
bank2_call_B278
    ld   hl,l_e5d7
    bit  1,(hl)
    ret  nz
    ld   a,(l_e366)
    and  a
    jp   nz,bank2_call_B2B9
    ld   hl,l_f61e
    bit  0,(hl)
    jp   nz,bank2_call_B2A3
    ld   hl,bank2_data_B339
    ld   de,$7684;$D284
    ld   c,5*16;$14
    call call_0E9A
    ld   hl,bank2_data_B343
    ld   de,$76d4;$D286
    ld   c,5*16;$14
    jp   call_0E9A
bank2_call_B2A3
    ld   hl,bank2_data_B34D
    ld   de,$7684;$D284
    ld   c,5*16;$14
    call call_0E9A
    ld   hl,bank2_data_B357
    ld   de,$76d4;$D286
    ld   c,5*16;$14
    jp   call_0E9A
bank2_call_B2B9
    ld   hl,l_f61e
    bit  0,(hl)
    jp   nz,bank2_call_B2DA
    ld   hl,bank2_data_B361
    ld   de,$7684;$D284
    ld   c,4*16;$10
    call call_0E9A
    ld   hl,bank2_data_B375
    ld   de,$76d4;$D286
    ld   c,4*16;$10
    call call_0E9A
    jp   bank2_call_B2F0
bank2_call_B2DA
    ld   hl,bank2_data_B34D        ;'TO'
    ld   de,$7684;$D284
    ld   c,4*16;$10
    call call_0E9A
    ld   hl,bank2_data_B37F        ;'START'
    ld   de,$76D4;$D286
    ld   c,4*16;$10
    call call_0E9A
bank2_call_B2F0
    ld   a,(l_fc23)
    bit  6,a
    ret  nz
    ld   hl,l_e366
    dec  (hl)
    ld   hl,l_e5d7
    set  1,(hl)
    ld   hl,l_e5d6
    ld   (hl),$01
    call call_35FF
    call call_22DA
    ld   hl,l_e5d8
    ld   (hl),$01
    ld   hl,l_f61c
    ld   (hl),$01
    call call_207B
    call call_3F39
    call call_3FFA
    call call_0514
    ld   hl,l_e6c3
    ld   (hl),$04
    ld   hl,l_e5f0
    inc  (hl)
    ld   a,$17
    call call_0EE0
    ld   a,$07
    call call_0EE0
    ld   hl,$0002
    bit  3,(hl)
    ret;ret  nz
bank2_data_B339
	BYTE $09,"  INSERT "
bank2_data_B343
	BYTE $09,"   COIN  "
bank2_data_B34D
	BYTE $09,"    TO   "
bank2_data_B357
	BYTE $09," CONTINUE"
bank2_data_B361
	BYTE $09,"   PUSH  "
bank2_data_B36B
	BYTE $09,"    1P   "
bank2_data_B375
	BYTE $09,"    2P   "
bank2_data_B37F
	BYTE $09,"   START "


bank2_data_B389
    BYTE $4C,$27
bank2_data_B38B    
    BYTE $04,$01,$00,$50,$27,$08,$02,$00,$54,$27,$0C,$03,$00,$58
    BYTE $27,$10,$04,$00,$5C,$27,$14,$05,$00,$60,$27,$18,$06,$00,$64,$27
    BYTE $1C,$07,$00,$68,$27,$20,$08,$00,$6C,$27,$24,$09,$00,$70,$27,$28
    BYTE $10,$00,$74,$27,$2C,$15,$00,$78,$27,$30,$20,$00,$7C,$27,$34,$25
    BYTE $00,$80,$27,$38,$30,$00,$84,$27,$3C,$35,$00,$88,$27,$40,$40,$00
    BYTE $8C,$27,$44,$45,$00,$90,$27,$48,$50,$00,$94,$27,$4C,$55,$00,$98
    BYTE $27,$50,$60,$00,$DC,$2B,$54,$65,$00,$E0,$2B,$58,$70,$00,$9C,$27
    BYTE $5C,$75,$00,$A0,$27,$60,$80,$00,$A4,$27,$64,$85,$00,$A8,$27,$68
    BYTE $90,$00,$E4,$2B,$6C,$95,$00,$E8,$2B,$70,$00,$01,$AC,$27,$70,$00
    BYTE $01,$B0,$27,$70,$00,$01,$EC,$2B,$78,$00,$02,$B4,$27,$78,$00,$02
    BYTE $B8,$27,$78,$00,$02,$BC,$27,$78,$00,$02,$C0,$27,$7C,$00,$03,$C4
    BYTE $27,$7C,$00,$03,$F0,$2B,$7C,$00,$03,$C8,$27,$7C,$00,$03,$CC,$27
    BYTE $80,$00,$04,$D0,$27,$80,$00,$04,$D4,$27,$80,$00,$04,$D8,$27,$80
    BYTE $00,$04,$04,$2B,$84,$00,$05,$08,$2B,$84,$00,$05,$EC,$1C,$84,$00
    BYTE $05,$10,$2B,$84,$00,$05,$14,$2B,$88,$00,$06,$18,$2B,$88,$00,$06
    BYTE $F0,$29,$88,$00,$06,$20,$2B,$8C,$00,$07,$24,$2B,$8C,$00,$07,$C4
    BYTE $29,$8C,$00,$07,$2C,$2B,$90,$00,$08,$C0,$29,$90,$00,$08,$34,$2B
    BYTE $90,$00,$08,$38,$2B,$90,$00,$08,$3C,$2B,$94,$00,$09,$40,$2B,$94
    BYTE $00,$09,$44,$2B,$98,$00,$10,$48,$2B,$98,$00,$10

bank2_call_B4B5    
    ld a,(l_f61f)
    and a
    jr   nz,bank2_call_B4CB
    ld   hl,l_f622
    ld   (hl),$00
    ld   hl,$B710
    ld   (l_f620),hl
    ld   hl,l_f61f
    ld   (hl),$01
bank2_call_B4CB
    ld   de,(l_f620)
    ld   a,(de)
    ld   hl,l_f622
    add  a,(hl)
    ld   (hl),a
    inc  de
    ld   hl,$C000       ;TODO - Possible Screen Loc
    or   a
    sbc  hl,de
    jr   z,bank2_call_B4E3
    ld   (l_f620),de
    ret
bank2_call_B4E3
    ld   hl,l_f61f
    ld   (hl),$00
    ld   a,(l_f623)
    ld   hl,l_f622
    cp   (hl)
;    ret  z
    ret       


bank2_data_B4F2
	BYTE LOW l_e608,HIGH l_e608,$01,$01,$01,$01,$01
bank2_data_B4F9
	BYTE LOW l_e610,HIGH l_e610,$01,$01,$01,$01,$00
bank2_data_B500
	BYTE LOW l_e60f,HIGH l_e60f,$01,$01,$01,$01,$00
bank2_data_B507
	BYTE LOW l_e60e,HIGH l_e60e,$01,$01,$01,$01,$00
bank2_data_B50E
	BYTE LOW l_e60d,HIGH l_e60d,$01,$01,$01,$01,$00
bank2_data_B515
	BYTE LOW l_e611,HIGH l_e611,$14,$19,$1E,$1B,$00
bank2_data_B51C
	BYTE LOW l_e60a,HIGH l_e60a,$01,$01,$01,$01,$00
bank2_data_B523
	BYTE LOW l_e609,HIGH l_e609,$01,$01,$01,$01,$00
bank2_data_B52A
	BYTE LOW l_e607,HIGH l_e607,$01,$01,$01,$01,$01
bank2_data_B531
	BYTE LOW l_e606,HIGH l_e606,$01,$01,$01,$01,$00
	BYTE LOW l_e605,HIGH l_e605,$01,$01,$01,$01,$00
	BYTE LOW l_e604,HIGH l_e604,$01,$01,$01,$01,$00
	BYTE LOW l_e5fe,HIGH l_e5fe,$0E,$0C,$08,$0A,$00
	BYTE LOW l_e5f8,HIGH l_e5f8,$03,$03,$03,$03,$00
	BYTE LOW l_e5f9,HIGH l_e5f9,$03,$03,$03,$03,$00
	BYTE LOW l_e5fa,HIGH l_e5fa,$03,$03,$03,$03,$00
	BYTE LOW l_e5fb,HIGH l_e5fb,$03,$03,$03,$03,$00
	BYTE LOW l_e5fc,HIGH l_e5fc,$03,$03,$03,$03,$00
	BYTE LOW l_e5fd,HIGH l_e5fd,$03,$03,$03,$03,$00
	BYTE LOW l_e5ff,HIGH l_e5ff,$03,$03,$03,$03,$00
	BYTE LOW l_e600,HIGH l_e600,$03,$03,$03,$03,$00
	BYTE LOW l_e602,HIGH l_e602,$03,$03,$03,$03,$00
	BYTE LOW l_e601,HIGH l_e601,$03,$03,$03,$03,$00
	BYTE LOW l_f458,HIGH l_f458,$01,$01,$01,$01,$00
	BYTE LOW l_f457,HIGH l_f457,$01,$01,$01,$01,$01
	BYTE LOW l_e5da,HIGH l_e5da,$1E,$19,$0F,$14,$01
	BYTE LOW l_e5d9,HIGH l_e5d9,$1E,$19,$0F,$14,$00
	BYTE LOW l_e5f4,HIGH l_e5f4,$10,$0E,$0A,$0C,$01
	BYTE LOW l_e5f3,HIGH l_e5f3,$10,$0E,$0A,$0C,$01
	BYTE LOW l_e5ed,HIGH l_e5ed,$04,$03,$01,$02,$00
	BYTE LOW l_e5ec,HIGH l_e5ec,$02,$02,$01,$01,$01
	BYTE LOW l_e5f0,HIGH l_e5f0,$05,$05,$05,$05,$00
	BYTE LOW l_e5ef,HIGH l_e5ef,$05,$05,$05,$05,$00
	BYTE LOW l_e5ee,HIGH l_e5ee,$07,$06,$04,$05,$01
	BYTE LOW l_e5f7,HIGH l_e5f7,$10,$0E,$0A,$0C,$01
	BYTE LOW l_e5f6,HIGH l_e5f6,$0D,$0C,$0A,$0B,$01
	BYTE LOW l_e5eb,HIGH l_e5eb,$03,$03,$03,$03,$00
	BYTE LOW l_e5ea,HIGH l_e5ea,$03,$03,$03,$03,$00
	BYTE LOW l_e5e9,HIGH l_e5e9,$03,$03,$03,$03,$00
	BYTE LOW l_e5e8,HIGH l_e5e8,$41,$3C,$32,$37,$01
	BYTE LOW l_e5e7,HIGH l_e5e7,$13,$13,$13,$13,$00
	BYTE LOW l_e5e7,HIGH l_e5e7,$12,$12,$12,$12,$00
	BYTE LOW l_e5e7,HIGH l_e5e7,$11,$11,$11,$11,$00
	BYTE LOW l_e5e7,HIGH l_e5e7,$10,$10,$10,$10,$00
	BYTE LOW l_e5e7,HIGH l_e5e7,$0F,$0F,$0F,$0F,$00
	BYTE LOW l_e5e3,HIGH l_e5e3,$19,$19,$19,$19,$00
	BYTE LOW l_e5e3,HIGH l_e5e3,$14,$14,$14,$14,$00
	BYTE LOW l_e5e3,HIGH l_e5e3,$0F,$0F,$0F,$0F,$00
	BYTE LOW l_e5e2,HIGH l_e5e2,$13,$10,$0A,$0D,$01
	BYTE LOW l_e5e1,HIGH l_e5e1,$0C,$0C,$0C,$0C,$00
	BYTE LOW l_e5e6,HIGH l_e5e6,$0C,$0C,$0C,$0C,$00
	BYTE LOW l_e5e4,HIGH l_e5e4,$23,$23,$23,$23,$00
	BYTE LOW l_e5e0,HIGH l_e5e0,$23,$23,$23,$23,$00
	BYTE LOW l_e5df,HIGH l_e5df,$23,$23,$23,$23,$00

bank2_data_B66C
    BYTE $80,$29
bank2_data_B66E    
    BYTE $28,$10,$00,$54,$25,$28,$10,$00,$58,$25,$28,$10,$00,$5C
    BYTE $25,$28,$10,$00,$60,$25,$30,$20,$00,$64,$25,$30,$20,$00,$68,$25
    BYTE $30,$20,$00,$6C,$25,$30,$20,$00,$84,$29,$30,$20,$00,$70,$25,$38
    BYTE $30,$00,$74,$25,$38,$30,$00,$78,$25,$38,$30,$00,$7C,$25,$38,$30
    BYTE $00,$88,$29,$38,$30,$00,$94,$26,$7C,$00,$03,$24,$29,$70,$00,$01
    BYTE $28,$29,$70,$00,$01,$2C,$29,$70,$00,$01,$30,$29,$7C,$00,$03,$34
    BYTE $29,$7C,$00,$03,$38,$29,$7C,$00,$03,$3C,$29,$78,$00,$02,$40,$29
    BYTE $78,$00,$02,$44,$29,$78,$00,$02,$48,$29,$78,$00,$02,$1C,$1D,$7C
    BYTE $00,$03,$20,$1D,$7C,$00,$03,$50,$29,$80,$00,$04,$4C,$29,$84,$00
    BYTE $05,$94,$1D,$08,$02,$00,$E4,$29,$70,$00,$01,$E8,$29,$70,$00,$01
    BYTE $A8,$25,$70,$00,$01,$E0,$29,$70,$00,$01,$E8,$1C,$70,$00,$01,$B8
    BYTE $29,$48,$50,$00,$BC,$29,$48,$50,$00,$E0,$1C,$48,$50,$00,$DC,$1C
    BYTE $48,$50,$00,$D4,$1C,$48,$50,$00,$D8,$1C,$48,$50,$00,$A4,$1D,$70
    BYTE $00,$01,$C8,$29,$70,$00,$01,$D0,$29,$70,$00,$01,$DC,$29,$70,$00
    BYTE $01,$98,$1D,$08,$02,$00,$B0,$29,$84,$00,$05,$B4,$29,$28,$10,$00
    BYTE $AC,$29,$04,$01,$00,$E4,$1C,$70,$00,$01,$E4,$1C,$70,$00,$01,$E4
    BYTE $1C,$70,$00,$01,$CC,$10,$7C,$00,$03,$EC,$29,$08
bank2_data_B778
	BYTE $02,$00
	;the $EC in the line above is the cola can!
bank2_data_B77A
	BYTE $CD,$CB,$03,$CD,$D0,$03,$CD,$1C,$03,$CD,$30,$03,$CD,$C8
bank2_data_B788
	BYTE $02
bank2_call_B77A
    call call_03CB       ;clear screen
    call call_03D0       ;clear top layer
    call call_031C
    call call_0330
    call call_02C8
bank2_call_B789				;used for protection routine at $85c4
     nextreg $43,%00110000         ;tiles palette
     nextreg $40,$F0
     ld   hl,bank2_data_B9A4
    ;ld   de,l_f9e0			;TODO Palette
    ld   b,$10
bank2_call_B789_Loop
     call call_0B30_update_entry
     djnz bank2_call_B789_Loop
    ld   hl,$792E;$CDD6
    ld   de,bank2_data_B8BA
    ld   bc,$091A
    ;ld   a,$3F
    ex af,af'
    ld a,$F0	;gfx atrtibute
     ex af,af'
	ld  a,$23
     ;break
	call call_0EC6_Adjusted
    ld   hl,bank2_data_B7F0		;'BUT THIS WAS NOT A TRUE ENDING'
    ld   de,$774C;$D58A
    ld   c,$00
    call call_0E9A
    ld   hl,bank2_data_B80E
    ld   de,$77EC;$D58E
    ld   c,$00
    call call_0E9A
    ld   hl,bank2_data_B82C
    ld   de,$788C;$D592
    ld   c,$00
    call call_0E9A
    ld   hl,bank2_data_B84A
    ld   de,$7C4C;$D5AA
    ld   c,$00
    call call_0E9A
    ld   hl,bank2_data_B867
    ld   de,$7CEC;$D5AE
    ld   c,$00
    call call_0E9A
    ld   hl,bank2_data_B883
    ld   de,$7D8C;$D5B2
    ld   c,$00
    call call_0E9A
    ld   hl,bank2_data_B89F
    ld   de,$7E2C;$D5B6
    ld   c,$00
    call call_0E9A
    ret
bank2_data_B7F0
	BYTE $1d,"BUT IT WAS NOT A TRUE ENDING!"
bank2_data_B80E
	BYTE $1d,"WRITE 8 BIG WORDS ON A PAPER."
bank2_data_B82C
	BYTE $1d,"THIS IS A KEY OF SECRET GAME."
bank2_data_B84A
	BYTE $1C,"----HINTS OF THIS WORDS!----"
bank2_data_B867
	BYTE $1B," NO MISS CLEAR! ROUND 1-20!"
bank2_data_B883
	BYTE $1B," & ENTER THE SILVER DOOR !!"
bank2_data_B89F
	BYTE $1A,"   YOU WILL FIND ",$22,"ABCD...",$22	;$22 IS QUOTE MARK
bank2_data_B8BA
	BYTE $38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38
	BYTE $38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$39,$3A,$3B,$3C,$3C
	BYTE $3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3D
	BYTE $3E,$3F,$40,$38,$38,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B
	BYTE $4C,$4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$38,$38,$59
	BYTE $5A,$5B,$5C,$5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D,$5D
	BYTE $5D,$5D,$5D,$5E,$5F,$60,$61,$38,$38,$62,$63,$64,$65,$66,$67,$68
	BYTE $69,$6A,$6B,$6C,$6D,$6E,$6B,$68,$69,$66,$67,$6F,$70,$71,$64,$72
	BYTE $73,$38,$38,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$6C,$7E,$7F
bank2_data_B94A
	BYTE $80,$7A,$7B,$78,$79,$81,$82,$83,$76,$84,$85,$38,$38,$86,$87,$88
	BYTE $89,$8A,$8B,$8C,$8D,$8E,$8F,$90,$91,$92,$93,$8C,$8D,$8A,$8B,$94
	BYTE $95,$96,$88,$97,$98,$38,$38,$99,$9A,$9B,$9B,$9B,$9B,$9B,$9B,$9B
	BYTE $9B,$9B,$9B,$9B,$9B,$9B,$9B,$9B,$9B,$9B,$9B,$9B,$9B,$9C,$9D,$38
	BYTE $38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38
	BYTE $38,$38,$38,$38,$38,$38,$38,$38,$38,$38
bank2_data_B9A4
	BYTE $FF,$F0,$0F,$00,$0D,$F0
	BYTE $FA,$00,$80,$F0,$33,$00,$33,$00,$88,$00,$66,$00,$44,$00,$FA,$00
	BYTE $FF,$00,$F8,$00,$F7,$00,$B6,$00,$00,$00
bank2_call_B9C4
    ld   hl,l_f624
    ld   bc,$0044
    jp   clearbytes
    
	
;Code for the flames
;flame structure
;00 - Active?
;01 - row in pixels
;02 - column in pixels

bank2_call_B9CD
     ld   ix,l_f628
     ld   a,$08
bank2_call_B9D3
     push af
     ld   a,(ix+$00)
     bit  0,a
     jp   nz,bank2_call_BA1D
     ld   a,(l_e737)
     and  a
     jp   nz,bank2_call_BAAA
     ld   a,(l_f590)
     and  a
     jp   nz,bank2_call_BAAA
     call bank2_call_A7E3
     ld   hl,l_f624
     bit  0,(hl)
     jp   z,bank2_call_BAAA
     ld   (hl),$00
     inc  hl
     ld   a,(hl)
     and  $F8			;mask off pixels to set to an 8 pixel boundary
     ld   (ix+$01),a
     inc  hl
     ld   a,(hl)
     ld   (ix+$03),a
     inc  hl
     ld   a,(hl)
     ld   (ix+$04),a
     call resetframetimer;call_1556
     set  0,(ix+$00)
;     ld   a,($0004)
;     ld   de,$00B9
;     sub  e
;     jr   z,bank2_call_BA1A
;     push af
;     push bc
bank2_call_BA1A
     jp   bank2_call_BAAA

bank2_call_BA1D
     inc  (ix+$06)				;increase fire frame timer
     ld   a,(ix+$06)
     cp   $08					;has it reached 8
     jp   nz,bank2_call_BAAA	;if not - skip next frame code 
     ld   (ix+$06),$00			;reset frame timer
     inc  (ix+$05)	
     ld   a,(ix+$05)
     cp   $1F
     jp   z,bank2_call_BAA6
     ld   (ix+$07),$00
     ld   a,(l_f54b)
     and  a
     jr   nz,bank2_call_BA47
     ld   a,(l_ed3d)
     and  a
     jr   nz,bank2_call_BA52
bank2_call_BA47
     ld   a,(ix+$05)
     cp   $1A
     jr   nc,bank2_call_BA52
     ld   (ix+$05),$1A
bank2_call_BA52
     ld   a,(ix+$07)
     add  a,a
     add  a,a
     add  a,a
     bit  0,(ix+$04)
     jr   z,bank2_call_BA60
     neg
bank2_call_BA60
     add  a,(ix+$03)
     ld   (ix+$02),a
     call call_166B
     jr   nz,bank2_call_BAAA
     ld   h,(ix+$02)
     ld   a,(ix+$01)
     call call_174C
     jr   z,bank2_call_BAAA
     call call_16E1					;convert HL as row/column coords into tilemap address
     push hl
     ld   a,(ix+$05)
     ld   hl,bank2_data_BB40		;data structure for fire element
     call call_0DA7					;double a and put value at HL+A offset into DE
     pop  hl
     ld   (hl),e
     inc  hl
     ld   (hl),d
     call bank2_call_BAE5
     ld   a,(ix+$05)
     cp   $05
     jr   c,bank2_call_BA9A
     cp   $19
     ld   e,$03
     jr   nc,bank2_call_BA9A
     call bank2_call_BAB5
bank2_call_BA9A
     inc  (ix+$07)
     ld   a,(ix+$07)
     cp   $10
     jr   nz,bank2_call_BA52
     jr   bank2_call_BAAA
bank2_call_BAA6
     ld   (ix+$00),$00
bank2_call_BAAA
     ld   de,$0008
     add  ix,de
     pop  af
     dec  a
     jp   nz,bank2_call_B9D3
     ret
     
bank2_call_BAB5
     ld   bc,$0808
     call call_13F0
     ret  nc
     and  a
     jr   nz,bank2_call_BAD2
     ld   a,(l_e6be)
     bit  5,a
     ret  nz
     ld   a,(l_e6b6)
     and  a
     ret  nz
     ld   a,(l_e6a4)
     and  a
     ret  nz
     jp   call_4B51
bank2_call_BAD2
     ld   a,(l_e6f0)
     bit  5,a
     ret  nz
     ld   a,(l_e6e8)
     and  a
     ret  nz
     ld   a,(l_e6d6)
     and  a
     ret  nz
     jp   call_4B5D

     

bank2_call_BAE5
     ld   e,(ix+$01)
     ld   d,(ix+$02)
     call bank2_call_BB0F
     ret  nc
     ld   (hl),$10
     inc  hl
     inc  hl
     inc  hl
     ld   (hl),$09
     ld   hl,l_e5f3
     inc  (hl)
     ld   hl,l_ed3d
     dec  (hl)
     ld   c,$25
     call call_1350
;     ld   hl,$044D
;     ld   bc,($0B2E)
;     xor  a
;     sbc  hl,bc
;     ret  z
     ret
;     ex   (sp),hl
bank2_call_BB0F
     ld   b,$00
     ld   hl,l_ed21
bank2_call_BB14
     bit  0,(hl)
     jp   z,bank2_call_BB33
     push hl
     inc  hl
     ld   a,(hl)
     sub  e
     jp   p,bank2_call_BB22
     neg
bank2_call_BB22
     cp   $08
     jp   nc,bank2_call_BB31
     inc  hl
     ld   a,(hl)
     sub  d
     jp   p,bank2_call_BB2F
     neg
bank2_call_BB2F
     cp   $08
bank2_call_BB31
     pop  hl
     ret  c
bank2_call_BB33
     inc  hl
     inc  hl
     inc  hl
     inc  hl
     inc  b
     ld   a,b
     cp   $07
     jp   nz,bank2_call_BB14
     xor  a
     ret


bank2_data_BB40
;revised data for fire - with next gfx attributes
    BYTE $DF,$90,$DE,$90,$DD,$90,$DC,$90,$DB,$90,$DA,$90,$DA,$98,$DA,$90
    BYTE $DA,$98,$DA,$90,$DA,$98,$DA,$90,$DA,$98,$DA,$90,$DA,$98,$DA,$90
    BYTE $DA,$98,$DA,$90,$DA,$98,$DA,$90,$DA,$98,$DA,$90,$DA,$98,$DA,$90
    BYTE $DA,$98,$DB,$90,$DC,$90,$DD,$90,$DE,$90,$DF,$90,$00,$00,$21,$98
    BYTE $FF,$36,$47,$FB,$3E,$EF,$32,$00,$FA,$3E,$56,$32,$40,$FB,$3E,$76
    BYTE $32,$40,$FB,$21,$68,$F6,$36,$00,$23,$36,$01,$23,$36,$00,$CD,$27
    BYTE $04,$01,$00,$20,$11,$00,$C0,$C5,$AF,$06,$05,$F5,$21,$35,$BC,$CD
    BYTE $89,$0D,$7E,$12,$1A,$BE,$28,$05,$0E,$EF,$CD,$27,$BC,$F1,$3C,$10
    BYTE $EA,$C1,$0B,$79,$B0,$13,$20,$DF,$01,$00,$02,$11,$00,$F8,$C5,$AF
    BYTE $06,$05,$F5,$21,$35,$BC,$CD,$89,$0D,$7E,$12,$1A,$BE,$28,$05,$0E
    BYTE $EF,$CD,$27,$BC,$F1,$3C,$10,$EA,$C1,$0B,$79,$B0,$13,$20,$DF,$21
    BYTE $69,$F6,$35,$20,$A9,$3E,$00,$32,$00,$FA,$06,$00,$10,$FE,$21,$68
    BYTE $F6,$11,$3A,$BC,$3A,$6A,$F6,$87,$CD,$84,$0D,$1A,$FE,$88,$20,$06
    BYTE $23,$23,$36,$00,$18,$DF,$77,$13,$23,$1A,$77,$23,$34,$21,$00,$FA
    BYTE $3A,$68,$F6,$77,$C3,$9E,$BB,$F5,$CD,$31,$04,$79,$21,$00,$F8,$77
    BYTE $CD,$27,$04,$F1,$C9,$10,$20,$40,$80,$FF,$07,$10,$08,$10,$09,$10
/*
	;original data for fire
    BYTE $DF,$1C,$DE,$1C,$DD,$1C,$DC,$1C,$DB,$1C,$DA,$1C,$DA,$5C,$DA,$1C
    BYTE $DA,$5C,$DA,$1C,$DA,$5C,$DA,$1C,$DA,$5C,$DA,$1C,$DA,$5C,$DA,$1C
    BYTE $DA,$5C,$DA,$1C,$DA,$5C,$DA,$1C,$DA,$5C,$DA,$1C,$DA,$5C,$DA,$1C
    BYTE $DA,$5C,$DB,$1C,$DC,$1C,$DD,$1C,$DE,$1C,$DF,$1C,$00,$00,$21,$98
    BYTE $FF,$36,$47,$FB,$3E,$EF,$32,$00,$FA,$3E,$56,$32,$40,$FB,$3E,$76
    BYTE $32,$40,$FB,$21,$68,$F6,$36,$00,$23,$36,$01,$23,$36,$00,$CD,$27
    BYTE $04,$01,$00,$20,$11,$00,$C0,$C5,$AF,$06,$05,$F5,$21,$35,$BC,$CD
    BYTE $89,$0D,$7E,$12,$1A,$BE,$28,$05,$0E,$EF,$CD,$27,$BC,$F1,$3C,$10
    BYTE $EA,$C1,$0B,$79,$B0,$13,$20,$DF,$01,$00,$02,$11,$00,$F8,$C5,$AF
    BYTE $06,$05,$F5,$21,$35,$BC,$CD,$89,$0D,$7E,$12,$1A,$BE,$28,$05,$0E
    BYTE $EF,$CD,$27,$BC,$F1,$3C,$10,$EA,$C1,$0B,$79,$B0,$13,$20,$DF,$21
    BYTE $69,$F6,$35,$20,$A9,$3E,$00,$32,$00,$FA,$06,$00,$10,$FE,$21,$68
    BYTE $F6,$11,$3A,$BC,$3A,$6A,$F6,$87,$CD,$84,$0D,$1A,$FE,$88,$20,$06
    BYTE $23,$23,$36,$00,$18,$DF,$77,$13,$23,$1A,$77,$23,$34,$21,$00,$FA
    BYTE $3A,$68,$F6,$77,$C3,$9E,$BB,$F5,$CD,$31,$04,$79,$21,$00,$F8,$77
    BYTE $CD,$27,$04,$F1,$C9,$10,$20,$40,$80,$FF,$07,$10,$08,$10,$09,$10
*/

ENDBANK2
     BYTE "END OF BANK2"