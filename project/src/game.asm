    DEVICE ZXSPECTRUMNEXT

;    INCLUDE "nextcodes.asm"			;macros to add Next Extended Opcodes
;    INCLUDE "game_public.asm"       ;public E000 space
 
 
    MACRO	FillLDIR startaddr, filllength, value
	    ld hl,startaddr
	    ld de,startaddr+1
	    ld bc,filllength-1
	    ld (hl),value
	    ldir
    ENDM


EXTEND_FIRST_SPRITE_P1	EQU 114
EXTEND_FIRST_SPRITE_P2	EQU 122

;screenholder EQU $5b00;$5b00 ;don't need systen vars
;codestart EQU $5b00+$600+$80;start code after screenholder + 128 byte stack
codestart   EQU $7000 
kempston1   EQU $1f;0x1ffd
kempston2   EQU $37;0x1ffd

;mainstart   EQU $7600+$800
mainstart	EQU $8000+256+128	;all of screen bank 5 is needed for tilemap mode
									;we also need room for the pattern_addr, pattern_bank & sprite_attr	
;intropal EQU $c000      ;palette info
;intro   EQU $c000+$100  ;code start for intro in bank

;banks 1,3 and 7 are contended  -
;need to multiply by 2 as these are now 8k banks (rather than 16k)
introbank   EQU 43*2   
slavebank EQU 44*2;9
firstlevelsbank EQU 45*2;10
secondlevelsbank EQU 46*2;11
bank1 EQU 40*2;12
//gfx1bank  EQU 26*2;13
//gfx2bank  EQU 25*2;14
bank2 EQU 41*2
bank0 EQU 39*2
bank3 EQU 42*2     
divmmcbank EQU 47*2
gfxbank00  EQU 15*2
gfxbank01  EQU 16*2
gfxbank02  EQU 17*2
gfxbank03  EQU 18*2
gfxbank04  EQU 19*2
gfxbank05  EQU 20*2
gfxbank06  EQU 21*2
gfxbank07  EQU 22*2
gfxbank08  EQU 23*2
gfxbank09  EQU 24*2
gfxbank10  EQU 25*2
gfxbank11  EQU 26*2
gfxbank12  EQU 27*2
gfxbank13  EQU 28*2
gfxbank14  EQU 29*2
gfxbank15  EQU 30*2
gfxbank16  EQU 31*2
gfxbank17  EQU 32*2
gfxbank18  EQU 33*2
gfxbank19  EQU 34*2
gfxbank20  EQU 35*2
gfxbank21  EQU 36*2
gfxbank22  EQU 37*2
gfxbank23  EQU 38*2
;gfxbank16  EQU 48*2
;gfxbank17  EQU 49*2
;gfxbank18  EQU 50*2
;gfxbank19  EQU 51*2
;gfxbank20  EQU 52*2
;gfxbank21  EQU 53*2
;gfxbank22  EQU 54*2
;gfxbank23  EQU 55*2

;spriteholder EQU 16*2
pattern_addr	EQU $8000				;this is where we store the pattern offsets for each sprite (room for 16 bit address for 128 potential patterns)
pattern_bank	EQU pattern_addr+256	;this is where we store the bank offsets for each sprite (room for 8 bit address for 128 potential patterns)


;l_cd00 EQU $7600

;stack_top   EQU l_f7fe

MUSIC_START EQU $E000
MUSIC_MOD_START EQU MUSIC_START+$03
MUSIC_PLAY EQU MUSIC_START+$05
MUSIC_MUTE EQU MUSIC_START+$08
MODULE1 EQU $E86E
                                                                
FLOORTILE  EQU 7

    include "ramlayout.asm"

    include "romloader.asm"

    
    org mainstart       ;this is point after the variable space
                         ;and after then $800 byte screen holder

    di

    nextreg $07,$03		;set turbo to 28Mhz
	
	nextreg $12,$08		;ensure layer 2 points to bank 8
	nextreg $13,$08		;ensure layer 2 shadow also points to bank 8

    nextreg $50,divmmcbank
    nextreg $51,divmmcbank+1

    ld sp,l_f7fe    ;this matches arcade


    ;set starting back at location C000 to bank 0
    ld a,bank0
    call call_026C_DI

	

    call setinterrupt

/*    ld bc,$243b
    ld a,05
    out (c),a    ;Select register #05  (peripheral 1)
    
    ld bc,$253b
    in a,(c)
	and 1		;preserve the scandoubler setting
    ;or 4        ;set to 60hz to match arcade
	or %01000110	;set to 60hz to match arcade, and both kempston joysticks
    out (c),a
  */  
    ld bc,$243b
    ld a,06
    out (c),a    ;Select register #06  (peripheral 2)
    
    ld bc,$253b
    in a,(c)
    and $f7
    or 128+1        ;Enable Turbo Mode
    out (c),a
	
	;nextreg $06,%10000000	;Enable Turbo Mode

    ld a,slavebank
    call call_026C_DI  ;switch bank    
    call MUSIC_START              ;music init
    call call_029B_DI

	
	;nextreg $07,$02		;set turbo to 14Mhz

	nextreg $68,%10000000
	nextreg $6b,%00000011		;tilemap control - disable until ready
	nextreg $6F,$00				;tile definition start address = 0
	nextreg $6E,$76				;tilemap start address $36 * $100 = $3600 + $4000 = $7600


	;ld hl,l_e1cc
    ld a,introbank 
    call call_026C;switchbank
 ;   call intro_updateromtable   ;this updates the table 
	call intro_init_layer2
    call call_029B ;restore bank


    ;ld hl,l_e1cc
;    ld a,introbank 
;    call call_026C;switchbank
 ;   call intro_updateromtable   ;this updates the table 
 ;   call call_029B ;restore bank

;    call hidelayer2
;    call clearlayer2
    
    ld a,0
    out ($fe),a				;border black
    call clearscreen
    call killsprites

	nextreg $4b,$0f			;set global transparency
	
	;nextreg $15,%01101011     ;Set priority - Sprite, ULA/Tiles, Layer 2 and show over borders
	nextreg $15,%01100110     ;Set priority - Sprite, ULA/Tiles, Layer 2 and show over borders
	
	;set sprite clipping (to hide y pos 0)
	nextreg $1c,%00001111
	nextreg $19,16
	nextreg $19,143	;(this will be internally doubled as we have set sprites over border mode)
	nextreg $19,0
	nextreg $19,231

    ;set layer 2 clipping
    nextreg $18,0
	nextreg $18,255	
	nextreg $18,0
	nextreg $18,183 ;hide bottom line for scrolling text purposes
	

	
	
	
    
/*	
    ld      bc,$243b		;sprite clip control
    ld      a,$19
    out     (c),a
    ld      bc,$253b
    ld      a,0
    out     (c),a
	ld      a,160
    out     (c),a
	ld      a,0
    out     (c),a
	ld      a,120
    out     (c),a
*/

	;ld bc,$0000			;frame
	
	
/*	
	ld bc,$0057
	ld a,32
	out (c),a
	out (c),a
	ld a,$70
	out (c),a
	ld a,%11000000
	out (c),a
	ld a,%10000000
	out (c),a
*/
	;nextreg $34,0		;sprite 0
	;nextreg $35,250		;sprite 0 x 
	;nextreg $36,50		;sprite 0 y
	;nextreg $36,$60		;sprite 0 palette offset 6
	;nextreg $38,%11000000		;make visible
	;nextreg $39,%10000000		;sprite 0 4 bit
/*	
	ld bc,$243b
    ld a,21
    out (c),a    ;Select register #21
	
	ld bc,$253b
    ld a,%00001011
    out (c),a     ;All sprites visible (over border)  
*/	
	
	
    ld hl,l_e000    ;clear variable space
    ld de,l_e000+1
    ld (hl),0
    ld bc,$1a00-1
    ldir    

    

   ;0B0A        ;Ignore???   
 ;   ld   a,(l_fe01)
 ;   ld   hl,($C000)
 ;   ld   a,l
 ;   and  $03
 ;   or   $81
 ;   ld   l,a
 ;   ld   h,$FE
 ;   ld   (hl),c
 ;   jp   $00E8
    
    ;$00E8
    ;more memchecks
    
    ;$0111
     ld   hl,bank3_call_9603;$9603
     ld   (l_fd86),hl   ;this hold address to jump to later
     dec  de
   
     ;$0124  
     ld   hl,l_ff94
     ld   (hl),$01


    
    ld a,$2e        
    ld (l_fc00),a   ;$0130
 ;   ld a,($5b5c);$74        ;$0143
    ld a,bank0
    ld (l_e1cb),a

  ;  call copysprite  ;temp to create a temp sprite for testing
	call copycoretiles			;this copies the logo and font tiles which are
			
					;needed consistently throughout the game

	
	ld hl,$7600
	call call_03FD ;clear row (bytes rid of 'bytes' message);
	ld hl,$7640
	call call_03FD ;clear row (bytes rid of 'bytes' message);
	;ld hl,$7610
	;call call_03FD ;clear row (bytes rid of 'bytes' message);
	;ld hl,$7650
	;call call_03FD ;clear row (bytes rid of 'bytes' message);
	;ld hl,$7660
	;call call_03FD ;clear row (bytes rid of 'bytes' message);
	;ld hl,$76A0
	;call call_03FD ;clear row (bytes rid of 'bytes' message);
	;ld hl,$76B0
	;call call_03FD ;clear row (bytes rid of 'bytes' message);
	

    call call_0AFC  	;
	
;	BYTE "call_0438"
    call call_0438

    ld   a,(l_fc20)
    bit  2,a
    jr   nz,call_0171
;    ld   a,$02
;    call call_026C ;bank switch
;    jp   $8000
call_0171
    call call_0BC8   ;$0171
;    ld   a,$EF     
 ;   ld   ($FA00),a   ;SOUND IO
    ;call call_0431     ;bank control
    call call_3449
    call call_31E1
    call call_031C
    call call_0372



    ld   a,bank3
    call call_026C;bankswitch
    call call_24ED
    call call_029B;restorebank
    ld   hl,l_e194
    ld   (hl),$01



    ;ld   a,$2D
    ;ld   ($FA00),a   ;SOUND IO
    call call_0427  ;bank control
    ;ld   hl,($FC82)
    ;ld   a,h
    ;or   l
    ;jr   z,$01C4   ;PS$ SUM ERROR CHECK PASSED
    ;ld   a,($FC7D) ;$01C4
    ;and  a
    ;jr   z,$01D7  ;IO ERROR CHECK PASSES
    ld   a,$00          ;$01D7
    call call_0030
    ld   hl,l_ff98
    ld   (hl),$47
    ld   a,$AA
    call call_0EE0
    ld   hl,l_fc1f
    set  0,(hl)
    ;now sits in loop until interrupt goes to 044D (after 0AEE)
    ;IM2 routine - i=$0B, bus seems to pass $2E (value held at $FC00)
    ;$0B2E points to $044D

	;ei
	
	;***** Once initialisation is complete everything is controlled through this interrupt driven routine ****
call_01ED
    ei
    halt
    call call_0AEE;call_044D
    jr call_01ED
	
	
    BYTE "CALL_01ED"
    ;mem values needed by bootleg?
    ;ff00 to ff03 are dip switch values
l_fe00  BYTE $F0
l_fe01  BYTE $55
l_fe02  BYTE $A3
l_fe03  BYTE $D3

l_fe80  BYTE $00
l_fe81  BYTE $FF
l_fe82  BYTE $FF
l_fe83  BYTE $FF

;DIP Switches
l_ff00  BYTE %11111110  ;11 Coin B, 11 Coin A, 1 Demo Sounds, 110, Game, English, No Flip Screen
l_ff01  BYTE %00111111  ;00 - Normal Monster Speed, 11 - 3 lives, 11 - Bonus 30K,100K,400K, 11 - Normal Difficulty
;Inputs
l_ff02  BYTE %11110011
l_ff03  BYTE %11111111
l_ff94  BYTE 0
l_ff98  BYTE 0


;include "oldintrocode.asm"

    BYTE "CALL_026C"
call_026C   ;switchbank
    call call_026C_DI
    ;ei
    ret

call_026C_DI ;call directly to avoid interrupts being re-enabled
    di 
    push af
    ld a,(l_e1cb)
    ld (l_e1cc),a
    pop af

    ld (l_e1cb),a
    nextreg $56,a
    inc a
    nextreg $57,a
    
    ret

  ;  BYTE "CALL_029B"
call_029B
    call call_029B_DI
    ;ei
    ret

call_029B_DI   ;restorebank
    di
    
    ld   a,(l_e1cc) ;restore first 4k bank
    nextreg $56,a
    ld (l_e1cb),a    
    inc a
    nextreg $57,a

    ret

call_14E1
    ld   e,(ix+$07)
call_14E4
    ld   d,$00
call_14E6
    ld   a,d
    call mul32;call_0D6C
    or   e
    ex   af,af'
    inc  d
    ld   a,d
    cp   $04
    jp   nz,call_14F6
    ld   d,$00
    inc  e
call_14F6
    ex   af,af'
    push de
    push bc
    push hl
    ld   b,(hl)
    call call_149C
    pop  hl
    pop  bc
    pop  de
    inc  hl
    djnz call_14E6
    ret


call_1529    
loadhlfromspritestruct              ;$1529
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ret
    
call_1530
    ld   l,(ix+$01)
    ld   h,(ix+$02)
    ret


call_1537
loadhl2             ;$1537
    ld   l,(ix+$03)
    ld   h,(ix+$04)
    ld   a,(hl)
    add  a,$08
    ld   (ix+$01),a
    inc  hl
    inc  hl
    ld   a,(hl)
    add  a,$08
    ld   (ix+$02),a
    ret
    
call_154C
    call loadhlfromspritestruct;$1529
    ld   (hl),$00
    inc  hl
    inc  hl
    ld   (hl),$00
    ret


call_1556
resetframetimer            ;$1556
    xor  a
    ld   (ix+$05),a
    ld   (ix+$06),a
    ret
call_155E
    call call_1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$10
    ret

call_1570
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$12
    ret
call_1579    
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$13
    ret
    
call_158B    
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$15
    ret
call_1594
    call call_1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$16
    ret
call_159D
    call call_1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$17
    ret
call_15A6
    call call_1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$18
    ret
call_15AF
    call call_1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$19
    ret
call_15B8
    call call_1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$1A
    ret
call_15C1
    call call_1529
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),$1B
    ret
call_15CA
frametimer         ;$15ca d=timer between frame updates  e=number of frames
    inc  (ix+$06)
    ld   a,(ix+$06)
    cp   d          ;is it $0a (10)
    jp   nz,call_15E5
    ld   (ix+$06),$00  ;reset counter (ix+06)
    inc  (ix+$05)      ;increase frame number (ix+05)
    ld   a,(ix+$05)    ;load into a
    cp   e             ;compare to 06, as weonly have have bubble frames
    ret  nz            ;return if still a valid frame with frame number in a
    xor  a             ;else zero 0 a 
    ld   (ix+$05),a    ;and zero frame and return frame number
    ret
call_15E5
    ld   a,(ix+$05)   ;return with frame number in a
    ret

call_15E9
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    ret  z
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    jp   call_174C
call_1604
    ld   a,(ix+$02)
    sub  $08
call_1609
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    ret  z
    ld   a,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    jp   call_174C
call_161F
    ld   a,(ix+$01)
    add  a,$08
    cp   $D8
    jp   c,call_162E
    cp   $E0
    jp   c,call_1634
call_162E
    ld   h,(ix+$02)
    jp   call_174C
call_1634
    xor  a
    ret
    

call_166B
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    sub  $08
    jp   call_174C
call_1676
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    ret  z
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    ret  z
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    jp   call_174C
call_169F
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    ret  z
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    call call_174C
    ret  z
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    jp   call_174C
call_16C2
call_16E1			;for now just use same routine as for 16C2
    call call_1530



call_16C5			;translates column/row (H/L) into Tilemap coords
	push bc
	ld	a,h			;get column number
	call div4
	push af
    ld   a,l		;get row number
    neg
    srl  a
    srl  a
	srl  a
    and  $1F;$3E
	dec a
    ld   b,$50
	call call_0DB1   ;a * b - returned in HL
	
    pop  af
    call adda2hl;call_0D84
    ld   de,$7608;$CD00   ;TODO - screen loc
    add  hl,de
    res  0,l
	pop bc
    ret
    
/*
call_16E1
    call call_1530
    ld   a,l		;get row
    neg
    srl  a			;divide by 4 (row is in pixel - we are converting to tile cell
    srl  a			;but each cell is 2 bytes so we only divide by 4
    and  $3E		;mask
    push af	
    ld   a,h
    call div8;$0D64
    call call_0D8E   ;a * 64 into DE
    pop  af
    call adda2de;$0D84
    ld   hl,$7650;$D500     ;TODO - screen loc
    add  hl,de
    res  0,l
    ret
*/


  ;  BYTE "CALL_1700"
call_1700
    ld   hl,l_e397     ;set slave newmap_flag to decode new map
    ld   (hl),$01
call_1705
    call  call_0020
    ld   a,(l_e397)     ;get slave newmap_flag			;1706 - one of the addresses 'returned to' from $0085
    and  a
    jp   p,call_1705    ;has map finished decoding?
    ld   a,bank1         ;switch bank
    call call_026C
    ld   a,(l_e59b)
    srl  a
    srl  a
    srl  a
    and  $1E
    ld   hl,bank1_data_95AA
    call adda2hl;$0D89
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ex   de,hl
    ld   de,l_e398
    ld   bc,$0050
    ldir
    ld   a,(l_e59b)
    and  $0F
    ld   hl,bank1_data_95AA
    call call_0DA7  ;mul2_addtohl_loadinde
    ex   de,hl
    ld   de,l_e568
    ld   bc,$0030
    ldir
    ld   hl,l_e397
    ld   (hl),$00
    call call_029B    ;restore bank
	call copyleveltiles
	ret
   ;  ret ;needed as not using restore bank to return

call_174B		;check map data for given coord in HL
    ld   a,l
call_174C
    ld   d,h
    neg
    and  $F8
    add  a,a
    ld   l,a
    ld   h,$00
    rl   h
    ld   a,d
    rrca
    rrca
    rrca
    rrca
    and  $0F
    add  a,l
    ld   l,a
    jp   nc,call_1764
    inc  h
call_1764
    ld   bc,l_e398
    add  hl,bc
    ld   a,(hl)
    bit  3,d
    jp   nz,call_1772
    rrca
    rrca
    rrca
    rrca
call_1772
    and  $0F
    ret


   ; BYTE "CALL_1775"
call_1775    
    ld   a,bank1
    call call_026C  ;switch bank
    ld   a,(levelnum)
    ld   b,$2B
    call call_0DB1       ;a * b
    ld   de,bank1_data_A73A
    add  hl,de
    ld   de,l_e598
    ld   bc,$002B
    ldir				;copy 43 bytes of level data into ram
    call call_029B  ;restore bank
    ld   a,(levelnum)
    cp   $64			;Have we loaded the demo level?
    ret  z				;if so exit
    ld   a,(l_e5db)
    and  a
    jr   z,call_17E0
    ld   hl,l_e5a4
    bit  4,(hl)
    jr   nz,call_17A8
    set  4,(hl)
    jr   call_17AA
call_17A8
    res  4,(hl)
call_17AA
    ld   hl,l_e5a4
    res  0,(hl)
    ld   hl,l_e59c
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   a,e
    and  $F0
    call div16
    ld   c,a
    ld   a,d
    and  $F0
    or   c
    ld   (hl),a
    dec  hl
    ld   a,d
    and  $0F
    call mul16
    ld   c,a
    ld   a,e
    and  $0F
    or   c
    ld   (hl),a
    ld   hl,l_e59e
    ld   a,(hl)
    and  $0F
    call mul16
    ld   c,a
    ld   a,(hl)
    and  $F0
    call div16
    or   c
    ld   (hl),a
call_17E0
    ld   a,(l_e5dc)
    ld   hl,data_1851
    call adda2hl
    ld   a,(l_e59f)
    add  a,(hl)
    jr   z,call_17F2
    jp   p,call_17F4
call_17F2
    ld   a,$01
call_17F4
     ld   (l_e59f),a
     ld   a,(l_e5dc)
     cp   $10
     ret  c
     sub  $10
     ld   hl,data_1870
     call adda2hl
     ld   a,(l_e5a5)
     add  a,(hl)
     bit  7,a
     jr   nz,call_1811
     cp   $05
     jr   nc,call_1813
call_1811
     ld   a,$05
call_1813
     ld   (l_e5a5),a
     ld   a,(l_e5dc)
     cp   $10
     ret  c
     sub  $10
     ld   hl,data_187F
     call adda2hl
     ld   a,(l_e5a7)
     add  a,(hl)
     bit  7,a
     jr   nz,call_1830
     cp   $02
     jr   nc,call_1832
call_1830
     ld   a,$02
call_1832
     ld   (l_e5a7),a
     ld   a,(l_e5dc)
     cp   $10
     ret  c
     sub  $10
     ld   hl,data_188E
     call adda2hl
     ld   a,(l_e5a0)
     add  a,(hl)
     cp   $1E
     jr   c,call_184D
     ld   a,$1E
call_184D
     ld   (l_e5a0),a
     ret
     
data_1851
    BYTE $07,$06,$05,$04,$03,$02,$01,$00,$FF,$FE,$FD,$FC,$FB,$FA,$F9,$F8
    BYTE $F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8

data_1870
    BYTE $FD,$FD,$FD,$FC,$FC,$FC,$FC,$FB,$FB,$FB,$FA,$FA,$FA,$F9,$F9
data_187F
    BYTE $FE,$FE,$FD,$FD,$FC,$FC,$FB,$FB,$FA,$FA,$F9,$F9,$F9,$F9,$F9  
data_188E
    BYTE $01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,$05

call_189D
    ld   hl,l_e598
    call adda2hl;$0D89
    ld   a,(hl)
    ret

    
    
call_18A5          ;set 4 sprites entries gfx num
    inc  hl
    ld   a,d
    call mul32      ;$0D6C	;multiply by 32
    or   e
    ld   (hl),a
    inc  d
    ld   a,d
    cp   $04
    jr   nz,call_18B5
    ld   d,$00
    inc  e
call_18B5
    inc  hl
    inc  hl
    inc  hl
    djnz call_18A5
    ret
call_18BB
    ld   b,$0E
call_18BD
    ld   a,$06
    call call_0018;rst  $18
call_18C0
    bit  0,b
    jr   nz,call_18C9
    call call_0431
    jr   call_18CC
call_18C9
    call call_0427
call_18CC
    djnz call_18BD
    ret
call_18CF
    ld   b,$07
    ld   hl,l_ed21
call_18D4
    bit  0,(hl)
    jr   z,call_18E0
    ld   (hl),$10
    inc  hl
    inc  hl
    inc  hl
    ld   (hl),a
    jr   call_18E3
call_18E0
    inc  hl
    inc  hl
    inc  hl
call_18E3
    inc  hl
    djnz call_18D4
    ret

    
call_18E7
    xor  a
	ld 	 a,4			;we don't want the non-visible rows
    ld   (l_e5c4),a
    jp   call_1700
    
    
   ; BYTE "CALL_18EE"
call_18EE
    ld a,introbank
    call call_026C
    call intro_call_18EE
    call call_029B
    ret


    BYTE "INTRO ROUTINE"
call_1AED
    ;ld a,$ff        ;temp hack to show real ending
    ;ld (l_e5db),a

    ld a,1              ;flag to allow the options screen to be called
    ld (options_control),a
	

    call call_1BBA
    call call_0431
    call call_1387
;    ld   ix,data_0B2E
;    ld   de,$044D
;    ld   a,e
;    sub  (ix+$00)
    ;jr   nz,call_1B09
;    ld   a,d
;    sub  (ix+$01)
;    jr   call_1B0A
;call_1B09
;    pop  bc
call_1B0A
    call call_03CB
    call call_02BA
/*
	ld bc,$243b
    ld a,$68
    out (c),a    ;ULA Control Register
    
    ld bc,$253b
    ld a,%10000000        ;Disable the ULA
    out (c),a
*/
    ;nextreg $68,%10000000		;Disable the ULA
	;nextreg $6B,%10000011		;40x32, 512 tile, 16 bit map, on top of ULA

	;call call_7007			;Just to test the Extend Screen

    ;select tilemap palette 0
	;nextreg $43,$30
 
;we need to copy the tilemap for the logos across from the gfxbanks
;main logo is held in locs $504 through $589, locs $604 though $6b0, locs $7dc through $7ed
;taito logo is held in locs $400 through $41F
;reduced font is held in locs $430 through $45a
;each gfx bank hold 512 or $200 tiles, so:
;$504 is in bank 2 - tiles 4 through 137 (134 tiles) - paged start is $E020 
;$604 is in bank 3 - tiles 4 through 176 (173 tiles) - paged start is $C080 
;$7dc is in bank 3 - tiles 220 though 237 (18 tiles) - paged start is $FB80
;$400 is in bank 2 - tiles 0 though 31 (32 tiles) - paged start is $C000
;$420 in in bank 2 - tiles 32 though 90 (59 tiles) - paged start is $C400
;total 416 tiles - we have room for 432 

	
	;nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91




	ld	a,gfxbank02
	call call_026C	;page in gfx bank 2
	ld de,$4b60
	ld hl,$e020		;start of Main Logo tiles
	ld bc,$1120		;137 tiles * 32 bytes
	ldir
	call call_029B  ;restore bank

	
	ld	a,gfxbank03
	call call_026C	;page in gfx bank 3
	ld hl,$C080		;offset for Main Logo tiles
	ld de,$5C80		;next address for screen tiles (ULA disabled)
	ld bc,$15A0	    ;173 tiles * 32 bytes
	ldir
	ld hl,$FB80		;offset for Main Logo tiles
	;ld de,$6EA0		;next address for screen tiles (ULA disabled)
	ld bc,$240	    ;18 tiles * 32 bytes
	ldir
	call call_029B  ;restore bank
	;tile data filled up to 7460

    
    ld   a,bank1      ;switch bank - bank 1 has the tilemaps for the title screen
    call call_026C
    
;	nextreg $6E,$76				;tilemap start address $36 * $100 = $3600 + $4000 = $7600
;	moved to start of code

    ld	hl,$7702
    ld	de,bank1_data_8300
	ld	bc,$120A
	ex af,af'
	ld a,1*16	;gfx atrtibute
	ex af,af'
	ld  a,90
	;call leftlogoloop
	call call_0EC6_Adjusted

	
	ld   hl,$7716
	ld   de,bank1_data_83B4
    ld   bc,$120C
	ex af,af'
	ld a,1*16	;gfx atrtibute
	ex af,af'
	ld   a,224
	;call rightlogoloop
	call call_0EC6_Adjusted

	 
    ld   a,(l_e5db) ;check whether Super Bubble Bobble?
    and  a
    jr   call_1B45	;bootleg ignores Super flag  

    ld   hl,$7702   ;If super game, redraw correct logo
    ld   de,bank1_data_848C
	ld	bc,$0306
	ex af,af'
	ld a,1*16	;gfx atrtibute
	ex af,af'
	ld a,$b5
	;call superbblogoloop
	call call_0EC6_Adjusted
call_1B45
	call call_029B	;restore bank
    call call_21C4  ;display TAITO logo and text below
    call call_0427  ;switch in display screen
	;nextreg $6B,%10000011		;40x32, 512 tile, 16 bit map, on top of ULA

	;nextreg $43,%10100000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    ;nextreg $40,$1E                  ; (R/W) 0x40 (64) => Palette Index
	nextreg $43,%10110000        ; (R/W) 0x43 (67) => Palette Control - Tiles
    nextreg $40,$1E                  ; (R/W) 0x40 (64) => Palette Index

	
    ld   bc,$0186
call_1B51
	
    call call_0020
call_1B52
    push bc
    call call_1BCF
    call call_1B90
    pop  bc
    dec  bc
    ld   a,c
    or   b
    jr   nz,call_1B51
;    ld   de,$70F0       ;reset logo palette cycle to original colour
;    ld   (l_f83c),de
	nextreg $44,$E1		 ;reset logo palette cycle to original colour
	nextreg $44,$1

    ld   b,$5A
call_1B68
    call call_0020
    push bc
    call call_1BCF
    pop  bc
    djnz call_1B68
	

 ;   ld   ix,$0013
 ;   ld   bc,$00B9
    ;ld   a,(ix-$0f)
;    ld   a,$B9      ;this is what ROM value returns
;    sub  c
;    jr   nz,call_1B83
    ;ld   a,(ix-$0e)
;    ld   a,$0      ;this is what ROM value returns
;    sub  b      
;    jr   z,call_1B84
;call_1B83
;    exx
;call_1B84
    call call_0431  ;flip screen enable
    call call_03CB		;clear screen
    call call_02AC
    jp   call_0427 ;restore bank
    ;ret    ;should ret to call_2b06 - but currently stack runs out
call_1B90
    ld   hl,l_e5c5
    inc  (hl)
    ld   a,(hl)
    cp   $02
    ret  nz
    ld   (hl),$00
    inc  hl
    inc  (hl)
    ld   a,(hl)
    cp   $06
    jr   nz,call_1BA3
    xor  a
    ld   (hl),a
call_1BA3
    ld   hl,data_1BAE
    add  a,a
    add  a,l
    ld   l,a
    jr   nc,call_1BA3_1
    inc  h
;    ld   (l_f83c),de  ;Cycle logo colour
call_1BA3_1
    call call_0B30_update_entry
            
    ret
data_1BAE
    BYTE $F0,$70,$F6,$70,$F7,$50,$F8,$00,$FA,$00,$FF,$00    ;palette cycle data
call_1BBA
    ld   hl,l_e5d0
    ld   (hl),$00
    ld   hl,l_e5c7
    ld   (hl),$7F
    ld   b,$08
    ld   hl,l_e5c8
call_1BC9
    ld   (hl),$7F
    inc  hl
    djnz call_1BC9
    ret
    
call_1BCF
    ld   a,(l_e5d0)
    cp   $08
    ret  z
    ld   a,(l_fc22)
    and  $7F
    ld   hl,l_e5c7
    cp   (hl)
    ret  z
    cp   $7F
    ret  z
    ld   (hl),a
    ld   c,a
    ld   a,(l_e5d0)
    ld   hl,l_e5c8
    call adda2hl
    ld   (hl),c
    ld   hl,l_e5d0
    inc  (hl)
    ld   a,(hl)
    cp   $08
    ret  nz
    ld   b,$08
    ld   hl,l_e5c8
   ; ld   de,data_1cbe
call_1BFE
    jr call_1BFE    
call_1D17
    call call_0020
    call call_2375
    call call_3395    
call_1D1E
    call call_0020
    ld   b,$03
    xor  a
    ld   hl,$0000
call_1D25
    add  a,(hl)
    inc  hl
    djnz call_1D25
    sub  $3E
    jr   call_1D2E  ;on real rom this is jr,z - a rom check
    pop  af
call_1D2E
    ld   a,$01
    ld   (l_e5d4),a
    ld   (l_e5d3),a
    call call_03D0
    call call_041E
    call call_031C
    call call_0372
    call call_0415
	nextreg $43, %00100000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    nextreg $40, 0                  ; (R/W) 0x40 (64) => Palette Index
    call call_0B30
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tilemap
    nextreg $40, 0                  ; (R/W) 0x40 (64) => Palette Index
	call call_0B30
    call call_2117
    ld   a,$01
    call call_0030
call_1D4E
    call call_0020
    ld   a,(l_e366)
    or   a
    jr   nz,call_1D70
    ld   a,(l_e5d4)
    and  a
    jr   nz,call_1D4E
    call call_0028
    call call_063E
    call call_03CB
    call call_03D0
    call call_041E
    call call_031C
    call call_0372
    jr   call_1D1E

call_1D70
    call call_0028
    call call_063E
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   call_1D81
;    call call_0038
call_1D81
	call call_0427
    call call_03CB
    call call_03D0
	ld   a,introbank;$01      ;switch bank
    call call_026C
	call intro_call_2F7A
	call call_029B     ;restore bank
    call call_041E
    call call_031C
    call call_0372
    call call_0B30
    call call_21C4
    ld   hl,l_e5d4
    ld   (hl),$00
    ld   hl,l_e5d3
    ld   (hl),$00
call_1DA3
    call call_0020
;    ld   a,i
;    ld   h,a
;    ld   a,(l_fc00)			;MCU shared ram
;    ld   l,a
;    ld   de,$0B2E
;    or   a
;    sbc  hl,de
;    jr   $1DB5
;    push ix
call_1DB5
    call call_2117
    call call_31ED
    call call_2133
    call call_1FF7
    jr   nc,call_1DA3
    call call_2931
	call copy_intro_tiles
	ld a,introbank
	call call_026C
    call intro_call_2578
	call call_029B
	call call_0B30			;moved out of intro bank as uses bank switching
    call call_02AC
    xor  a
    ld   (l_e64b),a
    ld   (l_f676),a
    ld   (l_e34f),a
    ld   (l_e350),a
    ld   (l_e742),a
    ld   (l_e743),a
    ld   (l_e5de),a
    ld   (l_e5dd),a
    ld   (l_e358),a

    ;ld a,99                ;temp to set start level number
    ;ld   (l_e64b),a
	
	;ld a,$3f				;temp to test extend code
	;ld   (l_e742),a
	
	;ld a,$1f				;temp to test extend code
	;ld   (l_e743),a
    
	
    ld   a,(l_e5d8)
    and  a
    jr   nz,call_1DF5
    ld   hl,l_e613
    ld   (hl),$01
    jr   call_1DFA
call_1DF5
    ld   hl,l_e613
    ld   (hl),$03
call_1DFA
    call call_22C6
    ld   a,(l_e5d8)
	and  a
    ld   c,$03
    call nz,call_22F0
    call call_0514
    call call_3EAC
    call call_205E
    call call_207B
    call call_3FBD
    call call_3FFA
    call call_03CB
    call call_03D0
    call call_031C
    call call_0330
    call call_3395

    ld   hl,l_e352
    ld   (hl),$00
    call call_21CF

call_1E2F
    ld   a,$02
    call call_0030
    xor  a
    call call_0018
    call call_0028			;1e34 - one of the addresses 'returned to' from $0085
    call call_0020
    ld   a,(l_e5d7)			;1e36 - one of the addresses 'returned to' from $0085
    and  a
    jp   z,call_1F90
    call call_0020
    call call_2310			;1e3e - one of the addresses 'returned to' from $0085
    call call_2355
    call call_225C
	
    ld   hl,l_e64b
    inc  (hl)			;increase level number
    ld   a,(hl)
    cp   $64			;check to see if we've reached level 100
    jr   z,call_1E64
    call call_227C
call_1E53
    call call_03C2
    call call_03E1
    call call_041E
    call call_031C
    call call_0372
    jr   call_1E2F
call_1E64
    ld   a,$00
    ;ld   ($FA00),a			;TODO - Sound
    call call_03D0
    ld   a,(l_e5d7)
    bit  0,a
    jr   nz,call_1E7C
    ld   hl,l_e2c5
    ld   bc,$0010
    call call_0D50
call_1E7C
    ld   a,(l_e5d7)
    bit  1,a
    jr   nz,call_1E8C
    ld   hl,l_e2b5
    ld   bc,$0010
    call call_0D50
call_1E8C
    ld   hl,$7F18;$D53A			;clear lives and credit
    ;nextreg $70,%00010000      ;set layer 2 to 320 x 256

    ;we need to copy some new tiles, especially for level 100!
	nextreg $6F,$00				;tile definition start address = 0
	;nextreg  $6F,$5B				;tile definition start address = 91

	ld	a,gfxbank21
	call call_026C_DI	;page in gfx bank 21
	ld de,$5400
	ld hl,$CBC0		;offset
	ld bc,$0800		;64 tiles * 32 bytes
	ldir
	call call_029B_DI  ;restore bank

    ld	a,gfxbank20
	call call_026C_DI	;page in gfx bank 21
	ld de,$6000
	ld hl,$D200		;offset
	ld bc,$0A00		;80 tiles * 32 bytes
	ldir
	call call_029B_DI  ;restore bank

    call call_03FD
    call call_0300
    ld   a,$05
    call call_0010
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_1EB4

    ld   b,$64
call_1EA1
    ld   a,$05
    call call_0018
    push bc
    ld   a,(l_f2a3)
    ld   (l_e5d6),a
    ld   de,$1000
    call call_2FB3
    pop  bc
    djnz call_1EA1
call_1EB4
    ld a,introbank
    call call_026C
    call intro_call_clear_level_num
    call call_029B
    call call_21CF          ;clears and redraws scores
    call bank0_call_B34F    ;Crumble screen
    call copy_intro_tiles   ;get starfield tiles back into tilemap
  ;  break
    call bank0_call_B370         ;scroll message
    call call_0B30
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_1F30
    ld   a,(l_e5db)
    and  a
    jr   nz,call_1EEA
;    ld   a,($0002)
;    cp   $5E
;    jr   $1ED3
;    pop  af
;    pop  hl
call_1ED3
    call copy_big_words_tiles
    ld   a,bank2
    call call_026C
    call bank2_call_B77A
    call call_029B
    ld   bc,$0960
call_1EE1
    call call_0020
    dec  bc
    ld   a,c
    or   b
    jr   nz,call_1EE1
    call call_03CB
call_1EEA
    ld   a,$02
    ;ld   ($FA00),a			;TODO - Sound
    ld   a,$03
    call call_0018
    ld   c,$08
    call call_1350
	
	ld   a,introbank
    call call_026C
    call intro_call_361D
	call call_029B
	
    call call_03C2
    call call_041E
    call call_03CB
    call call_03D0
    call call_031C
    call call_0372
    call call_0020
    call call_38F0
    call call_20C1
    ld   a,(l_e5d7)
    bit  0,a
    call nz,call_0F26
    ld   a,(l_e5d7)
    bit  1,a
    call nz,call_0F74
    xor  a
    ld   (l_e5d1),a
    ld   (l_e603),a
    ld   (l_e5d2),a
    jp   call_1D1E
call_1F30
    ld   a,$00
    ;ld   ($FA00),a			;TODO - sound
    ld   a,r
    and  $07
    ld   hl,data_1F88
    call call_0D89
    ld   a,(hl)
    ld   (l_e64b),a
    ld   hl,data_1F74
    ld   de,$7B08;$D6E0
    ld   c,4*16;$04
    call call_0E9A
    ld   a,$3C
    call call_0018
    call call_18BB
    call call_03D0
    ld   hl,l_e5dc
    ld   (hl),$1E
    ld   hl,l_e5dd
    ld   (hl),$1E
    ld   c,$30
    call call_1350
    ld   hl,l_fc2f
    ld   a,$56
    call call_0D89
    ld   a,(hl)
    bit  5,a
    jp   call_1E53
data_1F74
	BYTE $13,"YOU ZAPPED TO ....."
data_1F88
	BYTE $31,$36,$3B,$40,$45,$4A,$4F,$54
call_1F90
    call call_0020
    ld   ix,$0001
    ld   hl,$00B9
    ld   a,l
    sub  (ix+$03)
    nop
    nop
    ld   a,h
    sub  (ix+$04)
    jr   call_1FA9
call_1FA5
    call call_0431
    pop  hl
    ret
call_1FA9
    call call_03C2
    call call_041E
    call call_031C
    call call_0372
    call call_21CF
    ld   a,$02
    ;ld   ($FA00),a		;TODO - sound
    ld   a,$03
    call call_0018
    ld   c,$08
    call call_1350
	
	ld a,introbank
	call call_026C
    call intro_call_361D		;routines moved for memory saving
	call call_029B
	
    call call_03C2
    call call_041E
    call call_03CB
    call call_03D0
    call call_031C
    call call_0372
    call call_0020
    call call_38F0
    call call_20C1
    xor  a
    ld   (l_e5d1),a
    ld   (l_e603),a
    ld   (l_e5d2),a
    jp   call_1D1E
call_1FEE
    ld   hl,l_e5df
    ld   bc,$0035
    jp   clearbytes
call_1FF7
    ld   hl,l_e366
    ld   a,(hl)
    cp   $01
    jr   nz,call_200D
    ld   a,(l_fc22)
    bit  6,a
    jr   nz,call_205C
    dec  (hl)
    ld   hl,l_e5d9
    inc  (hl)
    jr   call_202B
call_200D
    ld   a,(l_fc22)
    bit  6,a
    jr   nz,call_201B
    dec  (hl)
    ld   hl,l_e5d9
    inc  (hl)
    jr   call_202B
call_201B
    ld   a,(l_fc23)
    bit  6,a
    jr   nz,call_205C
    dec  (hl)
    dec  (hl)
    ld   hl,l_e5d9
    inc  (hl)
    inc  (hl)
    jr   call_2041
call_202B
    ld   hl,l_e5d7
    ld   (hl),$01
    ld   hl,l_e5d8
    ld   (hl),$00
    ld   a,$01
    call call_0EE0
    ld   a,$06
    call call_0EE0
    scf
    ret
call_2041
    ld   hl,l_e5d7
    ld   (hl),$03
    ld   hl,l_e5d8
    ld   (hl),$01
    ld   a,$01
    call call_0EE0
    ld   a,$06
    call call_0EE0
    ld   a,$07
    call call_0EE0
    scf
    ret
call_205C
    xor  a
    ret
call_205E    
    call call_32BE		
    call call_314E
    ld   hl,l_e641
    ld   bc,$0003
    call clearbytes
    call call_33BC
    ld   hl,data_20B5	;"     00    " for scores - player 1
    ;ld   de,$CD46
    ;ld  de,$4000+$20+$1
	ld	de,$76AA
    ld   c,$00
    jp   call_0E9A
  ;  ret         ;ret as arcade rets from writetext

call_207B
    call call_32C5
    call call_315F
    ld   hl,l_e646
    ld   bc,$0003
    call clearbytes
    ld   hl,numplayers  ;e5d7
    bit  1,(hl)
    jr   z,call_209F
    call call_33B1
    ld   hl,data_20B5	;"     00    " for scores - player 2?
    ;ld   de,$D286
    ;ld   de,$4000+$20+$16
    ld	 de,$76d4
	ld   c,$00
    jp   call_0E9A;writetext
call_209F
    ld   hl,data_2250
    ;ld   de,$D244
    ;ld   de,$4000+$15
    ld	 de,$767a
	ld   c,$00
    call call_0E9A;writetext	;"           " for scores
    ld   hl,data_2250
    ;ld   de,$D246
    ;ld   de,$4000+$20+$15
    ld   de,$76ca
	ld   c,$00
    jp   call_0E9A;writetext

data_20B5
	;BYTE $0b,$60,$60,$60,$60,$60,$7b,$7b,$60,$60,$60,$60
    BYTE $0b,"     00    "
call_20C1
	ld   a,$05
	call call_0018
    ld   hl,l_e5db
    ld   (hl),$00
    ld   a,$0B
 ;   ld   ($FA00),a			;TODO - sound
    ld   hl,data_210D
    ld   de,$7ad0;$D820
    ld   c,$00
    call call_0E9A
    ld   a,$C8
    call call_0018
    ld   a,$00
    ;ld   ($FA00),a   ;TODO - sound
    ld   hl,l_e391
    ld   (hl),$00
    ld   a,$0A
    call call_0018
    ld   hl,l_e381
    ld   bc,$0010
    call call_0D50
    ;ld   hl,$FA03
    ;ld   (hl),$FF
    ;ld   hl,$FA03
    ;ld   (hl),$00
    ld   a,$0A
    call call_0018
    ld   a,$EF
    ;ld   ($FA00),a
    ld   a,$0A
    call call_0018
    ld   a,$00
   ; ld   ($FA00),a
    ret

data_210D
    BYTE $09,"GAME OVER"
    
call_2117 ;this routine draws the CREDIT text
	ld   a,(l_e366)
	ld   iy,$7f54;$7f04
	call call_0FC2
    ld hl,data_212C		;'CREDIT'
	ld de,$7f44;$7ef4
    ld c,$00
    jp call_0E9A;writetext         ;set colour
    
    ;ld   a,(l_e366)
    ;ld iy,$5000+$e0+$1e
    ;call call_0FC2
    
    ;ld   hl,data_212C   ;'CREDIT'
    ;ld de,$5000+$e0+$17
    ;ld   de,$DABA
   ; ld   c,$07
   ; jp   writetext

data_212C
    BYTE $6,"CREDIT"
	
	
call_2133
    ld   hl,data_215B
    ld   de,$7804;D890
    ld   c,$00
    call call_0E9A
    ld   a,(l_e366)
    cp   $02
    jr   nc,call_2150
    ld   hl,data_2160
    ld   de,$7894;$D694
    ld   c,$00
    jp   call_0E9A
call_2150
    ld   hl,data_2175
    ld   de,$7894;$D694
    ld   c,$00
    jp   call_0E9A
data_215B
	BYTE $04,"PUSH"
data_2160
	BYTE $14,"ONLY 1 PLAYER BUTTON"
data_2175
	BYTE $14,"1 OR 2 PLAYER BUTTON"
call_218A   ;Display Insert Coins
    ld   a,(l_fc20)
    bit  5,a
    jr   z,call_21A0
    bit  7,a
    jr   z,call_21A0
    ld   hl,data_21AB
    ld   de,$7ACE;$D7DE
    ld   c,$00
    jp   call_0E9A;writetext
call_21A0
    ld   hl,data_21B7
    ld   de,$7ACE;$D7DE
    ld   c,$00
    jp   call_0E9A;writetext
data_21AB
    BYTE $0B,"INSERT COIN" 
data_21B7
    BYTE $0C,"INSERT COINS"   


call_21CF
    ld   a,(l_e352)
    and  a
    call nz,call_0AA4
/*    ;if there a second screen here???
    ld   hl,$4000;$D504
    call clearrow
    ld   hl,$4000+$20;$D506
    call clearrow
*/
    ld   hl,data_2250	;"           " for scores
    ld   de,$7658;$CD04
    ld   c,$00
    call call_0E9A;writetext
    ld   hl,data_2250	;"           " for scores
    ld   de,$76A8   ;$CD06
    ld   c,$00
    call call_0E9A;writetext
    ld   hl,data_2250	;"           " for scores
    ld   de,$7682  ;$D244
    ld   c,$00
    call call_0E9A;writetext
    ld   hl,data_2250	;"           " for scores
    ld   de,$76D2 ;$D246
    ld   c,$00
    call call_0E9A;writetext
    ld   a,(numplayers)  ;$e5d7
    bit  0,a
    jr   z,call_221B
    ld   a,(levelnum)
    ld   (l_e644),a
call_221B
    ld   hl,l_e5d6
    ld   (hl),$00

    call call_2FF0
    call call_33BC


    ld   hl,$76B6;$CEC6		;player 1 score
    ld   (hl),'0';$7B
    ld   a,(l_e5d8)
    and  a
    jr   z,call_224E
    ld   a,(numplayers) ;$e5d7
    bit  1,a
    jr   z,call_223E
    ld   a,(levelnum)
    ld   (l_e649),a
call_223E
    ld   hl,l_e5d6
    ld   (hl),$01
    call call_2FF0
    call call_33B1
    ld   hl,$76e0 ;$D406		;player 2 score
    ld   (hl),'0';$7B
call_224E
    call call_0020  ;clears sprites etc
    ret


data_2250
	;BYTE $0b,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60
    BYTE $0b,"           "
	
call_225C
    ld   de,(l_e60b)
    inc  de
    ld   (l_e60b),de
    ld   hl,$0309
    or   a
    sbc  hl,de
    jr   nz,call_2277
    ld   hl,$0000
    ld   (l_e60b),hl
    ld   hl,l_e60a
    inc  (hl)
call_2277
    ld   hl,l_e5da
    inc  (hl)
    ret
call_227C
    ld   a,(l_e5d1)
    and  a
    jr   nz,call_229C
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,call_2290
    ld   a,(l_e613)
    bit  0,a
    jr   nz,call_229C
call_2290
    ld   hl,l_e5d7
    bit  1,(hl)
    ret  z
    ld   a,(l_e613)
    bit  1,a
    ret  z
call_229C
    ld   a,(l_e64b)
    cp   $13
    jr   nz,call_22A9
    ld   hl,l_e60d
    ld   (hl),$01
    ret
call_22A9
    cp   $1D
    jr   nz,call_22B3
    ld   hl,l_e60e
    ld   (hl),$01
    ret
call_22B3
    cp   $27
    jr   nz,call_22BD
    ld   hl,l_e60f
    ld   (hl),$01
    ret
call_22BD
    cp   $31
    ret  nz

    
call_22C6    
    ld   a,(l_fc21)         ;dip switch b mirror
    and  $03                ;difficulty
    ld   hl,data_22D6
    call adda2hl
    ld   a,(hl)
    ld   (l_e5dc),a
    ret
    
data_22D6
    BYTE $0d,$0a,$04,$07


call_22F0
    ld   a,(l_e5dc)
    add  a,c
    cp   $1E
    jr   c,call_22FA
    ld   a,$1E
call_22FA
    ld   (l_e5dc),a
    ret
    
call_22FE
    ld   a,(l_e5dc)
    sub  c
    jr   nc,call_2305
    xor  a
call_2305
    ld   hl,l_e5dd
    cp   (hl)
    jr   nc,call_230C
    ld   a,(hl)
call_230C
    ld   (l_e5dc),a
    ret
call_2310				;called when level complete!
    ld   a,(l_e34f)
    and  a
    ret  nz
    ld   hl,l_e5de
    inc  (hl)
    push hl
    bit  1,(hl)
    ld   c,$01
    call nz,call_22F0
    pop  hl
    ld   a,$1E
    cp   (hl)
    ld   c,$1E
    jr   z,call_2344
    ld   a,$14
    cp   (hl)
    ld   c,$19
    jr   z,call_2344
    ld   a,$0F
    cp   (hl)
    ld   c,$14
    jr   z,call_2344
    ld   a,$0A
    cp   (hl)
    ld   c,$0F
    jr   z,call_2344
    ld   a,$05
    cp   (hl)
    ld   c,$08
    ret  nz
call_2344
    ld   a,c
    ld   hl,l_e5dd
    cp   (hl)
    ret  c
    ld   (hl),a
    ld   (l_e5dd),a
    ld   hl,l_e5dc
    cp   (hl)
    ret  c
    ld   (hl),a
    ret
call_2355
    ld   hl,l_e337
    ld   a,$19
    cp   (hl)
    ld   c,$1E
    jr   c,call_2344
    ld   a,$14
    cp   (hl)
    ld   c,$19
    jr   c,call_2344
    ld   a,$0F
    cp   (hl)
    ld   c,$14
    jr   c,call_2344
    ld   a,$0A
    cp   (hl)
    ld   c,$0F
    jr   c,call_2344
    ret


  ;  BYTE "CALL_2375"    
call_2375
    ld   a,(l_fc20)
    bit  0,a
    ret  z
    call call_03D0
    call call_041E
    call call_031C
    call call_0372
    call call_0415
	nextreg $43, %00100000        ; (R/W) 0x43 (67) => Palette Control - Sprites
    nextreg $40, 0                  ; (R/W) 0x40 (64) => Palette Index
    call call_0B30
	nextreg $43, %00110000        ; (R/W) 0x43 (67) => Palette Control - Tilemap
    nextreg $40, 0                  ; (R/W) 0x40 (64) => Palette Index
	call call_0B30
    ;ld   hl,$4000;$CD04       ;TODO - hardware screen locs
    ;call clearrow
    ;ld   hl,$4000+$20;$CD06
    ;call clearrow    
    call call_0020

call_24B1
    ret
call_24ED
    ld   a,(bank3_data_9380+0)
    ld   (l_e35d),a
    ld   a,(bank3_data_9380+1)
    ld   (l_e37e),a
    ld   a,(bank3_data_9380+2)
    ld   (l_e396),a
    ld   a,(bank3_data_9380+3)
    ld   (l_e618),a
    ld   a,(bank3_data_9380+4)
    ld   (l_e653),a
    ld   a,(bank3_data_9380+5)
    ld   (l_e6f9),a
    ld   a,(bank3_data_9380+6)
    ld   (l_e6fe),a
    ld   a,(bank3_data_9380+7)
    ld   (l_e71f),a
    ld   a,(bank3_data_9380+8)
    ld   (l_eb30),a
    ld   a,(bank3_data_9380+9)
    ld   (l_eb35),a
    ld   a,(bank3_data_9380+$A)
    ld   (l_f45d),a
    ld   a,(bank3_data_9380+$B)
    ld   (l_f46a),a
    ld   a,(bank3_data_9380+$C)
    ld   (l_f47a),a
    ld   a,(bank3_data_9380+$D)
    ld   (l_f4ca),a
    ld   a,(bank3_data_9380+$E)
    ld   (l_f512),a
    ld   a,(bank3_data_9380+$F)
    ld   (l_f520),a
    ld   a,(bank3_data_9390+$0)
    ld   (l_f52a),a
    ld   a,(bank3_data_9390+$1)
    ld   (l_f58f),a
    ld   a,(bank3_data_9390+$2)
    ld   (l_f5ab),a
    ld   a,(bank3_data_9390+$3)
    ld   (l_f623),a
    ld   a,(bank3_data_9390+$4)
    ld   (l_eeab),a
    ld   a,(bank3_data_9390+$5)
    ld   (l_f112),a
    ld   a,(bank3_data_9390+$6)
    ld   (l_f366),a
    ret



call_2931
    ld   a,(l_e5db)
    and  a
    ret



   ; BYTE "CALL_2AF8"
call_2AF8
    call call_0020
    call call_063E
    ld   a,(l_e635)
    bit  0,a
    jr   nz,call_2B15
    call call_1AED      ;Draw LOGO and Text and cycle palette for a bit
    call call_03CB		;clear screen
    call call_03D0 		;other arcade clear screen code (just a ret for us)
    call call_218A      ;Show INSERT COIN(S) message
    call call_2117		;Draw CREDIT text
    ld   a,$5A
    call  call_0018
call_2B15
    call call_0372
    ld   hl,l_f676
    ld   (hl),$00
    call clearp1p2   ;$3EAC
    ld   hl,l_e635
    inc  (hl)
    bit  0,(hl)
    jp   z,call_2ECA
    ld   hl,levelnum ;e64b
    ld   (hl),$64			;set level to 100 for demo mode
    
    ;ld (hl),41      ;****** TEST TEST TEST TEST  *******
    
    call call_03D0		;Clear Screen
    call call_3FBD
    call call_3FFA
    ld   hl,l_e5dc
    ld   (hl),$07
    ld   hl,l_e645
    ld   (hl),$03			;Set P1 lives to 3
    xor  a
    ld   (l_e742),a
    ld   (l_e743),a
    ld   (l_e5d8),a
    ld   hl,l_e5d7
    ld   (hl),$01
    ld   hl,bank1_data_A5BC;$A5BC       
    ld   (l_e353),hl
    ld   hl,bank1_data_A6BC;$A6BC
    ld   (l_e355),hl
    ld   a,$02
    call call_0030
    ld   a,$05
    call  call_0018
    ld   a,(l_fc20)
    bit  0,a
    jp   z,call_2C83
        
    call call_02F2
    ld   a,bank1
    call call_026C         ;bank switch
    ld   hl,$D5CE
    ld   de,bank1_data_A6D2
    ld   bc,$0309
    ld   a,$06
    ;call call_0EC6
    ld   hl,$D618
    ld   de,bank1_data_A60A
    ld   bc,$0213
    ld   a,$07
    ;call call_0EC6
    call call_029B  ;restore bank
    ld   a,$F0
    call  call_0018
    ld   a,$5A
    call  call_0018
    ld   a,bank1      ;bank switch
    call call_026C
    ld   hl,$D618
    ld   de,bank1_data_A708
    ld   bc,$0219
    ld   a,$07
    ;call call_0EC6
    ld   hl,$D618
    ld   de,bank1_data_A630
    ld   bc,$0212
    ld   a,$07
    ;call call_0EC6
    call call_029B ;restore bank
    ld   a,$5A
    call call_0018;rst  $18
    ld   a,$F0
    call call_0018;rst  $18
    ld   a,bank1;$01
    call call_026C
    ld   hl,$D5CE
    ld   de,bank1_data_A6ED
    ld   bc,$0309
    ld   a,$06
    ;call call_0EC6
    ld   hl,$D618
    ld   de,bank1_data_A708
    ld   bc,$0219
    ld   a,$07
    ;call call_0EC6
    ld   hl,$D618
    ld   de,bank1_data_A654
    ld   bc,$0210
    ld   a,$07
    ;call call_0EC6
    call call_029B ;restore bank
    ld   a,$78
    call call_0018;rst  $18
    ld   a,bank1;$01
    call call_026C  ;switch bank
    ld   hl,$D618
    ld   de,bank1_data_A674
    ld   bc,$0216
    ld   a,$07
    ;call call_0EC6
    call call_029B   ;restore bank
    ld   a,$B4
    call call_0018;rst  $18
;    ld   hl,$044D
;    ld   bc,($0B2E)
;    ld   a,c
;    sub  l
;    nop
;    nop
;    nop
    ld   a,bank1;$01
    call call_026C
    ld   hl,$D5CE
    ld   de,bank1_data_A708
    ld   bc,$0219
    ld   a,$07
    ;call call_0EC6
    ld   hl,$D5D0
    ld   de,bank1_data_A708
    ld   bc,$0219
    ld   a,$07
    ;call call_0EC6
    call call_029B ;restore bank
    ld   bc,$0168
call_2C42
    call call_0020;rst  $20
    push bc
    bit  4,c
    jr   nz,call_2C5D
    ld   a,bank1;$01
    call call_026C
    ld   hl,$D618
    ld   de,bank1_data_A6A0
    ld   bc,$0219
    ld   a,$07
    ;call call_0EC6
    jr   call_2C70
call_2C5D
    ld   a,bank1;$01
    call call_026C
    ld   hl,$D618
    ld   de,bank1_data_A708
    ld   bc,$0219
    ld   a,$07
    ;call call_0EC6
call_2C70
    call call_029B
    pop  bc
    dec  bc
    ld   a,c
    or   b
    jr   nz,call_2C42
    call call_0415
    ld   hl,l_e5d4
    ld   (hl),$00
    xor  a
    call call_0018;rst  $18

    
call_2C83
    ld   hl,data_2D73
    ld   de,$7842;$D650
    ld   c,01*16  ;RED
    call call_0E9A   ;writetext
    ld   hl,data_2D86
    ld   de,$792e;$D5D6
    ld   c,$00
    call call_0E9A
    ld   hl,data_2DA1
    ld   de,$79ce;$D5DA
    ld   c,$00
    call call_0E9A
    ld   a,$F0
    call call_0018;rst  $18
    ld   a,(l_fc85)
    bit  1,a
    jr   nz,call_2CAF
    nop
call_2CAF
    ld   a,$5A
    call call_0018;rst  $18
    ld   hl,data_2DBC
    ld   de,$792e;$D5D6
    ld   c,$00
    call call_0E9A
    ld   hl,data_2DD7
    ld   de,$79ce;$D5DA
    ld   c,$00
    call call_0E9A
    ld   a,$5A
    call call_0018;rst  $18
    ld   a,$F0
    call call_0018;rst  $18
    ld   hl,data_2DF2
    ld   de,$7842;$D650
    ld   c,4*16	;YELLOW
    call call_0E9A
    ld   hl,data_2E0D
    ld   de,$792e;$D5D6
    ld   c,$00
    call call_0E9A
    ld   hl,data_2E28
    ld   de,$79ce;$D5DA
    ld   c,$00
    call call_0E9A
    ld   hl,data_2E43
    ld   de,$7a6e;$D5DE
    ld   c,$00
    call call_0E9A
    ld   a,$78
    call call_0018;rst  $18
    ld   hl,data_2E5E
    ld   de,$792e;$D5D6
    ld   c,$00
    call call_0E9A
    ld   hl,data_2E79
    ld   de,$79ce;$D5DA
    ld   c,$00
    call call_0E9A
    ld   hl,data_2E79
    ld   de,$7a6e;$D5DE
    ld   c,$00
    call call_0E9A
    ld   a,$B4
    call call_0018;rst  $18
    ld   hl,data_2E79
    ld   de,$7840;$D650
    ld   c,$00
	call call_0E9A
    ld   bc,$0168
call_2D2F
    call call_0020;rst  $20
    push bc
    bit  4,c
    jr   nz,call_2D4D
    ld   hl,data_2E94
    ld   de,$792e;$D5D6
    ld   c,$00
    call call_0E9A
    ld   hl,data_2EAF
    ld   de,$79ce;$D5DA
    ld   c,$00
    call call_0E9A
    jr   call_2D63
call_2D4D
    ld   hl,data_2E79
    ld   de,$792e;$D5D6
    ld   c,$00
    call call_0E9A
    ld   hl,data_2E79
    ld   de,$79ce;$D5DA
    ld   c,$00
    call call_0E9A
call_2D63
    pop  bc
    dec  bc
    ld   a,c
    or   b
    jr   nz,call_2D2F
    call call_0415
    ld   hl,l_e5d4
    ld   (hl),$00
    xor  a
    call call_0018;rst  $18

data_2D73
    BYTE $12,"BASIC SKILL ...   "
data_2D86
    BYTE $1A,"TRAP ENEMIES INSIDE       "
data_2DA1
    BYTE $1A,"BUBBLES.                  "
data_2DBC
    BYTE $1A,"BURST BUBBLES WITH YOUR   "
data_2DD7
    BYTE $1A,"HORNS OR FINS             "
data_2DF2
    BYTE $12,"ADVANCED SKILL ..."
data_2E0D
    BYTE $1A,"HIGHER POINTS ARE SCORED  "
data_2E28
    BYTE $1A,"WHEN BURSTING SEVERAL     "
data_2E43
    BYTE $1A,"BUBBLES AT THE SAME TIME. "
data_2E5E
    BYTE $1A,"YOU CAN JUMP OVER BUBBLES."
data_2E79
    BYTE $1A,"                          "
data_2E94
    BYTE $1A,"ONE STAGE CLEARED WHEN ALL"
data_2EAF
    BYTE $1A,"ALL ENEMIES ARE DESTROYED."

call_2ECA
    ld a,(l_e634)
    ld hl,data_2FAC
    call adda2hl  ;$0D89
    ld   a,(hl)
    ld   (l_e64b),a
    call call_3FBD
    call call_3FFA
    ld   hl,l_e5dc
    ld   (hl),$07
    ld   hl,l_e645			;set P1 lives to 5?
    ld   (hl),$05
    ld   hl,l_e64a			;set P2 lives to 5?
    ld   (hl),$05
    xor  a
    ld   (l_e742),a
    ld   (l_e743),a
    ld   hl,l_e5d8
    ld   (hl),$01
    ld   hl,l_e5d7
    ld   (hl),$03
    ld   a,bank1;$01      ;switch bank
    call call_026C
    ld   a,(l_e634)
    add  a,a
    add  a,a
    ld   hl,bank1_data_9A6A
    call adda2hl  ;$0D89
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   (l_e353),de
    inc  hl
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    ld   (l_e355),de
    call call_029B     ;restore bank
    ld   a,$02
    call  call_0030
    ld   a,$05
    call  call_0018
    call  call_03D0
    call call_2117
	ld a,introbank
	call call_026C
	call intro_call_2F2B
	call call_029B
    ;ld   hl,data_2FA2
    ;ld   de,$7ad0;$D820
    ;ld   c,1*16;$04  ;red
    ;call call_0E9A;writetext  'GAME OVER'
    ld   bc,$0528
call_2F39
    call  call_0020
    dec  bc
    ld   a,c
    or   b
    jr   nz,call_2F39
    ld   hl,l_e634
    inc  (hl)
    ld   a,(hl)
    cp   $07
    jr   nz,call_2F4A
    ld   (hl),$00
call_2F4A
    call call_2F54
    ld   hl,l_e5d4
    ld   (hl),$00
    xor  a
    call  call_0018
call_2F54
    call call_1FEE			;LOCATION TO FIND
    call call_063E			;38F0
    ld   a,$00
;    ld   ($FA00),a         ;SOUND IO
    ld   a,$03
    call  call_0008
    ld   a,$04
    call  call_0008
    ld   a,$05
    call  call_0008
    call call_0415
    call call_040C
    call call_03CB
    call call_4F0F
    call call_03D0
	ld   a,introbank;$01      ;switch bank
    call call_026C
	call intro_call_2F7A
	call call_029B     ;restore bank
    call call_0330
    call call_349F
    call call_2117
    ld   a,$96
    call  call_0018
 ;   ld   ix,$003E
 ;   ld   hl,$00B9
 ;   ld   e,(ix-$3a)
 ;   ld   d,(ix-$39)
 ;   xor  a
 ;   sbc  hl,de
;    jr   call_2F96      ;bypassed ROM security check
 ;   push hl
call_2F96
    call call_03CB
    call call_03D0
    call call_0330
    jp   call_38F0
    
data_2FA2
    BYTE $09,"GAME OVER"
data_2FAC
	BYTE $00,$04,$15,$23,$18,$1B,$31		;level order for DEMO MODE    

call_2FB3
    ld   a,(l_e5d3)
    and  a
    ret  nz
    push ix
    call call_30A5
    call call_2FC9
    call call_2FF0
    call call_3262
    pop  ix
    ret

call_2FC9
    ld   a,(l_e5d6)
    and  a
    jr   nz,call_2FD4
    ld   de,l_e643
    jr   call_2FD7
call_2FD4
    ld   de,l_e648
call_2FD7
    ld   hl,l_e64e
    call call_0E85
    ret  c
    ex   de,hl
    ld   bc,$0003
    lddr
    

call_2FE4
  ;  ld   hl,$D006      
    ld   hl,$76c0	;highscore number loc
    ld   de,l_e64e
    call call_3002
    jp   call_340B
call_2FF0
    ld   hl,$76aa;$CD46
    ld   de,l_e643
    ld   a,(l_e5d6)
    and  a
    jr   z,call_3002
    ld   hl,$76d4;$D286
    ld   de,l_e648
call_3002           ;draws numbers to the screen
    ld   bc,$0000
    ld   a,(de)
    call call_0D62
    add  a,'0';$7B
    cp   '0';$7B
    jp   z,call_3015
    set  0,c
    jp   call_3016
call_3015
    ld   a,b
call_3016
    ld   (hl),a
    inc  hl
    ld   (hl),$00
    ld   a,1;$3F
    call call_0D89
    ld   a,(de)
    and  $0F
    add  a,'0';$7B
    cp   '0';$7B
    jp   z,call_302E
    set  0,c
    jp   call_3034
call_302E
    bit  0,c
    jp   nz,call_3034
    ld   a,b
call_3034
    ld   (hl),a
    inc  hl
    ld   (hl),$00
    ld   a,1;$3F
    call call_0D89
    dec  de
    ld   a,(de)
    call call_0D62
    add  a,'0';$7B
    cp   '0';$7B
    jp   z,call_304E
    set  0,c
    jp   call_3054
call_304E
    bit  0,c
    jp   nz,call_3054
    ld   a,b
call_3054
    ld   (hl),a
    inc  hl
    ld   (hl),$00
    ld   a,1;$3F
    call call_0D89
    ld   a,(de)
    and  $0F
    add  a,'0';$7B
    cp   '0';$7B
    jp   z,call_306C
    set  0,c
    jp   call_3072
call_306C
    bit  0,c
    jp   nz,call_3072
    ld   a,b
call_3072
    ld   (hl),a
    inc  hl
    ld   (hl),$00
    ld   a,1;$3F
    call call_0D89
    dec  de
    ld   a,(de)
    call call_0D62
    add  a,'0';$7B
    cp   '0';$7B
    jp   z,call_308C
    set  0,c
    jp   call_3092
call_308C
    bit  0,c
    jp   nz,call_3092
    ld   a,b
call_3092
    ld   (hl),a
    inc  hl
    ld   (hl),$00
    ld   a,1;$3F
    call call_0D89
    ld   a,(de)
    and  $0F
    add  a,'0';$7B
    ld   (hl),a
    inc  hl
    ld   (hl),$00
    ret
call_30A5
    ld   a,(l_e5d6)
    and  a
    jr   nz,call_30B0
    ld   hl,l_e641
    jr   call_30B3
call_30B0
    ld   hl,l_e646
call_30B3
    or   a
    ld   a,(hl)
    add  a,e
    daa
    jr   nc,call_30BA
    inc  d
call_30BA
    ld   (hl),a
    inc  hl
    or   a
    ld   a,(hl)
    add  a,d
    daa
    ld   (hl),a
    ret  nc
    inc  hl
    or   a
    ld   a,(hl)
    add  a,$01
    daa
    ld   (hl),a
    ret  nc
    ld   (hl),$99
    dec  hl
    ld   (hl),$99
    dec  hl
    ld   (hl),$99
    ret

call_314E
    ld   hl,l_e63f
    ld   (hl),$00
    call call_3170
    ld   de,l_e639
    ld   bc,$0003
    ldir
    ret

call_315F
    ld   hl,l_e640
    ld   (hl),$00
    call call_3170
    ld   de,l_e63c
    ld   bc,$0003
    ldir
    ret

call_3170    
    ld   a,(l_fc21) ;Dip switch b
    rrca
    rrca
    and  $03        ;bonus life setting
    ld   b,$18
    call call_0DB1
    ld   de,data_3181
    add  hl,de
    ret

data_3181
    BYTE $00,$50,$00,$00,$50,$02,$00,$00,$05,$00,$00,$10,$00,$00,$20,$00
    BYTE $00,$30,$00,$00,$40,$00,$00,$50,$00,$40,$00,$00,$00,$02,$00,$00
    BYTE $05,$00,$00,$10,$00,$00,$20,$00,$00,$30,$00,$00,$40,$00,$00,$50
    BYTE $00,$20,$00,$00,$80,$00,$00,$00,$03,$00,$00,$10,$00,$00,$20,$00
    BYTE $00,$30,$00,$00,$40,$00,$00,$50,$00,$30,$00,$00,$00,$01,$00,$00
    BYTE $04,$00,$00,$10,$00,$00,$20,$00,$00,$30,$00,$00,$40,$00,$00,$50

call_31E1
    call call_3170
    ld   de,l_e64c
    ld   bc,$0003
    ldir
    ret
call_31ED
    ld   b,$03
    ld   iy,data_320D
    call call_0EAA
    call call_3170
    inc  hl
    inc  hl
    ex   de,hl
    push de
    ld   hl,$79EA;$D95C
    call call_3002
    pop  de
    inc  de
    inc  de
    inc  de
    ld   hl,$7A8A;$D960
    jp   call_3002
data_320D
	BYTE $D0,$79
	BYTE LOW data_321C,HIGH data_321C
	BYTE $00
	BYTE $70,$7A
	BYTE LOW data_3236,HIGH data_3236
	BYTE $00
	BYTE $18,$7B
	BYTE LOW data_3250,HIGH data_3250
	BYTE $00
data_321C
	BYTE $19,"1ST BONUS FOR      0 PTS."
data_3236
	BYTE $19,"2ND BONUS FOR      0 PTS."
data_3250
	BYTE $11,"AND MYSTERY !?..."
call_3262
    ld   a,(l_e5d6)
    and  a
    jr   nz,call_3293
    ld   a,(l_e63f)
    cp   $08
    ret  z
    ld   hl,l_e63b
    ld   de,l_e643
    call call_0E85
    ret  c
    ld   hl,l_e63f
    inc  (hl)
    call call_3170
    ld   a,(l_e63f)
    ld   c,a
    add  a,a
    add  a,c
    call adda2hl;$0D89
    ld   de,l_e639
    ld   bc,$0003
    ldir
    jp   call_32E0
call_3293
    ld   a,(l_e640)
    cp   $08
    ret  z
    ld   hl,l_e63e
    ld   de,l_e648
    call call_0E85
    ret  c
    ld   hl,l_e640
    inc  (hl)
    call call_3170
    ld   a,(l_e640)
    ld   c,a
    add  a,a
    add  a,c
    call adda2hl;$0D89
    ld   de,l_e63c
    ld   bc,$0003
    ldir
    jp   call_32F4
    

call_32BE
    call call_32CC
    ld   (l_e645),a
    ret
call_32C5
    call call_32CC
    ld   (l_e64a),a
    ret
call_32CC
    ld   a,(l_fc21)         ;dip switch b - lives setting
    call div16
    and  $03
    ld   hl,data_32DC
    call adda2hl
    ld   a,(hl)
    ret

data_32DC
    BYTE $01,$00,$04,$02

call_32E0
    ld   hl,l_e645
    ld   a,(hl)
    cp   $64
    ret  z
    inc  (hl)
    ld   a,$2D
    ;ld   (l_fa00),a   ;TODO SOUND IO
    ld   c,$01
    call call_22F0
    jr   call_3308
call_32F4
    ld   hl,l_e64a
    ld   a,(hl)
    cp   $64
    ret  z
    inc  (hl)
    ld   a,$2D
    ;ld   (l_fa00),a   ;TODO SOUND IO
    ld   c,$01
    call call_22F0
    jr   call_3353


call_3308               ;show lives - TODO
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(levelnum)   ;$e64b  don't show lives in demo mode
    cp   $64            ;level 100 (demo level)
    ret  z
    ld   b,$05
    ld   hl,$7f18      ;screen loc
call_3318              ;clear old P1 lives
    ld   (hl),$00
    inc  hl
    ld   (hl),$00
	inc hl
    ;ld   a,$3F         ;next column
    ;call adda2hl
    djnz call_3318
    ld   hl,l_e645    ;p1 lives?
    ld   a,(hl)
    and  a
    ret  z
    ret  m
    cp   $05
    jr   c,call_3331
    ld   a,$05
call_3331
    ld   b,a
    ld   hl,$7f18   ;screen loc
call_3335           ;show p1 lives
    ld   (hl),$90
    inc  hl
    ld   (hl),$70;$1C
    ;ld   a,$3F      ;next column
    ;call adda2hl
	inc hl
    djnz call_3335
;    ld   hl,(data_0B2E)
;    ld   de,$044D
;    ld   a,$4D;l
;    sub  e
    ret

call_3353
    ld   a,(l_e5d3)    ;p2 lives  - TODO
    and  a
    ret  nz
    ld   a,(levelnum)  ;$e64b  don't show lives in demo mode
    cp   $64
    ret  z
    ld   b,$05
    ld   hl,$7f56      ;TODO - screen loc
call_3363
    ld   (hl),$00
    inc  hl
    ld   (hl),$00
    or   a
    ld   de,$0003;$0041
    sbc  hl,de     ;back 1 column
    djnz call_3363
    ld   hl,l_e64a   ;p2 lives
    ld   a,(hl)
    and  a
    ret  z
    ret  m
    cp   $05
    jr   c,call_337D
    ld   a,$05
call_337D
    ld   b,a
    ld   hl,$7f56   ;TODO - screen drawing
call_3381
    ld   (hl),$91
    inc  hl
    ld   (hl),$70;$1C
    or   a
    ld   de,$0003;$0041
    sbc  hl,de
    djnz call_3381
    ld   a,(l_fc85)
    bit  1,a
    ret


call_3395
   ld   hl,data_33D3	;'high score'
;   ld   de,$CFC4
;   ld   de,$4000+$b
	ld   de,$766e
   ld   c,1*16
   call call_0E9A;writetext
   ld   hl,data_33EA	;undefined
 ;  ld   de,$CD06
   ld   de,$76A8
   ld   c,$00
   call call_0E9A;writetext
   call call_2FE4
   call call_33BC
        
call_33B1
    ld   hl,data_33DE	;2UP
    ;ld   de,$D244
    ld   de,$7682
    ld   c,5*16			;palette offset
    jp   call_0E9A;writetext

    
call_33BC    
	
    ld   hl,data_33C7	;1UP
    ;ld   de,$CD04
    ld   de,$7658
    ld   c,2*16
    jp   call_0E9A;writetext

     
data_33C7
   BYTE $0b,"    1UP    "
data_33D3
    BYTE $0a,"HIGH SCORE"
data_33DE
    BYTE $0b,"    2UP    "
data_33EA
    BYTE $20,"      00      20000        00   "

call_340B
    ret
call_3411
    ld   hl,l_e652
    ld   (hl),$00
    ld   hl,$028E
    ld   (l_e650),hl
    ld   hl,l_e64f
    ld   (hl),$01
call_3421
    ld   de,(l_e650)
    ld   a,(de)
    ld   hl,l_e652
    add  a,(hl)
    ld   (hl),a
    inc  de
    inc  de
    inc  de
    ld   hl,$757B
    or   a
    sbc  hl,de
    jr   z,call_343B
    ld   (l_e650),de
    ret
call_343B
    ld   hl,l_e64f
    ld   (hl),$00
    ld   a,(l_e653)
    ld   hl,l_e652
    cp   (hl)
    ret  z    
    push de
call_3449
    ld   hl,data_347C
    ld   de,l_e654
    ld   bc,$0023
    ldir
    ld   b,$05
    ld   de,l_e654
call_3459
    push bc
    push de
    call call_3170
    pop  de
    ld   bc,$0003
    ldir
    ld   a,$04
    call adda2de
    pop  bc
    djnz call_3459
    ld   hl,l_e67b
    ld   (hl),$1F
    ld   hl,l_e67c
    ld   (hl),$1F
    ld   hl,l_e67d
    ld   (hl),$13
    ret

data_347C
    BYTE $00,$20,$00,$1F,$49,$2E,$46,$00,$20,$00,$1B,$4D,$54,$4A,$00,$20
    BYTE $00,$17,$4E,$53,$4F,$00,$20,$00,$13,$4B,$49,$4D,$00,$20,$00,$0F
    BYTE $59,$53,$48

call_349F
    ld   a,(l_e5d3)
    and  a
    jr   z,call_34BB
    ld   b,$06
    ld   iy,data_3574    ;scores?
    call call_0EAA
    ld   hl,data_3597    ;'BEST 5'
    ld   de,$78f2;$D854
    ld   c,1*16;$04 ;red
    call call_0E9A ;writetext
    jr   call_34E5
call_34BB
    ld   b,$07
    ld   iy,data_3574    ;scores?
    call call_0EAA
    ld   hl,data_35ED	;'SCORE ROUND NAME'	for high score entry
    ld   de,$78E6;$D6D4
    ld   c,4*16;$10 ;Yellow
    call call_0E9A;writetext
    ld   hl,data_35C3 ;'ENTER 1UP INITIALS !'
    ld   c,2*16;	  ;Green
    ld   a,(l_e5d6)
    and  a
    jr   z,call_34DF
    ld   hl,data_35D8   ;'ENTER 2UP INITIALS !'
    ld   c,5*16; $14
call_34DF
    ld   de,$77F4;$D68E
    call call_0E9A;writetext
call_34E5
    ld   hl,$7b1a;$D762	;the actual 1st, 2nd, 3rd etc tags
    ld   de,l_e656
    ld   b,$05
call_34ED           ;show the 5 high scores titles
    push bc
    push de
    push hl
    push hl
    call call_3002
    pop  hl
    ld   de,$000C;0180
    add  hl,de
    ld   (hl),$30
    inc  hl
    ld   (hl),$00
    pop  hl
	ld de,$50*$02
	add hl,de
    pop  de
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ld   a,$07
    call adda2de;$0D84
    pop  bc
    djnz call_34ED
    ld   b,$05
    ld   iy,$7b30;$DA22
    ld   hl,l_e657
call_3515
    push bc
    push hl
    ld   a,(hl)
    inc  a
    cp   $65
    jr   nz,call_3537
    ld   (iy-$02),$41
    ld   (iy-$01),1*16
    ld   (iy+$00),$4C
    ld   (iy+$01),1*16
    ld   (iy+$02),$4C
    ld   (iy+$03),1*16		;this seems to write 'ALL' (if all levels complete)

    jr   call_353A
call_3537
    call call_0FC2			;else it plots the level number reached
call_353A
    pop  hl
    ld   a,$07
    call adda2hl
	;assume this increases by 2 rows???  so change for next layout
    ;inc  iy
    ;inc  iy
    ;inc  iy
    ;inc  iy
	ld bc,$0050*$02
	add iy,bc
    pop  bc
    djnz call_3515
    ld   b,$05
    ld   hl,l_e658
    ld   de,$7b38;$DB22			;write the 5 lots of high score initials
call_3553
    push bc
    push hl
    push de
    ld   b,$03
call_3558
    ld   a,(hl)
    ld   (de),a
    inc  de
    xor  a
    ld   (de),a
    ld   a,1;$3F   ;skip column
    call adda2de;$0D84
    inc  hl
    djnz call_3558
    pop  hl
	ld de,$50*$02
	add hl,de
	ex de,hl
    pop  hl
    pop  bc
    ;inc  de
    ;inc  de
    ;inc  de
    ;inc  de
    ld   a,$07
    call adda2hl;$0D89
    djnz call_3553
    ret

;data_3574
;    BYTE $DE,$D7,$9E,$35,$00,$62,$D6,$AF,$35,$00,$66,$D6,$B3,$35,$00,$6A
;    BYTE $D6,$B7,$35,$00,$6E,$D6,$BB,$35,$00,$72,$D6,$BF,$35,$00,$4E,$D8
;    BYTE $97,$35,$04

;screen loc, text data, colour    
data_3574
    BYTE $7E,$7A,LOW data_359E,HIGH data_359E,$00
    BYTE $12,$7B,LOW data_35AF,HIGH data_35AF,$00
    BYTE $B2,$7B,LOW data_35B3,HIGH data_35B3,$00
    BYTE $52,$7C,LOW data_35B7,HIGH data_35B7,$00
    BYTE $F2,$7C,LOW data_35BB,HIGH data_35BB,$00
    BYTE $92,$7D,LOW data_35BF,HIGH data_35BF,$00
    BYTE $f2,$78,LOW data_3597,HIGH data_3597,$10
    
data_3597
    BYTE $06,"BEST 5"
        
data_359E
    BYTE $10,"SCORE ROUND NAME"
    
data_35AF
    BYTE $03,"1ST"

data_35B3
    BYTE $03,"2ND"

data_35B7
    BYTE $03,"3RD"

data_35BB
    BYTE $03,"4TH"

data_35BF
    BYTE $03,"5TH"

data_35C3
    BYTE $14,"ENTER 1UP INITIALS !"

data_35D8
    BYTE $14,"ENTER 2UP INITIALS !"

data_35ED
    BYTE $11,"SCORE ROUND  NAME"

;moved to intro block for memory saving
;call_361D			;Called once all lives are lost
;	jr call_361D



call_3DF0
    call call_0020
    call call_4C35
    ld   a,bank2;$02
    call call_026C
    call bank2_call_A59B
    call bank2_call_A2FC
    call bank2_call_936A
    call bank2_call_99E2
    call bank2_call_96E6
    call bank2_call_90DD
    call bank2_call_83E8
    call bank2_call_85EB
    call bank2_call_92B6
    call bank2_call_A820
    call clearp1;call_3EB5
    call clearp2;call_3F39
    call call_5776
    call bank2_call_9F76
    call bank2_call_B9C4
    call bank2_call_8BA7
    call bank2_call_AC80
    call call_029B
    call call_4F52 
   ; BYTE "CALL_4F52"
   
	;3E32
    ld   hl,l_f448
    ld   (hl),$00
    ld   a,(l_f536)
    cp   $01
    jr   z,call_3E5B
    ld   a,(l_e64b)
    cp   $00
    jr   z,call_3E5B
    cp   $64
    jr   z,call_3E5B
    ld   a,$04
    call call_0030
;    ld   b,$03         ;ROM CHECK
;    xor  a
;    ld   hl,data_0000
;call_3E52
;    add  a,(hl)
;    inc  hl
;    djnz call_3E52
;    sub  $3E
;    jr   $3E5B
;    push de

    ;set of routines called by RST20 during normal gameplay
call_3E5B					;9852 IN ASSEMBLED CODE 
    call  call_0020;$20
    call call_4D13
    ld   a,bank2;$02
    call call_026C
    call bank2_call_8499
    call bank2_call_8686
    call bank2_call_A5A4
    call bank2_call_A480
    call bank2_call_A310        ;call flood fill
    call bank2_call_9373
    call bank2_call_99EB
    call bank2_call_96EF
    call bank2_call_AAC5
    call bank2_call_90ED
    call bank2_call_8DFF
    call bank2_call_8FA6
    call bank2_call_A829
    call call_577F              ;call VS mode
    call bank2_call_9F7F
    call bank2_call_B9CD
    call bank2_call_92CF
    call bank2_call_8BB0
    call bank2_call_ACBA
    call call_029B
    call call_4F5B
   ; BYTE "CALL_4F5B"
    call bank0_call_BF48
    call call_4012
    jp   call_3E5B
    


call_3EAC
clearp1p2     ;$3eac
    ld   hl,player1data   ;$E691 clear both player data structure (100 bytes at $e691)
    ld   bc,$0064
    jp   clearbytes

call_3EB5
clearp1       ;$3eb5
    ld   hl,player1data   ;$E691 clear just player one data structure
    ld   bc,$002A
    call clearbytes
    ld   hl,numplayers  ;e5d7
    bit  0,(hl)
    jr   nz,clearp1_1
    ld   ix,player1data
    ld   (ix+$00),$80
    ld   (ix+$09),$00
    ld   (ix+$07),$18
    ret
clearp1_1
    call call_3308              ;show p1 lives
    ld   a,(l_f61b)
    and  a
    jr   nz,clearp1_2
    ld   a,(l_e6ff)
    and  a
    ret  p
clearp1_2
    ld   hl,l_f61b
    ld   (hl),$00
    ld   ix,player1data
    ld   hl,spriteram_player1 ;$e2c5
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (hl),$18
    inc  hl
    ld   (hl),$18
    inc  hl
    ld   (hl),$18
    inc  hl
    ld   (hl),$12
    ld   hl,l_fc5f
    ld   (hl),$01
    ld   (ix+$09),$00
    ld   (ix+$08),$01
    ld   (ix+$07),$18
    ld   (ix+$1a),$1E
    ld   a,(ix+$2d)
    and  $38
    ld   (ix+$2d),a
    call call_4000         ;-1 life?
    call call_3FDC
    xor  a
    ld   (l_f60f),a
    ld   (l_f611),a
    ld   (l_f616),a
    ld   hl,(l_e345)
    ld   a,l
    or   h
    ret  z
    ld   (ix+$25),$B4
    ret
    
clearp2     ;$3f39
call_3F39
    ld   hl,player2data  	;$e6c3 clear player 2 data structure
    ld   bc,$002A
    call clearbytes
    ld   hl,numplayers   ;$E5D7
    bit  1,(hl)
    jr   nz,clearp2_1
    ld   ix,player2data ;E6C3
    ld   (ix+$00),$80
    ld   (ix+$09),$01
    ld   (ix+$07),$19
    ret
clearp2_1    ;$3f5a
    call call_3353              ;show p2 lives
    ld   a,(l_f61c)
    and  a
    jr   nz,clearp2_2
    ld   a,(l_e6ff)
    and  a
    ret  p
clearp2_2         ;$3f68
    ld   hl,l_f61c
    ld   (hl),$00
    ld   ix,player2data
    ld   hl,spriteram_player2
    ld   (ix+$03),l
    ld   (ix+$04),h
    ld   (hl),$18
    inc  hl
    ld   (hl),$19
    inc  hl
    ld   (hl),$D8
    inc  hl
    ld   (hl),$12
    ld   hl,l_fc67
    ld   (hl),$01
    ld   (ix+$09),$01
    ld   (ix+$08),$00
    ld   (ix+$07),$19
    ld   (ix+$1a),$22
    ld   a,(ix+$2d)
    and  $38
    ld   (ix+$2d),a
    call call_4000
    call call_3FDC
    xor  a
    ld   (l_f610),a
    ld   (l_f611),a
    ld   (l_e616),a
    ld   hl,(l_e345)
    ld   a,l
    or   h
    ret  z
    ld   (ix+$25),$B4
    ret

call_3FBD    ;$3fbd
    ld   ix,l_e691   ;PLAYER 1 DATA STRUCTURE
call_3FC1
    ld   (ix+$30),$0C
    ld   (ix+$2c),$00
    ld   (ix+$31),$40
    ld   (ix+$2e),$14
    ld   (ix+$2f),$03
    ld   (ix+$2d),$00
    call call_4000
call_3FDC
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e5d2)
    and  a
    jr   nz,call_3FED
    ld   a,(levelnum)
    cp   $63
    ret  nz
call_3FED
    ld   (ix+$30),$14
    ld   (ix+$2f),$06
    ld   (ix+$2e),$05
    ret
call_3FFA
    ld   ix,l_e6c3
    jr   call_3FC1
call_4000           ;-1 life?
    ld   a,(ix+$2a)
    or   a
    ret  z
    dec  a
    ld   (ix+$2a),a
    set  6,(ix+$2d)
    ld   (ix+$28),$10
    ret

call_4012				;INTRO ERROR - LAST KNOWN LOAD OF IX
    ld   ix,l_e691		;player 1 data structure
    ld   b,$02
call_4018
    push bc
    ld   a,(ix+$00)
    bit  7,a
    jp   nz,call_4070
    bit  2,a
    jp   nz,call_4062
    bit  0,a
    jp   nz,call_419F
    bit  1,a
    jp   nz,call_40E0
    bit  4,a
    jp   nz,call_407E		;player hit by enemy
    ld   a,(l_e6ff)
    and  a
    jp   p,call_41D7
    ld   a,(l_f536)
    cp   $01
    jp   z,call_41D7
    ld   a,(l_f518)
    and  a
    jr   z,call_405B
    ld   (ix+$13),$01
    ld   hl,$0384
    ld   (ix+$14),l
    ld   (ix+$15),h
    ld   (ix+$16),$00
call_405B
    ld   (ix+$00),$01
    jp   call_419F
call_4062
    ld   a,bank2;$02
    call call_026C
    call bank2_call_AFD8
    call call_029B
    jp   call_41D7
call_4070
    ld   a,bank2;$02
    call call_026C
    call bank2_call_AD98
    call call_029B
    jp   call_41D7
call_407E
    ld   c,$01
    call call_22FE
    xor  a
    ld   (l_f44d),a
    ld   (l_e5de),a
    call loadhlfromspritestruct;call_1529
    push hl
    ld   a,$08
    call adda2hl;$0D89
    ld   bc,$0008
    call clearbytes;$0D50
    pop  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    bit  0,(ix+$19)
    jr   nz,call_40BD
    ld   a,(ix+$01)
    add  a,$07
    ld   (hl),a
    inc  hl
    ld   a,(ix+$07)
    or   $20
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    sub  $08
    ld   (hl),a
    inc  hl
    ld   (hl),$12
    jr   call_40D4
call_40BD
    ld   a,(ix+$01)
    sub  $08
    ld   (hl),a
    inc  hl
    ld   a,(ix+$07)
    or   $20
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    add  a,$08
    ld   (hl),a
    inc  hl
    ld   (hl),$12
call_40D4
    call resetframetimer;call_1556
    ld   (ix+$00),$02
    ld   c,$0D
    call call_1350
call_40E0
    ;ld   hl,($0004)
    ;ld   bc,$00B9
    ;or   a
    ;sbc  hl,bc
;    jr   call_40EC
;    call call_0020;rst  $20

call_40EC
    call call_43C1
    jp   nc,call_41D7
    ld   a,(l_e5d3)
    and  a
    jr   nz,call_410D
    ld   a,(l_e64b)
    cp   $63
    jr   z,call_410D
    ld   hl,l_e358
    bit  0,(hl)
    jr   z,call_410D
    ld   (hl),$00
    ld   c,$30
    call call_1350
call_410D
   call call_0673
   ld   hl,l_e345
   ld   (hl),$05
   call loadhlfromspritestruct;call_1529
   ld   bc,$0010
   call clearbytes;$0D50
   ld   (ix+$00),$80
   bit  0,(ix+$09)
   jp   nz,call_415F
   ld   hl,l_e613
   res  0,(hl)
   ld   hl,l_e645		;reduce player 1 lives
   dec  (hl)
   ex   af,af'
   call call_3308
   ex   af,af'
   jp   m,call_4146
   call call_4195
   call clearp1;call_3EB5
   call call_3FBD
   jp   call_41D7

call_4146
    ld   hl,l_e5d7
    res  0,(hl)
    ld   a,(l_e64b)
    ld   (l_e644),a
    ld   c,$FD
    call call_22FE
    call call_0F26
    call call_4195
    jp   call_41D7
call_415F    
    ld   hl,l_e613
    res  1,(hl)
    ld   hl,l_e64a
    dec  (hl)
    ex   af,af'
    call call_3353
    ex   af,af'
    jp   m,call_417C
    call call_4195
    call clearp2;call_3F39
    call call_3FFA
    jp   call_41D7
call_417C
    ld   hl,l_e5d7
    res  1,(hl)
    ld   a,(l_e64b)
    ld   (l_e649),a
    ld   c,$FD
    call call_22FE
    call call_0F74
    call call_4195
    jp   call_41D7
call_4195
    ld   hl,l_e730
    bit  0,(hl)
    ret  z
    set  7,(hl)
    xor  a
    call call_0018;rst  $18
call_419F
    call loadhl2;call_1537
    call call_41F5
    call call_46D4
    call call_46FD
    call call_4869
    call call_4B76
    call call_4708
    call call_4247
    call call_4B62
    call call_450D
    ld   a,bank2;$02
    call call_026C
    call bank2_call_854E
    call bank2_call_873E
    call bank2_call_91A3
    call bank2_call_8CC7
    call bank2_call_9233
    call call_45F1
    call call_029B
call_41D7
    xor  a
    ld   (ix+$21),a
    ld   (ix+$22),a
    ld   (ix+$24),a
    ld   de,$0032
    add  ix,de
    pop  bc
    dec  b
    jp   nz,call_4018
    ret
call_41EC
    ld   a,(ix+$09)
    ld   (l_e5d6),a
    jp   call_2FB3
call_41F5
    ld   hl,l_fc60
    bit  0,(ix+$09)
    jr   z,call_4201
    ld   hl,l_fc68
call_4201
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    ret
call_420B
    ret


call_4247
    bit  0,(ix+$1b)
    ret  nz
    bit  0,(ix+$0b)
    jp   nz,call_42E3
    bit  0,(ix+$0c)
    ret  nz
    call call_43B5
    bit  0,a
    jr   z,call_42AE
    bit  1,a
    jr   z,call_4271
    ld   (ix+$23),$00
    ld   a,(ix+$22)
    and  a
    ret  nz
    ld   a,$00
    jp   call_44FE
call_4271
    call call_43A0
    ld   (ix+$23),$02
    ld   a,$08
    call call_44FE
    ld   a,(ix+$20)
    or   a
    ret  z
    ld   b,a
call_4283
    push bc
    call loadhl2;call_1537
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_42AC
    call call_1676
    jr   nz,call_42A6
    call loadhlfromspritestruct;call_1529
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz call_4283
    jp   call_480F
call_42A6
    pop  bc
    set  0,(ix+$0b)
    ret
call_42AC
    pop  bc
    ret

call_42AE
    call call_43A0
    ld   (ix+$23),$04
    ld   a,$08
    call call_44FE
    ld   a,(ix+$20)
    or   a
    ret  z
    ld   b,a
call_42C0
    push bc
    call loadhl2;call_1537
    ld   a,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_42AC
    call call_1676
    jr   nz,call_42A6
    call loadhlfromspritestruct;call_1529
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz call_42C0
    jp   call_480F


call_42E3
    call call_0AE3
    ld   (ix+$23),$03
    ld   a,$18
    call call_44FE
    ld   a,(ix+$20)
    or   a
    ret  z
    ld   b,a
call_42F5
    push bc
    call loadhl2;call_1537
    ld   a,(ix+$01)
    cp   $20
    jr   c,call_4313
    cp   $E0
    jp   nc,call_4313
    and  $07
    jr   nz,call_4313
    call call_169F
    jr   z,call_4313
    call call_1676
    jr   z,call_4326
call_4313
    call loadhlfromspritestruct;call_1529
    dec  (hl)
    jr   nz,call_431D
    ld   hl,l_e5e7
    inc  (hl)
call_431D
    pop  bc
    djnz call_42F5
    call call_4334
    jp   call_43A0

call_4326
    pop  bc
    ld   (ix+$0b),$00
    ld   a,(ix+$0c)
    and  $02
    ld   (ix+$0c),a
    ret

call_4334    
    inc  (ix+$18)
    ld   a,(ix+$18)
    cp   $03
    ret  c
    ld   (ix+$18),$00
    call loadhl2;$1537
    call call_43B5
    bit  0,a
    jr   z,call_4377
    bit  1,a
    ret  nz
    ld   a,(ix+$01)
    cp   $E0
    jr   c,call_435D
    ld   a,(ix+$02)
    cp   $E7
    ret  nc
    jr   call_4370
call_435D
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    ret  z
    call call_15E9
    ret  z
call_4370
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  (hl)
    ret
call_4377
    ld   a,(ix+$01)
    cp   $E0
    jr   c,call_4386
    ld   a,(ix+$02)
    cp   $18
    ret  c
    jr   call_4399
call_4386
    ld   a,(ix+$02)
    sub  $08
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    ret  z
    call call_1604
    ret  z
call_4399
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    dec  (hl)
    ret



call_43A0
    call call_43B5
    bit  0,a
    jr   z,call_43AF
    bit  1,a
    ret  nz
    ld   (ix+$08),$01
    ret
call_43AF
    ld   (ix+$08),$00
    ret
call_43B4
    ret


call_43B5
    ld   a,(l_e33f)
    bit  0,(ix+$09)
    ret  z
    ld   a,(l_e340)
    ret
    
call_43C1
    call call_420B
    call loadhl2;call_1537
    ld   a,(ix+$05)
    cp   $1E
    jr   nc,call_43E3
    ld   a,(ix+$01)
    and  $07
    jr   nz,call_43DA
    call call_166B
    jr   z,call_43E3
call_43DA
    call loadhlfromspritestruct;call_1529
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    dec  (hl)
call_43E3
    ld   a,(ix+$05)
    ld   c,a
    add  a,a
    add  a,c
    ld   hl,data_4450
    bit  0,(ix+$19)
    jr   z,call_43F5
    ld   hl,data_44CB
call_43F5
    call adda2hl;$0D89
    ld   a,(hl)
    inc  (ix+$06)
    cp   (ix+$06)
    jr   nz,call_441A
    ld   (ix+$06),$00
    inc  (ix+$05)
    ld   a,(ix+$05)
    ld   e,$29
    bit  0,(ix+$19)
    jr   z,call_4415
    ld   e,$11
call_4415
    cp   e
    jr   nz,call_441A
    scf
    ret

call_441A
    inc  hl
    ld   b,(hl)
    ld   c,(ix+$1a)
    bit  0,(ix+$19)
    jr   z,call_4427
    set  0,c
call_4427
    ld   a,(ix+$07)
    inc  hl
    push hl
    push bc
    push af
    bit  0,(ix+$08)
    jr   nz,call_4442
    call call_147D
    pop  af
    pop  bc
    pop  hl
    ld   b,(hl)
    or   $20
    call call_147D
    xor  a
    ret
call_4442
    call call_149C
    pop  af
    pop  bc
    pop  hl
    ld   b,(hl)
    or   $20
    call call_149C
    xor  a
    ret

data_4450
    BYTE $1E,$8C,$00,$03,$90,$00,$03,$94,$00,$03,$98,$00,$03,$8C,$00,$03
    BYTE $90,$00,$03,$94,$00,$03,$98,$00,$03,$8C,$00,$03,$90,$00,$03,$94
    BYTE $00,$03,$98,$00,$03,$8C,$00,$03,$90,$00,$03,$94,$00,$03,$98,$00
    BYTE $03,$8C,$00,$03,$90,$00,$03,$AC,$9C,$03,$B0,$A0,$03,$B4,$A4,$03
    BYTE $B8,$A8,$03,$AC,$9C,$03,$B0,$A0,$03,$B4,$A4,$03,$B8,$A8,$03,$AC
    BYTE $9C,$03,$B0,$A0,$03,$B4,$A4,$03,$B8,$A8,$03,$AC,$9C,$03,$B0,$A0
    BYTE $03,$B4,$A4,$03,$B8,$A8,$03,$AC,$9C,$03,$B0,$A0,$03,$B4,$A4,$03
    BYTE $B8,$A8,$0F,$BC,$00,$0F,$C0,$00,$0F,$C4,$00
data_44CB    
    BYTE $05,$1C,$00,$05,$20
    BYTE $00,$05,$24,$00,$05,$28,$00,$05,$2C,$00,$05,$30,$00,$05,$34,$38
    BYTE $05,$3C,$40,$05,$44,$48,$05,$4C,$00,$05,$50,$00,$05,$54,$00,$05
    BYTE $58,$00,$05,$5C,$00,$05,$60,$00,$05,$64,$00,$0F,$00,$00


call_44FE
    bit  2,(ix+$0a)
    ret  nz
    cp   (ix+$12)
    ret  z
    ld   (ix+$12),a
    jp   resetframetimer;call_1556

call_450D
    ld   a,(ix+$12)
    cp   $FF
    ret  z
    ld   hl,data_4584
    call adda2hl;call_0D89
    ld   e,(hl)
    inc  hl
    push hl
    ld   a,(ix+$2c)
    call adda2hl;$0D89
    ld   d,(hl)
    pop  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  (ix+$06)
    ld   a,(ix+$06)
    cp   d
    jp   c,call_4545
    ld   (ix+$06),$00
    inc  (ix+$05)
    ld   a,(ix+$05)
    cp   e
    jr   nz,call_4548
    xor  a
    ld   (ix+$05),a
    jr   call_4549
call_4545
    ld   a,(ix+$05)
call_4548
    scf
call_4549
    ld   e,(hl)
    inc  hl
    ld   d,(hl)
    inc  hl
    jr   c,call_4558
    bit  0,(hl)
    jr   z,call_4558
    ld   (ix+$12),$FF
    ret
call_4558
    bit  1,(hl)
    jr   nz,call_4563
    add  a,a
    add  a,a
    ld   b,a
    ld   a,(de)
    add  a,b
    jr   call_4567
call_4563
    call adda2de;$0D84
    ld   a,(de)
call_4567
    ld   b,a
    ld   c,(ix+$1a)
    ld   a,(ix+$25)
    or   a
    jr   z,call_4577
    bit  0,a
    jr   z,call_4577
    ld   b,$00
call_4577
    ld   a,(ix+$07)
    bit  0,(ix+$08)
    jp   z,call_147D
    jp   call_149C

data_4584
    BYTE $02,$14,$0A,$0A,$05,LOW data_45E4,HIGH data_45E4,$02,$04,$05,$03,$03,$02,LOW data_45E6,HIGH data_45E6,$00
    BYTE $02,$0A,$06,$06,$04,LOW data_45EB,HIGH data_45EB,$00,$02,$0A,$06,$06,$04,LOW data_45E7,HIGH data_45E7,$00
    BYTE $02,$0A,$06,$06,$04,LOW data_45E8,HIGH data_45E8,$00,$03,$08,$06,$06,$05,LOW data_45E9,HIGH data_45E9,$00
    BYTE $03,$08,$06,$06,$05,LOW data_45EA,HIGH data_45EA,$00,$02,$0A,$08,$08,$07,LOW data_45EC,HIGH data_45EC,$00
    BYTE $04,$03,$02,$02,$02,LOW data_45ED,HIGH data_45ED,$01,$04,$03,$02,$02,$02,LOW data_45EE,HIGH data_45EE,$01
    BYTE $04,$03,$02,$02,$02,LOW data_45EF,HIGH data_45EF,$01,$04,$03,$02,$02,$02,LOW data_45F0,HIGH data_45F0,$01
data_45E4
    BYTE $44
data_45E5
	BYTE $4C
data_45E6
	BYTE $48
data_45E7
	BYTE $6C
data_45E8
	BYTE $74
data_45E9
	BYTE $60
data_45EA
	BYTE $7C
data_45EB
	BYTE $58
data_45EC
	BYTE $CC
data_45ED
	BYTE $04
data_45EE
	BYTE $14
data_45EF
	BYTE $24
data_45F0
	BYTE $34

call_45F1
    ld   hl,l_f678
    bit  0,(ix+$09)
    jr   z,call_45FD
    ld   hl,l_f67a
call_45FD
    ld   a,(hl)
    cp   $01
    jr   nz,call_4674
    ld   (hl),$00
    dec  hl
    ld   a,(hl)
    ld   (hl),$00
    cp   $02
    ret  c
    ld   (ix+$27),$01
    dec  a
    dec  a
    cp   $07
    jr   c,call_4617
    ld   a,$06
call_4617
    push af
    push af
    ld   hl,data_46AA
    call call_0DA7
    call call_41EC
    pop  af
    ld   hl,data_46B8
    call adda2hl;$0D89
    ld   c,(hl)
    call call_1350
    call loadhlfromspritestruct;call_1529
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    push hl
    ld   d,$01
    ld   e,(ix+$07)
    ld   b,$03
    call call_18A5
    pop  hl
    ld   b,$03
    ld   e,(ix+$01)
    ld   a,(ix+$02)
    sub  $10
call_464A
    ld   (hl),e
    inc  hl
    inc  hl
    ld   (hl),a
    inc  hl
    ld   (hl),$15
    inc  hl
    add  a,$10
    djnz call_464A
    pop  af
    ld   l,a
    add  a,a
    add  a,l
    ld   hl,data_46BF
    call adda2hl;$0D89
    ld   b,$03
    ld   e,(ix+$07)
    ld   d,$01
    ld   c,$1E
    bit  0,(ix+$09)
    jr   z,call_4671
    ld   c,$22
call_4671
    call call_14C2
call_4674
    ld   a,(ix+$27)
    and  a
    ret  z
    inc  (ix+$27)
    ld   a,(ix+$27)
    cp   $5A
    jr   nc,call_4695
    call loadhlfromspritestruct;call_1529
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   b,$03
call_468C
    inc  (hl)
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_468C
    ret

call_4695
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    ld   bc,$000C
    call clearbytes;$0D50
    ld   (ix+$27),$00
    call call_24B1
    ret


data_46AA
    BYTE $00,$02,$00,$04,$00,$08,$00,$16,$00,$32,$00,$64,$01,$00
data_46B8    
    BYTE $26,$26
    BYTE $26,$27,$27,$27,$27
data_46BF    
    BYTE $CC,$C4,$00,$D0,$C4,$00,$D4,$C4,$00,$D8,$DC
    BYTE $E0,$E4,$E8,$E0,$EC,$F0,$E0,$F4,$F8,$FC


call_46D4
    ld   a,$16
    bit  0,(ix+$13)
    jr   nz,call_46DF
    ld   a,(ix+$30)
call_46DF
    ld   hl,data_11CE
    call call_0DA7
    ld   a,(ix+$1f)
    call adda2de;$0D84
    ld   a,(de)
    or   a
    jp   p,call_46F6
    ld   (ix+$1f),$00
    jr   call_46D4
call_46F6
    ld   (ix+$20),a
    inc  (ix+$1f)
    ret

call_46FD
    ld   a,(ix+$25)
    and  a
    ret  z
    dec  (ix+$25)
    jp   call_0D14


call_4708
    ld   a,(ix+$22)
    and  a
    ret  z
    push af
    ld   a,$30
    call call_44FE
    pop  af
    jp   m,call_4735
    ld   a,(ix+$22)
    or   a
    ret  z
    ld   b,a
call_471D
    push bc
    call loadhl2;call_1537
    call call_1676
    jr   nz,call_4755
    call call_15E9
    jr   z,call_4759
    call loadhlfromspritestruct;call_1529
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz call_471D
    ret
call_4735
    ld   a,(ix+$22)
    or   a
    ret  z
    neg
    ld   b,a
call_473D
    push bc
    call loadhl2;1537
    call call_1676
    jr   nz,call_4755
    call call_1604
    jr   z,call_4759
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz call_473D
    ret

call_4755
    set  0,(ix+$0b)
call_4759
    pop  bc
    ret


call_4804
    ret  z
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    dec  (hl)
    ld   (ix+$08),$00
call_480F
    ld   hl,l_e5e5
    ld   a,(hl)
    add  a,(ix+$20)
    ld   (hl),a
    jr   nc,call_481B
    inc  hl
    inc  (hl)
call_481B
    bit  0,(ix+$2d)
    ret  z
    ld   de,$0001
    jp   call_41EC

call_482C
    ret

call_4869
    bit  0,(ix+$0b)
    jr   nz,call_4875
    bit  0,(ix+$0c)
    jr   z,call_4895
call_4875
    bit  0,(ix+$24)
    jr   z,call_488E
    res  0,(ix+$24)
    call call_43B5
    bit  4,a
    jr   nz,call_488E
    ld   de,$0001
    call call_41EC
    jr   call_48A6
call_488E
    bit  0,(ix+$0b)
    ret  nz
    jr   call_4912
call_4895
    call call_43B5
    bit  4,a
    jr   z,call_48A1
    res  1,(ix+$0c)
    ret

call_48A1
    bit  1,(ix+$0c)
    ret  nz
call_48A6
    ld   c,$2C
    call call_1350
    ld   (ix+$0c),$00
    set  1,(ix+$0c)
    call loadhlfromspritestruct;$1529
    res  0,(hl)
    call loadhl2;$1537
    bit  1,(ix+$2d)
    ld   de,$0050
    call nz,call_41EC
    set  0,(ix+$0c)
    ld   hl,l_e5e4
    inc  (hl)
    call call_43B5
    bit  0,a
    jr   z,call_48DE
    bit  1,a
    jr   z,call_48E4
    set  5,(ix+$0c)
    jr   call_48E8
call_48DE
    set  4,(ix+$0c)
    jr   call_48E8
call_48E4
    set  3,(ix+$0c)
call_48E8
    ld   hl,data_4AED
    ld   (ix+$0d),l
    ld   (ix+$0e),h
    ld   a,(hl)
    ld   (ix+$0f),a
    inc  hl
    ld   a,(hl)
    ld   (ix+$10),a
    inc  hl
    ld   a,(hl)
    call call_44FE
    ld   (ix+$11),$00
    call loadhlfromspritestruct;$1529
    res  0,(hl)
    call loadhl2;$1537
    call call_1387
    res  0,(ix+$0b)
call_4912
    call call_43A0
    call call_4334
    ld   a,(ix+$20)
    or   a
    ret  z
    ld   b,a
call_491E
    push bc
    call call_4926
    pop  bc
    djnz call_491E
    ret

call_4926
    call loadhl2;1537
    ld   a,(ix+$0f)
    and  a
    jp   p,call_4936
    ld   (ix+$23),$03
    jr   call_493A
call_4936
    ld   (ix+$23),$01
call_493A
    ld   a,(ix+$0c)
    bit  5,a
    jp   nz,call_4A3F
    bit  4,a
    jp   nz,call_49C4
    bit  7,(ix+$0f)
    jp   z,call_497F
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_49AD
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jr   z,call_49AD
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jr   z,call_49AD
    jp   call_4A3F
call_497F
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   nz,call_49B8
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jr   z,call_49AD
    ld   a,(ix+$02)
    add  a,$09
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jr   nz,call_49B8
call_49AD
    ld   a,(ix+$01)
    cp   $20
    jr   c,call_49B8
    cp   $D0
    jr   c,call_49C0
call_49B8
    ld   a,(ix+$02)
    cp   $E7
    jp   c,call_4A3F
call_49C0
    set  6,(ix+$0c)
call_49C4
    bit  7,(ix+$0f)
    jp   z,call_49FB
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_4A29
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jr   z,call_4A29
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jr   z,call_4A29
    jr   call_4A3F
call_49FB
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   nz,call_4A34
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    add  a,$08
    call call_174C
    jr   z,call_4A29
    ld   a,(ix+$02)
    sub  $09
    ld   h,a
    ld   a,(ix+$01)
    sub  $08
    call call_174C
    jr   nz,call_4A34
call_4A29
    ld   a,(ix+$01)
    cp   $20
    jr   c,call_4A34
    cp   $D0
    jr   c,call_4A3B
call_4A34
    ld   a,(ix+$02)
    cp   $18
    jr   nc,call_4A3F
call_4A3B
    set  6,(ix+$0c)
call_4A3F   
    bit  7,(ix+$0f)
    jp   z,call_4A7E
    ld   a,(ix+$01)
    and  $07
    jr   nz,call_4A7E
    ld   h,(ix+$02)
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_4A7E
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_4A7E
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_4A7E
    call call_1676
    jr   nz,call_4A7E
    set  0,(ix+$0b)
    ret
call_4A7E
    call loadhlfromspritestruct;$1529
    ld   a,(ix+$0f)
    add  a,(hl)
    ld   (hl),a
    bit  5,(ix+$0c)
    jr   nz,call_4AAB
    bit  6,(ix+$0c)
    jr   nz,call_4AAB
    inc  hl
    inc  hl
    ld   a,(ix+$11)
    ld   de,data_4B10
    call adda2de;$0D84
    ld   a,(de)
    or   a
    jr   z,call_4AAB
    bit  3,(ix+$0c)
    jr   nz,call_4AAA
    dec  (hl)
    jr   call_4AAB
call_4AAA
    inc  (hl)
call_4AAB
    inc  (ix+$11)
    dec  (ix+$10)
    jr   nz,call_4AD4
    ld   l,(ix+$0d)
    ld   h,(ix+$0e)
    inc  hl
    inc  hl
    inc  hl
    ld   (ix+$0d),l
    ld   (ix+$0e),h
    ld   a,(hl)
    cp   $80
    jr   z,call_4AE0
    ld   (ix+$0f),a
    inc  hl
    ld   a,(hl)
    ld   (ix+$10),a
    inc  hl
    ld   a,(hl)
    jp   call_44FE
call_4AD4
    ld   l,(ix+$0d)
    ld   h,(ix+$0e)
    inc  hl
    inc  hl
    ld   a,(hl)
    jp   call_44FE
call_4AE0
    set  0,(ix+$0b)
    ld   a,(ix+$0c)
    and  $02
    ld   (ix+$0c),a
    ret


data_4AED
    BYTE $02,$10,$20,$01,$09,$20,$00,$02,$20,$01,$01,$20,$00,$02,$20,$00
    BYTE $03,$18,$FF,$01,$18,$00,$02,$18,$FF,$09,$18,$FE,$10,$18,$80,$80
    BYTE $80,$80,$80
data_4B10    
    BYTE $00,$00,$01,$00,$01,$00,$00,$00,$01,$01,$00,$01,$01
    BYTE $00,$01,$01,$00,$01,$01,$00,$01,$01,$00,$01,$01,$00,$01,$01,$00
    BYTE $01,$01,$01,$00,$01,$01,$00,$01,$01,$00,$01,$01,$00,$01,$01,$00
    BYTE $01,$01,$00,$01,$01,$00,$01,$01,$00,$00,$00,$01,$00,$01,$00,$00
    BYTE $00,$00,$00,$00

    
call_4B51
    ld   hl,l_e6ac
call_4B54
    bit  0,(hl)
    ret  nz
    set  0,(hl)
    inc  hl
    ld   (hl),$1E
    ret

call_4B5D
    ld   hl,l_e6de
    jr   call_4B54
call_4B62
    bit  0,(ix+$1b)
    ret  z
    dec  (ix+$1c)
    jr   z,call_4B71
    ld   a,$38
    jp   call_44FE
call_4B71
    res  0,(ix+$1b)
    ret

call_4B76
    bit  0,(ix+$0a)
    jp   nz,call_4C03
    call call_43B5
    bit  5,a
    jr   z,call_4B89
    res  1,(ix+$0a)
    ret
call_4B89
    bit  1,(ix+$0a)
    ret  nz
    ld   a,(l_fc85)
    and  $25
    jr   nz,call_4B96
    nop
call_4B96
    ld   hl,l_e75e
    ld   a,(ix+$09)
    and  a
    jr   z,call_4BA2
    ld   hl,l_e764
call_4BA2
    ld   a,$01
    bit  6,(ix+$2d)
    jr   z,call_4BB4
    dec  (ix+$28)
    jr   nz,call_4BB3
    res  6,(ix+$2d)
call_4BB3
    inc  a
call_4BB4
    ld   (hl),a
    inc  hl
    ld   a,(ix+$01)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$02)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$08)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$31)
    ld   (hl),a
    inc  hl
    ld   a,(ix+$2f)
    ld   (hl),a
    ld   b,$0D
    ld   hl,data_4C1B
    ld   a,(ix+$12)
call_4BD6
    cp   (hl)
    jr   z,call_4BDD
    inc  hl
    inc  hl
    djnz call_4BD6
call_4BDD
    inc  hl
    ld   a,(hl)
    call call_44FE
    ld   hl,l_e5df
    inc  (hl)
    bit  2,(ix+$2d)
    ld   de,$0010
    call nz,call_41EC
    ld   a,(ix+$2e)
    ld   (ix+$26),a
    set  1,(ix+$0a)
    set  0,(ix+$0a)
    set  2,(ix+$0a)
    ret
call_4C03
    ld   a,(ix+$12)
    cp   $FF
    jr   nz,call_4C0E
    res  2,(ix+$0a)
call_4C0E
    dec  (ix+$26)
    ret  nz
    res  0,(ix+$0a)
    res  2,(ix+$0a)
    ret

data_4C1B
    BYTE $00,$40,$08,$40,$10,$48,$18,$50,$20,$58,$28,$40,$30,$40,$38,$40
    BYTE $40,$40,$48,$48,$50,$50,$58,$58,$FF,$40


call_4C35
    ld   hl,l_e6ff
    ld   bc,$001C
    call clearbytes;$0D50
    ld   a,bank2;$02
    call call_026C
    call bank2_call_9C7D
    call call_029B
    ld   a,(l_e5d7)
    ld   (l_e71a),a
    ld   a,(l_e71a)
    bit  0,a
    jr   z,call_4CB1
    ld   ix,l_e700
    ld   de,(l_e692)
    ld   a,(l_e64b)
    and  a
    jr   z,call_4C6A
    ld   a,(l_e5d3)
    and  a
    jr   z,call_4C71
call_4C6A
    ld   de,$4850    ;TODO don't think this is an address??
    ld   (l_e692),de
call_4C71
    ld   (ix+$01),e
    res  0,d
    ld   (ix+$02),d
    ld   hl,l_e2c5
    ld   (ix+$03),l
    ld   (ix+$04),h
    push hl
    call call_4EC1
    pop  hl
    ld   de,$0018
    ld   b,$04
    call call_18A5      ;set 4 sprites gfx num entries to $18
    ld   (ix+$07),$18
    ld   (ix+$08),$00
    ld   e,$00
    ld   a,(l_e693)
    cp   $20
    jr   c,call_4CA1
    inc  e
call_4CA1
    ld   a,(l_e692)
    cp   $28
    jr   nc,call_4CAA
    set  1,e
call_4CAA
    ld   (ix+$0a),e
    set  0,(ix+$00)
call_4CB1
    ld   a,(l_e71a)
    bit  1,a
    ret  z
    ld   ix,l_e70c
    ld   de,(l_e6c4)
    ld   a,(l_e64b)
    and  a
    jr   z,call_4CCB
    ld   a,(l_e5d3)
    and  a
    jr   z,call_4CD2
call_4CCB
    ld   de,$B050			;TODO - Check - is this an address? check bank0_call_A269
    ld   (l_e6c4),de
call_4CD2
    ld   (ix+$01),e
    res  0,d
    ld   (ix+$02),d
    ld   hl,l_e2b5
    ld   (ix+$03),l
    ld   (ix+$04),h
    push hl
    call call_4EC1
    pop  hl
    ld   de,$0019
    ld   b,$04
    call call_18A5
    ld   (ix+$08),$01
    ld   (ix+$07),$19
    ld   e,$00
    ld   a,(l_e6c5)
    cp   $E0
    jr   c,call_4D02
    inc  e
call_4D02
    ld   a,(l_e6c4)
    cp   $28
    jr   nc,call_4D0B
    set  1,e
call_4D0B
    ld   (ix+$0a),e
    set  0,(ix+$00)
    ret
call_4D13
    ld   a,(l_e6ff)
    and  a
    ret  m
    ld   a,bank2;$02
    call call_026C
    call bank2_call_9D35
    call call_029B
    ld   ix,l_e700
    ld   b,$02
call_4D29
    push bc
    ld   a,(ix+$00)
    bit  0,a
    jr   nz,call_4D3D
    bit  1,a
    jr   nz,call_4D6D
    bit  2,a
    jp   nz,call_4DC2
    jp   call_4DFF
call_4D3D
    ld   de,$0A06
    call frametimer;call_15CA
    jr   z,call_4D62
    add  a,a
    add  a,a
    ld   hl,data_4EE3
    call adda2hl;$0D89
    ld   c,$1F
    bit  0,(ix+$08)
    jr   z,call_4D57
call_4D55
    ld   c,$23
call_4D57
    ld   b,$04
    call call_14BD
    call call_4E4A
    jp   call_4DFF
call_4D62
    ld   (ix+$00),$00
    set  1,(ix+$00)
    jp   call_4DFF
call_4D6D
    ld   de,$0A02
    call frametimer;call_15CA
    add  a,a
    add  a,a
    ld   hl,data_4EF7
    call adda2hl;$0D89
    ld   c,$1F
    bit  0,(ix+$08)
    jr   z,call_4D85
    ld   c,$23
call_4D85
    ld   b,$04
    call call_14BD
    call call_4E4A
    ld   a,(ix+$09)
    cp   $03
    jr   nz,call_4DFF
    ld   hl,l_e718
    bit  0,(ix+$08)
    jr   nz,call_4DA1
    set  0,(hl)
    jr   call_4DA3
call_4DA1
    set  1,(hl)
call_4DA3
    ld   a,(l_e71a)
    cp   (hl)
    jr   nz,call_4DFF
    ld   a,(l_e351)
    and  a
    jr   nz,call_4DFF
    ld   a,(l_f536)
    cp   $01
    jr   z,call_4DFF
    call resetframetimer;call_1556
    ld   (ix+$00),a
    set  2,(ix+$00)
    jr   call_4DFF
call_4DC2
    ld   de,$0503
    call frametimer;call_15CA
    jr   z,call_4DE3
    add  a,a
    add  a,a
    ld   hl,data_4F03
    call adda2hl;$0D89
    ld   c,$1F
    bit  0,(ix+$08)
    jr   z,call_4DDC
    ld   c,$23
call_4DDC
    ld   b,$04
    call call_14BD
    jr   call_4DFF
call_4DE3
    ld   (ix+$00),$00
    call loadhlfromspritestruct;call_1529
    ld   bc,$0010
    call clearbytes;$0D50
    ld   hl,l_e719
    bit  0,(ix+$08)
    jr   nz,call_4DFD
    set  0,(hl)
    jr   call_4DFF
call_4DFD
    set  1,(hl)
call_4DFF
    call loadhl2;call_1537
    ld   de,$000C
    add  ix,de
    pop  bc
    dec  b
    jp   nz,call_4D29
    ld   hl,l_e719
    ld   a,(l_e71a)
    cp   (hl)
    ret  nz
    ld   hl,l_e6ff
    ld   (hl),$FF
    ld   hl,l_e71a
    bit  0,(hl)
    call nz,clearp1;call_3EB5
    ld   hl,l_e71a
    bit  1,(hl)
    call nz,clearp2;call_3F39
    ld   a,$05
    call call_0030
    ld   a,(l_f536)
    and  a
    jp   m,call_4E3E
    ld   a,(l_e64b)
    cp   $00
    jr   z,call_4E3E
    cp   $64
    jr   nz,call_4E41
call_4E3E
    ld   a,$04
    call call_0030
call_4E41
    ld   a,$02     ;this is where it is currently crashing
    call call_0018
    ld   hl,l_f66b
    ld   (hl),$49
    ret
call_4E4A    
    ld   a,(l_fc85)
    bit  5,a
    nop
    inc  (ix+$0b)
    ld   a,(ix+$0b)
    cp   $02
    ret  nz
    ld   (ix+$0b),$00
    call loadhlfromspritestruct;call_1529
    ld   b,$04
    ld   a,(hl)
    cp   $28
    jr   z,call_4E6B
    cp   $29
    jr   nz,call_4E71
call_4E6B
    set  0,(ix+$09)
    jr   call_4E89
call_4E71
    bit  1,(ix+$0a)
    jr   nz,call_4E81
call_4E77
    dec  (hl)
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_4E77
    jr   call_4E89
call_4E81
    inc  (hl)
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_4E81
call_4E89
    call loadhlfromspritestruct;call_1529
    ld   b,$04
    inc  hl
    inc  hl
    ld   a,(hl)
    bit  0,(ix+$08)
    jr   nz,call_4EA0
    cp   $10
    jr   nz,call_4EA9
    set  1,(ix+$09)
    ret
call_4EA0
    cp   $D0
    jr   nz,call_4EA9
    set  1,(ix+$09)
    ret
call_4EA9
    bit  0,(ix+$0a)
    jr   nz,call_4EB8
call_4EAF
    inc  (hl)
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_4EAF
    ret
call_4EB8
    dec  (hl)
    dec  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_4EB8
    ret

call_4EC1
    ld   b,$04
    ld   de,data_4EDB
call_4EC6
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
    ld   (hl),$14
    inc  hl
    inc  de
    djnz call_4EC6
    ret

data_4EDB
    BYTE $00,$F0,$00,$00,$F0,$F0,$F0,$00
    
data_4EE3
    BYTE $04,$08,$1C,$20,$0C,$10,$24,$28,$14,$18,$2C,$30,$34,$38,$4C,$50
    BYTE $3C,$40,$54,$58
data_4EF7
    BYTE $44,$48,$5C,$60,$64,$68,$7C,$80,$6C,$70,$84,$88
data_4F03
    BYTE $74,$78,$8C,$90,$94,$98,$AC,$B0,$00,$00,$00,$00,$C9,$00,$00,$00
    BYTE $00,$00
    

call_4F52
    ld   hl,l_e720
    ld   bc,$0003
    jp   clearbytes


call_4F5B
    ld   a,(l_e5d3)
    and  a
    ret  nz
    ld   a,(l_e720)
    and  a
    ret  z
    ret  m
    ld   a,$08
    call call_18CF
    ld   a,$02
    call call_0018;rst  $18
    ld   a,$03
    call call_0008;rst  $08
    ld   a,$05
    call call_0008;rst  $08
    ld   a,$04
    call call_0008;rst  $08
    ld   a,$02
    call call_0008;rst  $08
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $4F8B
;    ld   a,i
;    inc  a
;    ld   i,a
call_4F8B
    ld   hl,l_e720
    ld   bc,$0003
    call clearbytes;$0D50
    call call_0A97
    ld   hl,$4000;$CD04
    ;call clearrow;$03FD
    ld   hl,$4000+$20;$CD06
    ;call clearrow;$03FD
    call call_0020;rst  $20
call_4FA4
    jr call_4FA4

call_4F0F
    ret


call_5046
    ld   a,(l_e723)
    cp   $29
    ret  nz
    ld   hl,l_f66b
    ld   (hl),$00
    ld   hl,l_e76c
    ld   bc,$0168
    call clearbytes;$0D50
    ld   hl,l_e725
    ld   bc,$000F
    call clearbytes;$0D50
    ld   hl,$0960
    ld   (l_e72e),hl
    ld   hl,l_ed3d
    ld   (hl),$0A
    ld   a,$03
    call call_0008;rst  $08
    ld   a,$04
    call call_0008;rst  $08
    ld   hl,l_e341
    ld   (hl),$FF
    ld   hl,l_e343
    ld   (hl),$00
    call call_03D0
    ld   hl,l_e5d7
    bit  0,(hl)
    call nz,call_3308
    ld   hl,l_e5d7
    bit  1,(hl)
    call nz,call_3353
    call call_18BB
    ld   hl,l_e64b
    inc  (hl)
    ld   a,(hl)
    ld   (l_e726),a
    ld   (hl),a
	ld a,introbank
	call call_026C
    call intro_call_30DF  ;TODO - this clear the area where P2 'insert coins gfx will appear'
	call call_029B
    ld   hl,l_e64b
    ld   (hl),$65
    call call_1775
    call call_1700
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,call_50BB
    ld   hl,l_e2c5
    ld   (hl),$58
    inc  hl
    inc  hl
    ld   (hl),$18
call_50BB
    ld   hl,l_e5d7
    bit  1,(hl)
    jr   z,call_50CB
    ld   hl,l_e2b5
    ld   (hl),$58
    inc  hl
    inc  hl
    ld   (hl),$D8
call_50CB
    ld   a,$03
    call call_0018;rst  $18
    call call_5498
    call call_5267
    ld   a,$03
    call call_0010;rst  $10
    ld   hl,l_e725
    ld   (hl),$00
    ld   hl,l_e358
    ld   (hl),$01
    ld   c,$29
    call call_1350
    ld   a,bank2
    call call_026C
    ld   a,(l_e724)
    ld   hl,data_50F6
    call call_0DA7
    ex   de,hl
    jp   (hl)
data_50F6
    BYTE LOW call_50FC,HIGH call_50FC
    BYTE LOW call_510B,HIGH call_510B
    BYTE LOW call_5115,HIGH call_5115
call_50FC
    ld   hl,l_f47b
    ld   (hl),$00
    call bank2_call_8DA3
    ld   hl,l_f47c
    ld   (hl),$01
    jr   call_5124
call_510B
    call bank2_call_A433
    ld   hl,l_f595
    ld   (hl),$01
    jr   call_5124
call_5115
    ld   hl,l_f47b
    ld   (hl),$01
    call bank2_call_8DA3
    ld   hl,l_f47c
    ld   (hl),$01
    jr   call_5124
call_5124
    call call_029B
call_5127
    call call_0020;rst  $20
    call call_55DB
    call call_52B6
    call call_5353
    call call_5416
    call call_52A6
    call bank0_call_A150
    call call_541E
    ld   ix,l_e76c
    ld   b,$24
call_5143
    push bc
    ld   a,(ix+$00)
    bit  0,a
    jr   nz,call_517F
    bit  1,a
    jp   nz,call_51B8
    bit  2,a
    jp   nz,call_51CA
    call loadhlfromspritestruct;$1529
    ld   a,(ix+$08)
    add  a,a
    add  a,a
    ld   de,data_51D7
    call adda2de;0D84
    ld   a,(de)
    ld   (hl),a
    inc  hl
    inc  hl
    inc  de
    ld   a,(de)
    ld   (hl),a
    inc  de
    ld   a,(de)
    ld   b,a
    inc  de
    ld   a,(de)
    ld   c,a
    ld   a,(ix+$07)
    call call_147D
    call loadhl2;$1537
    set  0,(ix+$00)
    jr   call_51CA
call_517F
    ld   bc,$1010
    call call_13F0
    jr   nc,call_51CA
    and  a
    jr   nz,call_5197
    ld   (l_e5d6),a
    ld   de,$1000
    call call_2FB3
    ld   c,$1E
    jr   call_51A2
call_5197
    ld   (l_e5d6),a
    ld   de,$1000
    call call_2FB3
    ld   c,$22
call_51A2
    ld   b,$98
    ld   a,(ix+$07)
    call call_147D
    ld   (ix+$09),$3C
    ld   (ix+$00),$02
    ld   hl,l_e725
    inc  (hl)
    jr   call_51CA
call_51B8
    dec  (ix+$09)
    jr   z,call_51C3
    call loadhlfromspritestruct;$1529
    inc  (hl)
    jr   call_51CA
call_51C3
    call call_154C
    ld   (ix+$00),$04
call_51CA
    pop  bc
    ld   de,$000A
    add  ix,de
    dec  b
    jp   nz,call_5143
    jp   call_5127
data_51D7
    BYTE $B8,$2C,$9C,$28,$B8,$3C,$9C,$28,$B8,$B4,$9C,$28,$B8,$C4,$9C,$28
    BYTE $A0,$2C,$9C,$28,$A0,$3C,$9C,$28,$A0,$B4,$9C,$28,$A0,$C4,$9C,$28
    BYTE $88,$10,$AC,$1C,$88,$20,$AC,$1C,$88,$30,$AC,$1C,$88,$40,$AC,$1C
    BYTE $88,$B0,$AC,$1C,$88,$C0,$AC,$1C,$88,$D0,$AC,$1C,$88,$E0,$AC,$1C
    BYTE $70,$10,$A8,$1C,$70,$20,$A8,$1C,$70,$30,$A8,$1C,$70,$40,$A8,$1C
    BYTE $70,$B0,$A8,$1C,$70,$C0,$A8,$1C,$70,$D0,$A8,$1C,$70,$E0,$A8,$1C
    BYTE $18,$10,$A0,$28,$18,$20,$A0,$28,$18,$30,$A0,$28,$18,$40,$A0,$28
    BYTE $18,$50,$A0,$28,$18,$60,$A0,$28,$18,$90,$A0,$28,$18,$A0,$A0,$28
    BYTE $18,$B0,$A0,$28,$18,$C0,$A0,$28,$18,$D0,$A0,$28,$18,$E0,$A0,$28
call_5267
    ld   ix,l_e76c
    xor  a
    ld   de,$000C
call_526F
    push af
    ld   (ix+$08),a
    add  a,a
    add  a,a
    ld   hl,l_e20d
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
    jr   nz,call_5294
    ld   d,$00
    inc  e
call_5294
    inc  hl
    inc  hl
    ld   (hl),$13
    ex   de,hl
    ld   de,$000A
    add  ix,de
    ex   de,hl
    pop  af
    inc  a
    cp   $24
    jr   nz,call_526F
    ret
call_52A6
    ld   hl,(l_e72e)
    dec  hl
    ld   (l_e72e),hl
    ld   a,l
    or   h
    ret  nz
    ld   hl,l_e343
    ld   (hl),$01
    ret
call_52B6
    ld   a,(l_e72b)
    bit  1,a
    jr   nz,call_5302
    bit  0,a
    jr   nz,call_52CD
    ld   a,(l_e725)
    cp   $18
    ret  c
    ld   hl,l_e72b
    set  0,(hl)
    ret
call_52CD
    ld   hl,l_e72c
    inc  (hl)
    ld   a,(hl)
    cp   $1E
    ret  nz
    ld   (hl),$00
    inc  hl
    ld   a,(l_e72d)
    add  a,a
    add  a,a
    add  a,a
    ld   hl,data_533B
    call adda2hl;0D89
stop52ea
    jr stop52ea
    BYTE "stop52ea"
;    ld   de,$D0E6
;    ld   bc,$0004
;52EA: ED B0         ldir
;52EC: 11 26 D1      ld   de,$D126
;52EF: 01 04 00      ld   bc,$0004
;52F2: ED B0         ldir
;52F4: 21 2D E7      ld   hl,$E72D
;52F7: 34            inc  (hl)
;52F8: 7E            ld   a,(hl)
;52F9: FE 03         cp   $03
;52FB: C0            ret  nz
;52FC: 21 2B E7      ld   hl,$E72B
;52FF: CB CE         set  1,(hl)
;5301: C9            ret
call_5302
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,call_5320
    ld   hl,l_e2c5
    ld   a,(hl)
    cp   $58
    jr   nz,call_5320
    inc  hl
    inc  hl
    ld   a,(hl)
    cp   $77
    jr   c,call_5320
    cp   $7A
    jr   nc,call_5320
    dec  hl
    dec  hl
    ld   (hl),$18
call_5320
    ld   hl,l_e5d7
    bit  1,(hl)
    ret  z
    ld   hl,l_e2b5
    ld   a,(hl)
    cp   $58
    ret  nz
    inc  hl
    inc  hl
    ld   a,(hl)
    cp   $77
    ret  c
    cp   $7A
    ret  nc
    dec  hl
    dec  hl
    ld   (hl),$18
    ret
data_533B
    BYTE $25,$3D,$2D,$3D,$26,$3D,$2E,$3D,$36,$3D,$40,$3D,$37,$3D,$41,$3D
    BYTE $4A,$3D,$54,$3D,$4B,$3D,$55,$3D
call_5353
    ld   a,(l_e731)
    bit  1,a
    jr   nz,call_539F
    bit  0,a
    jr   nz,call_536A
    ld   a,(l_e725)
    cp   $24
    ret  c
    ld   hl,l_e731
    set  0,(hl)
    ret
call_536A
    ld   hl,l_e732
    inc  (hl)
    ld   a,(hl)
    cp   $1E
    ret  nz
    ld   (hl),$00
    inc  hl
    ld   a,(l_e733)
    add  a,a
    add  a,a
    add  a,a
    ld   hl,data_5406
    call adda2hl;$0D89
    ld   de,$D0F6
    ld   bc,$0004
stop5389
    jr stop5389
    BYTE "stop5389"    
;    ldir
;5389: 11 36 D1      ld   de,$D136
;538C: 01 04 00      ld   bc,$0004
;538F: ED B0         ldir
;5391: 21 33 E7      ld   hl,$E733
;5394: 34            inc  (hl)
;5395: 7E            ld   a,(hl)
;5396: FE 02         cp   $02
;5398: C0            ret  nz
;5399: 21 31 E7      ld   hl,$E731
;539C: CB CE         set  1,(hl)
;539E: C9            ret
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
data_5406
    BYTE $5E,$39,$68,$39,$5F,$39,$69,$39,$72,$39,$7B,$39,$73,$39,$7C,$39
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
stop542c
    jr stop542c
    BYTE "stop542c"



call_5498
    ld   iy,l_fc44
    ld   a,(iy+$41)
    sub  $37
    nop
    nop
    call call_02C8
    ld   hl,data_55BB
    ld   de,$F9C0
    ld   bc,$0020
    ;ldir               ;TODO - palette    
    ld   a,(l_e724)
    ld   hl,data_54BC
    call call_0DA7
    ex   de,hl
    jp   (hl)
data_54BC
    BYTE LOW call_54C2,HIGH call_54C2
    BYTE LOW call_54ED,HIGH call_54ED
    BYTE LOW call_5518,HIGH call_5518

call_54C2
    jr call_54C2
    BYTE "call_54C2"
    
call_54ED
    jr call_54ED
    BYTE "call_54ED"

call_5518
    jr call_5518
    BYTE "call_5518"


data_55BB
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$33,$00,$44,$00,$88,$00
    BYTE $66,$00,$55,$00,$FA,$00,$FF,$00,$F8,$00,$F7,$00,$94,$00,$00,$00
call_55DB
    ld   a,(l_e729)
    and  a
    jr   z,call_55E5
    jp   m,call_55FA
    ret
call_55E5
    ld   hl,l_e729
    ld   (hl),$FF
    ld   hl,l_e72a
    ld   (hl),$78
    ld   hl,data_560F
    ld   de,$7a1a;$D65E
    ld   c,$00
    jp   call_0E9A;writetext;$0E9A
call_55FA
    ld   hl,l_e72a
    dec  (hl)
    ret  nz
    ld   hl,l_e729
    ld   (hl),$01
    ld   hl,data_5627
    ld   de,$7a1a;$D65E
    ld   c,$00
    jp   call_0E9A;writetext;0E9A
    
    
data_560F
    BYTE $17,"WELCOME TO SECRET ROUND"
    
data_5627
    BYTE $17,"                       "
	
call_563F
    ld   a,0
    ld  (intro_scroll_counter),a
    ld   hl,l_e5c4
    ld	 (hl),$00
    ld   hl,intro_bank1_data_90EA     ;1 Player ending
    ld   a,(l_e5d7)
    cp   $03                        ;check numbers of players
    jr   nz,call_565A
    ld   hl,intro_bank1_data_8D42     ;2 Player ending
    ld   a,(l_e5db)
    and  a
    jr   z,call_565A
    ld   hl,intro_bank1_data_91BF     ;Real ending
call_565A
    ld   (l_e734),hl
call_565D
    call  call_0020
    ld   hl,l_e736
    inc  (hl)
    ld   a,(hl)
    cp   $04
    jr   nz,call_565D
    ld   (hl),$00
    call call_56AB      ;scroll screen and raise sprites
    ld   a,(l_e2f5)
    ;ld   a,(l_e1cd)
    and  $07
    jr   nz,call_565D   ;if not scrolled 8 pixels don't write new line

    ld a,introbank
    call call_026C
    ld   a,(intro_scroll_counter)
    call intro_call_5701      ;clear line
    ld   a,(intro_scroll_counter)
    call intro_call_5719      ;write message
    call call_029B

    ld   e,$3B      ;59 - number of scrolls lines in 1 player ending in
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_568C
    ld   e,$AC      ;172 - number of scrolls lines in 2 player ending
    ld   a,(l_e5db)
    and  a
    jr   z,call_568C
    ld   e,$AC      ;172 - number of scrolls lines in real ending
call_568C
    ld a,(intro_scroll_counter)
    inc a
    cp 24
    jr nz,call_568C_1
    ld a,0
call_568C_1
    ld   (intro_scroll_counter),a
    ld   hl,l_e5c4
    inc  (hl)
    ld   a,(hl)
    cp   e
    jr   nz,call_565D
    ld   hl,l_e5c4
    ld   (hl),$00
    ;ld   b,$10
    ld   hl,l_e2f5
    ld   (hl),$00
    ;ld   hl,l_e1cd
call_569E
    ld a,0
    ld   (intro_scroll_counter),a
    ;ld   (hl),$00
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;djnz intro_call_569E
    ld a,$05
    call call_0008    
    call call_0020
    ret
call_56AB
;    ld   a,($0002) ;protection
;    cp   $5E
;    jr   z,$56B4
;    push af
;    push bc
    ;ld   b,$10
    ld   a,(l_e2f5)
    ;ld   hl,l_e1cd
call_56B9
    inc  a
    cp $c0;24
    jr nz,call_56B9_1
    ld a,0
call_56B9_1
    ld (l_e2f5),a
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;djnz call_56B9
    ld   b,$10
    ld   hl,l_e20d      ;raise sprites
call_56C5
    ld   a,(hl)
    and  a
    jr   z,call_56CA
    inc  (hl)
call_56CA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_56C5
    ld   hl,l_e2c5
    ld   a,(hl)
    and  a
    jr   z,call_56D8
    inc  (hl)
call_56D8
    ld   hl,l_e2b5
    ld   a,(hl)
    and  a
    jr   z,call_56E0
    inc  (hl)
call_56E0
    ld   b,$08
    ld   hl,l_e255
call_56E5
    ld   a,(hl)
    and  a
    jr   z,call_56EA
    inc  (hl)
call_56EA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_56E5
    ld   b,$10
    ld   hl,l_e275
call_56F5
    ld   a,(hl)
    and  a
    jr   z,call_56FA
    inc  (hl)
call_56FA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_56F5
    ret

intro_scroll_counter
    BYTE $00

    /*break
    ld a,introbank
    call call_026C
    call intro_call_563F
    break
    call call_029B
    ld   a,$05
    call call_0008
    call call_0020
    ret*/
/*
    ld   hl,l_e5c4
    ld	 (hl),$00
    ld   hl,bank1_data_90EA     ;1 Player ending
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_565A
    ld   hl,bank1_data_8D42     ;2 Player ending
    ld   a,(l_e5db)
    and  a
    jr   z,call_565A
    ld   hl,bank1_data_91BF     ;Real ending
call_565A
    ld   (l_e734),hl
call_565D
    call  call_0020
    ld   hl,l_e736
    inc  (hl)
    ld   a,(hl)
    cp   $04
    jr   nz,call_565D
    ld   (hl),$00
    call call_56AB      ;scroll screen and raise sprites
    ;ld   a,(l_e2f5)
    ld   a,(l_e1cd)
    and  $07
    jr   nz,call_565D   ;if not scrolled 8 pixels don't write new line
    call call_5701      ;clear line
    call call_5719      ;write message
    ld   e,$3B      ;59 - number of scrolls lines in 1 player ending in
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_568C
    ld   e,$AC      ;172 - number of scrolls lines in 2 player ending
    ld   a,(l_e5db)
    and  a
    jr   z,call_568C
    ld   e,$AC      ;172 - number of scrolls lines in real ending
call_568C
    ld   hl,l_e5c4
    inc  (hl)
    ld   a,(hl)
    cp   e
    jr   nz,call_565D
    ld   hl,l_e5c4
    ld   (hl),$00
    ld   b,$10
    ;ld   hl,l_e2f5
    ld   hl,l_e1cd
call_569E
    ld   (hl),$00
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_569E
    ld   a,$05
    call call_0008
    call call_0020
    ret
call_56AB
;    ld   a,($0002) ;protection
;    cp   $5E
;    jr   z,$56B4
;    push af
;    push bc
    ;ld   b,$10
    ;ld   hl,l_e2f5
    ld   hl,l_e1cd
call_56B9
    inc  (hl)
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;inc  hl
    ;djnz call_56B9
    ld   b,$10
    ld   hl,l_e20d      ;raise sprites
call_56C5
    ld   a,(hl)
    and  a
    jr   z,call_56CA
    inc  (hl)
call_56CA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_56C5
    ld   hl,l_e2c5
    ld   a,(hl)
    and  a
    jr   z,call_56D8
    inc  (hl)
call_56D8
    ld   hl,l_e2b5
    ld   a,(hl)
    and  a
    jr   z,call_56E0
    inc  (hl)
call_56E0
    ld   b,$08
    ld   hl,l_e255
call_56E5
    ld   a,(hl)
    and  a
    jr   z,call_56EA
    inc  (hl)
call_56EA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_56E5
    ld   b,$10
    ld   hl,l_e275
call_56F5
    ld   a,(hl)
    and  a
    jr   z,call_56FA
    inc  (hl)
call_56FA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_56F5
    ret
call_5701
    ld   a,(l_e5c4)
    and  $1F
    //add  a,a

    call call_0D8E          ;A * 64 and into DE
    ld h,0
    ld l,a
    add hl,hl				;x2
	add hl,hl				;x4
	add hl,hl				;x8
	add hl,hl				;x16
	add hl,de				;total is now a x 80

    ld   de,$7608;$D500
    add  hl,de

    ld   b,$20
call_570C
;    call call_0D89     
    ld   (hl),$00
    inc  hl
    ld   (hl),$00
    inc hl
;    ld   a,$3F
    djnz call_570C
    ret
call_5719
    ld   e,$1A      ;rows in 1 player message (26)
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_572C
    ld   e,$8B      ;rows in 2 player message (139)
    ld   a,(l_e5db)
    and  a
    jr   z,call_572C
    ld   e,$8B      ;rows in real ending message (139)
call_572C
    ld   a,(l_e5c4)
    cp   e
    ret  nc         ;return with writing if row is beyond last message line
    ;break
    ld   a,bank1
    call call_026C
    ld   ix,(l_e734)
call_573A
    ;break
    ld   a,(ix+$00)
    inc  ix
    cp   $FF
    jr   z,call_576F
    ld   c,a*/
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
/*
    ld   a,(l_e5c4)         ;row?
    and $1F
    call call_0D8E          ;A * 64 and into DE
    ld h,0
    ld l,a
    add hl,hl				;x2
	add hl,hl				;x4
	add hl,hl				;x8
	add hl,hl				;x16
	add hl,de				;total is now a x 80

    ld   a,(ix+$00)         ;column
    inc ix
    add  a,a                ;* 2
    ld   e,a
    ld   d,0
    add  hl,de

    ld   de,$7608;$D500
    add  hl,de

    
    ld   b,(ix+$00)
    inc  ix
call_575E
    ld   a,(ix+$00)
    ld   (hl),a
    inc  hl
    inc  ix
    ld   (hl),c
    ;ld   a,$3F
    ;call call_0D89
    inc hl
    djnz call_575E
    jr   call_573A
call_576F
    ld   (l_e734),ix
    jp   call_029B
    */
call_5776
    ld   hl,l_e737
    ld   bc,$000B
    jp   clearbytes
call_577F
    ld   a,(l_e737)
    and  a
    ret  z
    ret  m
    ld   a,(l_e738)		;control var - 0=initial draw of Vs Box and Time
    bit  5,a
    ret  nz
    bit  0,a			;1= Update box
    jr   nz,call_57E4	;Draws the Vs Box, updates scores and timer
    bit  2,a
    jp   nz,call_58C4
    bit  3,a
    jp   nz,call_59A3
    bit  4,a
    jp   nz,call_59CF
    bit  1,a
    jr   nz,call_580D
    ld   a,$04
    call call_0008; $08
    ld   hl,l_e26d
    ld   bc,$0040
    call clearbytes;$0D50
    ld   hl,l_ed21
    ld   bc,$001C
    call clearbytes;0D50
    call call_0673
    ld   hl,l_e358
    ld   (hl),$01
    ld   c,$32
    call call_1350
    call call_5A0D	;Draws the Vs box
    call call_5A34  ;Draws the Vs scores

    ld   hl,l_e738
    ld   (hl),$01
    ld   hl,l_e741
    ld   (hl),$1E
    ld   hl,data_57DF
    ;ld   de,$D80E   ;TODO - screen loc
    ld   de,$7800			;write the 'TIME' message for the vs screen
    ld   c,$10		;red
    jp   call_0E9A;writetext;$0E9A


data_57DF
    BYTE $04,"TIME"
    
call_57E4
    call call_5A34	;Draws the Vs scores
    call call_5AD3	;Updates and draws the timer
    call call_6065	;Just does a ret
    ld   a,(l_e73c)
    and  a
    ret  z
    ld   hl,l_e73a
    ld   a,(hl)
    inc  hl
    add  a,(hl)
    inc  hl
    cp   (hl)
    ret  nz
    ld   hl,l_e73e
    ld   (hl),$01
    ld   hl,l_e738
    ld   (hl),$02
    ld   a,$05
    call call_0008;rst  $08
    ld   hl,l_f66b
    ld   (hl),$00
call_580D 
    ld   hl,l_e20d
    ld   bc,$0078
    call clearbytes;$0D50
    ;ld   hl,$C000       ;TODO - screen loc
    ;ld   bc,$0400
    ;call clearbytes;$0D50
    ld hl,pattern_addr
    ld   bc,$0100           ;clear both P1 and P2 bonus sprites
    call call_0D50
    ld hl,pattern_bank
    ld   bc,$0080           ;clear both P1 and P2 bonus sprites
flag_all_update
    ld   (hl),$02
    inc  hl
    dec  bc
    ld   a,c
    or   b
    jr   nz,flag_all_update
    /*ld hl,pattern_addr
    ld   bc,$0020           ;clear both P1 and P2 bonus sprites
    call call_0D50
    ld hl,pattern_addr+64
    ld   bc,$0020         
    call call_0D50
    ld hl,pattern_addr+128
    ld   bc,$0020         
    call call_0D50
    ld hl,pattern_addr+192
    ld   bc,$0020         
    call call_0D50

    ld hl,pattern_bank
    ld   bc,$0010           ;clear both P1 and P2 bonus sprites
    call call_0D50
    ld hl,pattern_bank+32
    ld   bc,$0010         
    call call_0D50
    ld hl,pattern_bank+64
    ld   bc,$0010         
    call call_0D50
    ld hl,pattern_bank+96
    ld   bc,$0010         
    call call_0D50*/
  
    ld   hl,l_e73d
    ld   (hl),$00
    call call_5A34
    ld   hl,l_e20d
    ld   de,$0000
    ld   b,$1E
    call call_18A5
    ld   de,data_5AEE   ;set the initial Y, X & gfx bank positions
    ld   hl,l_e20d
    ld   b,$1E
call_583A
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
    djnz call_583A
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,call_5882    ;skip if no player 1
    ld   hl,data_5B2A   ;'500 X'
    ld   bc,$031D
    ld   e,$00
    call call_14C0
    ld   a,(l_e73a)     ;P1 Vs score
    cp   $64
    jr   c,call_5863
    ld   a,$63
call_5863
    call call_1040      ;convert to BCD in B & C
    push bc
    ld   a,b            ;get 10s
    add  a,a
    add  a,a            ;x4
    add  a,$04          ;+4
    ld   b,a            ;set gfx offset to correct number gfx
    ld   c,$1D
    ld   a,$60
    call call_147D
    pop  bc
    ld   a,c            ;get 1s
    add  a,a
    add  a,a            ;x4
    add  a,$2C          ;+2c
    ld   b,a            ;set gfx offset to correct number gfx
    ld   c,$1D
    ld   a,$01
    call call_147D
call_5882
    ld   hl,l_e5d7
    bit  1,(hl)
    jr   z,call_58BE    ;skip if no player 2
    ld   hl,data_5B2A   ;'500 X'
    ld   bc,$0321
    ld   e,$01
    ld   d,$01
    call call_14C2
    ld   a,(l_e73b)     ;P2 Vs Score
    cp   $64
    jr   c,call_589F
    ld   a,$63
call_589F
    call call_1040
    push bc
    ld   a,b
    add  a,a
    add  a,a
    add  a,$04
    ld   b,a
    ld   c,$21
    ld   a,$02
    call call_147D      ;P2 10s
    pop  bc
    ld   a,c
    add  a,a
    add  a,a
    add  a,$2C
    ld   b,a
    ld   c,$21
    ld   a,$22
    call call_147D      ;P2 1s
call_58BE
    ld   hl,l_e738
    ld   (hl),$04
    ret
    
call_58C4
    ld   b,$0A          ;this raises both player bonus sprites (5 per player)
    ld   hl,l_e20d
call_58C9
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_58C9
    ld   a,(l_e20d)
    cp   $70           ;check if bonus message has reached final position
    ret  nz
    ld   hl,l_e738
    ld   (hl),$08
    ld   a,(l_e73e)
    and  a
    ret  z
    ld   iy,l_fc6e
    ld   de,$0017
    add  iy,de
    bit  0,(iy+$00)
    jr   call_58F0
    ex   (sp),hl		;protection
call_58F0
    ld   hl,l_e5d7
    bit  0,(hl)
    jr   z,call_594A    ;skip if no player 1
    ld   hl,l_e5d6
    ld   (hl),$00
    ld   de,$5000
    call call_2FB3
    ld   de,$5000
    ld   a,(l_e73a)
    ld   hl,l_e73b
    cp   (hl)
    jr   c,call_5923
    ld   de,$5000
    call call_2FB3
    ld   hl,data_5B2D   ;BYTE $68,$6C,$70,$74,$78,$7C,$80,$84,$88,$8C   'PERFECT 100000!!'
    ld   bc,$0A1D       ;10 sprites
    ld   e,$02          ;start at sprite 66
    ld   d,$02          ;so sprites 66,98,03,35,67.. etc
    call call_14C2
    jr   call_594A
call_5923
    ld   hl,data_5B2D   ;BYTE $68,$6C,$70,$74,$78,$7C,$80,$84,$88,$8C   'PERFECT 100000!!'
    ld   bc,$0A1D
    ld   e,$02
    ld   d,$02
    call call_14C2
    ld   hl,data_5B37   ;BYTE $8C,$90 '+5'
    ld   bc,$021E
    ld   d,$03
    ld   e,$03
    call call_14C2
    ld   hl,data_5B39   ;BYTE $EC,$F0,$F4 '0000!!'
    ld   bc,$031F
    ld   d,$01
    ld   e,$04
    call call_14C2
call_594A
    ld   hl,l_e5d7
    bit  1,(hl)
    ret  z          ;return if no player 2
;5950: 3A 02 00      ld   a,($0002)
;5953: FE 5E         cp   $5E
;5955: 28 02         jr   z,$5959
;5957: AF            xor  a
;5958: DF            rst  $18
    ld   hl,l_e5d6
    ld   (hl),$01
    ld   de,$5000
    call call_2FB3
    ld   a,(l_e73b)
    ld   hl,l_e73a
    cp   (hl)
    jr   c,call_597E
    ld   de,$5000
    call call_2FB3
    ld   hl,data_5B2D   ;BYTE $68,$6C,$70,$74,$78,$7C,$80,$84,$88,$8C   'PERFECT 100000!!'
    ld   bc,$0A21
    ld   e,$05
    jp   call_14C0
call_597E
    ld   hl,data_5B2D   ;BYTE $68,$6C,$70,$74,$78,$7C,$80,$84,$88,$8C   'PERFECT 100000!!'
    ld   bc,$0A21
    ld   e,$05
    call call_14C0
    ld   hl,data_5B37   ;BYTE $8C,$90 '+5'
    ld   bc,$0222
    ld   d,$01
    ld   e,$06
    call call_14C2
    ld   hl,data_5B39   ;BYTE $EC,$F0,$F4 '0000!!'
    ld   bc,$0323
    ld   d,$03
    ld   e,$06
    jp   call_14C2
call_59A3
    ld   hl,l_e73f
    inc  (hl)
    ld   a,(hl)
    cp   $96
    jr   z,call_59C4
    ld   a,(l_e73e)
    and  a
    ret  z
    ld   a,(l_e235)
    cp   $48
    ret  z
    ld   b,$14
    ld   hl,l_e235
call_59BC
    inc  (hl)
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_59BC
    ret

call_59C4
    ld   hl,l_e738
    ld   (hl),$10
    ld   hl,l_e73f
    ld   (hl),$00
    ret
call_59CF
    ld   b,$1E
    ld   hl,l_e20d
call_59D4
    ld   a,(hl)
    cp   $F0
    jr   z,call_59DA
    inc  (hl)
call_59DA
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    djnz call_59D4
    ld   hl,l_e73f
    inc  (hl)
    ld   a,(hl)
    cp   $B4
    ret  nz
    ld   hl,$77e8;D50E
    call call_03FD		;clear row
    ld   hl,l_ed3d
    ld   (hl),$00
    ld   hl,l_e738
    ld   (hl),$20
    ld   hl,l_e737
    ld   (hl),$FF
    ld   hl,l_e342
    ld   (hl),$01
    ld   hl,l_e358
    ld   (hl),$00
    ld   c,$30
    call call_1350
    ret

call_5A0D       ;Draws the Vs box
    ld   b,$08
    ld   e,$90
    ld   hl,$7710;$D008   screen loc
call_5A14
    ld   (hl),e
    inc  hl
    ld   (hl),$71;1D
    inc  e
	inc  hl
    ;ld   a,$3F
    ;call adda2hl;$0D89
    djnz call_5A14
    ld   b,$08
    ld   e,$9B
    ld   hl,$7760;$D00A
call_5A27
    ld   (hl),e
    inc  hl
    ld   (hl),$71;1D
    inc  e
	inc  hl
    ;ld   a,$3F
    ;call adda2hl;$0D89
    djnz call_5A27
    ret

call_5A34				;draws the Vs scores
    ld   a,(l_e73a)		;the score var for P1
    cp   $64			;most we can have is 99
    jr   c,call_5A3D	;so if greater
    ld   a,$63			;cap at 99
call_5A3D
    call call_1040		;create Binary Packed Decimal in BC
    ld   a,b
    or   a
    jr   nz,call_5A50
    ld   hl,$7712;$D048       ;screen loc - P1 10s position
    ld   e,$70;1D			;colour info
    ld   a,$60;A6				;blanker gfx if no 10s
    call call_5AC9
    jr   call_5A58
call_5A50
    ld   hl,$7712;$D048       ;screen loc - P1 10s position
    ld   e,$70;1D			;colour info
    call call_5AC7
call_5A58
    ld   a,c
    ld   hl,$7714;$D088       ;screen loc - P1 1s position
    ld   e,$70;$1D
    call call_5AC7
    ld   a,(l_e73b)			 ;score var for player 2
    cp   $64				;most we can have is 99
    jr   c,call_5A6A		;so if greater
    ld   a,$63				;cap at 99
call_5A6A
    call call_1040			;create Binary Packed Decimal in BC
    ld   a,b
    or   a
    jr   nz,call_5A7D
    ld   hl,$771A;$D148       ;screen loc - P2 10s position
    ld   e,$80
    ld   a,$60;A6				;blanker gfx if no 10s
    call call_5AC9
    jr   call_5A85
call_5A7D
    ld   hl,$771a;$D148       ;screen loc - P2 10s position
    ld   e,$80;21
    call call_5AC7
call_5A85
    ld   a,c
    ld   hl,$771c;$D188         ;screen loc - P2 1s position
    ld   e,$80;21
    call call_5AC7
    ld   hl,l_e73d
    inc  (hl)
    bit  4,(hl)
    ret  z
    ld   hl,(l_e73a)            ;p1 score in l, p2 score in h
    ld   a,l
    cp   h
    ret  z                      ;return if both scores are equal
    jr   c,call_5AB2            ;c = a < n, so branch if p1 score is lower than p2 score
    ld   hl,$7712;$D048       ;screen loc - P1 10s position
    ld   e,$70;1D
    ld   a,$60;A6				  ;blanking gfx
    call call_5AC9
    ld   hl,$7714;$D088       ;screen loc - P1 1s position
    ld   e,$70;1D
    ld   a,$60;A6				  ;blanking gfx
    call call_5AC9
    ret
call_5AB2
    ld   hl,$771a;$D148       ;screen loc - P2 10s position
    ld   e,$80
    ld   a,$60;A6				  ;blanking gfx
    call call_5AC9
    ld   hl,$771c;$D188       ;screen loc - P2 1s position
    ld   e,$80
    ld   a,$60;A6				 ;blanking gfx
    call call_5AC9
    ret
call_5AC7
    add  a,$61;A7
call_5AC9	
    ld   (hl),a				;draw top half of Vs score gfx
    inc  hl
    ld   (hl),e
    dec  hl
	push de
	ld de,$50
	add hl,de
	pop de
    add  a,$0B				;draw bottom half of Vs score gfx
    ld   (hl),a
    inc  hl
    ld   (hl),e
    ret

call_5AD3
    ld   hl,l_e740
    inc  (hl)
    ld   a,(hl)
    cp   $3C
    jr   c,call_5AE4
    ld   (hl),$00
    inc  hl
    ld   a,(hl)
    and  a
    jr   z,call_5AE4
    dec  (hl)
call_5AE4
    ld   a,(l_e741)
    ld   iy,$780c;$D98E   ;screen loc - the Vs timer
    jp   call_0FC2

data_5AEE
    BYTE $00,$28,$00,$38,$00,$48,$00,$58,$00,$68,$00,$90,$00,$A0,$00,$B0
    BYTE $00,$C0,$00,$D0,$F0,$28,$F0,$38,$F0,$48,$F0,$58,$F0,$68,$00,$28
    BYTE $00,$38,$00,$48,$00,$58,$00,$68,$F0,$90,$F0,$A0,$F0,$B0,$F0,$C0
    BYTE $F0,$D0,$00,$90,$00,$A0,$00,$B0,$00,$C0,$00,$D0
data_5B2A    
    BYTE $AC,$94,$98    ;'500 X'
data_5B2D    
    BYTE $68,$6C,$70,$74,$78,$7C,$80,$84,$88,$8C    ;'PERFECT 100000!!'
;data_5B2E
;    BYTE $6C,$70,$74,$78,$7C,$80,$84,$88,$8C
data_5B37    
    BYTE $8C,$90    ;'+5'
data_5B39
    BYTE $EC,$F0,$F4    ;'0000!!'

;	BYTE "call_53BC"
call_5B3C
    call call_0020
    call call_5B6E
    call call_6EEF
    call call_6755
    ld   a,(l_e5d3)
    and  a
    jr   nz,call_5B53
    ld   a,(l_e64b)
    cp   $63
    jr   nc,call_5B65
call_5B53
    call call_0020;rst  $20
    ld   a,(l_eb57)				;called by demo routine
    and  a
    jr   nz,call_5B60
    call call_5046
    call call_5C2B				;INTRO ERROR
call_5B60
    call call_6EF8
    jr   call_5B53
call_5B65    
    call call_0020;rst  $20
    call call_67B3
    call call_5C2B
    jr   call_5B65
call_5B6E
    ld   hl,l_e744
    ld   bc,$03E8
    call clearbytes;0D50
    ld   a,(l_e64b)
    cp   $63
    call nz,call_62FB

    ld   hl,l_f66f
    ld   bc,$0007
    call clearbytes;$0D50
    ld   hl,$0000
    ld   (l_f677),hl
    ld   hl,$0000
    ld   (l_f679),hl
    ld   e,$18
    ld   a,(l_e64b)
    cp   $63
    jr   nz,call_5B9F
    ld   e,$12
call_5B9F
    ld   hl,l_e76b
    ld   (hl),e
    ld   a,(l_e5a1)
    ld   (l_fc76),a
    ld   hl,l_e75c
    ld   (hl),$80
    ld   hl,l_e75d
    ld   (hl),$3C
    ld   de,l_e5be
    ld   hl,l_e745
    ld   c,$01
    call call_5C11
    inc  de
    ld   c,$02
    call call_5C11
    inc  de
    ld   c,$03
    call call_5C11
    inc  de
    ld   c,$04
    call call_5C11
    ld   ix,l_e76c
    xor  a
    ld   de,$0000
call_5BD8
    push af
    ld   (ix+$1d),a
    add  a,a
    add  a,a
    ld   hl,l_e20d
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
    jr   nz,call_5BFD
    ld   d,$00
    inc  e
call_5BFD
    inc  hl
    inc  hl
    ld   (hl),$12
    ex   de,hl
    ld   de,$0028
    add  ix,de
    ex   de,hl
    pop  af
    inc  a
    ld   hl,l_e76b
    cp   (hl)
    jr   nz,call_5BD8
    ret
call_5C11
    ld   a,(de)
    or   a
    ret  z
    ld   b,a
call_5C15
    ld   (hl),c
    inc  hl
    djnz call_5C15
;    exx
;    ld   b,$03
;    xor  a
;    ld   hl,data_0000
;call_5C20
;    add  a,(hl)
;    inc  hl
;    djnz call_5C20
;    sub  $3E
;    jr   $5C29
;    ex   (sp),hl
;call_5C29
;    exx
    ret


call_67B3                   ;level 100 boss!
    ld   a,(l_ed3d)
    and  a
    jr   nz,call_67EA
    ld   hl,l_eb36
    bit  5,(hl)
    jr   nz,call_67C7
    ld   hl,l_eb46
    bit  5,(hl)
    jr   z,call_67CA
call_67C7
    call bank0_call_B8D3    ;cycle heart palette
call_67CA
    ;break
    ld   a,(l_e5d7)
    cp   $03
    jr   nz,call_67EA
    ld   a,(l_f446)     ;last row from crumbling wall routine
    cp   $20
    jr   nz,call_67EA
    ld   hl,l_eb43
    bit  0,(hl)
    jr   nz,call_67E7
    ;break
    call bank0_call_B3AF        ;reprint the starfield?
    ld   hl,l_eb43
    set  0,(hl)
call_67E7
    ld   a,introbank;$01      ;switch bank
    call call_026C
    call intro_call_B732
    call call_029B     ;restore bank
call_67EA
    ld   a,introbank      ;switch bank
    call call_026C
    ld   ix,l_eb36
    ld   b,$02
	call intro_call_67F0
	call call_029B     ;restore bank
    ret


call_6EEF
    ld   hl,l_eb56
    ld   bc,$0043
    jp   clearbytes;$0D50

    
call_79E9
    ld   hl,l_eb99
    ld   bc,$0090
    call clearbytes;$0D50
    ld   a,(l_ed41)
    and  a
    ret  z
    ld   ix,l_eb99
    xor  a
call_79FC
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
    ld   de,$0012
    add  ix,de
    pop  af
    inc  a
    ld   hl,l_ed41
    cp   (hl)
    jr   nz,call_79FC
    ret

call_7A27
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $7A35
;    push ix
    ld   a,(l_ed41)
    and  a
    ret  z
    ld   ix,l_eb99
    ld   hl,l_efa1
    xor  a
call_7A42
    push af
    push hl
    ld   a,(l_f44e)
    and  a
    jp   nz,call_7B61
    call bank0_call_8879
    bit  0,(ix+$00)
    jp   nz,call_7ABA
    ld   a,$18
    call adda2hl;$0D89
    ld   a,(hl)
    bit  3,a
    jp   z,call_7B75
    pop  hl
    push hl
    ld   a,$08
    call adda2hl;$0D89
    ld   a,(hl)
    ld   (ix+$07),a
    ld   (ix+$08),a
    dec  hl
    push hl
    call bank0_call_918F
    pop  hl
    jr   z,call_7A7D
    ld   (hl),$01
    inc  hl
    ld   (hl),$01
    jr   call_7A82
call_7A7D
    ld   (hl),$03
    inc  hl
    ld   (hl),$03
call_7A82
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
    ld   a,(de)
    ld   (hl),a
    pop  hl
    push hl
    ld   a,$0C
    call adda2hl;$0D89
    ld   a,(hl)
    add  a,$0A
    cp   $1E
    ld   (ix+$0c),a
    jr   c,call_7AAC
    ld   (ix+$0c),$1E
call_7AAC
    ld   a,(ix+$0a)
    ld   b,$00
    ld   c,$33
    call call_147D
    set  0,(ix+$00)
call_7ABA
    call loadhl2;$1537
    call bank0_call_8838
    ld   a,(l_fc7a)
    and  a
    jp   nz,call_7B75
    bit  6,(ix+$00)
    jp   nz,call_7B61
    ld   a,(ix+$07)
    ld   hl,data_7B8C
    call call_0DA7
    ex   de,hl
    jp   (hl)
call_7AD9
    ld   a,(ix+$0d)
    or   a
    jp   z,call_7B1E
    ld   b,a
call_7AE1
    push bc
    call loadhl2;$1537
    call bank0_call_879A
    jr   z,call_7AF6
    call loadhlfromspritestruct;1529
    inc  hl
    inc  hl
    dec  (hl)
    pop  bc
    djnz call_7AE1
    jp   call_7B1E
call_7AF6
    pop  bc
    call resetframetimer;call_1556
    set  6,(ix+$00)
    jp   call_7B75
call_7B01
    ld   a,(ix+$0d)
    or   a
    jp   z,call_7B1E
    ld   b,a
call_7B09
    push bc
    call loadhl2;$1537
    call bank0_call_87AC
    jr   z,call_7AF6
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    inc  (hl)
    pop  bc
    djnz call_7B09
    jp   call_7B1E
call_7B1E
    inc  (ix+$10)
    ld   a,(ix+$05)
    cp   $05
    jr   z,call_7B37
    ld   de,$0406
    ld   a,(l_e349)
    and  a
    jr   z,call_7B34
    ld   de,$0206
call_7B34
    call frametimer;$15CA
call_7B37
    ld   b,a
    ld   a,$05
    sub  b
    add  a,a
    add  a,a
    ld   b,a
    ld   a,$4C
    bit  3,(ix+$10)
    jr   nz,call_7B48
    ld   a,$64
call_7B48
    add  a,b
    ld   b,a
    ld   c,$1E
    ld   a,(ix+$0a)
    bit  1,(ix+$07)
    jr   z,call_7B5B
    call call_147D
    jp   call_7B75
call_7B5B
    call call_149C
    jp   call_7B75
call_7B61
    ld   (ix+$00),$00
    pop  hl
    push hl
    ld   a,$18
    call adda2hl;$0D89
    res  3,(hl)
    call call_154C
    ld   hl,l_f05e
    inc  (hl)
call_7B75
    ld   de,$0012
    add  ix,de
    pop  hl
    ld   a,$1B
    call adda2hl;$0D89
    ex   de,hl
    pop  af
    inc  a
    ld   hl,l_ed41
    cp   (hl)
    ex   de,hl
    jp   nz,call_7A42
    ret

data_7B8C
    BYTE LOW call_7B1E,HIGH call_7B1E
    BYTE LOW call_7B01,HIGH call_7B01
    BYTE LOW call_7B1E,HIGH call_7B1E
    BYTE LOW call_7AD9,HIGH call_7AD9
    
call_7B94
    bit  1,(ix+$0e)
    ret  z
    call bank0_call_91B9
    ret  z
    ld   hl,l_fc2b
    ld   a,(ix+$09)
    add  a,a
    add  a,a
    add  a,a
    call adda2hl;$0D89
    push hl
    call bank0_call_91A6
    ld   a,(hl)
    cp   $08
    pop  hl
    ;nop
    ;nop				;enemy fire routine nopped out in bobbob bootleg?????
	jr c,call_7BB6		;I've reinstated - let's see what happens!
    xor  a
    or   a
    ret
;IF 0
call_7BB6
    inc  hl
    inc  hl
    call bank0_call_91A6
    ld   a,(hl)
    cp   $40
    jr   nc,call_7BC3
    xor  a
    or   a
	ret
call_7BC3
	bit  1,(ix+$08)
    jr   z,call_7BE3
    ld   a,(ix+$02)
    sub  $0A
    ld   h,a
    ld   a,(ix+$01)
    call call_174C		;get map data at location HL
    ret  z
    ld   a,(ix+$02)
    sub  $13			
    ld   h,a
    ld   a,(ix+$01)
    call call_174C		;get map data at location HL (for enemy projectile?)
    ret
call_7BE3
    ld   a,(ix+$02)
    add  a,$08
    ld   h,a
    ld   a,(ix+$01)
    call call_174C		;get map data at location HL
    ret  z
    ld   a,(ix+$02)
    add  a,$10
    ld   h,a
    ld   a,(ix+$01)
    call call_174C		;get map data at location HL
    ret
;ENDIF
call_7BFD
;    ld   hl,$044D
;    ld   de,($0B2E)
;    or   a
;    sbc  hl,de
;    jr   $7C0B
;    push ix
    bit  0,(ix+$0e)
    jp   nz,call_7CEE
    bit  2,(ix+$0e)
    jr   z,call_7C72
    call bank0_call_86BD
    inc  hl
    ld   a,(hl)
    ld   b,a
    sub  $0A
    jr   nc,call_7C60
    dec  hl
    set  6,(hl)
    ld   hl,l_ed3d
    dec  (hl)
    ld   hl,l_e5ee
    inc  (hl)
    set  2,(ix+$0e)
    set  0,(ix+$0e)
    call loadhlfromspritestruct;$1529
    ld   (hl),$E0
    inc  hl
    inc  hl
    ld   a,(ix+$09)
    call mul16;$0D6D
    ld   b,a
    ld   a,(hl)
    cp   $90
    ld   a,b
    jr   nc,call_7C4E
    add  a,$50
    ld   (hl),a
    jr   call_7C51       ;7C4C
call_7C4E
    add  a,$80
    ld   (hl),a
call_7C51
    call bank0_call_86BD
    ld   (hl),$08
    inc  hl
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$15),a
    ld   (hl),$00
    ret
call_7C60
    inc  hl
    ld   a,(hl)
    inc  hl
    ld   (hl),$00
    call loadhlfromspritestruct;$1529
    ld   (hl),b
    inc  hl
    inc  hl
    ld   (hl),a
    call loadhl2;call_1537
    jp   call_7E8C
call_7C72
    ld   (ix+$0e),$00
    call loadhlfromspritestruct;$1529
    inc  hl
    inc  hl
    ld   a,(hl)
    cp   $18
    jr   nc,call_7C86
    ld   (ix+$08),$01
    jr   call_7C8E
call_7C86
    cp   $E8
    jr   c,call_7C8E
    ld   (ix+$08),$03
call_7C8E
    inc  hl
    ld   (hl),$13
    ld   a,(ix+$09)
    ;break
    ld   hl,bank0_data_80C9 ;address table for enemy death patterns
    call call_0DA7
    bit  4,(ix+$00)
    jr   z,call_7CA5
    ;break
    ld   de,bank0_data_808D ;death from invincible dragon calla this but is replace by 7cb0
    jr   call_7CB0
call_7CA5
    bit  6,(ix+$00)
    jr   z,call_7CB0
    ;break
    ld   de,bank0_data_80B6     ;death by big lightning, fireballxxaaaa
    jr   call_7CB0
call_7CB0
    ld   a,(l_f518)
    and  a
    jr   z,call_7CB9
    ;break
    ld   de,bank0_data_8064     ;death from invincible dragon
call_7CB9
    ld   (ix+$10),e
    ld   (ix+$11),d
    inc  de
    ld   a,(de)
    ld   (ix+$13),a
    ld   b,$00
    ld   c,$24
    ld   a,(ix+$0a)
    call call_147D
    call resetframetimer;$1556
    ld   (ix+$12),a
    ld   (ix+$0d),a
    ld   (ix+$0b),a
    ld   (ix+$14),a
    set  0,(ix+$0e)
    call bank0_call_86BD
    inc  hl
    inc  hl
    inc  hl
    ld   a,(hl)
    ld   (ix+$15),a
    ld   (hl),$00
    ret
call_7CEE
    call loadhl2;$1537
    call bank0_call_86A8
    bit  1,(ix+$0e)
    jp   nz,call_7F4B
    bit  5,(ix+$0e)
    jr   z,call_7D0F
    inc  (ix+$14)
    ld   a,(ix+$14)
    sub  $3C
    jp   c,call_7F30
    jp   nc,call_7F53
call_7D0F
    bit  4,(ix+$0e)
    jp   nz,call_7F04
    bit  3,(ix+$0e)
    jr   z,call_7D3D
    dec  (ix+$16)
    jp   nz,call_7E8C
    inc  (ix+$14)
    ld   a,(ix+$14)
    cp   $08
    jr   nc,call_7D33
    ld   (ix+$16),$3C
    jp   call_7E8C
call_7D33
    set  1,(ix+$0e)
    call resetframetimer;$1556
    jp   call_7E8C
call_7D3D
    bit  2,(ix+$0e)
    jp   nz,call_7E45
    bit  1,(ix+$08)
    jp   z,call_7DD1
    ld   a,(ix+$02)
    sub  $18
    jr   nc,call_7D71
    ld   (ix+$08),$01
    ld   a,(ix+$09)
    ld   hl,bank0_data_8160
    call call_0DA7
    ld   (ix+$10),e
    ld   (ix+$11),d
    inc  de
    ld   a,(de)
    ld   (ix+$13),a
    ld   (ix+$12),$00
    jp   call_7E8C
call_7D71
    bit  6,(ix+$0e)
    jr   z,call_7DC4
    ld   a,(ix+$01)
    and  $07
    jr   nz,call_7DAA
    ld   a,(ix+$01)
    ld   h,(ix+$02)
    call call_174C
    jr   z,call_7DAA
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_7DAA
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_7DAA
    call call_1676
    jr   z,call_7DB1
call_7DAA
    call loadhlfromspritestruct;1529
    dec  (hl)
    jp   call_7E8C
call_7DB1
    call bank0_call_86BD
    ld   (hl),$08
    set  3,(ix+$0e)
    call resetframetimer;$1556
    ld   (ix+$16),$3C
    jp   call_7E8C
call_7DC4
    call call_7F79
    jp   nz,call_7E8C
    set  6,(ix+$0e)
    jp   call_7E8C
call_7DD1
    ld   a,(ix+$02)
    sub  $E8
    jr   c,call_7DF7
    ld   (ix+$08),$03
    ld   a,(ix+$09)
    ld   hl,bank0_data_8160
    call call_0DA7
    ld   (ix+$10),e
    ld   (ix+$11),d
    inc  de
    ld   a,(de)
    ld   (ix+$13),a
    ld   (ix+$12),$00
    jp   call_7E8C
call_7DF7
    bit  6,(ix+$0e)
    jr   z,call_7E38
    ld   a,(ix+$01)
    and  $07
    jr   nz,call_7E31
    ld   a,(ix+$01)
    ld   h,(ix+$02)
    call call_174C
    jr   z,call_7E31
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_7E31
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_7E31
    call call_1676
    jp   z,call_7DB1
call_7E31
    call loadhlfromspritestruct;$1529
    dec  (hl)
    jp   call_7E8C
call_7E38
    call call_7F79
    jp   nz,call_7E8C
    set  6,(ix+$0e)
    jp   call_7E8C
call_7E45
    ld   a,(ix+$01)
    cp   $D0
    and  $07
    jr   nz,call_7E7A
    ld   a,(ix+$01)
    ld   h,(ix+$02)
    call call_174C
    jr   z,call_7E7A
    ld   a,(ix+$02)
    sub  $07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_7E7A
    ld   a,(ix+$02)
    add  a,$07
    ld   h,a
    ld   a,(ix+$01)
    call call_174C
    jr   z,call_7E7A
    call call_1676
    jr   z,call_7E80
call_7E7A
    call loadhlfromspritestruct;$1529
    dec  (hl)
    jr   call_7EAB
call_7E80
    call bank0_call_86BD
    ld   (hl),$08
    set  3,(ix+$0e)
    call resetframetimer;$1556
call_7E8C
    bit  3,(ix+$0e)
    jr   nz,call_7EAB
    ld   de,$0504
    call frametimer;$15CA
    add  a,a
    add  a,a
    ld   b,a
    ld   a,(ix+$17)
    ld   hl,bank0_data_801F
    call adda2hl;$0D89
    ld   a,(hl)
    add  a,b
    ld   b,a
    ld   c,$1C
    jr   call_7EB6
call_7EAB
    ld   a,(ix+$15)
    ld   hl,bank0_data_8009
    call call_0DA7
    ld   b,e
    ld   c,d
call_7EB6
    ld   a,(ix+$0a)
    bit  1,(ix+$08)
    jr   z,call_7EC4
    call call_147D
    jr   call_7EC7
call_7EC4
    call call_149C
call_7EC7
    bit  0,(ix+$0e)
    ret  z
    call bank0_call_86BD
    inc  hl
    inc  hl
    inc  hl
    ld   a,(hl)
    and  a
    ret  z
    jp   m,call_7EDF
    ld   b,$00
    ld   (ix+$0f),b
call_7EDD
    jr   call_7EE4
call_7EDF
    ld   b,$01
    ld   (ix+$0f),b
call_7EE4
    dec  hl
    dec  hl
    dec  hl
    ld   hl,l_e5e8
    inc  (hl)
    ld   a,b
    ld   (l_e5d6),a
    ld   a,(ix+$15)
    ld   hl,bank0_data_8032
    call call_0DA7
    call call_2FB3
    ld   c,$11
    call call_1350
    set  4,(ix+$0e)
call_7F04
    inc  (ix+$0b)
    ld   b,$04
    ld   a,(ix+$0b)
    cp   b
    jp   c,call_7F30
    inc  (ix+$0d)
    ld   a,(ix+$0d)
    sub  $1E
    jr   c,call_7F28
    set  5,(ix+$0e)
    ld   (ix+$14),$00
    ld   hl,l_ed47
    dec  (hl)
    jr   call_7F30
call_7F28
    ld   (ix+$0b),$00
    call loadhlfromspritestruct;$1529
    inc  (hl)
call_7F30
    ld   a,(ix+$15)
    ld   hl,bank0_data_8027
    call adda2hl;$0D89
    ld   b,(hl)
    ld   c,$1E
    bit  0,(ix+$0f)
    jr   z,call_7F44
    ld   c,$22
call_7F44
    ld   a,(ix+$0a)
    call call_147D
    ret
call_7F4B
    ld   de,$1403
    call frametimer;$15CA
    jr   nz,call_7F68
call_7F53
    call bank0_call_86BD
    ld   (hl),$00
    ld   (ix+$0e),$00
    ld   (ix+$00),$00
    set  3,(ix+$00)
    call call_154C
    ret
call_7F68
    add  a,a
    add  a,a
    call call_1570
    add  a,$BC
    ld   b,a
    ld   c,$22
    ld   a,(ix+$0a)
    call call_147D
    ret
call_7F79
    ld   l,(ix+$10)
    ld   h,(ix+$11)
    ld   a,(hl)
    cp   $99
    ret  z
    or   a
    jr   z,call_7F90
    bit  1,(ix+$08)
    jr   z,call_7F90
    ld   b,a
    ld   a,$20
    sub  b
call_7F90
    call call_109C
    ld   a,(ix+$12)
    call adda2de;$0D84
    ld   a,(de)
    ld   b,a
    call loadhlfromspritestruct;$1529
    bit  0,b
    jr   z,call_7FAE
    bit  3,b
    jr   nz,call_7FAB
    call call_7FE7
    jr   call_7FAE
call_7FAB
    call call_7FF8
call_7FAE
    bit  4,b
    jr   z,call_7FC0
    inc  hl
    inc  hl
    bit  7,b
    jr   nz,call_7FBD
    call call_7FE7
    jr   call_7FC0
call_7FBD
    call call_7FF8
call_7FC0
    inc  (ix+$12)
    inc  de
    ld   a,(de)
    cp   $88
    jr   z,call_7FCA
    ret
call_7FCA
    ld   (ix+$12),$00
    dec  (ix+$13)
    ret  nz
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
call_7FE7
    inc  (hl)
    ld   a,(hl)
    and  $07
    ret  z
    inc  (hl)
    ld   a,(hl)
    and  $07
    ret  z
    bit  4,(ix+$00)
    ret  z
    inc  (hl)
    ret
call_7FF8
    dec  (hl)       ;dying enemy falls
    ld   a,(hl)
    and  $07
    ret  z
    dec  (hl)
    ld   a,(hl)
    and  $07
    jp bank0_call_8001    



/*
createscore
    ld bc,$303b
    ld a,50
    out (c),a
    ld bc,$0055
    ld hl,scoreline1
    ld d,0
cscoreloop1
    ld a,(hl)
    out (c),a
    inc hl
    dec d
    jr nz,cscoreloop1
    
    ld bc,$0053
    ld a,255
    out (c),a
    
    ld bc,$0057
    ld a,240
    out (c),a
    ld a,0
    out(c),a
  ;  ld a,%10000000
    out(c),a
    ld a,128+50
    out(c),a
    ld a,72
    out (c),a
    ld a,0
    out(c),a
  ;  ld a,%10000000
    out(c),a
    ld a,128+50
    out(c),a
    
    ret
*/
    
    

clearscreen
	ret
    ld hl,$7600
    ld de,$7601
    ld bc,$9ff
    ld (hl),0;64+24;0;128+64  ;bright black for transparency
    ldir
    ;ld hl,$4000
    ;ld de,$4001
    ;ld bc,$1800-1
    ;ld (hl),0
    ;ldir
    ret
    
writetext			;0E9A
	ret

plotletter
    ret
    
killsprites
	nextreg $34,0				;set sprite number to 0
    ld b,128
killspritesloop
    nextreg $38,$40					;set attr 3 make sprite invisible for now
	nextreg $79,$80					;set attr 4 and increment sprite pointer
    djnz killspritesloop	;repeat for all 128 sprites
	
	;now load the extend bubbles into sprites
	ld bc,$303B
	ld a,EXTEND_FIRST_SPRITE_P1>>1
	out (c),a
	ld a,EXTEND_FIRST_SPRITE_P1;112			;starting sprite number
	nextreg $34,a
	ld bc,$0218			;b=2 we need to copy 2 lots of 6 sprites
copy_extend_loop1
	push bc
	ld de,$E080			;start of EXTEND gfx
	ld bc,$0668			;b=6 we need to copy 6 sprites each time
	
copy_extend_loop2
	push bc
	
	ld l,0
	push de
	call copysprite
	pop hl
	ld de,$0080
	add hl,de
	ex de,hl
	pop bc
	ld a,c
	nextreg $76,a
	add a,$10
	ld c,a
	djnz copy_extend_loop2
	
	ld bc,$303B
	ld a,EXTEND_FIRST_SPRITE_P2>>1
	out (c),a
	ld a,EXTEND_FIRST_SPRITE_P2			;starting sprite number
	nextreg $34,a
	
	pop bc
	djnz copy_extend_loop1
    ret
	

copysprite				;copies sprite pattern from gfx roms banks to internal spritesheet
						;L contains bank number
						;DE contains sprite address within bank
						
	ld a,gfxbank00
	add a,l
    call call_026C
    
	ld bc,$0020
	ld h,d
	ld l,e
	add hl,bc
	ex de,hl
	
;    ld bc,$005B
    
	ld b,2		;2 x 64 byte to copy
tempspriteloop3
	push bc
	ld b,8		;8 x 8 bytes to copy
tempspriteloop
	push bc
    ld b,4      ;4 bytes to copy
tempspriteloop1
    ld a,(hl)
    out ($5b),a
    inc hl    
    djnz tempspriteloop1
    ld b,4      ;4 bytes to copy
tempspriteloop2
    ld a,(de)
    out ($5b),a
    inc de
    djnz tempspriteloop2
	
	pop bc
	djnz tempspriteloop
	
	ld bc,$20
	add hl,bc
	ex de,hl
	add hl,bc
	ex de,hl
	pop bc
	djnz tempspriteloop3
    jp call_029B    


setinterrupt
 ; Setup the 128 entry vector table
    di
    ld            hl, $be00;IM2Table
    ld            de, $be01;IM2Table+1
    ld            bc, 256
    ; Setup the I register (the high byte of the table)
    ld            a, h
    ld            i, a
    ; Set the first entries in the table to $bf
    ld            a, $bf
    ld            (hl), a
    ; Copy to all the remaining 256 bytes
    ldir
    
    ;put IM2 routine at $bfbf to call myinterrupt
    ld hl,$bfbf 
    ld (hl),$f3      ;DI
    inc hl
    ld (hl),$cd      ;call
    inc hl
    ld a,LOW myinterrupt
    ld (hl),a
    inc hl
    ld a,HIGH myinterrupt
    ld (hl),a
    ;inc hl           ;set address   
    ;ld (hl),$fb      ;EI
    ;inc hl
    ;ld (hl),$ed      ;extend
    ;inc hl
    ;ld (hl),$4d      ;reti
    inc hl
    ld (hl),$c9      ;ret
    ; Setup IM2 mode
    im 2
    ret

myinterrupt
	push iy
    push ix
    push hl
    push bc
    push de
    push af
	
	ld a,(l_e1cb)
	ld (int_membackup),a
	ld a,(l_e1cc)
	ld (int_membackup+1),a
	
	ld a,(l_e1cd)		;scroll pos tilemap
	nextreg $31,a

    ld a,(l_e2f5)       ;scroll pos Layer 2
    nextreg $17,a
	
   ; nextreg $43,%10110000
   ; nextreg $40,$0f
   ; nextreg $41,$e0
   ; nextreg $4C,$00
    call spriteupdate
   ; nextreg $40,$0f
   ; nextreg $41,$e0
   ; nextreg $4C,$0F
	
    ld hl,l_f66e;   slave frame counter   
    inc (hl)
    call slave_map_decode		;call 00A9
	ld a,slavebank
    call call_026C_DI  ;switch bank

    call slave_getinput
  ;  break
    ld a,(music_playing)
    call slave_ay_music              ;music interrupt

	call slave_call_02E0
	ld   a,(l_f66b) ;control byte...
    cp   $49
    jp   nz,interruptexit
	call slave_call_01B9
	call slave_call_0266
	call slave_call_03BB
	call slave_call_08F0
	call slave_call_0A30
	call slave_call_0A67
	call slave_call_0C46
	call slave_call_0BCF
	call slave_call_0A9E
	call slave_call_0B4C
	call slave_call_0C79
	call slave_call_0CA6
	call slave_call_0CCE
	call slave_call_0B98
	;call slave_call_0190  ;TODO - maybe implement -just seems like protection
interruptexit
	
	call call_029B_DI  ;restore bank
	
	
	ld a,(int_membackup)
	ld (l_e1cb),a
	ld a,(int_membackup+1)
	ld (l_e1cc),a
	
	
    pop af
    pop de
    pop bc
    pop hl
    pop ix
	pop iy
    ret  

int_membackup
	BYTE $00,$00

slave_map_decode ;extra code to select correct 16k level bank
     ld   a,(l_e397)	;this byte set to 1 if new map to be drawn
     and  a
     ret  z	;if zero no map update
     ret  m	;if >=128 no map update
     ld   a,(levelnum)
     cp   $33    ;check which level bank we need (0 - 50, or 51 to 101)
     jr c,slave_map_decode_0to50
     ld a,secondlevelsbank
     call call_026C_DI  ;switch bank
     call second_levels_decode
     jp call_029B_DI  ;restore bank
slave_map_decode_0to50
     ld a,firstlevelsbank
     call call_026C_DI  ;switch bank
     call first_levels_decode
     jp call_029B_DI  ;restore bank
	 
     
spriteupdate
	

	ld ix,l_e20d
	;ld iy,sprite_attr

	ld b,$4a
sprite_update_loop
	ld a,b
	nextreg $34,a			;selected sprite
	push bc
    ld a,(ix+$2)		;xpos
	bit 6,(ix+$3)		;test whether x axis is reversed
	jr nz,sprite_flip_x_axis
	add a,32
	;ld (iy+0),a		;done
	nextreg $35,a			;set x position
	ld a,0
	adc a,0
	ld (attr2),a
	jr sprite_noflip_x_axis
sprite_flip_x_axis
	sub $e0				;flip x axis
	;ld (iy+0),a		;done
	nextreg $35,a			;set x position
	ld a,0
	adc a,0
	ld (attr2),a		;done
	;ld (iy+1),a
	;add a,8
sprite_noflip_x_axis    
    ld a,(ix+$0)		;ypos
	add a,24
    neg

	;ld (iy+2),a		;done
	nextreg $36,a			;set y position
	
	ld a,(ix+$1)		;pattern
	and $7f
	
;	out (DMA_SPR_NO4),a			;set the sprite pattern DMA address
	
	ld e,a		;store in DE
	
	
	;code to generate pattern number in Next format
	;ld a,e          ;unneccesary
	rrca				;move 6 msbs into bits 5 to 0 and get lsb into bit 7 (from bit 0)
	ld d,a
	ld bc,$303b			;and write to pattern select register
    out (c),a
	and $3f
	or $40				;add visible and extended attributes
	;ld (iy+4),a		;done
	ld (attr2+2),a		;store for now
	;nextreg $38,a			;write to sprite attributes
	
	ld a,d				;retrieve partially rotated pattern number
	rrca				;get lsb into bit 6
	and $40				;isolate low bit of pattern
	or $80				;set 4 bit mode
	nextreg $39,a			;write to sprite attributes
	ld d,0
	ld hl,pattern_bank
	add hl,de	
	ld a,(hl)			;get our flip and palette info
	bit 1,a
	jr z,sprite_noupdate
	and $fd
	ld (hl),a		;set update flag to 0
	;ld (sprite_attr+($3e*$8)+5),a
	ld (attr2+1),a
	;ld (iy+5),a
	
	ex de,hl
	add hl,hl	;double it as we are indexing a 16 bit table next
	ld de,pattern_addr
	add hl,de	;we now have the correct position in the address table
	ld e,(hl)		;get low byte
	inc hl
	ld d,(hl)		;get high byte
	ld a,e
	or d
	jr z,hiddensprite
	ld a,(attr2+2)
	or $80
	ld (attr2+2),a
hiddensprite
	
	;ld h,a          ;temp storage
    ld l,d
;	and $01
;	jr z,nobankadj
;	set 7,d			;adjust mid byte for banking
;nobankadj
	;ld a,e
;	out (DMA_CPU_LO),a
    ;DE contains offset with 32k gfx bank (arcade gfx banks are 32k ours are 16k!)
	ld a,d
	and $3f
	add a,$c0
	ld d,a		;de is now points to a 16k bank located at $c000
;	out (DMA_CPU_MD),a
	
    ld a,(ix+$03)	;finally get the gfx bank number
    ld h,a              ;bank number
	sla	h				;and move into bits 4-1
	ld a,l
	rlca
	rlca
	and 1
	ld l,a
	ld a,h
	and $1e
	or l
	add a,a
	ld l,a		;l now contains which gfx bank to use
				;and de containts the offset within the bank
	
	;add a,$04			;temp - this is the high address of gfxbank 0
	;ld hl,$40000gfxbank00*8192
	;ld a,$05
;	out (DMA_CPU_HI),a
;	ld a,$00					;high byte clear for pattern copy
;	out (DMA_LEN_HI),a
	
;	ld a,$80					;copy 128 bytes (set to required value)
;	out (DMA_LEN_LO_A),a		;write here starts the transfer - alt/arcade mode - memory is rearrange from 8 bit tiles to 16 bit sprites
    
;    ld a,1
	call copysprite
    ;ld (sprite_attr+($3e*$8)+6),a
	;ld (iy+6),a
	ld a,(attr2)
	ld d,a
	ld a,(attr2+1)
	or d
	nextreg $37,a
	ld a,(attr2+2)
	nextreg $38,a
sprite_noupdate
	

	ld de,$0004
	add ix,de
;	ld de,$0008
;	add iy,de
	pop bc
	dec b
	jp nz,sprite_update_loop
		
;	ld a,$83					;and copy 1024 bytes (high byte set) and flag attr copy using bit 7
;	out (DMA_LEN_HI),a
	;ld hl,sprite_attr
;	ld a,sprite_attr >> 8
;	out (DMA_CPU_MD),a		;We want to copy from CPU memory location 0
;	ld a,sprite_attr AND 8
;	out (DMA_CPU_LO),a
;	ld a,$0
;	out (DMA_CPU_HI),a
	
;	out (DMA_ATTR_LO),a
;	out (DMA_ATTR_HI),a
;	ld a,$ff				;and copy 16384 bytes (low byte set)
;	out (DMA_LEN_LO),a   ;This also starts the DMA Transfer
	
	;ld a,0
	;out (PAL_VAL_HI),a
	;ld a,0
	;out (PAL_VAL_LO),a
	;out (PAL_WRITE),a
    
    ret
    
attr2
	BYTE 0,0,0

music_playing
    BYTE 0

music_module
    BYTE 0,0

options_control         ;controls whether the options screen can be displayed
    BYTE 0

    
;     BYTE "END OF INTERRUPT"    
;framecounter BYTE m0

 ;   org $8000
    
mapstart
;    incbin "map.asm"  ;level data
;    include "screens.asm"  
;    include "tiles.asm"


 ;   include "sprites.asm"
  ;  include "scores.asm"
Sprite1

scoreline1
    
    
;slave_0068
;     ld   hl,l_f66e
;     inc  (hl)
;     ret    
/*
screentable
    BYTE $00,$40
    BYTE $20,$40
    BYTE $40,$40
    BYTE $60,$40
    BYTE $80,$40
    BYTE $A0,$40
    BYTE $C0,$40
    BYTE $E0,$40
    BYTE $00,$48
    BYTE $20,$48
    BYTE $40,$48
    BYTE $60,$48
    BYTE $80,$48
    BYTE $A0,$48
    BYTE $C0,$48
    BYTE $E0,$48
    BYTE $00,$50
    BYTE $20,$50
    BYTE $40,$50
    BYTE $60,$50
    BYTE $80,$50
    BYTE $A0,$50
    BYTE $C0,$50
    BYTE $E0,$50
*/
    BYTE "END OF CODE"

    CSPECTMAP "game.map"

    ; write everything into NEX file
    ;SAVENEX OPEN "game.nex", mainstart, l_f7fe, 0  
    SAVENEX OPEN "game.nex", mainstart, $FFFE, 9  ; stack will go into Layer2
    SAVENEX CORE 2, 0, 0        ; Next core 2.0.0 required as minimum
    SAVENEX CFG 3, 1           ; green border, Close file once done
    SAVENEX BAR 1, $E0, 50,25  ; do load bar, red colour, start/load delays 50/25 frames
    ;SAVENEX SCREEN L2 0, 0      ; store the data from C000 (page 0, offset 0), no palette
    SAVENEX AUTO                ; store all appropriate banks
    SAVENEX CLOSE               ; (banks 100 and 101 are added just as example)


    ;END codestart

    ORG $FFFE
stack_top