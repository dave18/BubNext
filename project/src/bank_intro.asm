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

intro_call_18EE
    ld   a,(l_e5c4)     ;row number
    cp   $20-$2
    ret  nc;z
    call intro_call_1942  ;clear current row
    call intro_call_1958  ;draw one line of level data
    ;call intro_call_6065  ;ret
    call intro_call_199C  ;add shadows
    call intro_call_1A93  ;changes side panels
	
    ld   hl,l_e5c4	;get row number address
    inc  (hl)		;increase row number
    ld   a,(hl)		;get new row number into a
    cp   $20-$2		;is it last row?
    jr   nz,intro_call_1922  ;if not skip past next code
    ld   a,$1E-$2		;set A to row 30
    ld   (l_e5c4),a ;store in row number
    call intro_call_1A99	;call side borders again for this row???
    ld   a,$1F-$2		;set A to row 31
    ld   (l_e5c4),a ;store in row number
    call intro_call_1A99	;call side borders again for this row???
    ld   hl,l_e5c4		;row number
    ld   (hl),$20		;set to 32

    ret
intro_call_1922
    ld   a,(l_e5c3)		;what is this checking???
    and  a
    jr   z,intro_call_18EE	;loop to complete next row
    ret
intro_call_1929
	
    ld   a,(l_e64b) ;level num
    ;push af
	;ld hl,$0085
    ;pop  bc
    ld   h,15*16;$3C
	ld	 l,$85+$5
    bit  0,a
    jr   nz,intro_call_193F
    ld   h,14*16;$38
	ld	 l,$85
intro_call_193F
    ;or   h
    ;ld   h,a
    ret
intro_call_1942
    ld   a,(l_e5c4)		;row number
	ld b,$50
	call call_0DB1  ;a * b into HL	;80 bytes per row

/*    ld   a,(l_e64b) ;level num
    bit  0,a
    ld   a,15*16;$3C	    
    jr   nz,intro_call_1942_1
    ld   a,14*16;$38
intro_call_1942_1*/

    ;add  a,a
    ;ld   hl,l_cd00
	ld   de,$7608-$50;$76F8
    ld   b,$20
    ;call adda2hl;call_0D89
	add  hl,de
intro_call_194B 
    ld   (hl),$00
    inc  hl
    //ld   (hl),a;$00
    ld   (hl),$00
    inc  hl
    djnz intro_call_194B
    ld   a,(l_e5c4)
    ret
intro_call_1958
    ld   a,(l_e5c4)		;row number
    push af
    ld   b,$10			;each tile is represented by a nibble so we need to multiply by 16 (32 cols)
    call call_0DB1			;a * b - row number * 16 into HL
    ld   de,l_e398		;location that decoded level data is held
    add  hl,de			;add on row number
    pop  af				;retrieve row number
	push hl				;save hl as need to trash it
	ld   b,$50
	call call_0DB1  	;a * b into HL	;80 bytes per row
	ex	 de,hl			;move it into DE
	pop  hl				;restore level offset
    ld   iy,$7608-$50;$76F8		;base screen location
    add  iy,de			;add row position to screen loc
    ld   b,$10			;outer loop counter of 16
intro_call_1972    
	push bc				;store as inner loop also needs to use bc counter
    ld   b,$02			;inner loop counter of 2
    ld   a,(hl)			;get byte (representing 2 tiles as each tile is a nibble)
intro_call_1976 
   ld   c,a			;save a into c
    and  $F0			;is the a value in the first nibble?
    ld   a,c			;retrieve a from c
    jr   nz,intro_call_198D	;if first nibble not zero (ie isn't a platform) then skip next code to draw platform
    ex   af,af'			;switch register set
    exx
    call intro_call_1929			;calc gfx offset
    inc  hl				;return address of 1st of the 5 level tiles (4 panel + 1 platform)
    inc  hl				;so inc 4 times to use the platform tile
    inc  hl
    inc  hl
    ld   (iy+$00),l		;and store the tile number
    ld   (iy+$01),h		;plus the bank, colour and flip info
    exx					;switch register set
    ex   af,af'
intro_call_198D
    call mul16			;multiply a by 16 to shift second nibble into 4 msbs
    ;ld   de,$0040		;move to next
    ;add  iy,de			;screen column
	inc iy
	inc iy				;move to next screen column
    djnz intro_call_1976			;and repeat for second nibble (now shifted into 4 msbs)
    inc  hl				;move to next 2 tiles
    pop  bc				;retrieve outer loop counter
    djnz intro_call_1972			;and loop until 0
    ret
intro_call_199C

    ld   a,(l_e5c4)		;row number
	ld b,$50
	call call_0DB1  ;a * b into HL	;80 bytes per row
	ex de,hl
    ld   iy,$7608-$50;$7f68
    add  iy,de
    call intro_call_1929
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   a,(l_e64b)
    ld   c,15*16;$3C
    bit  0,a
    jr   nz,intro_call_19BB
    ld   c,14*16;$38
intro_call_19BB
    ld   b,$20
intro_call_19BD
    ld   a,(iy+$00)
    or   (iy+$01)
    jp   nz,intro_call_1A6D
    ld   a,(iy-$50);02)
    cp   l
    jr   nz,intro_call_19E8
    ;ld   a,(iy-$4f);01)
    ;cp   h
    ;jr   nz,call_19E8
	ld   a,(iy-$50)
	cp   l;$AB
    jr   c,intro_call_19E8
    ld   a,(iy-$02);$40)
    cp   l
    jr   nz,intro_call_19E8
    ;ld   a,(iy-$01);$3f)
    ;cp   h
    ;jr   nz,call_19E8
	ld   a,(iy-$02)
	cp   l;$AB
    jr   c,intro_call_19E8
    ld   (iy+$00),$F0		;needs to be changed to F0 equivalent
    ld   (iy+$01),c
    jp   intro_call_1A6D
intro_call_19E8
     ld   a,(iy-$02);$40)
     cp   l
     jr   nz,intro_call_1A09
     ;ld   a,(iy-$01);$3f)
     ;cp   h
     ;jr   nz,call_1A09
	 ld   a,(iy-$02)
	 cp   l;$AB
     jr   c,intro_call_1A09
     ld   a,(iy-$52);$42)
     cp   l
     jr   z,intro_call_1A09
     ;ld   a,(iy-$51);$41)
     ;cp   h
     ;jr   z,call_1A09
     ;ld   a,(iy-$52)
	 ;cp   l;$AB
     ;jr   nc,call_1A09
	 ld   (iy+$00),$F1			;needs to be changed to F1 equivalent
     ld   (iy+$01),c
     jr   intro_call_1A6D
intro_call_1A09
     ld   a,(iy-$50);$02)
     cp   l
     jr   nz,intro_call_1A2A
     ;ld   a,(iy-$4f);$01)
     ;cp   h
     ;jr   nz,call_1A2A
	 ld   a,(iy-$50)
	 cp   l;$AB
     jr   c,intro_call_1A2A
     ld   a,(iy-$52);$42)
     cp   l
     jr   nz,intro_call_1A2A
     ;ld   a,(iy-$51);$41)
     ;cp   h
     ;jr   nz,call_1A2A
	 ld   a,(iy-$52)
	 cp   l;$AB
     jr   c,intro_call_1A2A
     ld   (iy+$00),$F2			;needs to be changed to F2 equivalent
     ld   (iy+$01),c
     jr   intro_call_1A6D
intro_call_1A2A
     ld   a,(iy-$52);$42)
     cp   l
     jr   nz,intro_call_1A45
     ;ld   a,(iy-$51);$41)
     ;cp   h
     ;jr   nz,call_1A45
	 ;ld   a,(iy-$52)
	 ;cp   l;$AB
     ;jr   z,call_1A45
     ;ld   a,(iy-$01);$3f)
     ;cp   h
	 ;jr   z,call_1A45
	 ld   a,(iy-$02)
	 cp   l;$AF
     jr   z,intro_call_1A45
;	 cp   $AE
;     jr   z,call_1A45
;	 cp   $AC
;     jr   z,call_1A45
     ld   (iy+$00),$F3			;needs to be changed to F3 equivalent
     ld   (iy+$01),c
     jr   intro_call_1A6D
intro_call_1A45
      ld   a,(iy-$02);$40)
      cp   l
      jr   nz,intro_call_1A5A
      ;ld   a,(iy-$01);$3f)
      ;cp   h
      ;jr   nz,call_1A5A
	  ld   a,(iy-$02)
	  cp   l;$AB
      jr   c,intro_call_1A5A
      ld   (iy+$00),$F4			;needs to be changed to F4 equivalent
      ld   (iy+$01),c
      jr   intro_call_1A6D
intro_call_1A5A
      ld   a,(iy-$50);$02)
      cp   l
      jr   nz,intro_call_1A6D
      ;ld   a,(iy-$4f);$01)
      ;cp   h
      ;jr   nz,call_1A6D
	  ld   a,(iy-$50)
	  cp   l;$AB
      jr   c,intro_call_1A6D
      ld   (iy+$00),$F5			;needs to be changed to F5 equivalent
      ld   (iy+$01),c
intro_call_1A6D
      ld   de,$0002;$0040
      add  iy,de
      dec  b
      jp   nz,intro_call_19BD
      ld   a,(l_e5c4)
      and  a
      ret  nz
      ld   a,(l_e59b)
      bit  7,a
      jr   nz,intro_call_1A87
      ld   hl,$CF40
      ;ld   (hl),$F4				;needs to be changed to F4 equivalent
intro_call_1A87
      ld   a,(l_e59b)
      bit  5,a
      ret  nz
;      ld   hl,$D1C0
;      ld   (hl),$F4
      ret
	  
;draw borders (ie the large tiles on each side)
intro_call_1A93
      ld   a,(l_e5c4)		;row number
      sub  $02
      ret  c
intro_call_1A99
      ld b,$50
	  call call_0DB1  ;a * b into HL	;80 bytes per row
	  ex de,hl
      push de
      ld   iy,$7608-$50;$7f68
      call intro_call_1AAA
      pop  de
      ld   iy,$7644-$50
intro_call_1AAA
      add  iy,de
      call intro_call_1929
      ex   de,hl
      inc  de
      inc  de
      inc  de
      inc  de				;de points to small tile?
      ld   l,(iy+$00)		;get current tile bytes into HL
      ld   h,(iy+$01)
      and  a				;clear carry
      sbc  hl,de			;check against standard level small tile
      jr   z,intro_call_1ACD		;if match jp to 1ACD (to draw big tile)
      xor  a				;else zero a
      ld   (iy+$00),a		;and draw 4 blank tiles
      ld   (iy+$01),a
      ld   (iy+$02),a;$40),a
      ld   (iy+$03),a;$41),a
      ret
intro_call_1ACD
      dec  de				;change DE to point to first of the 4 big tiles
      dec  de
      dec  de
      dec  de
      ld   a,(l_e5c4)		;get row number
      bit  0,a				;check odd/even row
      jr   z,intro_call_1ADA		;odd row skip to 1ADA
      inc  de				;if even row change tile pointer to be bottom 2 big tiles
      inc  de
intro_call_1ADA
      ld   (iy+$00),e
      ld   (iy+$01),d
      inc  de
      ld   (iy+$02),e
      ld   (iy+$03),d
      ld   a,(l_fc85)
      bit  1,a
      ret

intro_call_2578					;this code is run once start button is pressed
    /*ld a,0
    ld (options_control),a*/
    /*ld a,0;hl,MODULE1
    ld (music_module),a
    ld a,2
    ld (music_playing),a*/
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

intro_call_2941

    ld a,0
    ld (options_control),a

    call call_03D0
    call call_031C
    call call_0330
    call call_3395
    call call_02C8
    ld   hl,intro_data_2AE1
    ld   de,$7898;D712
    ld   c,$00
    call call_0E9A
    ld   hl,intro_data_2AF2
    ld   de,$7C64;D8AA
    ld   c,$00
    call call_0E9A    
    ld   hl,$7A32;D05C
    ld   de,intro_data_2A55
    ld   bc,$0406       ;$18 Bytes
    ;ld   a,$1F
    ex af,af'
	ld a,$07*16	;gfx atrtibute
	ex af,af'
	ld a,$00
    call call_0EC6_Adjusted

    ld   hl,$7CB6;D0EC
    ld   de,intro_data_2A6D
    ld   bc,$0202       ;$18 Bytes
    ;ld   a,$1F
    ex af,af'
	ld a,$07*16	;gfx atrtibute
	ex af,af'
	ld a,$00
    call call_0EC6_Adjusted  
    call intro_call_29CB
    ld   bc,$04B0
intro_call_2988
    call call_0020
    push bc
    bit  3,c
    jr   nz,intro_call_299B
    ld   hl,intro_data_2AF2
    ld   de,$7C64;D8AA
    ld   c,$00
    call call_0E9A
    jr   intro_call_29A6
intro_call_299B
    ld   hl,intro_data_2AF2
    ld   de,$7C64;D8AA
    ld   c,$10
    call call_0E9A
intro_call_29A6
    ld   a,(l_fc22)
    bit  0,a
    call z,intro_call_29CB
    ld   a,(l_fc22)
    bit  1,a
    call z,intro_call_29FB
    pop  bc
    ld   a,(l_fc22)
    bit  4,a
    ret  z
    bit  5,a
    ret  z
    dec  bc
    ld   a,c
    or   b
    jr   nz,intro_call_2988
    ld   hl,l_e5db
    ld   (hl),$00
    ret
intro_call_29CB
    ld   hl,$7A20;CE1C
    ld   de,intro_data_2A8D
    ld   bc,$0407
    ex af,af'
	ld a,$07*16	;gfx atrtibute
	ex af,af'
	ld a,$00
    call call_0EC6_Adjusted
    ld   hl,$7A42;D25C
    ld   de,intro_data_2AA9
    ld   bc,$0407
    ex af,af'
	ld a,$07*16	;gfx atrtibute
	ex af,af'
	ld a,$00
    call call_0EC6_Adjusted
    ld   hl,$7A32;D05C
    ld   de,intro_data_2A55
    ld   bc,$0406
    ex af,af'
	ld a,$07*16	;gfx atrtibute
	ex af,af'
	ld a,$00
    call call_0EC6_Adjusted
    ld   hl,l_e5db
    ld   (hl),$00
    ret
intro_call_29FB
    ld   hl,$7A20;CE1C
    ld   de,intro_data_2A71
    ld   bc,$0407
    ex af,af'
	ld a,$07*16	;gfx atrtibute
	ex af,af'
	ld a,$00
    call call_0EC6_Adjusted
    ld   hl,$7A42;D25C
    ld   de,intro_data_2AC5
    ld   bc,$0407
    ex af,af'
	ld a,$07*16	;gfx atrtibute
	ex af,af'
	ld a,$00
    call call_0EC6_Adjusted
    ld   hl,l_e5db
    ld   (hl),$01
    ld   hl,$7A82;D05E
    ld   (hl),$AE
    inc  hl
    ld   (hl),$78
    inc  hl
    ld   (hl),$AD;BA
    inc  hl
    ld   (hl),$78
    ld   hl,$7AD2;D09E
    ld   (hl),$BA
    inc  hl
    ld   (hl),$78
    inc  hl
    ld   (hl),$B9
    inc  hl
    ld   (hl),$78
    ld   hl,$7A8A;D15E
    ld   (hl),$AA
    inc  hl
    ld   (hl),$78
    inc  hl
    ld   (hl),$A9;B6
    inc  hl
    ld   (hl),$78
    ld   hl,$7ADA;D19E
    ld   (hl),$B6;A9
    inc  hl
    ld   (hl),$78
    inc  hl
    ld   (hl),$B5
    inc  hl
    ld   (hl),$78
    ret
intro_data_2A55
   	BYTE $9E,$9E,$A2,$A3,$9E,$9E,$A9,$AA,$AB,$AC,$AD,$AE,$B5,$B6,$B7,$B8
	BYTE $B9,$BA,$9E,$9E,$BD,$BE,$9E,$9E
intro_data_2A6D
    BYTE $C2,$C3,$C9,$CA
intro_data_2A71
	defb $9F,$A0,$A0,$A0,$A0,$A0,$A1,$A0,$A4,$A5,$B3,$A6,$A7,$A8,$A0,$A0
	defb $B4,$A7,$A6,$B2,$A0,$BB,$A0,$A0,$A0,$A0,$A0,$BC
intro_data_2A8D
   	BYTE $BF,$C0,$C0,$C0,$C0,$C0,$C1,$C0,$C4,$C5,$CF,$C6,$C7,$C8,$C0,$C0
	BYTE $D0,$C7,$C6,$CE,$C0,$D1,$C0,$C0,$C0,$C0,$C0,$D2
intro_data_2AA9
	defb $9F,$A0,$A0,$A0,$A0,$A0,$A1,$A0,$AF,$B0,$B1,$B2,$B3,$A0,$A0,$A0
	defb $B4,$A7,$A6,$B2,$A0,$BB,$A0,$A0,$A0,$A0,$A0,$BC
intro_data_2AC5
	defb $BF,$C0,$C0,$C0,$C0,$C0,$C1,$C0,$CB,$CC,$CD,$CE,$CF,$C0,$C0,$C0
	defb $D0,$C7,$C6,$CE,$C0,$D1,$C0,$C0,$C0,$C0,$C0,$D2


intro_data_2AE1
    BYTE $10,"SELECT GAME MODE"
intro_data_2AF2
    BYTE $4,"PUSH"
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
	ld a,$8c
	ld de,$0008
	ld c,iyl
	call Layer2_Write_Char
	ld a,$8b
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
    ;ld a,0
    ;ld (music_playing),a
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
    ld (highscoreupdate),a
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


;Record Screen
intro_call_38FC
    ld   ix,l_e682
    ld   (ix+$01),$00
    ld   a,(l_e644)
    ld   (ix+$02),a
    ld   a,(l_e5d3)
    and  a
    jr   z,intro_call_3916
    ld   a,(l_e67c)
    ld   (ix+$02),a
intro_call_3916
    ld   ix,l_e689
    ld   (ix+$01),$01
    ld   a,(l_e649)
    ld   (ix+$02),a
    ld   a,(l_e5d3)
    and  a
    jr   z,intro_call_3930
    ld   a,(l_e67d)
    ld   (ix+$02),a
intro_call_3930
    ld   hl,l_e20d
    ld   de,$0000
    ld   b,$28
intro_call_3938
    call call_18A5
    ld   de,intro_data_3D02
    ld   hl,l_e20d
    ld   b,$28
intro_call_3943
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
    djnz intro_call_3943
    ld   hl,l_e220
    set  6,(hl)
    ld   hl,l_e234
    set  6,(hl)
    ld   hl,intro_data_3D88
    ld   bc,$041F
    ld   e,$00
    call call_14C0
    ld   hl,intro_data_3D7A
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
    jr   nz,intro_call_398C
    ld   a,$64
intro_call_398C
    call intro_call_3C57
    ld   a,$BA
    sub  h
    ld   (l_e241),a
    ld   (l_e291),a
    ld   a,(l_e5d8)
    and  a
    jr   nz,intro_call_39A6
    ld   hl,l_e67e
    set  1,(hl)
    jp   intro_call_39DB
intro_call_39A6
    ld   hl,intro_data_3D88
    ld   bc,$0423
    ld   e,$05
    call call_14C0
    ld   hl,intro_data_3D81
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
    jr   intro_call_39DB
;    rst  $38
/*intro_call_39D8
    ld   a,$05				;failed protection check?!
    call call_0018*/
intro_call_39DB
    ld   a,(l_e67e)
    cp   $03
    jp   nz,intro_call_3A79
    ld   hl,intro_data_3DC4
    ld   de,$774a;$D54A
    ld   c,3*16;$00
    call call_0E9A	;writetext "TODAY'S RECORD IS"
    ld   hl,l_e680
    inc  (hl)
    bit  2,(hl)
    jr   nz,intro_call_3A41
    ld   a,$23
    ld   bc,$F81E
    call call_147D
    ld   a,(l_e5d8)
    and  a
    jr   z,intro_call_3A0C
    ld   a,$28
    ld   bc,$F822
    call call_147D
intro_call_3A0C
    ld   hl,intro_data_3DD6
    ld   de,$776E;$D9CA
    ld   c,4*16
    call call_0E9A			;writetext "ROUND "      ""
    ld   iy,$777e;$DBCA
    ld   a,(l_e67b)			;best level reached
    inc  a
    cp   $65
    jr   nz,intro_call_3A31
    ld   (iy-$02),$41
    ld   (iy+$00),$4C
    ld   (iy+$02),$4C
    jr   intro_call_3A34
intro_call_3A31
    call call_0FC2
intro_call_3A34
    ld   a,4*16
    ld   (iy-$01),a
    ld   (iy+$01),a
    ld   (iy+$03),a
    jr   intro_call_3A5C
intro_call_3A41
    ld   hl,intro_data_3DE3
    ld   de,$776C;$D9CA
    ld   c,4*16;$04
    call call_0E9A		;writetext "                "
    ld   a,$23
    ld   bc,$001E
    call call_147D
    ld   a,$28
    ld   bc,$0022
    call call_147D
intro_call_3A5C
    ld   hl,l_e67f
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    jr   nz,intro_call_3A79
    ld   a,$00
    ld (music_playing),a
;    ld   ($FA00),a				;Sound IO - Stop Record Screen sound
    call call_03CB
    call call_03D0
    call call_041E
    call call_031C
    jp   call_0372
intro_call_3A79
    ld   ix,l_e682
    ld   b,$02
intro_call_3A7F
    push bc
    bit  0,(ix+$01)
    jp   nz,intro_call_3B63
    ld   de,$0302
    call call_15CA
    push af
    add  a,a
    add  a,a
    ld   hl,intro_data_3D8C
    call call_0D89
    ld   bc,$041F
    ld   e,$04
    call call_14C0
    ld   a,$43
    ld   bc,$C80F			;This is a gfx code for the 'Round' sprite
    pop  de
    bit  0,d
    jr   z,intro_call_3AAD
    call call_147D
    jr   intro_call_3AB0
intro_call_3AAD
    call call_149C
intro_call_3AB0
    bit  0,(ix+$00)
    jp   nz,intro_call_3C4A
    ld   a,(ix+$03)
    cp   (ix+$02)
    jr   nz,intro_call_3AC8
    ld   (ix+$00),$01
    ld   hl,l_e67e
    set  0,(hl)
intro_call_3AC8
    inc  (ix+$03)
    ld   a,(ix+$03)
    cp   $65
    jr   nz,intro_call_3AD4
    ld   a,$64
intro_call_3AD4
    call intro_call_3C57
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
    jr   z,intro_call_3B47
    cp   $65
    jr   z,intro_call_3B55
    call call_1040
    ld   a,b
    push bc
    add  a,a
    ld   hl,intro_data_3D94
    call call_0D89
    ld   bc,$021F
    ld   e,$00
    call call_14C0
    pop  bc
    ld   a,c
    add  a,a
    ld   hl,intro_data_3DA8
    call call_0D89
    ld   bc,$021F
    ld   de,$0200
    call call_14C2
    jp   intro_call_3C4A
intro_call_3B47
    ld   hl,intro_data_3DBC
    ld   bc,$041F
    ld   e,$00
    call call_14C0
    jp   intro_call_3C4A
intro_call_3B55
    ld   hl,intro_data_3DC0
    ld   bc,$041F
    ld   e,$00
    call call_14C0
    jp   intro_call_3C4A
intro_call_3B63
    ld   de,$0302
    call call_15CA
    push af
    ld   c,a
    ld   a,(l_e5d8)
    and  a
    jp   z,intro_call_3B83
    ld   a,c
    add  a,a
    add  a,a
    ld   hl,intro_data_3D8C
    call call_0D89
    ld   bc,$0423
    ld   e,$09
    call call_14C0
intro_call_3B83
    pop  de
    ld   a,$48
    ld   bc,$C81B
    bit  0,d
    jr   nz,intro_call_3B92
    call call_147D
    jr   intro_call_3B95
intro_call_3B92
    call call_149C
intro_call_3B95
    ld   a,(l_e5d8)
    and  a
    jp   z,intro_call_3C4A
    bit  0,(ix+$00)
    jp   nz,intro_call_3C4A
    ld   a,(ix+$03)
    cp   (ix+$02)
    jr   nz,intro_call_3BB4
    ld   (ix+$00),$01
    ld   hl,l_e67e
    set  1,(hl)
intro_call_3BB4
    inc  (ix+$03)
    ld   a,(ix+$03)
    cp   $65
    jr   nz,intro_call_3BC0
    ld   a,$64
intro_call_3BC0
    call intro_call_3C57
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
    jr   z,intro_call_3C32
    cp   $65
    jr   z,intro_call_3C3F
    call call_1040
    ld   a,b
    push bc
intro_call_3C0F
    add  a,a
    ld   hl,intro_data_3D94
    call call_0D89
    ld   bc,$0223
    ld   e,$05
    call call_14C0
    pop  bc
    ld   a,c
    add  a,a
    ld   hl,intro_data_3DA8
    call call_0D89
    ld   bc,$0223
    ld   de,$0205
    call call_14C2
    jr   intro_call_3C4A
intro_call_3C32
    ld   hl,intro_data_3DBC
    ld   bc,$0423
    ld   e,$05
    call call_14C0
    jr   intro_call_3C4A
intro_call_3C3F
    ld   hl,intro_data_3DC0
    ld   bc,$0423
    ld   e,$05
    call call_14C0
intro_call_3C4A
    pop  bc
    ld   de,$0007
    add  ix,de
    dec  b
    jp   nz,intro_call_3A7F
    jp   call_39D8
intro_call_3C57
    ld   b,$00
    ld   c,a
    ld   de,$019A
    jp   call_0DC1

/*intro_data_3CC2
	BYTE $FF,$F0,$00,$00,$0B,$00,$60,$00,$00,$F0,$90,$00,$40,$00,$09,$F0
	BYTE $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
	BYTE $FF,$F0,$00,$00,$08,$F0,$60,$00,$00,$F0,$90,$00,$40,$00,$09,$F0
	BYTE $0B,$F0,$F0,$70,$0A,$F0,$0F,$F0,$F8,$00,$F7,$70,$D4,$00,$00,$00*/
intro_data_3D02
	BYTE $C0,$0A,$15,$B0,$0A,$15,$C0,$1A,$15,$B0,$1A,$15,$C0,$FA,$14,$C0
	BYTE $2A,$14,$C0,$3A,$14,$C0,$4A,$14,$C0,$5A,$14,$B0,$FA,$14,$B0,$2A
	BYTE $14,$00,$00,$00,$C8,$68,$14,$B6,$68,$14,$18,$68,$16,$00,$00,$00
	BYTE $D0,$60,$14,$D0,$70,$14,$C0,$60,$14,$C0,$70,$14,$C0,$D6,$15,$B0
	BYTE $D6,$15,$C0,$E6,$15,$B0,$E6,$15,$C0,$96,$14,$C0,$A6,$14,$C0,$B6
	BYTE $14,$C0,$C6,$14,$C0,$F6,$14,$B0,$C6,$14,$B0,$F6,$14,$00,$00,$00
	BYTE $C8,$88,$14,$B6,$88,$14,$18,$88,$16,$00,$00,$00,$D0,$80,$14,$D0
	BYTE $90,$14,$C0,$80,$14,$C0,$90,$14
intro_data_3D7A
	BYTE $B4,$B8,$BC,$C0,$C4,$C8,$CC
intro_data_3D81
	BYTE $D0,$D4,$D8,$DC,$E0,$F0,$F4
intro_data_3D88
	BYTE $40,$54,$94,$A8
intro_data_3D8C
	BYTE $04,$08,$1C,$20,$0C,$10,$24,$28
intro_data_3D94
	BYTE $40,$54,$44,$58
	BYTE $48,$5C,$4C,$60,$50,$64,$68,$7C,$6C,$80,$70,$84,$74,$88,$78,$8C
intro_data_3DA8
	BYTE $90,$A4,$94,$A8,$98,$AC,$9C,$B0,$A0,$B4,$B8,$CC,$BC,$D0,$C0,$D4
	BYTE $C4,$D8,$C8,$DC
intro_data_3DBC
	BYTE $E0,$E8,$E4,$EC
intro_data_3DC0
	BYTE $F0,$F8,$F4,$FC
intro_data_3DC4
	BYTE $11,"TODAY'S RECORD IS"
intro_data_3DD6
	BYTE $0c,$22,"ROUND    ",$22," "
intro_data_3DE3
	BYTE $0c,"            "


intro_call_55DB
    ld   a,(l_e729)
    and  a
    jr   z,intro_call_55E5
    jp   m,intro_call_55FA
    ret
intro_call_55E5
    ld   hl,l_e729
    ld   (hl),$FF
    ld   hl,l_e72a
    ld   (hl),$78
    ld   hl,intro_data_560F
    ld   de,$5028;$D65E
    ld   c,$00
    ;jp   call_0E9A;writetext;$0E9A
    jp   Write_Layer2_Text
intro_call_55FA
    ld   hl,l_e72a
    dec  (hl)
    ret  nz
    ld   hl,l_e729
    ld   (hl),$01
    ld   hl,intro_data_5627
    ld   de,$5028;$D65E
    ld   c,$00
    ;jp   call_0E9A;writetext;0E9A
    jp   Write_Layer2_Text
    
intro_data_560F
    BYTE $17,"WELCOME TO SECRET ROUND"
    
intro_data_5627
    BYTE $17,"                       "

/*intro_call_563F
    ld   a,0
    ld  (intro_scroll_counter),a
    ld   hl,l_e5c4
    ld	 (hl),$00
    ld   hl,intro_bank1_data_90EA     ;1 Player ending
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,intro_call_565A
    ld   hl,intro_bank1_data_8D42     ;2 Player ending
    ld   a,(l_e5db)
    and  a
    jr   z,intro_call_565A
    ld   hl,intro_bank1_data_91BF     ;Real ending
intro_call_565A
    ld   (l_e734),hl
intro_call_565D
    call  call_0020
    ld   hl,l_e736
    inc  (hl)
    ld   a,(hl)
    cp   $04
    jr   nz,intro_call_565D
    ld   (hl),$00
    call intro_call_56AB      ;scroll screen and raise sprites
    ld   a,(l_e2f5)
    ;ld   a,(l_e1cd)
    and  $07
    jr   nz,intro_call_565D   ;if not scrolled 8 pixels don't write new line
    call intro_call_5701      ;clear line
    call intro_call_5719      ;write message
    ld   e,$3B      ;59 - number of scrolls lines in 1 player ending in
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,intro_call_568C
    ld   e,$AC      ;172 - number of scrolls lines in 2 player ending
    ld   a,(l_e5db)
    and  a
    jr   z,intro_call_568C
    ld   e,$AC      ;172 - number of scrolls lines in real ending
intro_call_568C
    ld a,(intro_scroll_counter)
    inc a
    cp 24
    jr nz,intro_call_568C_1
    ld a,0
intro_call_568C_1
    ld   (intro_scroll_counter),a
    ld   hl,l_e5c4
    inc  (hl)
    ld   a,(hl)
    cp   e
    jr   nz,intro_call_565D
    ld   hl,l_e5c4
    ld   (hl),$00
    ;ld   b,$10
    ld   hl,l_e2f5
    ld   (hl),$00
    ;ld   hl,l_e1cd
intro_call_569E
    ld a,0
    ld   (intro_scroll_counter),a
    ;ld   (hl),$00
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;djnz intro_call_569E
    
    ret
intro_call_56AB
;    ld   a,($0002) ;protection
;    cp   $5E
;    jr   z,$56B4
;    push af
;    push bc
    ;ld   b,$10
    ld   a,(l_e2f5)
    ;ld   hl,l_e1cd
intro_call_56B9
    inc  a
    cp $c0;24
    jr nz,intro_call_56B9_1
    ld a,0
intro_call_56B9_1
    ld (l_e2f5),a
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;djnz call_56B9
    ld   b,$10
    ld   hl,l_e20d      ;raise sprites
intro_call_56C5
    ld   a,(hl)
    and  a
    jr   z,intro_call_56CA
    inc  (hl)
intro_call_56CA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz intro_call_56C5
    ld   hl,l_e2c5
    ld   a,(hl)
    and  a
    jr   z,intro_call_56D8
    inc  (hl)
intro_call_56D8
    ld   hl,l_e2b5
    ld   a,(hl)
    and  a
    jr   z,intro_call_56E0
    inc  (hl)
intro_call_56E0
    ld   b,$08
    ld   hl,l_e255
intro_call_56E5
    ld   a,(hl)
    and  a
    jr   z,intro_call_56EA
    inc  (hl)
intro_call_56EA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz intro_call_56E5
    ld   b,$10
    ld   hl,l_e275
intro_call_56F5
    ld   a,(hl)
    and  a
    jr   z,intro_call_56FA
    inc  (hl)
intro_call_56FA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz intro_call_56F5
    ret*/
intro_call_5701
    //ld   a,(intro_scroll_counter)
    //and  $1F
    ;break
    //add  a,a

    //ld   a,(intro_scroll_counter)         ;row?
    ;and $1F
    
    add a,a				;x2
	add a,a				;x4
	add a,a				;x8
	ld d,a

    ld e,0
    
    ld b,$20
    ;ld b,(ix+$00)       ;length
    ;add  a,a                ;* 2
    ;ld   e,a
    ;ld   d,0
    ;add  hl,de

    ;ld   de,$7608;$D500
    ;add  hl,de
    
    ;ld   b,(ix+$00)
    call Clear_Layer2_Text
    ret
intro_call_5719
    ld (scroll_temp),a
    ld   e,$1E      ;rows in 1 player message (30)
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,intro_call_572C
    ld   e,$8B+$04      ;rows in 2 player message (139)
    ld   a,(l_e5db)
    and  a
    jr   z,intro_call_572C
    ld   e,$8B+$04      ;rows in real ending message (139)
intro_call_572C
    ld   a,(l_e5c4)
    cp   e
    ret  nc         ;return with writing if row is beyond last message line
    ;break
    ;ld   a,bank1
    ;call call_026C
    ld   hl,(l_e734)
intro_call_573A
    ;break
    ld   a,(hl)
    inc  hl
    cp   $FF
    jr   z,intro_call_576F
    ld   c,a
    /*ld   a,(ix+$00)     ;column
    inc  ix
    call call_0D8E      ;A * 64 and into DE (Column adjust)
    ld   hl,$D500       ;TODO screen locs
    add  hl,de
    ld   a,(l_e5c4)     ;row
    and  $1F
    add  a,a
    call call_0D89      ;add A to HL
    */
    ;break

    ld   a,(scroll_temp)         ;row?
    ;and $1F
    
    add a,a				;x2
	add a,a				;x4
	add a,a				;x8
	ld d,a

    ld  a,(hl)         ;column
    add a,a ;x2
    add a,a ;x4
    add a,a ;x8
    ld e,a
    
    inc hl              ;points to length
    ;ld b,(ix+$00)       ;length
    ;add  a,a                ;* 2
    ;ld   e,a
    ;ld   d,0
    ;add  hl,de

    ;ld   de,$7608;$D500
    ;add  hl,de
    
    ;ld   b,(ix+$00)
    call Write_Layer2_Text
    
;    inc  ix
;intro_call_575E
;    ld   a,(ix+$00)
;    ld   (hl),a
;    inc  hl
;    inc  ix
;    ld   (hl),c
    ;ld   a,$3F
    ;call call_0D89
;    inc hl
 ;   djnz intro_call_575E
    jr   intro_call_573A
intro_call_576F
    ld   (l_e734),hl
    ;jp   call_029B
    ret
scroll_temp
    BYTE $00
intro_bank1_data_8D42
    BYTE $FF,$FF,$FF,$FF
    BYTE $10,$08                ;Red, Start at Col 8
    BYTE $10,"CONGRATULATIONS!"
    BYTE $FF,$FF,$FF,$40,$05    ;3 x CRs, Yellow, Start at Col 5    1,2,3
    BYTE $16,"NOW,YOU FOUND THE MOST"
    BYTE $FF,$FF,$40,$02        ;2 x CRs, Yellow, Start at Col 2    ;4,5
    BYTE $1D,"IMPORTANT MAGIC IN THE WORLD."
    BYTE $FF,$FF,$FF,$00,$03    ;6,7,8
    BYTE $04,"IT'S"
    BYTE $10,$08
    BYTE $06,$22,"LOVE",$22     ;$22 = Quote Mark
    BYTE $00,$0F
    BYTE $01,"&"
    BYTE $10,$11
    BYTE $0C,$22,"FRIENDSHIP",$22
    BYTE $00,$1D
    BYTE $1,"!"
    BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$40,$0D    ;9,10,11,12,13,14,15,16,17,18.19
    BYTE $01,$1D,$40,$0E,$05,"STAFF"    ;1D = Bullet Point
    BYTE $FF,$FF,$FF,$10,$04    ;20,21,22
    BYTE $01,$1D,$10,$05,$17,"GAME DESIGN & CHARACTER"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B    ;23,24
    BYTE $0B,"MTJ/MITSUJI"
    BYTE $FF,$FF,$FF,$10,$04    ;25,26,27
    BYTE $01,$1D,$10,$05,$14,"SOFTWARE PROGRAMMERS"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B    ;28,29
    BYTE $0B,"ICH/FUJISUE"
    BYTE $FF,$FF,$00,$0B    ;30,31
    BYTE $0D,"NSO/NISHIYORI"
    BYTE $FF,$FF,$FF,$10,$04    ;32,33,34
    BYTE $01,$1D,$10,$05,$0D,"SOUND CREATOR"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B    ;35,36
    BYTE $0C,"KIM/KIMIJIMA"
    BYTE $FF,$FF,$FF,$10,$04 ;37,38,39
    BYTE $01,$1D,$10,$05,$0B,"INSTRUCTION"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B    ;40,41
    BYTE $0B,"YSH/YOSHIDA"
    BYTE $FF,$FF,$FF,$10,$04    ;42,43,44
    BYTE $01,$1D,$10,$05,$08,"HARDWARE"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B    ;45,46
    BYTE $0C,"KTU/FUJIMOTO"
    BYTE $FF,$FF,$00,$0B    ;47,48
    BYTE $0B,"SAK/SAKMOTO"
    BYTE $FF,$FF,$FF,$10,$04    ;49,50,51
    BYTE $01,$1D,$10,$05,$12,"AND SPECIAL THANKS"    ;1D = Bullet Point
    BYTE $FF,$FF,$10,$05,$14,"TO ALL OTHER PEOPLE!" ;52,53
    BYTE $FF,$FF,$00,$0B    ;54,55
    BYTE $0B,"TOP/SUEKADO"
    BYTE $FF,$FF,$00,$0B    ;56,57
    BYTE $08,"HED/UENO"
    BYTE $FF,$FF,$00,$0B    ;58,59
    BYTE $08,"RYO/YUKI"
    BYTE $FF,$FF,$00,$0B    ;60,61
    BYTE $0C,"SKE/NAKAMURA"
    BYTE $FF,$FF,$00,$0B    ;62,63
    BYTE $09,"SAN/SANBE"
    BYTE $FF,$FF,$00,$0B    ;64,65
    BYTE $0C,"PAN/NAKAGAWA"
    BYTE $FF,$FF,$00,$0B    ;66,67
    BYTE $0B,"OTO/IMAMURA"
    BYTE $FF,$FF,$FF,$FF,$10,$04    ;68,69,70,71
    BYTE $01,$1D,$10,$05,$0A,"CHARACTERS"    ;1D = Bullet Point
    BYTE $FF,$FF,$20,$0B    ;72,73
    BYTE $07,"BUBBLUN"
    BYTE $FF,$FF,$50,$0B    ;74,75
    BYTE $07,"BOBBLUN"
    BYTE $FF,$FF,$00,$0B    ;76,77
    BYTE $08,"ZEN-CHAN"
    BYTE $FF,$FF,$00,$0B    ;78,79
    BYTE $06,"MONSTA"  
    BYTE $FF,$FF,$00,$0B    ;80,81
    BYTE $0B,"SKEL-MONSTA"
    BYTE $FF,$FF,$00,$0B    ;82,83
    BYTE $06,"MIGHTA"
    BYTE $FF,$FF,$00,$0B    ;84,85
    BYTE $06,"PULPUL"
    BYTE $FF,$FF,$00,$0B    ;86,87
    BYTE $07,"BANEBOU"
    BYTE $FF,$FF,$00,$0B    ;88,89
    BYTE $07,"INVADER"
    BYTE $FF,$FF,$00,$0B    ;90,91
    BYTE $08,"HIDEGONS"
    BYTE $FF,$FF,$00,$0B    ;92,93
    BYTE $05,"DRUNK"
    BYTE $FF,$FF,$00,$0B    ;94,95
    BYTE $0B,"SUPER DRUNK"
    BYTE $FF,$FF,$00,$0B    ;96,97
    BYTE $06,"RASCAL"  
    BYTE $FF,$FF,$00,$0B    ;98,99
    BYTE $05,"BOBBY"
    BYTE $FF,$FF,$00,$0B    ;100,101
    BYTE $05,"BETTY"
    BYTE $FF,$FF,$00,$0B    ;102,103
    BYTE $05,"BUBBY"
    BYTE $FF,$FF,$00,$0B    ;104,105
    BYTE $05,"PATTY"
    BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$0A    ;106,107,108,109,110,111,112,113,114
    BYTE $01,$1D,$10,$0B,$0B,"PRODUCED BY"    ;1D = Bullet Point
    BYTE $FF,$FF,$10,$0B    ;115,116
    BYTE $0A,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A        ;Top Half OF TAITO Logo
    BYTE $FF,$10,$0C    ;117
    BYTE $09,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13            ;Bottom Half OF TAITO Logo
    BYTE $FF,$FF,$00,$04    ;118,119
    BYTE $18,"@ TAITO CORPORATION 1986"
    BYTE $FF,$FF,$00,$06    ;120,121
    BYTE $13,"ALL RIGHTS RESERVED"
    BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$06    ;122-136
    BYTE $13,"THANK YOU VERY MUCH"
    BYTE $FF,$FF,$00,$07    ;137,138
    BYTE $11,"FOR YOUR PLAYING!"
    BYTE $FF    ;139
intro_bank1_data_90EA
    BYTE $FF,$FF,$FF,$FF
    BYTE $10,$08
    BYTE $10,"CONGRATULATIONS!"                 
    BYTE $FF,$FF,$FF,$40,$01                    ;1,2,3
    BYTE $0B,"BUT THIS IS"                      
    byte $40,$0D
    BYTE $12,"NOT A TRUE ENDING!"               
    BYTE $FF,$FF,$FF,$FF,$10,$02                ;4,5,6,7
    BYTE $1C,"COME HERE WITH YOUR FRIENDS!"     
    BYTE $FF,$FF,$FF,$FF,$00,$04                ;8,9,10,11
    BYTE $18,"YOU WILL BE IMPRESSED BY"         
    BYTE $FF,$FF,$00,$03                        ;12,13
    BYTE $1A,"THE TRUTH OF THIS STORY !!"       
    BYTE $FF,$FF,$FF,$FF,$FF,$00,$03            ;14,15,16,17,18
    BYTE $11,"NEVER FORGET YOUR"                
    BYTE $10,$15
    BYTE $08,"FRIEND !"                         
    BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$0A    ;19,20,21,22,23,24,25
    BYTE $0C,"TRY AGAIN !!"                     
    BYTE $FF                                    ;26

intro_bank1_data_91BF
    BYTE $FF,$FF,$FF,$FF
    BYTE $10,$08
    BYTE $10,"CONGRATULATIONS!"
    BYTE $FF,$FF,$FF,$00,$02
    BYTE $1C,"YOU COULD HELP YOUR FATHER &"
    BYTE $FF,$FF,$00,$02
    BYTE $1B,"MOTHER! THEY WERE CONTROLED"
    BYTE $FF,$FF,$00,$02
    BYTE $1D,"BY SOMEONE. WHO IS HE? NO ONE"
    BYTE $FF,$FF,$00,$02
    BYTE $1C,"KNOWS OF IT! THE TRUTH IS IN"
    BYTE $FF,$FF,$00,$02
    BYTE $19,"THE DARKNESS FOREVER ...."
    BYTE $FF,$FF,$FF,$10,$0C
    BYTE $09,"THE END !"
    BYTE $FF,$FF,$FF,$FF,$FF,$40,$0D
    BYTE $01,$1D,$40,$0E,$05,"STAFF"    ;1D = Bullet Point
    BYTE $FF,$FF,$FF,$10,$04
    BYTE $01,$1D,$10,$05,$17,"GAME DESIGN & CHARACTER"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"MTJ/MITSUJI"
    BYTE $FF,$FF,$FF,$10,$04
    BYTE $01,$1D,$10,$05,$14,"SOFTWARE PROGRAMMERS"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"ICH/FUJISUE"
    BYTE $FF,$FF,$00,$0B
    BYTE $0D,"NSO/NISHIYORI"
    BYTE $FF,$FF,$FF,$10,$04
    BYTE $01,$1D,$10,$05,$0D,"SOUND CREATOR"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B
    BYTE $0C,"KIM/KIMIJIMA"
    BYTE $FF,$FF,$FF,$10,$04
    BYTE $01,$1D,$10,$05,$0B,"INSTRUCTION"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"YSH/YOSHIDA"
    BYTE $FF,$FF,$FF,$10,$04
    BYTE $01,$1D,$10,$05,$08,"HARDWARE"    ;1D = Bullet Point
    BYTE $FF,$FF,$00,$0B
    BYTE $0C,"KTU/FUJIMOTO"
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"SAK/SAKMOTO"
    BYTE $FF,$FF,$FF,$10,$04
    BYTE $01,$1D,$10,$05,$12,"AND SPECIAL THANKS"    ;1D = Bullet Point
    BYTE $FF,$FF,$10,$05,$14,"TO ALL OTHER PEOPLE!"
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"TOP/SUEKADO"
    BYTE $FF,$FF,$00,$0B
    BYTE $08,"HED/UENO"
    BYTE $FF,$FF,$00,$0B
    BYTE $08,"RYO/YUKI"
    BYTE $FF,$FF,$00,$0B
    BYTE $0C,"SKE/NAKAMURA"
    BYTE $FF,$FF,$00,$0B
    BYTE $09,"SAN/SANBE"
    BYTE $FF,$FF,$00,$0B
    BYTE $0C,"PAN/NAKAGAWA"
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"OTO/IMAMURA"
    BYTE $FF,$FF,$FF,$FF,$10,$04
    BYTE $01,$1D,$10,$05,$0A,"CHARACTERS"    ;1D = Bullet Point
    BYTE $FF,$FF,$20,$0B
    BYTE $07,"BUBBLUN"
    BYTE $FF,$FF,$50,$0B
    BYTE $07,"BOBBLUN"
    BYTE $FF,$FF,$00,$0B
    BYTE $08,"ZEN-CHAN"
    BYTE $FF,$FF,$00,$0B
    BYTE $06,"MONSTA"
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"SKEL-MONSTA"
    BYTE $FF,$FF,$00,$0B
    BYTE $06,"MIGHTA"
    BYTE $FF,$FF,$00,$0B
    BYTE $06,"PULPUL"
    BYTE $FF,$FF,$00,$0B
    BYTE $07,"BANEBOU"
    BYTE $FF,$FF,$00,$0B
    BYTE $07,"INVADER"
    BYTE $FF,$FF,$00,$0B
    BYTE $08,"HIDEGONS"
    BYTE $FF,$FF,$00,$0B
    BYTE $05,"DRUNK"
    BYTE $FF,$FF,$00,$0B
    BYTE $0B,"SUPER DRUNK"
    BYTE $FF,$FF,$00,$0B
    BYTE $06,"RASCAL"
    BYTE $FF,$FF,$00,$0B
    BYTE $05,"BOBBY"
    BYTE $FF,$FF,$00,$0B
    BYTE $05,"BETTY"
    BYTE $FF,$FF,$00,$0B
    BYTE $05,"BUBBY"
    BYTE $FF,$FF,$00,$0B
    BYTE $05,"PATTY"
    BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$0A
    BYTE $01,$1D,$10,$0B,$0B,"PRODUCED BY"    ;1D = Bullet Point
    BYTE $FF,$FF,$10,$0B
    BYTE $0A,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A        ;Top Half OF TAITO Logo
    BYTE $FF,$10,$0C
    BYTE $09,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13            ;Bottom Half OF TAITO Logo
    BYTE $FF,$FF,$00,$04
    BYTE $18,"@ TAITO CORPORATION 1986"
    BYTE $FF,$FF,$00,$06
    BYTE $13,"ALL RIGHTS RESERVED"
    BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$06
    BYTE $13,"THANK YOU VERY MUCH"
    BYTE $FF,$FF,$00,$07
    BYTE $11,"FOR YOUR PLAYING!"
    BYTE $FF

intro_call_57D4
    ;ld   de,$D80E   ;TODO - screen loc
    ;ld   de,$7800			;write the 'TIME' message for the vs screen
    ;ld   c,$10		;red
    ;jp   call_0E9A;writetext;$0E9A
    ld   hl,data_57DF
    ld   de,$1060;$7b22;$D822
    ld   c,$10;$00
    jp   Write_Layer2_Text

intro_call_59E8
    ;ld   de,$D80E   ;TODO - screen loc
    ;ld   de,$7800			;write the 'TIME' message for the vs screen
    ;ld   c,$10		;red
    ;jp   call_0E9A;writetext;$0E9A
    ld   hl,intro_data_59E8_1
    ld   de,$1060;$7b22;$D822
    ld   c,$00;$00
    jp   Write_Layer2_Text

intro_data_59E8_1
    BYTE $08,$00,$00,$00,$00,$00,$00,$00,$00

intro_call_5AD3
    ld   hl,l_e740
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    jr   c,intro_call_5AE4
    ld   (hl),$00
    inc  hl
    ld   a,(hl)
    and  a
    jr   z,intro_call_5AE4
    dec  (hl)
intro_call_5AE4
    ld   a,(l_e741)
    ld   iy,$1088;$780c;$D98E   ;screen loc - the Vs timer
    jp   Write_Layer2_Num

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


intro_call_67F0
    push bc

;    ld a,$06            ;temp cheat
;    ld (l_e645),a

    ld   a,(ix+$00)     ;eb36
    bit  0,a
    jr   nz,intro_call_682C
;    ld   hl,data_044D             ;protection
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $6806
;    push ix
    ld   de,intro_data_6BF7
    bit  0,(ix+$08)
    jr   z,intro_call_6812
    ld   de,intro_data_6BFF
intro_call_6812
    call call_1529
    ld   b,$04
intro_call_6817
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  hl
    ld   (hl),$16
    inc  hl
    inc  de
    djnz intro_call_6817
    set  0,(ix+$00)
    jp   intro_call_6BEC
intro_call_682C
    bit  6,(ix+$00)
    jp   nz,intro_call_6BEC
    bit  4,(ix+$00)
    ;jp   intro_call_6AE3
    jp   nz,intro_call_6AE3
    bit  2,(ix+$00)
    jp   nz,intro_call_6976
    bit  1,(ix+$00)
    jp   nz,intro_call_691E
intro_call_6848
    ld   de,$0502
    call call_15CA
    add  a,a
    add  a,a
    ld   hl,intro_data_6C13
    bit  0,(ix+$08)
    jr   z,intro_call_685C
    ld   hl,intro_data_6C1B
intro_call_685C
    call call_0D89
    ld   c,(ix+$09)
    ld   b,$04
    call call_14BD
    bit  1,(ix+$00)
    jp   nz,intro_call_6BEC
intro_call_686E    
    ld   a,(l_ed3d)
    and  a
    jp   nz,intro_call_68B7
    ld   a,(ix+$0b)
    cp   $54
    jp   nz,intro_call_68B7
    ld   a,(l_e5d7)
    bit  0,(ix+$08)
    jr   nz,intro_call_688C
    bit  0,a
    jr   z,intro_call_689A
    jr   intro_call_6890
intro_call_688C
    bit  1,a
    jr   z,intro_call_689A
intro_call_6890
    set  1,(ix+$00)
    call call_1556
    jp   intro_call_6BEC
intro_call_689A
    call call_1529
    ld   b,$04
    ld   de,intro_data_6C07
intro_call_68A2
    ld   a,(de)
    cp   (hl)
    jr   nz,intro_call_68AC
    set  1,(ix+$00)
    jr   intro_call_68AD
intro_call_68AC
    dec  (hl)
intro_call_68AD
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  de
    djnz intro_call_68A2
    jp   intro_call_6BEC
intro_call_68B7
    ld   de,intro_data_6D1D
    bit  0,(ix+$08)
    jr   z,intro_call_68C3
    ld   de,intro_data_6CAF
intro_call_68C3
    ld   a,(ix+$0b)
    inc  (ix+$0b)
    call call_0D84
    call call_1529
    ld   a,(de)
    cp   $88
    jr   nz,intro_call_68DA
    ld   (ix+$0b),$00
    jr   intro_call_686E
intro_call_68DA
    and  $F0
    or   a
    jr   z,intro_call_68FB
    bit  7,a
    jr   nz,intro_call_68F0
    push hl
    ld   b,$04
intro_call_68E6
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz intro_call_68E6
    pop  hl
    jr   intro_call_68FB
intro_call_68F0
    push hl
    ld   b,$04
intro_call_68F3
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz intro_call_68F3
    pop  hl
intro_call_68FB
    ld   a,(de)
    and  $0F
    or   a
    jp   z,intro_call_6BEC
    bit  3,a
    jr   nz,intro_call_6912
    ld   b,$04
intro_call_6908
    inc  hl
    inc  hl
    inc  (hl)
    inc  hl
    inc  hl
    djnz intro_call_6908
    jp   intro_call_6BEC
intro_call_6912
    ld   b,$04
intro_call_6914
    inc  hl
    inc  hl
    dec  (hl)
    inc  hl
    inc  hl
    djnz intro_call_6914
    jp   intro_call_6BEC
intro_call_691E
    ld   a,(l_e5d7)
    bit  0,(ix+$08)
    jr   nz,intro_call_692E
    bit  0,a
    jp   z,intro_call_6848
    jr   intro_call_6933
intro_call_692E
    bit  1,a
    jp   z,intro_call_6848
intro_call_6933
    ld   de,$0A05
    call call_15CA
    jr   z,intro_call_6957
    add  a,a
    add  a,a
    ld   hl,intro_data_6C23
    bit  0,(ix+$08)
    jr   z,intro_call_6949
    ld   hl,intro_data_6C37
intro_call_6949
    call call_0D89
    ld   c,(ix+$09)
    ld   b,$04
    call call_14BD
    jp   intro_call_6BEC
intro_call_6957
    set  2,(ix+$00)
    call call_1556
    ld   b,$04
    ld   l,(ix+$03)
    ld   h,(ix+$04)
intro_call_6966
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    inc  hl
    inc  hl
    djnz intro_call_6966
    dec  hl
    ld   (hl),$13
    jp   intro_call_6BEC
intro_call_6976
    call intro_call_69BE
    bit  3,(ix+$00)
    jr   nz,intro_call_6994
    call call_1529
    ld   (hl),$A8
    inc  hl
    inc  hl
    ld   (hl),$30
    bit  0,(ix+$08)
    jr   z,intro_call_6990
    ld   (hl),$C0
intro_call_6990
    set  3,(ix+$00)
intro_call_6994
    call call_1529
    ld   a,(hl)
    cp   $19
    jr   nc,intro_call_69A3
    set  7,(ix+$00)
    jp   intro_call_6BEC
intro_call_69A3
    dec  (hl)
    ld   b,$C8
    ld   a,(ix+$07)
    ld   c,(ix+$09)
    bit  0,(ix+$08)
    jr   z,intro_call_69B8
    call call_147D
    jp   intro_call_6BEC
intro_call_69B8
    call call_149C
    jp   intro_call_6BEC
intro_call_69BE
    ld   a,(ix+$0c)
    or   a
    jp   z,intro_call_6A88
    ld   hl,l_e2c5
    ld   de,l_e699
    bit  0,(ix+$08)
    jr   z,intro_call_69D7
    ld   hl,l_e2b5
    ld   de,l_e6cb
intro_call_69D7
    ld   a,(hl)
    cp   $18
    jr   z,intro_call_69DE
    dec  (hl)
    ret
intro_call_69DE
    bit  7,(ix+$00)
    ret  z
    inc  hl
    inc  hl
    ld   a,(hl)
    bit  0,(ix+$08)
    jr   nz,intro_call_69F4
    cp   $40
    jr   z,intro_call_6A41
    jr   c,intro_call_69FF
    jr   intro_call_69FA
intro_call_69F4
    cp   $B0
    jr   z,intro_call_6A41
    jr   c,intro_call_69FF
intro_call_69FA
    dec  (hl)
    xor  a
    ld   (de),a
    jr   intro_call_6A03
intro_call_69FF
    inc  (hl)
    ld   a,$01
    ld   (de),a
intro_call_6A03
    inc  (ix+$0f)
    ld   a,(ix+$0f)
    cp   $05
    jr   nz,intro_call_6A1F
    ld   (ix+$0f),$00
    inc  (ix+$0e)
    ld   a,(ix+$0e)
    cp   $04
    jr   nz,intro_call_6A1F
    ld   (ix+$0e),$00
intro_call_6A1F
    ld   a,(ix+$0e)
    add  a,a
    add  a,a
    add  a,$44
    ld   b,a
    ld   c,(ix+$0c)
    ld   a,$18
    bit  0,(ix+$08)
    jr   z,intro_call_6A34
    ld   a,$19
intro_call_6A34
    ex   de,hl
    bit  0,(hl)
    jr   nz,intro_call_6A3D
    call call_147D
    ret
intro_call_6A3D
    call call_149C
    ret
intro_call_6A41
    ld   a,(l_e5d7)
    cp   $03
    jr   z,intro_call_6A77
    bit  0,(ix+$08)
    jr   nz,intro_call_6A56
    bit  0,a
    jr   nz,intro_call_6A5E
    call intro_call_6B80
    ret
intro_call_6A56
    bit  1,a
    jr   nz,intro_call_6A5E
    call intro_call_6B80
    ret
intro_call_6A5E
    set  6,(ix+$00)
    ld   de,l_e699
    xor  a
    ld   (de),a
    bit  0,(ix+$08)
    jp   z,intro_call_6A03
    ld   de,l_e6cb
    ld   a,$01
    ld   (de),a
    jp   intro_call_6A03
intro_call_6A77
    ld   (hl),$00
    dec  hl
    dec  hl
    ld   (hl),$00
    xor  a
    ld   (ix+$0c),a
    ld   (ix+$0e),a
    ld   (ix+$0f),a
    ret
intro_call_6A88
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,$0C
    call call_0D89
    ld   (hl),$18
    inc  hl
    inc  hl
    ld   (hl),$40
    bit  0,(ix+$08)
    jr   z,intro_call_6AA1
    ld   (hl),$B0
intro_call_6AA1
    dec  hl
    inc  (ix+$0f)
    ld   a,(ix+$0f)
    cp   $0F
    jr   nz,intro_call_6ABA
    ld   (ix+$0f),$00
    inc  (ix+$0e)
    ld   a,(ix+$0e)
    cp   $03
    jr   z,intro_call_6AC9
intro_call_6ABA
    ld   a,(ix+$0e)
    add  a,a
    add  a,a
    add  a,$B0
    ld   b,a
    ld   c,$24
    ld   a,(hl)
    call call_147D
    ret
intro_call_6AC9
    set  4,(ix+$00)
    ld   (ix+$0b),$B4
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,$0C
    call call_0D89
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    ret
intro_call_6AE3
    bit  5,(ix+$00)
    jr   nz,intro_call_6B47
    dec  (ix+$0b)
    jr   nz,intro_call_6B0D
    set  5,(ix+$00)
    call intro_call_6B80
    call call_1556
    bit  0,(ix+$08)
    jp   nz,intro_call_6BEC
    call intro_call_B878        ;set palette for big heart
    call intro_call_B884        ;draw big heart
    ld   c,$1C
    call call_1350
    jp   intro_call_6BEC
intro_call_6B0D
    ld   de,intro_data_6C0B
    bit  0,(ix+$08)
    jr   z,intro_call_6B19
    ld   de,intro_data_6C0F
intro_call_6B19
    call call_1529
    ld   b,$02
intro_call_6B1E
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    djnz intro_call_6B1E
    ld   b,$02
    ld   c,(ix+$09)
    bit  0,(ix+$08)
    jr   z,intro_call_6B3E
    ld   hl,intro_data_6C4B
    call call_14BD
    jp   intro_call_6BEC
intro_call_6B3E
    ld   hl,intro_data_6C55
    call call_14E1
    jp   intro_call_6BEC
intro_call_6B47
    ld   de,$0504
    call call_15CA
    jr   nz,intro_call_6B56
    set  6,(ix+$00)
    jp   intro_call_6BEC
intro_call_6B56
    ld   b,$02
    ld   c,(ix+$09)
    bit  0,(ix+$08)
    jr   z,intro_call_6B6D
    add  a,a
    ld   hl,intro_data_6C4D
    call call_0D89
    call call_14BD
    jr   intro_call_6B77
intro_call_6B6D
    add  a,a
    ld   hl,intro_data_6C57
    call call_0D89
    call call_14E1
intro_call_6B77
    call intro_call_6B9F
    call intro_call_6BC2
    jp   intro_call_6BEC
intro_call_6B80
    call call_1529
    ld   a,$08
    call call_0D89
    ld   (hl),$30
    inc  hl
    ld   a,(hl)
    inc  hl
    ld   (hl),$38
    bit  0,(ix+$08)
    jr   z,intro_call_6B97
    ld   (hl),$B8
intro_call_6B97
    ld   b,$44
    ld   c,$26
    call call_147D
    ret
intro_call_6B9F
    ld   a,(l_e5d7)
    cp   $03
    ret  nz
    ;ld   hl,$7AbA;$D560
    ld hl,$5808
    ld   de,intro_data_6C5F ;P1 'HAPPY END!!'
    ld   bc,$040A
    ex   af,af'
	ld   a,$70	;gfx atrtibute
	ex   af,af'
	ld   a,$70
    ;ld   a,$1C
    call call_Layer2_0EC6
    ;ld   hl,$7AE0;$DA20
    ld hl,$58A0
    ld   de,intro_data_6C5F ;P2 'HAPPY END!!'
    ld   bc,$040A
    ex   af,af'
	ld   a,$70	;gfx atrtibute
	ex   af,af'
	ld   a,$70
    ;ld   a,$1C
    call call_Layer2_0EC6
    ret
intro_call_6BC2
    ld   a,(l_e5d7)
    cp   $03
    ret  nz
    ld   a,(l_f2a3)
    and  a
    jr   nz,intro_call_6BDD     ;'1000000PTS!!' in Green
    ld   hl,$1830;$D690
    ld   de,intro_data_6C87
    ld   bc,$0214
    ex   af,af'
	ld   a,$70	;gfx attribute
	ex   af,af'
	ld   a,$70;90
    ;ld   a,$1C
    call call_Layer2_0EC6
    ret
intro_call_6BDD
    ld   hl,$1830;$D690
    ld   de,intro_data_6C87     ;'1000000PTS!!' in Blue
    ld   bc,$0214
    ex   af,af'
	ld   a,$80	;gfx attribute
	ex   af,af'
	ld   a,$70;90
    ;ld   a,$20
    call call_Layer2_0EC6
    ret
intro_call_6BEC
    pop  bc
    ld   de,$0010
    add  ix,de
    dec  b
    jp   nz,intro_call_67F0
    ret
intro_data_6BF7
    BYTE $BA,$32,$BA,$42,$AA,$32,$AA,$42
intro_data_6BFF
    BYTE $BA,$AE,$BA,$BE,$AA,$AE,$AA,$BE
intro_data_6C07
    BYTE $28,$28,$18,$18
intro_data_6C0B
    BYTE $18,$30,$18,$40
intro_data_6C0F
    BYTE $18,$B0,$18,$C0
intro_data_6C13
    BYTE $6C,$70,$84,$88,$74,$78,$8C,$90
intro_data_6C1B
    BYTE $04,$08,$1C,$20,$0C,$10,$24,$28
intro_data_6C23
    BYTE $14,$18,$2C,$30,$34,$38,$4C,$50
    BYTE $3C,$40,$54,$58,$44,$48,$5C,$60
    BYTE $64,$68,$7C,$80
intro_data_6C37
    BYTE $94,$98,$AC,$B0,$9C,$A0,$B4,$B8
    BYTE $3C,$40,$54,$58,$44,$48,$5C,$60
    BYTE $64,$68,$7C,$80
intro_data_6C4B
    BYTE $C4,$C8
intro_data_6C4D
    BYTE $CC,$D0,$D4,$D8,$DC,$E0,$E4,$E8
intro_data_6C55
    BYTE $C8,$C4
intro_data_6C57
    BYTE $D0,$CC,$D8,$D4,$E0,$DC,$E8,$E4
intro_data_6C5F         ;'1000000PTS!!'
    BYTE $B8,$B9,$BC,$BD,$C0,$C1,$C4,$C5,$C8,$C9,$BA,$BB,$BE,$BF,$C2,$C3
    BYTE $C6,$C7,$CA,$CB,$CC,$CD,$D0,$D1,$D4,$D5,$D8,$D9,$DC,$DD,$CE,$CF
    BYTE $D2,$D3,$D6,$D7,$DA,$DB,$DE,$DF
intro_data_6C87         ;'HAPPY END !!'
    BYTE $90,$91,$94,$95,$98,$99,$9C,$9D,$A0,$A1,$A4,$A5,$A8,$A9,$AC,$AD
    BYTE $B0,$B1,$B4,$B5,$92,$93,$96,$97,$9A,$9B,$9E,$9F,$A2,$A3,$A6,$A7
    BYTE $AA,$AB,$AE,$AF,$B2,$B3,$B6,$B7
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

    ;call call_0431      ;toggle display off

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
    ;call layer2_update_palette_ret
    nextreg $70,%00010000      ;set layer 2 to 320 x 256
    nextreg $15,%01101011     ;Set priority - Sprite, ULA/Tiles, Layer 2 and show over borders

    ;set L2 clip window to correct size for EXTEND screen
    nextreg $18,16
	nextreg $18,143	
	nextreg $18,24
	nextreg $18,231

    jp intro_call_7007
	
;intro_data_6FE3
;	defb $18,$04,$08,$0C,$10,$14,$14,$18,$04,$08,$0C,$10,$10,$14,$18,$04,$08,$0C
;	defb $0C,$10,$14,$18,$04,$08,$08,$0C,$10,$14,$18,$04,$04,$08,$0C,$10
;	defb $14,$18
	
intro_data_6FE3
	defb $05,$00,$01,$02,$03,$04,$04,$05,$00,$01,$02,$03,$03,$04,$05,$00,$01,$02
	defb $02,$03,$04,$05,$00,$01,$01,$02,$03,$04,$05,$00,$00,$01,$02,$03
	defb $04,$05

/*call_draw_extend_bubble
	ex de,hl
    ld hl,$0000
call_draw_extend_bubble_loop2
	push bc
	push de;hl
	ld b,c
call_draw_extend_bubble_loop1
	push af
	;add a,(hl)
    ld a,l
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
	djnz call_draw_extend_bubble_loop1
	pop de;hl
	ex de,hl
	ld bc,80
	add hl,bc
	ex de,hl
	pop bc
	djnz call_draw_extend_bubble_loop2
	ex de,hl
    ret*/


intro_call_7007			;we will put code in here to add extend tiles to layer 2

;	ld hl,$044D			;protection removed
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $7015
;    push iy

    call call_03CB		;clear screen

    ld   hl,$1118       ;H=bank   L=row
    ld   de,intro_bank1_data_849E
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6		
    ld   hl,$1218       ;H=bank   L=row
    ld   de,intro_bank1_data_84E2
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    ld   hl,$1318       ;H=bank   L=row
    ld   de,intro_bank1_data_8526
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    ld   hl,$1418       ;H=bank   L=row
    ld   de,intro_bank1_data_856A
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    ld   hl,$1518       ;H=bank   L=row
    ld   de,intro_bank1_data_85AE
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    ld   hl,$1618       ;H=bank   L=row
    ld   de,intro_bank1_data_85F2
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    ld   hl,$1718       ;H=bank   L=row
    ld   de,intro_bank1_data_8636
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    ld   hl,$1818       ;H=bank   L=row
    ld   de,intro_bank1_data_867A
    ld   bc,$1A04
    ex af,af'
	ld a,$00 	;gfx attribute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    ;break

	ld   a,gfxbank23
    call extend_get_tiles
	
    ld   hl,$79CA;7A1A;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_8982;8A54
    ld   bc,$0705
	ex af,af'
	ld a,$0d*16	;gfx atrtibute
	ex af,af'
	ld a,$b0
    call call_0EC6_Adjusted

    ld   hl,$79D4;7A24;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_89A5
    ld   bc,$0705
	ex af,af'
	ld a,$0d*16	;gfx atrtibute
	ex af,af'
	ld a,$B0
    call call_0EC6_Adjusted

    ld   hl,$79DE;7A2E;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_89C8
    ld   bc,$0705
	ex af,af'
	ld a,$0d*16	;gfx atrtibute
	ex af,af'
	ld a,$B0
    call call_0EC6_Adjusted

    ld   hl,$79E8;7A38;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_89EB
    ld   bc,$0705
	ex af,af'
	ld a,$0d*16	;gfx atrtibute
	ex af,af'
	ld a,$B0
    call call_0EC6_Adjusted

    ld   hl,$79F2;7A42;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_8A0E
    ld   bc,$0705
	ex af,af'
	ld a,$0d*16	;gfx atrtibute
	ex af,af'
	ld a,$B0
    call call_0EC6_Adjusted

    ld   hl,$79FC;7A4C;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_8A31
    ld   bc,$0705
	ex af,af'
	ld a,$0d*16	;gfx atrtibute
	ex af,af'
	ld a,$B0
    call call_0EC6_Adjusted

	
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
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tilemap
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
 ;   call call_03CB    ;Clear screen

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
/*    
    ld   hl,intro_bank1_data_849E  
    ld   de,$1A00		;d=number of  rows - e=x pos
    ld   bc,$0C00		;b=number of columns - c=colour
	ex af,af'
	ld a,0*16	;gfx atrtibute
	ex af,af'
	ld a,$d0
    call extend_0EC6
    
    		
    break
    ld   hl,$76F8+$18		;top row, 12 across of level area
    ld   de,intro_bank1_data_85D6  
    ld   bc,$1A0C
	ex af,af'
	ld a,0*16	;gfx atrtibute
	ex af,af'
	ld a,$d0
    ;call call_0EC6_Adjusted		
    ld   hl,$76F8+$18+$18		;top row, 24 across of level area
    ld   de,intro_bank1_data_870E  
    ld   bc,$1A08
	ex af,af'
	ld a,0*16	;gfx atrtibute
	ex af,af'
	ld a,$d0
    ;call call_0EC6_Adjusted

    ;break
*/
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
    call intro_call_7293    ;Update first 'E'
    call intro_call_7321    ;Update X
    call intro_call_739D    ;Update T
    call intro_call_7419    ;Update E
    call intro_call_7495    ;Update N
    call intro_call_7511    ;Update D
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

    ld   a,gfxbank24
    call extend_get_tiles

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

    ld   a,gfxbank24
    call extend_get_tiles

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
    ld   hl,l_eb63          ;EXTEND animation timer
    ld   bc,l_eb64          ;EXTEND animation frame
    ld   de,$0F04
    call intro_call_7900    ;update EXTEND animation
    or   a
    jr   z,intro_call_72D5
    cp   $01
    jr   z,intro_call_72C6
    cp   $02
    jr   z,intro_call_72E4
intro_call_72C6
    ;E Pos 1
    ld   a,gfxbank22+1
    ld   hl,$8000
    ld   de,$5600
    call extend_get_tiles_single_bubble
    ret
intro_call_72D5
    ;E Pos 2
    ld   a,gfxbank22
    ld   hl,$8000
    ld   de,$5600
    call extend_get_tiles_single_bubble
    ret
intro_call_72E4
    ;E Pos 3
    ld   a,gfxbank23
    ld   hl,$8000
    ld   de,$5600
    call extend_get_tiles_single_bubble
    ret
intro_call_72F3
    ld   hl,l_eb61
    ld   bc,l_eb62
    ld   de,$0A02
    call intro_call_7900
    cp   $01
    jr   z,intro_call_7312
    ;E Popped with Stars
    ld   a,gfxbank23+1
    ld   hl,$8000
    ld   de,$5600
    call extend_get_tiles_single_bubble
    ret
intro_call_7312
    ;E Popped
    ld   a,gfxbank24+1
    ld   hl,$8000
    ld   de,$5600
    call extend_get_tiles_single_bubble
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
    ;X Pos 1
    ld   a,gfxbank22+1
    ld   hl,$8460
    ld   de,$5A60
    call extend_get_tiles_single_bubble
    ret
intro_call_735A
    ;X Pos 2
    ld   a,gfxbank22
    ld   hl,$8460
    ld   de,$5A60
    call extend_get_tiles_single_bubble
    ret
intro_call_7369
    ;X Pos 3
    ld   a,gfxbank23
    ld   hl,$8460
    ld   de,$5A60
    call extend_get_tiles_single_bubble
    ret
intro_call_7378
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_738E
    ;X Popped with Stars
    ld   a,gfxbank23+1
    ld   hl,$8460
    ld   de,$5A60
    call extend_get_tiles_single_bubble
    ret
intro_call_738E
    ;X Popped
    ld   a,gfxbank24+1
    ld   hl,$8460
    ld   de,$5A60
    call extend_get_tiles_single_bubble
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
    ;T Pos 1
    ld   a,gfxbank22+1
    ld   hl,$88C0
    ld   de,$5EC0
    call extend_get_tiles_single_bubble
    ret
intro_call_73D6
    ;T Pos 2
    ld   a,gfxbank22
    ld   hl,$88C0
    ld   de,$5EC0
    call extend_get_tiles_single_bubble
    ret
intro_call_73E5
    ;T Pos 3
    ld   a,gfxbank23
    ld   hl,$88C0
    ld   de,$5EC0
    call extend_get_tiles_single_bubble
    ret
intro_call_73F4
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_740A
    ;T Popped with Stars
    ld   a,gfxbank23+1
    ld   hl,$88C0
    ld   de,$5EC0
    call extend_get_tiles_single_bubble
    ret
intro_call_740A
    ;T Popped
    ld   a,gfxbank24+1
    ld   hl,$88C0
    ld   de,$5EC0
    call extend_get_tiles_single_bubble
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
    ;E(2) Pos 1
    ld   a,gfxbank22+1
    ld   hl,$8D20
    ld   de,$6320
    call extend_get_tiles_single_bubble
    ret
intro_call_7452
    ;E(2) Pos 2
    ld   a,gfxbank22
    ld   hl,$8D20
    ld   de,$6320
    call extend_get_tiles_single_bubble
    ret
intro_call_7461
    ;E(2) Pos 3
    ld   a,gfxbank23
    ld   hl,$8D20
    ld   de,$6320
    call extend_get_tiles_single_bubble
    ret
intro_call_7470
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_7486
    ;E(2) Popped with Stars
    ld   a,gfxbank23+1
    ld   hl,$8D20
    ld   de,$6320
    call extend_get_tiles_single_bubble
    ret
intro_call_7486
    ;E(2) Popped
    ld   a,gfxbank24+1
    ld   hl,$8D20
    ld   de,$6320
    call extend_get_tiles_single_bubble
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
    ;N Pos 1
    ld   a,gfxbank22+1
    ld   hl,$9180
    ld   de,$6780
    call extend_get_tiles_single_bubble
    ret
intro_call_74CE
    ;N Pos 2
    ld   a,gfxbank22
    ld   hl,$9180
    ld   de,$6780
    call extend_get_tiles_single_bubble
    ret
intro_call_74DD
    ;N Pos 1
    ld   a,gfxbank23
    ld   hl,$9180
    ld   de,$6780
    call extend_get_tiles_single_bubble
    ret
intro_call_74EC
    ld   a,(l_eb62)
    cp   $01
    jr   z,intro_call_7502
    ;N Popped with Stars
    ld   a,gfxbank23+1
    ld   hl,$9180
    ld   de,$6780
    call extend_get_tiles_single_bubble
    ret
intro_call_7502
    ;N Popped
    ld   a,gfxbank24+1
    ld   hl,$9180
    ld   de,$6780
    call extend_get_tiles_single_bubble
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
    ;ld   a,(l_eb64)
    or   a
    jr   z,intro_call_7553
    cp   $01
    jr   z,intro_call_7544
    cp   $02
    jr   z,intro_call_7562
intro_call_7544
    ;D Pos 1
    ld   a,gfxbank22+1
    ld   hl,$95E0
    ld   de,$6bE0
    call extend_get_tiles_single_bubble
    ret
intro_call_7553
    ;D Pos 2
    ld   a,gfxbank22
    ld   hl,$95E0
    ld   de,$6bE0
    call extend_get_tiles_single_bubble
    ret
intro_call_7562
    ;D Pos 3
    ld   a,gfxbank23
    ld   hl,$95E0
    ld   de,$6bE0
    call extend_get_tiles_single_bubble
    ret
intro_call_7571
    ld   hl,l_eb61
    ld   bc,l_eb62
    ld   de,$0A02
    call intro_call_7900
    cp   $01
    jr   z,intro_call_7590
    ;D Popped with stars
    ld   a,gfxbank23+1
    ld   hl,$95E0
    ld   de,$6bE0
    call extend_get_tiles_single_bubble
    ret
intro_call_7590
    ;D Popped
    ld   a,gfxbank24+1
    ld   hl,$95E0
    ld   de,$6bE0
    call extend_get_tiles_single_bubble
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
    
    ld   hl,$79D0;7A1A;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_8CCA;8A54
    ld   bc,$040E
	ex af,af'
	ld a,$09*16	;gfx atrtibute
	ex af,af'
	ld a,$65
    call call_0EC6_Adjusted

    ld   hl,$79F0;7A1A;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_8D02;8A54
    ld   bc,$0408
	ex af,af'
	ld a,$09*16	;gfx atrtibute
	ex af,af'
	ld a,$07
    call call_0EC6_Adjusted

    ret
intro_call_77EE
    

    ld   hl,$79D0;7A1A;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_8CCA;8A54
    ld   bc,$040E
	ex af,af'
	ld a,$0A*16	;gfx atrtibute
	ex af,af'
	ld a,$65
    call call_0EC6_Adjusted

    ld   hl,$79F0;7A1A;CD08		;Top left corner of level area
    ld   de,intro_bank1_data_8D22;8A54
    ld   bc,$0408
	ex af,af'
	ld a,$0A*16	;gfx atrtibute
	ex af,af'
	ld a,$07
    call call_0EC6_Adjusted

   ret
intro_call_780B     ;clear the large EXTEND tiles
    
    ld   hl,$79CA;7A1A
    ld   de,intro_data_786B
    ld   bc,$0705	
	ld a,$00
    call call_0EC6

    ld   hl,$79CA+($0A*$01)
    ld   de,intro_data_786B
    ld   bc,$0705	
	ld a,$00
    call call_0EC6

    ld   hl,$79CA+($0A*$02)
    ld   de,intro_data_786B
    ld   bc,$0705	
	ld a,$00
    call call_0EC6

    ld   hl,$79CA+($0A*$03)
    ld   de,intro_data_786B
    ld   bc,$0705	
	ld a,$00
    call call_0EC6

    ld   hl,$79CA+($0A*$04)
    ld   de,intro_data_786B
    ld   bc,$0705	
	ld a,$00
    call call_0EC6

    ld   hl,$79CA+($0A*$05)
    ld   de,intro_data_786B
    ld   bc,$0705	
	ld a,$00
    call call_0EC6

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
    nextreg $70,%00000000      ;set layer 2 to 256 x 192
    nextreg $15,%01100111     ;Set priority - Sprite, ULA/Tiles, Layer 2 and show over borders

    nextreg $18,0
	nextreg $18,255	
	nextreg $18,0
	nextreg $18,183 ;hide bottom line for scrolling text purposes
	
	call layer2_update_palette_ret		;this clears the layer 2 screen

    ld a,music_mainshort;3;MODULE3
    ld (music_module),a
    ld a,2
    ld (music_playing),a
	
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
    defb $00,$01,$02,$02
    defb $06,$07,$08,$09
    defb $00,$10,$11,$12
    defb $06,$1A,$1B,$1C
    defb $00,$01,$23,$24
    defb $06,$29,$2A,$2B
    defb $00,$32,$33,$34
    defb $06,$07,$0B,$3B
    defb $00,$01,$0E,$0F
    defb $06,$07,$08,$09
    defb $00,$10,$11,$12
    defb $06,$1A,$1B,$1C
    defb $00,$01,$23,$24
    defb $06,$29,$2A,$2B
    defb $00,$32,$33,$34
    defb $06,$07,$0B,$3B
    defb $00,$01,$0E,$0F
    defb $06,$07,$08,$09
    defb $00,$01,$11,$12
    defb $06,$07,$1B,$1C
    defb $00,$01,$23,$24
    defb $06,$29,$2A,$2B
    defb $00,$32,$33,$34
    defb $06,$07,$0B,$3B
    defb $00,$01,$0E,$0F
    defb $06,$07,$02,$02
intro_bank1_data_84E2
    defb $02,$02,$02,$02
    defb $0A,$0B,$0C,$0D
    defb $13,$14,$15,$16
    defb $1D,$1E,$1F,$20
    defb $25,$20,$26,$1B
    defb $2C,$2D,$2E,$2F
    defb $35,$36,$37,$38
    defb $3A,$1C,$1B,$3C
    defb $0E,$0F,$0E,$3F
    defb $0A,$0B,$0C,$0D
    defb $13,$14,$15,$16
    defb $1D,$1E,$1F,$20
    defb $25,$20,$26,$1B
    defb $2C,$2D,$2E,$2F
    defb $35,$36,$37,$38
    defb $3A,$1C,$1B,$3C
    defb $0E,$0F,$0E,$3F
    defb $0A,$0B,$0C,$0D
    defb $13,$14,$15,$16
    defb $1D,$1E,$1F,$20
    defb $25,$20,$26,$1B
    defb $2C,$2D,$2E,$2F
    defb $35,$36,$37,$38
    defb $3A,$1C,$1B,$3C
    defb $0E,$0F,$0E,$3F
    defb $02,$02,$02,$02
intro_bank1_data_8526
    defb $03,$04,$05,$05
    defb $0E,$0F,$08,$09
    defb $17,$18,$11,$19
    defb $21,$14,$0F,$22
    defb $27,$28,$0B,$0A
    defb $30,$0F,$0E,$31
    defb $39,$3A,$0A,$22
    defb $3D,$3E,$31,$18
    defb $40,$0A,$22,$41
    defb $0E,$0F,$08,$09
    defb $17,$18,$11,$19
    defb $21,$14,$0F,$22
    defb $27,$28,$0B,$0A
    defb $30,$0F,$0E,$31
    defb $39,$3A,$0A,$22
    defb $3D,$3E,$31,$18
    defb $40,$0A,$22,$41
    defb $0E,$0F,$08,$09
    defb $17,$18,$11,$19
    defb $21,$14,$0F,$22
    defb $27,$28,$0B,$0A
    defb $30,$0F,$0E,$31
    defb $39,$3A,$0A,$22
    defb $3D,$3E,$31,$18
    defb $40,$0A,$22,$41
    defb $42,$0F,$05,$05
intro_bank1_data_856A
    defb $43,$44,$45,$45
    defb $4A,$4B,$43,$4C
    defb $54,$55,$56,$57
    defb $5F,$60,$54,$61
    defb $69,$4B,$6A,$6B
    defb $70,$4F,$71,$72
    defb $5F,$5A,$7A,$7B
    defb $56,$4B,$4E,$4A
    defb $84,$85,$86,$67
    defb $4A,$8A,$8B,$4C
    defb $54,$8D,$8E,$57
    defb $5F,$60,$54,$61
    defb $69,$4B,$6A,$6B
    defb $70,$4F,$71,$72
    defb $5F,$5A,$7A,$7B
    defb $56,$91,$92,$4A
    defb $84,$93,$94,$67
    defb $4A,$95,$96,$4C
    defb $54,$55,$56,$57
    defb $5F,$60,$54,$61
    defb $69,$4B,$6A,$6B
    defb $70,$4F,$71,$72
    defb $5F,$5A,$7A,$7B
    defb $56,$4B,$4E,$4A
    defb $84,$8C,$78,$67
    defb $98,$99,$45,$45
intro_bank1_data_85AE
    defb $45,$45,$45,$46
    defb $4D,$4E,$4F,$50
    defb $58,$59,$5A,$5B
    defb $62,$63,$64,$65
    defb $6C,$65,$6D,$54
    defb $73,$74,$75,$76
    defb $7C,$7D,$7E,$7F
    defb $80,$61,$54,$81
    defb $78,$67,$78,$87
    defb $4D,$4E,$4F,$8C
    defb $58,$59,$5A,$8F
    defb $62,$63,$64,$65
    defb $6C,$65,$6D,$54
    defb $73,$74,$75,$76
    defb $7C,$7D,$7E,$7F
    defb $80,$61,$54,$81
    defb $78,$67,$78,$87
    defb $4D,$4E,$4F,$8C
    defb $58,$59,$5A,$8F
    defb $62,$63,$64,$65
    defb $6C,$65,$6D,$54
    defb $73,$74,$75,$76
    defb $7C,$7D,$7E,$7F
    defb $80,$61,$54,$81
    defb $78,$67,$78,$87
    defb $45,$45,$45,$46
intro_bank1_data_85F2
    defb $47,$48,$49,$45
    defb $51,$52,$53,$4C
    defb $5C,$5D,$56,$5E
    defb $66,$59,$67,$68
    defb $6E,$6F,$4E,$4D
    defb $77,$67,$78,$79
    defb $69,$80,$4D,$68
    defb $82,$83,$79,$70
    defb $88,$4D,$68,$89
    defb $78,$67,$43,$4C
    defb $90,$70,$56,$5E
    defb $66,$59,$67,$68
    defb $6E,$6F,$4E,$4D
    defb $77,$67,$78,$79
    defb $69,$80,$4D,$68
    defb $82,$83,$79,$70
    defb $88,$4D,$68,$89
    defb $78,$67,$43,$4C
    defb $90,$70,$56,$5E
    defb $66,$59,$67,$68
    defb $6E,$6F,$4E,$4D
    defb $77,$67,$78,$79
    defb $69,$80,$4D,$68
    defb $82,$83,$79,$70
    defb $97,$4B,$68,$89
    defb $46,$46,$46,$45
intro_bank1_data_8636
    defb $9A,$9B,$9C,$9C
    defb $9F,$A0,$A1,$A2
    defb $A7,$A8,$A9,$AA
    defb $AE,$AF,$A7,$B0
    defb $B4,$A0,$B5,$B6
    defb $BA,$BB,$BC,$BD
    defb $AE,$C0,$C1,$C2
    defb $A9,$A0,$A4,$9F
    defb $C8,$C9,$CA,$CB
    defb $9F,$CC,$A1,$A2
    defb $A7,$CD,$A9,$AA
    defb $AE,$AF,$A7,$B0
    defb $B4,$A0,$B5,$B6
    defb $BA,$BB,$BC,$BD
    defb $AE,$C0,$C1,$C2
    defb $A9,$CE,$CF,$9F
    defb $C8,$D0,$D1,$CB
    defb $9F,$D2,$D3,$A2
    defb $A7,$A8,$A9,$AA
    defb $AE,$AF,$A7,$B0
    defb $B4,$A0,$B5,$B6
    defb $BA,$BB,$BC,$BD
    defb $AE,$C0,$C1,$C2
    defb $A9,$A0,$A4,$9F
    defb $C8,$D4,$CA,$CB
    defb $D5,$D6,$9C,$9C
intro_bank1_data_867A
    defb $9C,$9C,$9D,$9E
    defb $A3,$A4,$A5,$A6
    defb $AB,$AC,$AD,$9E
    defb $B1,$B2,$B3,$A6
    defb $B7,$B8,$B9,$9E
    defb $BE,$BF,$A5,$A6
    defb $C3,$C4,$C5,$9E
    defb $C6,$B0,$C7,$A6
    defb $CA,$CB,$9D,$9E
    defb $A3,$A4,$A5,$A6
    defb $AB,$AC,$AD,$9E
    defb $B1,$B2,$B3,$A6
    defb $B7,$B8,$B9,$9E
    defb $BE,$BF,$A5,$A6
    defb $C3,$C4,$C5,$9E
    defb $C6,$B0,$C7,$A6
    defb $CA,$CB,$9D,$9E
    defb $A3,$A4,$A5,$A6
    defb $AB,$AC,$AD,$9E
    defb $B1,$B2,$B3,$A6
    defb $B7,$B8,$B9,$9E
    defb $BE,$BF,$A5,$A6
    defb $C3,$C4,$C5,$9E
    defb $C6,$B0,$C7,$A6
    defb $CA,$CB,$9D,$9E
    defb $9C,$9C,$D7,$A6

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
    BYTE $00,$01,$02,$03,$04
    BYTE $05,$06,$07,$08,$09
    BYTE $0A,$0B,$0C,$0D,$0E
    BYTE $0F,$10,$11,$12,$13
    BYTE $14,$15,$16,$17,$18
    BYTE $19,$1A,$1B,$1C,$1D
    BYTE $1E,$1F,$20,$21,$22
    ;defb $00,$00,$01,$00,$00,$11,$12,$13,$14,$15,$2F,$30,$31,$32,$33,$4D
    ;defb $4E,$4F,$50,$51,$69,$6A,$4F,$6B,$6C,$82,$83,$84,$85,$86,$95,$96
    ;defb $97,$98,$99	;88A5
intro_bank1_data_89A5
    BYTE $23,$24,$25,$26,$27
    BYTE $28,$29,$2A,$2B,$2C
    BYTE $2D,$2E,$2F,$30,$31
    BYTE $32,$33,$34,$35,$36
    BYTE $37,$38,$39,$3A,$3B
    BYTE $3C,$3D,$3E,$3F,$40
    BYTE $41,$42,$43,$44,$45
    ;defb $00,$02,$03,$04,$00,$16,$17,$18,$19,$1A,$34,$35,$36,$37,$38,$52
    ;defb $53,$54,$55,$56,$6D,$6E,$6F,$70,$71,$87,$18,$18,$18,$88,$00,$9A
    ;defb $9B,$9C,$00	;89C8
intro_bank1_data_89C8
    BYTE $46,$47,$48,$49,$4A
    BYTE $4B,$4C,$4D,$4E,$4F
    BYTE $50,$51,$52,$53,$54
    BYTE $55,$56,$57,$58,$59
    BYTE $5A,$5B,$5C,$5D,$5E
    BYTE $5F,$60,$61,$62,$63
    BYTE $64,$65,$66,$67,$68
    ;defb $05,$06,$07,$08,$09,$1B,$1C,$1D,$1E,$1F,$39,$3A,$3B,$3C,$3D,$57
    ;defb $58,$59,$58,$5A,$72,$58,$73,$58,$74,$89,$8A,$58,$8B,$8C,$00,$00
    ;defb $9D,$00,$00	;89EB
intro_bank1_data_89EB
    BYTE $69,$6A,$6B,$6C,$6D
    BYTE $6E,$6F,$70,$71,$72
    BYTE $73,$74,$75,$76,$77
    BYTE $78,$79,$7A,$7B,$7C
    BYTE $7D,$7E,$7F,$80,$81
    BYTE $82,$83,$84,$85,$86
    BYTE $87,$88,$89,$8A,$8B
    ;defb $00,$0A,$0B,$0C,$00,$20,$21,$22,$23,$24,$3E,$3F,$40,$41,$42,$5B
    ;defb $5C,$40,$5D,$5E,$75,$76,$40,$41,$77,$8D,$22,$22,$22,$8E,$00,$9E
    ;defb $9F,$A0,$00	;8A0E
intro_bank1_data_8A0E
    BYTE $8C,$8D,$8E,$8F,$90
    BYTE $91,$92,$93,$94,$95
    BYTE $96,$97,$98,$99,$9A
    BYTE $9B,$9C,$9D,$9E,$9F
    BYTE $A0,$A1,$A2,$A3,$A4
    BYTE $A5,$A6,$A7,$A8,$A9
    BYTE $AA,$AB,$AC,$AD,$AE
    ;defb $00,$00,$0D,$00,$00,$25,$26,$27,$28,$29,$43,$44,$45,$46,$47,$5F
    ;defb $60,$61,$62,$63,$78,$79,$7A,$7B,$7C,$8F,$90,$27,$91,$92,$A1,$A2
    ;defb $A3,$A4,$A5	;8A31
intro_bank1_data_8A31
    BYTE $AF,$B0,$B1,$B2,$B3
    BYTE $B4,$B5,$B6,$B7,$B8
    BYTE $B9,$BA,$BB,$BC,$BD
    BYTE $BE,$BF,$C0,$C1,$C2
    BYTE $C3,$C4,$C5,$C6,$C7
    BYTE $C8,$C9,$CA,$CB,$CC
    BYTE $CD,$CE,$CF,$D0,$D1
    ;defb $00,$0E,$0F,$10,$00,$2A,$2B,$2C,$2D,$2E,$48,$49,$4A,$4B,$4C,$64
    ;defb $65,$66,$67,$68,$7D,$7E,$7F,$80,$81,$93,$2C,$2C,$2C,$94,$00,$A6
    ;defb $A7,$A8,$00
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
	
intro_call_B732
    nextreg $43,%10110000      ;select tilemap palette
    ld   a,(l_e5d7)
    cp   $03
    ret  nz
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

intro_call_B878
    ;ld   hl,$F8E0       ;palette entry $70
    ;ld   de,$F920       ;palette entry $90
    ;ld   bc,$0020
    
    ;break
    ld a,$70
    ld l,$10
intro_call_B878_loop
    nextreg $43,%10010000
    push af
    nextreg $40,a
    ld  bc,$243b
    ld a,$41
    out (c),a
    ld  bc,$253b
    in d,(c)
    ld  bc,$243b
    ld a,$44
    out (c),a
    ld  bc,$253b
    in e,(c)
    pop af
    push af
    add $20
    nextreg $40,a
    ld a,d
    nextreg $44,a
    ld a,e
    nextreg $44,a
    nextreg $43,%10100000
    ld a,d
    nextreg $44,a
    ld a,e
    nextreg $44,a
    pop af
    inc a
    dec l
    jr nz,intro_call_B878_loop
    
;    ldir
    ret
intro_call_B884                 ;BIG HEART
    ld   hl,$3860;7990;$D818
    ld   de,intro_data_B893
    ld   bc,$0108
    ;ld   a,$26
    ex af,af'
	ld a,$90 	;gfx atrtibute
	ex af,af'
	ld a,$42
    call call_Layer2_0EC6
    ;split as over 2 layer 2 pages
    ld   hl,$4060;7990;$D818
    ld   de,intro_data_B893+8
    ld   bc,$0708
    ;ld   a,$26
    ex af,af'
	ld a,$90 	;gfx atrtibute
	ex af,af'
	ld a,$42
    call call_Layer2_0EC6

    ret
intro_data_B893         ;Big Heart
    BYTE $5E,$5F,$62,$63,$66,$67,$6A,$6B,$60,$61,$64,$65,$68,$69,$6C,$6D
    BYTE $6E,$6F,$72,$73,$76,$77,$7A,$7B,$70,$71,$74,$75,$78,$79,$7C,$7D
    BYTE $7E,$7F,$82,$83,$86,$87,$8A,$8B,$80,$81,$84,$85,$88,$89,$8C,$8D
    BYTE $8E,$8F,$92,$93,$96,$97,$9A,$9B,$90,$91,$94,$95,$98,$99,$9C,$9D


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


Clear_Layer2_Text
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
	;ld   b,(hl)		;get text length
	;inc  hl
Clear_Layer2_Text_Loop
	
	
	ld   a,0
    ;ld   (de),a
    ;inc  hl
	call Layer2_Clear_Char
	
	
    ;inc  de
    ;ld   a,c
	;ld   (de),a
	;inc  de
    djnz Clear_Layer2_Text_Loop
	
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

Layer2_Clear_Char			;write a letter to Layer 2
	push hl
    push bc
	push de
    ld b,8
Layer2_Clear_Char_Loop2
	push de
	push bc

	ld b,8
Layer2_Clear_Char_Loop
	ld (de),a
	inc de
	djnz Layer2_Clear_Char_Loop

	pop bc
	pop de
	inc d
	djnz Layer2_Clear_Char_Loop2
	pop de
	ld hl,$0008
	add hl,de
	ex de,hl
    pop bc
	pop hl
	ret
/*
Write_Layer2_320_Text
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
Write_Layer2_320_Text_Loop
	
	
	ld   a,(hl)
    ;ld   (de),a
    inc  hl
	call Layer2_320_Write_Char
	
	
    ;inc  de
    ;ld   a,c
	;ld   (de),a
	;inc  de
    djnz Write_Layer2_320_Text_Loop
	
	ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	ei
	ret

Layer2_320_Write_Char			;write a letter to Layer 2
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
Layer2_320_Write_Char_Loop2
	push de
	push bc
	ld b,4
Layer2_320_Write_Char_Loop
	ld a,(hl)
	and $F0
	call call_0D62			;div 16
	or c
	ld (de),a
	inc d;e
	ld a,(hl)
	and $0F
	or c
	ld (de),a
	inc d;e
	inc hl
	djnz Layer2_320_Write_Char_Loop
	pop bc
	pop de
	inc e;d
	djnz Layer2_320_Write_Char_Loop2
	pop de
	ld hl,$0800
	add hl,de
	ex de,hl
	pop bc
	pop hl
	ret
*/	

    ;routine to use address $8000 to stage tiles data ahead
    ;of copy into tilemap
    ;a = gfxbank
extend_get_tiles_single_bubble
    call intro_get_tiles_at_8000

    nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	
	;ld de,$5600
	;ld hl,$8000		;offset
	ld bc,$460		;35 tiles (7 x 5) * 32 bytes
	ldir

    call intro_restore_8000

    ret


    ;routine to use address $8000 to stage tiles data ahead
    ;of copy into tilemap
    ;a = gfxbank
extend_get_tiles
    call intro_get_tiles_at_8000

    nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	
	ld de,$5600
	ld hl,$8000		;offset
	ld bc,$2000		;256 tiles * 32 bytes
	ldir

    call intro_restore_8000

    ret
	
extend_0EC6     ;H has bank, L has column number
	di
	ld 	(oldstack),sp
	ld sp,$FF00				;space at end of this bank	
	push af
	;push bc

    ex de,hl

    ld a,d
    nextreg $54,a
	
	;ld bc,$123B		;now we can safely page in Layer 2 for writes
	;ld a,d
	;and $C0			;get correct bank for Layer 2
	;or %00000011	;set write mode
	;out (c),a
	
	;ld a,d
	;and $3f
	;ld d,a			;mask layer 2 address with 8k bank
	
	;pop bc
    pop af
    ;ld a,$ff
    ;sub e
    ;ld e,a
    ;actual code here
    ld d,$80       ;make hl point to offset with $8000
	
extend_0EC6_loop2
	push bc
	push de;hl
	ld b,c
extend_0EC6_loop1
	push af
	add a,(hl)
	;ld a,(hl)
	;push af
;	ld (de),a
;	inc de
	;pop af
	jr nc,extend_0EC6_in_first_256
	ex af,af'
	inc a
	;ld (de),a
    ld c,a
	dec a
	jr extend_0EC6_in_second_256
extend_0EC6_in_first_256
	ex af,af'
	;ld (de),a
    ld c,a
extend_0EC6_in_second_256
	ex af,af'
    ;break
   ; ld a,65
   ; ld c,$10
    call Extend_Write_Char
    ;call Layer2_Write_Char
	;inc de
	inc hl
	pop af
	djnz extend_0EC6_loop1
	pop de;hl
	ex de,hl
	ld bc,$0008;$0800
	add hl,bc
	ex de,hl
    ;inc d
	pop bc
	djnz extend_0EC6_loop2
	ex de,hl

    call intro_restore_8000

    ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
	ret

Extend_Write_Char			;write a letter to Layer 2
;    break
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
Extend_Write_Char_Loop2
	push de
	push bc
	ld b,4
Extend_Write_Char_Loop
	ld a,(hl)
	and $F0
	call call_0D62			;div 16
	or c
	ld (de),a
	inc d
	ld a,(hl)
	and $0F
	or c
	ld (de),a
	inc d
	inc hl
	djnz Extend_Write_Char_Loop
	pop bc
	pop de
	inc e
	djnz Extend_Write_Char_Loop2
 ;   break
	pop de
	ld hl,$0800
	add hl,de
	ex de,hl
    pop bc
	pop hl
	ret

call_Layer2_0EC6
	di
	ld 	(oldstack),sp
	ld sp,$FF00				;space at end of this bank	
	push af
	push bc

    ex de,hl
	
	ld bc,$123B		;now we can safely page in Layer 2 for writes
	ld a,d
	and $C0			;get correct bank for Layer 2
	or %00000011	;set write mode
	out (c),a
	
	ld a,d
	and $3f
	ld d,a			;mask layer 2 address with 16k bank
	
	pop bc
    pop af
    ;actual code here
	
call_Layer2_0EC6_loop2
	push bc
	push de;hl
	ld b,c
call_Layer2_0EC6_loop1
	push af
	add a,(hl)
	;ld a,(hl)
	;push af
;	ld (de),a
;	inc de
	;pop af
	jr nc,call_Layer2_0EC6_in_first_256
	ex af,af'
	inc a
	;ld (de),a
    ld c,a
	dec a
	jr call_Layer2_0EC6_in_second_256
call_Layer2_0EC6_in_first_256
	ex af,af'
	;ld (de),a
    ld c,a
call_Layer2_0EC6_in_second_256
	ex af,af'
    ;break
    call Layer2_Write_Char
	;inc de
	inc hl
	pop af
	djnz call_Layer2_0EC6_loop1
	pop de;hl
	ex de,hl
	ld bc,$0800
	add hl,bc
	ex de,hl
    ;inc d
	pop bc
	djnz call_Layer2_0EC6_loop2
	ex de,hl

    ld bc,$123B
	ld a,%00000010
	out (c),a
	ld 	sp,(oldstack)
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
