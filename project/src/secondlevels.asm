    org $c000

    ld   a,(l_e397)	;slave_newmap this byte set to 1 if new map to be drawn
    and  a
    ret  z	;if zero no map update
    ret  m	;if >=128 no map update
second_levels_decode
    ld   a,(levelnum)
    sub  $33           ;need to subtract 51 as this bank only has levels 51 to 101
    ld   e,a
    ld   d,$00
    ld   bc,$0120
    call s_calclevel	;return with level offset in HL (levelnum * 288)
    ld   de,sleveldata ;add base address
    add  hl,de
    ld   de,l_e3e8	;destination address
    ex   de,hl
    ld   a,(de)		;load first byte
    ld   ix,$0180	;32 nibbles x 24 rows
    ld   b,$08		;set bit counter to 8
s_level_loop
    ld   (hl),$00	;start by zeroing dest byte
    sla  a		;x 2
    jr   nc,s_level_l1	;is next bit set
    set  6,(hl)		;if so set 2 bit of first nibble
s_level_l1
    dec  b		;dec bit counter
    jr   nz,s_level_l2	;if all bits decoded get another byte
    ld   b,$08		;reset bit counter
    inc  de		;move to next source address
    ld   a,(de)		;and get byte
s_level_l2
    sla  a		;x 2
    jr   nc,s_level_l3	;is next bit set
    set  5,(hl)		;if so set bit 1 of first nibble
s_level_l3
    dec  b		;dec bit counter
    jr   nz,s_level_l4	;if all bits decoded get another byte
    ld   b,$08		;reset bit counter
    inc  de		;move to next source address
    ld   a,(de)		;and get byte
s_level_l4
    sla  a		;x 2
    jr   nc,s_level_l5	;is next bit set
    set  4,(hl)		;if so set bit 0 of first nibble
s_level_l5
    dec  b		;dec bit counter
    jr   nz,s_level_l6	;if all bits decoded get another byte
    ld   b,$08		;reset bit counter
    inc  de		;move to next source address
    ld   a,(de)		;and get byte
s_level_l6
    sla  a		;x 2
    jr   nc,s_level_l7	;is next bit set
    set  2,(hl)		;if so set bit 2 of second nibble
s_level_l7
    dec  b		;dec bit counter
    jr   nz,s_level_l8	;if all bits decoded get another byte
    ld   b,$08		;reset bit counter
    inc  de		;move to next source address
    ld   a,(de)		;and get byte
s_level_l8
    sla  a		;x 2
    jr   nc,s_level_l9	;is next bit set
    set  1,(hl)		;if so set bit 1 of second nibble
s_level_l9
    dec  b		;dec bit counter
    jr   nz,s_level_l10	;if all bits decoded get another byte
    ld   b,$08		;reset bit counter
    inc  de		;move to next source address
    ld   a,(de)		;and get byte
s_level_l10
    sla  a		;x 2
    jr   nc,s_level_l11	;is next bit set
    set  0,(hl)		;if so set 2 of second nibble
s_level_l11
    dec  b		;dec bit counter
    jr   nz,s_level_l12	;if all bits decoded get another byte
    ld   b,$08		;reset bit counter
    inc  de		;move to next source address
    ld   a,(de)		;and get byte
s_level_l12
    inc  hl		;move to next dest address
    ex   af,af'		;exchange regs
    exx
    dec  ix		;dec counter
    push ix		;transfer counter to
    pop  de		;de
    ld   a,e		;and check if 0
    or   d
    jr   z,s_level_l13	;fin if counter = 0
    ex   af,af'		;exchange regs
    exx
    jr   s_level_loop		;loop
s_level_l13
    ld   hl,l_e397     ;slave_newmap
    ld   (hl),$FF	;set level finished flag
    ret

s_calclevel
    ld   a,e
    call s_calclevel_1	;multiply bc x a (288 & level num)
    ex   af,af'
    push hl
    ld   a,d
    call s_calclevel_2	;hmm d, e and a are surely all zero
				;so this will calc 0 x 288 every time???
    ld   d,a	;0
    ex   af,af'
    add  a,h
    ld   h,l
    ld   l,e
    ld   e,a
    jr   nc,s_calclevel_3
    inc  d
s_calclevel_3
    pop  bc	;get level offset
    add  hl,bc
    ret  nc
    inc  de
    ret
s_calclevel_1
    ld   e,$00
s_calclevel_2
    ld   h,e
    ld   l,e
    add  a,a
    jr   nc,s_calclevel_10
    add  hl,bc
    adc  a,e
s_calclevel_10
    add  hl,hl
    adc  a,a
    jr   nc,s_calclevel_4
    add  hl,bc
    adc  a,e
s_calclevel_4
    add  hl,hl
    adc  a,a
    jr   nc,s_calclevel_5
    add  hl,bc
    adc  a,e
s_calclevel_5
    add  hl,hl
    adc  a,a
    jr   nc,s_calclevel_6
    add  hl,bc
    adc  a,e
s_calclevel_6
    add  hl,hl
    adc  a,a
    jr   nc,s_calclevel_7
    add  hl,bc
    adc  a,e
s_calclevel_7
    add  hl,hl
    adc  a,a
    jr   nc,s_calclevel_8
    add  hl,bc
    adc  a,e
s_calclevel_8
    add  hl,hl
    adc  a,a
    jr   nc,s_calclevel_9
    add  hl,bc
    adc  a,e
s_calclevel_9
    add  hl,hl
    adc  a,a
    ret  nc
    add  hl,bc
    adc  a,e
    ret


sleveldata
    incbin "../data/level51-101.bin"