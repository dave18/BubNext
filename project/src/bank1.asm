
    org $c000

bank1_data_8000 ;- 8100
    ;this contains palette information
    BYTE $00,$00,$FF,$F0,$CC,$F0,$0A,$00,$F6,$00,$FB,$00,$0F,$00,$F8,$00	;00
    BYTE $FF,$F0,$F0,$00,$A0,$00,$FF,$60,$F7,$70,$F5,$70,$00,$00,$00,$00
    BYTE $00,$00,$F0,$00,$77,$70,$99,$90,$BB,$B0,$FF,$F0,$44,$40,$55,$50	;10
    BYTE $00,$00,$00,$00,$00,$00,$FB,$00,$FF,$00,$FF,$F0,$F0,$70,$00,$00
    BYTE $00,$00,$0F,$00,$0B,$00,$FA,$A0,$66,$B0,$88,$B0,$AA,$D0,$00,$C0	;20
    BYTE $66,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
    BYTE $FF,$F0,$00,$00,$0B,$00,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$FA,$80	;30
    BYTE $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
    BYTE $00,$00,$FF,$00,$F0,$00,$FF,$F0,$00,$00,$EA,$60,$C8,$50,$88,$60	;40
    BYTE $A7,$40,$F0,$70,$CC,$A0,$0B,$00,$00,$00,$75,$50,$AA,$80,$00,$00
    BYTE $00,$00,$0B,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00	;50
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $FF,$F0,$00,$00,$0A,$F0,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$FA,$80	;60
    BYTE $0B,$F0,$F0,$70,$0C,$F0,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
    BYTE $FF,$F0,$00,$00,$0B,$00,$FA,$A0,$80,$F0,$88,$B0,$AA,$D0,$09,$F0	;70
    BYTE $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
    
bank1_data_8100
	BYTE $FF,$F0,$00,$00,$08,$F0,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$09,$F0	;80
	BYTE $0B,$F0,$F0,$70,$0A,$F0,$0F,$F0,$F8,$00,$F7,$70,$D4,$00,$00,$00
	BYTE $FF,$F0,$00,$00,$0B,$00,$FB,$00,$F7,$70,$A0,$90,$70,$C0,$80,$00	;90
	BYTE $F0,$60,$F0,$00,$0F,$00,$CF,$00,$F8,$00,$0F,$F0,$A0,$00,$00,$00
	BYTE $A0,$A0,$0F,$00,$A0,$00,$FF,$00,$0F,$E0,$FA,$70,$F9,$00,$FA,$F0	;A0
	BYTE $00,$F0,$0E,$F0,$08,$F0,$0C,$F0,$F0,$F0,$FF,$F0,$F0,$00,$00,$00
	BYTE $FF,$F0,$00,$00,$0B,$00,$FA,$A0,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
	BYTE $0B,$F0,$F0,$70,$F8,$00,$FA,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
	BYTE $FF,$F0,$00,$00,$0D,$00,$FA,$00,$80,$F0,$88,$B0,$AA,$D0,$09,$F0
	BYTE $0C,$F0,$F0,$70,$08,$00,$FF,$00,$F8,$00,$FA,$80,$D4,$00,$00,$00
	BYTE $FF,$F0,$00,$00,$0B,$00,$FA,$A0,$80,$F0,$70,$80,$AA,$D0,$09,$F0
	BYTE $0B,$F0,$F0,$70,$0F,$00,$FF,$00,$F8,$00,$F7,$70,$D4,$00,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

bank1_data_8200
    ;more palette info - level palette data
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$66,$80,$88,$B0,$AA,$D0,$80,$00
	BYTE $F0,$00,$60,$00,$80,$00,$FD,$80,$F9,$70,$F7,$00,$B2,$00,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$0F,$F0,$0B,$00,$66,$F0,$80,$00
	BYTE $F0,$00,$45,$70,$66,$80,$FF,$F0,$AA,$D0,$88,$B0,$66,$90,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$66,$80
	BYTE $66,$F0,$55,$70,$66,$A0,$FF,$F0,$0F,$F0,$0A,$F0,$09,$F0,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$07,$F0,$80,$00
	BYTE $F0,$00,$66,$60,$77,$70,$FF,$F0,$CC,$C0,$99,$90,$88,$80,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00
	BYTE $0F,$00,$60,$00,$80,$00,$FF,$F0,$FF,$00,$FA,$00,$F0,$70,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	BYTE $F0,$00,$70,$00,$80,$40,$FF,$F0,$FA,$F0,$F7,$F0,$F0,$90,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$FF,$F0,$0F,$00,$0C,$00,$09,$00
	BYTE $F0,$00,$55,$00,$76,$00,$FF,$B0,$CC,$80,$AA,$70,$88,$50,$00,$00
	BYTE $00,$00,$00,$00,$00,$00,$00,$00,$FF,$F0,$00,$00,$00,$00,$00,$00
	BYTE $F0,$00,$55,$00,$76,$00,$FF,$C0,$FC,$80,$DA,$70,$B8,$50,$00,$00


bank1_data_8300	;tile data for left hand side of logo
	BYTE $04,$04,$04,$05,$06,$07,$08,$09,$04,$0A,$04,$04,$04,$0B,$0C,$0D
	BYTE $0E,$0F,$10,$11,$04,$04,$04,$12,$0D,$0D,$0D,$0D,$13,$14,$04,$15
	BYTE $16,$17,$18,$19,$0D,$0D,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$0D,$0D
	BYTE $22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$0D,$2F,$30
	BYTE $31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40
	BYTE $04,$41,$42,$43,$44,$45,$46,$47,$48,$49,$04,$04,$4A,$4B,$4C,$4D
	BYTE $4E,$4F,$50,$51,$04,$52,$53,$0D,$54,$55,$56,$57,$58,$59,$5A,$5B
	BYTE $5C,$0D,$5D,$5E,$5F,$60,$61,$62,$63,$64,$0D,$0D,$65,$66,$67,$68
	BYTE $69,$6A,$04,$6B,$6C,$6D,$65,$6E,$6F,$70,$71,$72,$04,$73,$74,$75
	BYTE $76,$77,$78,$0C,$0E,$79,$04,$7A,$7B,$7C,$7D,$7E,$7F,$80,$81,$82
	BYTE $04,$04,$83,$84,$85,$86,$87,$88,$89,$04,$04,$04,$04,$04,$04,$04
	BYTE $04,$04,$04,$04
;	BYTE $04,$04,$04,$05,$06,$07,$08,$09,$04,$0A,$04,$04,$04,$0B,$0C,$0D
;	BYTE $0E,$0F,$10,$11,$04,$04,$04,$12,$0D,$0D,$0D,$0D,$13,$14,$04,$15
;	BYTE $16,$7B,$4C,$4D,$4E,$0D,$1A,$1B,$1C,$1D,$0D,$0D,$54,$55,$56,$57
;	BYTE $58,$23,$24,$25,$0D,$0D,$5D,$5E,$5F,$60,$61,$2D,$2E,$0D,$0D,$0D
;	BYTE $65,$66,$67,$68,$69,$36,$37,$38,$39,$0D,$65,$6E,$6F,$70,$71,$40
;	BYTE $04,$41,$42,$0D,$76,$77,$78,$0D,$0E,$49,$04,$04,$4A,$4B,$4C,$4D
;	BYTE $4E,$0D,$0D,$51,$04,$52,$53,$0D,$54,$55,$56,$57,$58,$59,$5A,$5B
;	BYTE $5C,$0D,$5D,$5E,$5F,$60,$61,$62,$63,$64,$0D,$0D,$65,$66,$67,$68
;	BYTE $69,$6A,$04,$6B,$6C,$6D,$65,$6E,$6F,$70,$71,$72,$04,$73,$74,$75
;	BYTE $76,$77,$78,$0C,$0E,$79,$04,$7A,$7B,$7C,$7D,$7E,$7F,$80,$81,$82
;	BYTE $04,$04,$83,$84,$85,$86,$87,$88,$89,$04,$04,$04,$04,$04,$04,$04
;	BYTE $04,$04,$04,$04

bank1_data_83B4	;tile data for right hand side of logo
	BYTE $04,$05,$05,$06,$07,$08,$05,$05,$05,$05,$05,$05,$09,$05,$0A,$0B
	BYTE $0C,$0D,$0E,$08,$05,$05,$05,$05,$0F,$10,$11,$12,$13,$14,$15,$16
	BYTE $17,$05,$05,$05,$18,$13,$19,$13,$1A,$1B,$1C,$1D,$1E,$1F,$05,$05
	BYTE $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$05,$05,$2A,$2B,$2C,$2D
	BYTE $2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D
	BYTE $3E,$3F,$13,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$13,$13,$4A
	BYTE $4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$13,$54,$55,$56,$57,$58,$59
	BYTE $5A,$5B,$5C,$5D,$5E,$13,$5F,$60,$61,$62,$63,$64,$65,$66,$67,$68
	BYTE $69,$1A,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72,$73,$13,$74,$75,$76
	BYTE $77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,$1A,$80,$81,$82,$83,$84,$85
	BYTE $86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$90,$91,$92,$93,$94,$95
	BYTE $96,$60,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$A0,$A1,$A2,$05,$05
	BYTE $A3,$A4,$A5,$A6,$A7,$A8,$1A,$A9,$AA,$AB,$05,$05,$05,$05,$05,$AC
	BYTE $AD,$AE,$AF,$B0,$05,$05,$05,$05

bank1_data_848C	;tile data to update logo to 'Super' Bubble Bobble
	BYTE $DC,$DD,$DE,$DF,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB
	BYTE $EC,$ED



bank1_data_95AA
    
;    BYTE $EA,$95,$3A,$96,$8A,$96,$EA,$95,$DA,$96,$2A,$97,$7A,$97,$EA,$95
;    BYTE $CA,$97,$1A,$98,$6A,$98,$EA,$95,$EA,$95,$EA,$95,$EA,$95,$EA,$95
;    BYTE $BA,$98,$EA,$98,$1A,$99,$BA,$98,$4A,$99,$7A,$99,$AA,$99,$BA,$98
;    BYTE $DA,$99,$0A,$9A,$3A,$9A,$BA,$98,$BA,$98,$BA,$98,$BA,$98,$BA,$98
    
    BYTE LOW bank1_data_95EA,HIGH bank1_data_95EA,LOW bank1_data_963A,HIGH bank1_data_963A,LOW bank1_data_968A,HIGH bank1_data_968A,LOW bank1_data_95EA,HIGH bank1_data_95EA,LOW bank1_data_96DA,HIGH bank1_data_96DA,LOW bank1_data_972A,HIGH bank1_data_972A,LOW bank1_data_977A,HIGH bank1_data_977A,LOW bank1_data_95EA,HIGH bank1_data_95EA
    BYTE LOW bank1_data_97CA,HIGH bank1_data_97CA,LOW bank1_data_981A,HIGH bank1_data_981A,LOW bank1_data_986A,HIGH bank1_data_986A,LOW bank1_data_95EA,HIGH bank1_data_95EA,LOW bank1_data_95EA,HIGH bank1_data_95EA,LOW bank1_data_95EA,HIGH bank1_data_95EA,LOW bank1_data_95EA,HIGH bank1_data_95EA,LOW bank1_data_95EA,HIGH bank1_data_95EA
    BYTE LOW bank1_data_98BA,HIGH bank1_data_98BA,LOW bank1_data_98EA,HIGH bank1_data_98EA,LOW bank1_data_991A,HIGH bank1_data_991A,LOW bank1_data_98BA,HIGH bank1_data_98BA,LOW bank1_data_994A,HIGH bank1_data_994A,LOW bank1_data_997A,HIGH bank1_data_997A,LOW bank1_data_99AA,HIGH bank1_data_99AA,LOW bank1_data_98BA,HIGH bank1_data_98BA
    BYTE LOW bank1_data_99DA,HIGH bank1_data_99DA,LOW bank1_data_9A0A,HIGH bank1_data_9A0A,LOW bank1_data_9A3A,HIGH bank1_data_9A3A,LOW bank1_data_98BA,HIGH bank1_data_98BA,LOW bank1_data_98BA,HIGH bank1_data_98BA,LOW bank1_data_98BA,HIGH bank1_data_98BA,LOW bank1_data_98BA,HIGH bank1_data_98BA,LOW bank1_data_98BA,HIGH bank1_data_98BA
 
    
bank1_data_95EA
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
bank1_data_963A
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
bank1_data_968A
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
bank1_data_96DA
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
bank1_data_972A
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
bank1_data_977A
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
bank1_data_97CA
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
bank1_data_981A
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
bank1_data_986A
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
bank1_data_98BA
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$01,$11,$10,$00,$00,$00,$00
bank1_data_98EA
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$04,$44,$40,$00,$00,$00,$00
bank1_data_991A
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00
bank1_data_994A
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$01,$11,$10,$00,$00,$00,$00
bank1_data_997A
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$04,$44,$40,$00,$00,$00,$00
bank1_data_99AA
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
bank1_data_99DA
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$11,$10,$00,$00,$00,$00
bank1_data_9A0A
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$44,$40,$00,$00,$00,$00
bank1_data_9A3A
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    
bank1_data_9A6A
    BYTE LOW data_bank1_9A86,HIGH data_bank1_9A86
    BYTE LOW data_bank1_9B60,HIGH data_bank1_9B60
    BYTE LOW data_bank1_9C00,HIGH data_bank1_9C00
    BYTE LOW data_bank1_9CA2,HIGH data_bank1_9CA2
    BYTE LOW data_bank1_9D32,HIGH data_bank1_9D32
    BYTE LOW data_bank1_9DB0,HIGH data_bank1_9DB0
    BYTE LOW data_bank1_9E1A,HIGH data_bank1_9E1A
    BYTE LOW data_bank1_9EFC,HIGH data_bank1_9EFC
    BYTE LOW data_bank1_A0EE,HIGH data_bank1_A0EE
    BYTE LOW data_bank1_A180,HIGH data_bank1_A180
    BYTE LOW data_bank1_A208,HIGH data_bank1_A208
    BYTE LOW data_bank1_A320,HIGH data_bank1_A320
    BYTE LOW data_bank1_A43C,HIGH data_bank1_A43C
    BYTE LOW data_bank1_A508,HIGH data_bank1_A508
    
data_bank1_9A86	;9B60-9A86=DA
    BYTE $4F,$7F,$20,$7D,$10,$7F,$14,$6F,$0C,$7F,$0D,$7E,$07,$7F,$0E,$7D ;010
    BYTE $14,$7F,$07,$7E,$09,$7F,$13,$7D,$02,$7F,$06,$7E,$03,$7F,$34,$7D ;020
    BYTE $01,$7F,$25,$7E,$03,$5E,$02,$5F,$1F,$7F,$06,$5F,$05,$7F,$52,$7D ;030
    BYTE $1D,$7F,$03,$5F,$04,$7F,$03,$5F,$05,$7F,$04,$5F,$05,$7F,$02,$5E ;040
    BYTE $09,$7E,$03,$7F,$02,$7D,$03,$7F,$08,$6F,$03,$6E,$10,$7E,$04,$5E ;050
    BYTE $03,$7E,$02,$5E,$03,$7E,$02,$5E,$03,$7E,$02,$5E,$03,$7E,$02,$5E ;060
    BYTE $03,$7E,$03,$5E,$03,$7E,$01,$5E,$1D,$7E,$02,$7F,$11,$7D,$01,$7F ;070
    BYTE $23,$7E,$13,$6E,$0C,$7E,$07,$7F,$0B,$7D,$05,$7F,$07,$7E,$01,$7F ;080
    BYTE $2D,$7D,$10,$7F,$03,$7E,$0C,$7F,$05,$7D,$03,$7F,$05,$7E,$04,$7F ;090
    BYTE $11,$6F,$0F,$7F,$22,$7E,$05,$5E,$06,$7E,$04,$5E,$04,$7E,$04,$5E ;0A0
    BYTE $05,$7E,$03,$5F,$08,$5D,$05,$7D,$01,$5D,$02,$5F,$02,$5E,$0B,$7E ;0B0
    BYTE $03,$5E,$0A,$7E,$03,$7F,$30,$7D,$1D,$6D,$4E,$7D,$23,$6D,$04,$7D ;0C0
    BYTE $02,$7F,$0E,$7E,$07,$5E,$0A,$7E,$16,$6E,$11,$7E,$08,$5E,$05,$7E ;0D0
    BYTE $06,$5E,$07,$7E,$3A,$6E,$16,$7E,$C2,$7F			 ;0DA

data_bank1_9B60 ;9C00-9B60=A0
    BYTE $5E,$7F,$23,$7E,$0B,$7F                                         ;006
    BYTE $09,$5F,$10,$7F,$10,$6F,$2B,$7F,$08,$6F,$09,$7F,$29,$7E,$04,$7F ;016
    BYTE $13,$79,$05,$7F,$08,$5F,$1B,$7F,$08,$5F,$04,$7F,$3F,$7E,$0B,$6E ;026
    BYTE $10,$7F,$2E,$7D,$03,$5D,$08,$5F,$09,$7F,$17,$7E,$03,$7F,$01,$7D ;036
    BYTE $0A,$79,$02,$59,$01,$5D,$03,$5F,$0D,$7F,$06,$5F,$04,$7F,$05,$5F ;046
    BYTE $11,$7F,$08,$7E,$03,$7F,$05,$5F,$17,$7F,$01,$7D,$0C,$79,$25,$7D ;056
    BYTE $0B,$7F,$2F,$7E,$13,$7F,$0C,$7D,$03,$5D,$02,$7D,$1E,$7F,$14,$7D ;066
    BYTE $02,$7F,$06,$6F,$29,$7F,$05,$5F,$0F,$7F,$14,$7E,$04,$7F,$2F,$7D ;076
    BYTE $07,$6D,$26,$7D,$03,$7F,$1D,$7E,$4D,$7F,$18,$7E,$0B,$6E,$1E,$7E ;086
    BYTE $0B,$6E,$19,$7E,$08,$5E,$06,$7E,$09,$6E,$02,$7E,$11,$7F,$0F,$7D ;096
    BYTE $05,$5D,$1A,$7D,$0B,$6D,$03,$6F,$E3,$7F                         ;0A0

data_bank1_9C00 ;9CA2-9C00=A2
    BYTE $65,$7D,$0E,$6D,$0F,$7D                                         ;006
    BYTE $0B,$7F,$0A,$7E,$07,$7F,$07,$7E,$03,$7F,$04,$79,$01,$7D,$0A,$7F ;016
    BYTE $06,$5F,$05,$7F,$11,$6F,$05,$7F,$06,$5F,$04,$7F,$0B,$6F,$05,$7F ;026
    BYTE $13,$6F,$06,$7F,$06,$5F,$13,$7F,$15,$7D,$07,$6D,$04,$6F,$07,$6E ;036
    BYTE $05,$7E,$06,$5E,$03,$7E,$1B,$7F,$0A,$6F,$01,$7F,$15,$7E,$25,$7F ;046
    BYTE $0A,$7E,$01,$7F,$18,$79,$05,$69,$01,$6F,$03,$6E,$1E,$7E,$09,$7F ;056
    BYTE $08,$7E,$08,$7F,$0B,$6F,$1C,$7F,$4A,$7E,$09,$6E,$17,$7E,$04,$7F ;066
    BYTE $17,$7D,$02,$6D,$04,$6F,$02,$6E,$33,$7E,$0A,$6E,$31,$7E,$02,$7F ;076
    BYTE $5F,$7D,$18,$6D,$09,$7D,$05,$7F,$0C,$7E,$0A,$6E,$2F,$7E,$10,$6E ;086
    BYTE $4C,$7E,$09,$7F,$01,$7D,$07,$79,$02,$7D,$54,$7F,$1E,$7D,$12,$6D ;096
    BYTE $18,$7D,$0F,$6D,$05,$7D,$09,$5D,$10,$7D,$D4,$7F                 ;0A2

data_bank1_9CA2  ;9D32-9CA2=90
    BYTE $15,$7D,$2A,$7F                                                 ;004
    BYTE $31,$7E,$02,$7F,$17,$6F,$08,$7F,$1B,$7D,$19,$6D,$22,$7D,$05,$7F ;014
    BYTE $1E,$7E,$05,$5E,$02,$7E,$04,$7F,$03,$5F,$05,$7F,$14,$6F,$06,$7F ;024
    BYTE $0D,$7D,$04,$7F,$0D,$7E,$0D,$6F,$08,$6D,$18,$7D,$08,$7F,$3D,$7E ;034
    BYTE $15,$6E,$09,$7E,$01,$7F,$05,$6F,$08,$6D,$06,$6F,$04,$7F,$06,$6F ;044
    BYTE $32,$7F,$13,$6F,$02,$7F,$17,$7D,$06,$7F,$02,$7D,$10,$6D,$13,$7D ;054
    BYTE $03,$7F,$08,$7E,$08,$7D,$16,$6D,$10,$7D,$05,$7F,$0A,$7E,$14,$6E ;064
    BYTE $24,$7E,$12,$6E,$04,$7E,$12,$6E,$2C,$7E,$0C,$6E,$39,$7E,$05,$7F ;074
    BYTE $78,$7D,$8D,$7F,$1A,$7D,$17,$6D,$13,$7D,$08,$5D,$05,$7D,$05,$5D ;084
    BYTE $06,$7D,$3A,$6D,$0B,$7D,$09,$6D,$10,$7D,$AD,$7F                 ;090

data_bank1_9D32 ;9DB0-9D32=7E
    BYTE $72,$7F,$B7,$7D                                                 ;004
    BYTE $02,$7F,$64,$7E,$0A,$6E,$02,$7E,$05,$6E,$02,$7F,$1B,$7D,$0D,$7F ;014
    BYTE $05,$7E,$74,$7F,$19,$7D,$01,$7F,$04,$7E,$02,$5E,$03,$4E,$12,$6E ;024
    BYTE $33,$6F,$02,$6D,$0B,$6F,$06,$4F,$15,$6F,$04,$4F,$1B,$6F,$05,$4F ;034
    BYTE $17,$6F,$09,$6D,$04,$4D,$11,$6D,$01,$7F,$0D,$7E,$10,$7F,$06,$7E ;044
    BYTE $07,$6E,$04,$7E,$B6,$7F,$24,$7D,$01,$7F,$05,$7E,$02,$6E,$03,$4E ;054
    BYTE $06,$6E,$05,$7E,$0A,$7F,$19,$6F,$04,$6D,$2C,$6F,$05,$4F,$13,$6F ;064
    BYTE $0A,$4F,$19,$6F,$24,$6D,$04,$7D,$17,$6D,$14,$7D,$07,$6D,$03,$7D ;074
    BYTE $08,$6D,$30,$7D,$0B,$6D,$BB,$7D,$20,$7F                         ;07E

data_bank1_9DB0 ;9E1A-9DB0=6A
    BYTE $72,$7F,$47,$7F,$11,$7D                                         ;006
    BYTE $09,$7F,$23,$7E,$05,$7F,$08,$7D,$02,$7F,$75,$7E,$05,$7F,$24,$7D ;016
    BYTE $03,$7F,$11,$7E,$03,$7F,$19,$7D,$06,$5D,$0A,$7D,$12,$6D,$08,$6F ;026
    BYTE $31,$6E,$07,$6F,$21,$6D,$05,$6F,$2E,$6E,$89,$7E,$01,$7F,$57,$7D ;036
    BYTE $04,$5D,$03,$7D,$02,$5F,$02,$5E,$02,$7E,$03,$5E,$02,$7E,$02,$5E ;046
    BYTE $01,$5F,$01,$7F,$02,$7D,$03,$5D,$02,$7D,$03,$5D,$02,$7F,$03,$5E ;056
    BYTE $30,$7E,$16,$7A,$18,$7E,$01,$7F,$06,$7D,$07,$5D,$05,$7D,$14,$6D ;066
    BYTE $05,$6F,$61,$7F                                                 ;06A

data_bank1_9E1A ;9EFC-9E1A=E2
    BYTE $11,$7F,$67,$7D,$01,$7F,$24,$7E,$03,$7F,$18,$7D                 ;00C
    BYTE $03,$7F,$04,$5F,$05,$7F,$08,$7E,$06,$5E,$04,$7E,$06,$5E,$09,$7E ;01C
    BYTE $02,$7F,$05,$7D,$07,$5D,$05,$7D,$06,$5D,$01,$7D,$03,$7F,$02,$7E ;02C
    BYTE $05,$5E,$03,$7E,$05,$5E,$08,$7E,$02,$7F,$0D,$7D,$02,$7F,$0F,$7E ;03C
    BYTE $01,$7F,$04,$79,$01,$7D,$07,$7F,$07,$6F,$14,$7F,$07,$5F,$14,$7F ;04C
    BYTE $07,$7E,$01,$7F,$02,$7D,$0A,$7F,$05,$5F,$08,$7F,$10,$7D,$09,$7F ;05C
    BYTE $06,$5F,$02,$7F,$08,$7E,$05,$7D,$01,$7F,$06,$5F,$08,$7F,$07,$7D ;06C
    BYTE $04,$7F,$2B,$7D,$0A,$6D,$01,$6F,$06,$6A,$18,$6F,$08,$7F,$0A,$7E ;07C
    BYTE $02,$6E,$17,$6F,$10,$6D,$04,$6F,$0B,$6E,$01,$6F,$15,$6D,$04,$6F ;08C
    BYTE $02,$7F,$2C,$7D,$05,$7F,$0A,$6F,$1D,$7F,$07,$6F,$05,$7F,$04,$7E ;09C
    BYTE $1C,$7F,$0A,$7E,$0B,$6E,$10,$7F,$09,$7D,$01,$7F,$0D,$7E,$01,$7F ;0AC
    BYTE $35,$7D,$16,$79,$0E,$69,$71,$79,$02,$7D,$02,$7F,$2F,$7E,$0A,$6E ;0BC
    BYTE $01,$6F,$1C,$6D,$05,$7D,$02,$7F,$02,$7E,$04,$7F,$05,$6F,$01,$7F ;0CC
    BYTE $07,$6F,$0C,$6D,$06,$6F,$08,$6E,$0B,$6F,$0C,$6D,$0A,$7F,$27,$6F ;0DC
    BYTE $09,$7F,$14,$6F,$F9,$7F                                         ;0E2

data_bank1_9EFC ;A0EE-9EFC=1F2
    BYTE $54,$7D,$02,$7F,$06,$7E,$07,$7F,$0A,$7D                         ;00A
    BYTE $01,$7F,$0E,$7E,$02,$7F,$13,$7D,$01,$7F,$02,$7E,$0B,$7F,$03,$5F ;01A
    BYTE $03,$7F,$02,$5F,$09,$7F,$03,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F ;02A
    BYTE $03,$7F,$03,$5F,$02,$7F,$03,$5F,$02,$7F,$03,$5F,$02,$7F,$03,$5F ;03A
    BYTE $03,$7F,$02,$5F,$03,$7F,$03,$5F,$03,$7F,$02,$5F,$03,$7F,$03,$5F ;04A
    BYTE $10,$7F,$09,$6F,$08,$7F,$05,$5F,$2C,$7F,$12,$6F,$04,$7F,$04,$5F ;05A
    BYTE $0F,$7F,$04,$5F,$03,$7F,$03,$5F,$02,$7F,$02,$5F,$03,$7F,$02,$5F ;06A
    BYTE $03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F,$02,$7F,$03,$5F ;07A
    BYTE $02,$7F,$02,$5F,$03,$7F,$03,$5F,$02,$7F,$02,$5F,$02,$7F,$03,$5F ;08A
    BYTE $02,$7F,$03,$5F,$08,$7F,$03,$5F,$02,$7F,$02,$5F,$02,$7F,$02,$5F ;09A
    BYTE $03,$7F,$02,$5F,$02,$7E,$03,$5E,$02,$7E,$02,$5E,$02,$7E,$02,$5E ;0AA
    BYTE $02,$7E,$02,$5F,$02,$7F,$02,$5F,$02,$7F,$03,$5F,$02,$7F,$02,$5F ;0BA
    BYTE $01,$5E,$02,$7E,$02,$5E,$01,$5F,$02,$7F,$03,$5F,$02,$7F,$03,$5F ;0CA
    BYTE $02,$7F,$03,$5F,$02,$7F,$02,$7E,$0E,$7F,$04,$5F,$09,$7F,$08,$7E ;0DA
    BYTE $13,$7F,$06,$7E,$0E,$7F,$04,$5F,$26,$7F,$10,$7D,$06,$7F,$08,$7E ;0EA
    BYTE $03,$7F,$0F,$7D,$01,$7F,$01,$7E,$03,$5E,$03,$7E,$01,$5E,$01,$5F ;0FA
    BYTE $02,$7F,$02,$5F,$02,$7F,$02,$5E,$02,$7E,$02,$5E,$02,$7E,$01,$5E ;10A
    BYTE $01,$5F,$02,$7F,$02,$5F,$03,$7E,$02,$5F,$02,$7F,$01,$5E,$01,$5F ;11A
    BYTE $02,$7D,$02,$5D,$02,$7F,$01,$7E,$02,$5E,$01,$7E,$01,$7F,$01,$5F ;12A
    BYTE $02,$5D,$01,$7D,$01,$7F,$02,$5F,$01,$5D,$02,$7F,$03,$5F,$02,$7F ;13A
    BYTE $03,$5F,$02,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F ;14A
    BYTE $02,$5F,$03,$7F,$03,$5F,$01,$7F,$01,$7F,$02,$5F,$02,$7E,$03,$5E ;15A
    BYTE $03,$7F,$02,$5D,$03,$7F,$03,$5F,$02,$7E,$03,$5E,$02,$7E,$03,$5E ;16A
    BYTE $02,$7F,$03,$5F,$02,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F ;17A
    BYTE $02,$7F,$03,$5F,$03,$7F,$03,$5F,$02,$7F,$03,$5F,$02,$7F,$02,$5F ;18A
    BYTE $03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F ;19A
    BYTE $03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F ;1AA
    BYTE $02,$7F,$02,$5F,$03,$7F,$02,$5E,$7D,$7E,$03,$7F,$47,$7D,$06,$7F ;1BA
    BYTE $18,$7E,$01,$7F,$08,$7D,$04,$5D,$01,$7F,$1F,$7E,$04,$7F,$07,$7D ;1CA
    BYTE $03,$5D,$01,$5F,$01,$7F,$12,$7E,$1B,$7F,$0E,$7E,$04,$7F,$83,$7D ;1DA
    BYTE $06,$7F,$61,$7D,$03,$79,$01,$7D,$5F,$7F,$08,$7D,$0A,$6D,$44,$7D ;1EA
    BYTE $04,$5D,$05,$7D,$04,$5D,$23,$7D                                 ;1F2

data_bank1_A0EE  ;A180-A0EE=92
    BYTE $0A,$7E,$30,$7F,$17,$7E,$02,$7F                                 ;008
    BYTE $25,$7D,$05,$5D,$03,$7F,$04,$5F,$03,$7F,$04,$5E,$01,$7E,$01,$7F ;018
    BYTE $01,$7D,$05,$5D,$03,$7D,$02,$5D,$01,$5F,$02,$7F,$02,$7E,$03,$5E ;028
    BYTE $0B,$7E,$05,$5E,$02,$7E,$1B,$7F,$26,$7D,$04,$7F,$3F,$7E,$03,$7F ;038
    BYTE $12,$7D,$02,$7F,$07,$7E,$15,$6E,$02,$6F,$1E,$7F,$0F,$6F,$11,$7F ;048
    BYTE $40,$7D,$03,$7F,$25,$7E,$13,$6E,$03,$7F,$36,$7D,$05,$5D,$28,$7D ;058
    BYTE $03,$7F,$0E,$7E,$01,$7F,$23,$7D,$02,$7F,$50,$7E,$01,$7F,$1A,$7D ;068
    BYTE $02,$7F,$0D,$7E,$1A,$6E,$18,$7E,$01,$7F,$47,$7D,$02,$7F,$31,$7E ;078
    BYTE $13,$6E,$14,$7E,$24,$6E,$2C,$7E,$02,$7F,$7F,$7D,$02,$7F,$2A,$7E ;088
    BYTE $17,$6E,$3F,$7E,$01,$7F,$01,$7D,$B2,$7F                         ;092

data_bank1_A180 ;A208-A180=88
    BYTE $4E,$7F,$3A,$7E,$1B,$7F                                         ;006
    BYTE $02,$7D,$02,$79,$0C,$7F,$1A,$7E,$02,$7F                         ;010
    BYTE $0D,$7D,$04,$5D,$34,$7D                                         ;016
    BYTE $02,$7F,$06,$6F,$2D,$7F,$07,$7E,$01,$7F,$04,$5F,$0A,$7F,$38,$7E ;026
    BYTE $15,$7F,$03,$7D,$13,$7F,$03,$7D,$05,$7F,$05,$7D,$06,$7F,$07,$6F ;036
    BYTE $39,$7F,$0E,$7E,$06,$7F,$05,$5F,$03,$7F,$0D,$7E,$04,$7F,$06,$5F ;046
    BYTE $11,$7F,$01,$7E,$05,$5E,$01,$5F,$14,$7F,$09,$7E,$05,$5E,$23,$7E ;056
    BYTE $04,$6E,$03,$6F,$24,$7F,$BF,$7D,$05,$7F,$56,$7E,$04,$5E,$0C,$7E ;066
    BYTE $05,$5E,$08,$7E,$04,$5E,$10,$7E,$05,$5E,$1D,$7E,$04,$7F,$19,$7D ;076
    BYTE $25,$7F,$32,$7D,$0B,$6D,$1D,$7D,$08,$6D,$02,$7D,$08,$7F,$22,$7E ;086
    BYTE $09,$7F                                                         ;088

data_bank1_A208 ;A320-A208=118
    BYTE $2A,$7F,$34,$7D,$04,$5D,$05,$7D,$19,$7F,$13,$7E,$05,$7F         ;00E
    BYTE $1A,$7D,$04,$7F,$0F,$7E,$03,$7F,$05,$7D,$05,$5D,$05,$7D,$04,$5D ;01E
    BYTE $03,$7F,$03,$5F,$04,$7F,$03,$5F,$04,$7F,$04,$5F,$04,$7F,$03,$5F ;02E
    BYTE $04,$7F,$05,$5F,$19,$7F,$06,$5F,$04,$7F,$04,$5F,$04,$7F,$04,$5F ;03E
    BYTE $04,$7F,$04,$5F,$05,$7F,$04,$5F,$05,$7F,$04,$5F,$06,$7F,$04,$5F ;04E
    BYTE $06,$7F,$04,$5F,$05,$7F,$03,$5F,$0B,$7E,$02,$7F,$08,$7D,$02,$5D ;05E
    BYTE $03,$5F,$04,$7F,$04,$5F,$03,$7F,$04,$5F,$03,$7F,$04,$5F,$02,$7F ;06E
    BYTE $04,$5F,$02,$7F,$04,$5F,$02,$7F,$03,$5F,$03,$7F,$02,$5F,$03,$7F ;07E
    BYTE $02,$5F,$02,$7F,$03,$5F,$03,$7F,$03,$5F,$03,$7F,$03,$5F,$03,$7F ;08E
    BYTE $02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F,$03,$7F ;09E
    BYTE $02,$5F,$03,$7F,$02,$5F,$03,$7F,$02,$5F,$02,$7F,$1B,$7F,$25,$7D ;0AE
    BYTE $0B,$7F,$17,$6F,$69,$7D,$01,$79,$02,$7B,$0B,$7A,$0E,$6A,$10,$7A ;0BE
    BYTE $05,$7E,$07,$6E,$26,$7E,$07,$6E,$03,$7E,$05,$6E,$24,$7E,$10,$6E ;0CE
    BYTE $1A,$7E,$0B,$6E,$59,$7E,$09,$7F,$11,$7E,$09,$7F,$46,$7D,$22,$6D ;0DE
    BYTE $13,$7D,$0E,$5D,$02,$7D,$07,$79,$06,$59,$04,$5B,$04,$5A,$08,$7A ;0EE
    BYTE $02,$5A,$02,$5E,$02,$5A,$02,$7A,$04,$5E,$05,$7E,$04,$5E,$0E,$7E ;0FE
    BYTE $04,$5E,$03,$7E,$04,$5E,$02,$7E,$04,$5E,$03,$7E,$03,$5E,$33,$7E ;10E
    BYTE $01,$7F,$01,$7B,$44,$79,$01,$7D,$C7,$7F                         ;118

data_bank1_A320 ;A43C-A320=11C
    BYTE $7B,$7F,$09,$7E,$01,$5E                                         ;006
    BYTE $04,$5F,$0A,$7F,$0B,$7E,$0F,$7F,$07,$7E,$02,$7F,$04,$5F,$17,$7F ;016
    BYTE $04,$5F,$13,$7F,$04,$5F,$1B,$7F,$05,$5F,$1B,$7F,$05,$5F,$33,$7F ;026
    BYTE $04,$5F,$0C,$7F,$0B,$7E,$16,$7F,$02,$5F,$03,$7F,$02,$5F,$02,$7F ;036
    BYTE $01,$5F,$03,$7F,$01,$5F,$02,$7F,$01,$5F,$02,$7F,$02,$5F,$02,$7F ;046
    BYTE $01,$5F,$02,$7F,$01,$5F,$03,$7F,$01,$5F,$02,$7F,$01,$5F,$03,$7F ;056
    BYTE $01,$5F,$03,$7F,$01,$5F,$02,$7F,$01,$5F,$03,$7F,$01,$5F,$03,$7F ;066
    BYTE $01,$5F,$03,$7F,$01,$5F,$07,$7F,$01,$5F,$03,$7F,$01,$5F,$03,$7F ;076
    BYTE $01,$5F,$03,$7F,$02,$5F,$02,$7F,$02,$5F,$02,$7F,$02,$5F,$03,$7F ;086
    BYTE $02,$5F,$03,$7F,$02,$5F,$02,$7F,$02,$5F,$02,$7F,$02,$5F,$03,$7F ;096
    BYTE $02,$5F,$02,$7F,$31,$7E,$01,$6E,$03,$6F,$32,$7F,$2B,$7D,$01,$7F ;0A6
    BYTE $02,$7E,$04,$5F,$03,$7F,$04,$5F,$03,$7F,$03,$5F,$03,$7F,$04,$5F ;0B6
    BYTE $01,$7F,$03,$7E,$04,$5E,$05,$7E,$04,$5E,$03,$7E,$03,$5E,$23,$7E ;0C6
    BYTE $08,$6E,$18,$7E,$05,$7F,$06,$6F,$14,$7F,$02,$7D,$09,$79,$06,$69 ;0D6
    BYTE $13,$79,$07,$69,$04,$79,$01,$7D,$18,$7F,$06,$6F,$03,$7F,$05,$6F ;0E6
    BYTE $25,$7F,$06,$6F,$2C,$7F,$0A,$6F,$21,$7F,$0C,$7D,$0A,$6D,$2A,$7D ;0F6
    BYTE $02,$7F,$14,$7E,$2E,$7F,$08,$5F,$10,$7F,$04,$5F,$0B,$7F,$05,$5F ;106
    BYTE $04,$7F,$04,$5F,$03,$7F,$11,$7E,$05,$5E,$18,$7E,$07,$6E,$02,$6F ;116
    BYTE $18,$7F,$23,$7E,$EC,$7F                                         ;11C

data_bank1_A43C ;A508-A43C=CC
    BYTE $4F,$7F,$17,$7D,$07,$6D,$04,$7D,$03,$7F                         ;00A
    BYTE $1E,$7E,$0A,$6E,$03,$7E,$09,$7F,$13,$7D,$03,$7F,$06,$7E,$0D,$6F ;01A
    BYTE $0C,$7F,$12,$7E,$04,$6E,$16,$6F,$09,$7D,$02,$5D,$01,$5F,$20,$7F ;02A
    BYTE $08,$7E,$11,$7F,$12,$7D,$04,$75,$08,$7D,$03,$75,$05,$7D,$03,$75 ;03A
    BYTE $09,$7D,$05,$75,$38,$7D,$0B,$7F,$4A,$7D,$08,$6D,$05,$7D,$01,$79 ;04A
    BYTE $05,$7B,$12,$7A,$07,$6A,$02,$7A,$09,$6A,$06,$7A,$0A,$7F,$0E,$7D ;05A
    BYTE $10,$6D,$0E,$7D,$07,$7F,$02,$79,$0D,$7D,$01,$79,$01,$7A,$04,$7E ;06A
    BYTE $03,$5F,$08,$7F,$3D,$7D,$01,$7F,$3A,$7E,$01,$7F,$08,$7E,$06,$7F ;07A
    BYTE $12,$6F,$05,$7F,$05,$7D,$02,$5D,$03,$7D,$02,$5D,$01,$5F,$02,$7F ;08A
    BYTE $02,$5F,$03,$7F,$02,$5F,$02,$7F,$03,$5F,$02,$7F,$02,$5F,$03,$7F ;09A
    BYTE $02,$5F,$02,$7F,$02,$5F,$02,$7F,$0D,$7D,$01,$6D,$0E,$6F,$0D,$7F ;0AA
    BYTE $5D,$7E,$02,$7A,$05,$7B,$0A,$79,$55,$7D,$04,$5D,$03,$7D,$03,$5D ;0BA
    BYTE $03,$7D,$02,$5D,$14,$7D,$47,$6D,$04,$6B,$01,$6A,$88,$7A,$21,$7E ;0CA
    BYTE $9E,$7F                                                         ;0CC

data_bank1_A508
    BYTE $37,$7F,$27,$7E,$06,$6E,$22,$7F,$08,$6F,$1D,$7F,$07,$6F         ;00E
    BYTE $03,$7F,$29,$7D,$07,$6F,$05,$7F,$04,$7E,$02,$7F,$05,$7E,$01,$7F ;01E
    BYTE $05,$5F,$07,$7F,$04,$7E,$04,$7F,$05,$5F,$02,$7F,$06,$5F,$04,$7F ;02E
    BYTE $0D,$7E,$05,$5F,$07,$7F,$09,$7E,$05,$7F,$06,$5F,$05,$7F,$09,$7E ;03E
    BYTE $05,$7F,$05,$5F,$0C,$7F,$4C,$7E,$05,$5F,$65,$7F,$62,$7E,$07,$6E ;04E
    BYTE $1A,$7E,$04,$6E,$02,$6F,$08,$7F,$05,$6F,$0D,$7F,$0B,$7E,$09,$7F ;05E
    BYTE $07,$6F,$0C,$7F,$04,$7D,$0E,$7F,$07,$6F,$1A,$7F,$04,$7E,$05,$5F ;06E
    BYTE $03,$7F,$04,$5F,$03,$7F,$04,$5F,$02,$7F,$04,$5F,$05,$7F,$04,$5F ;07E
    BYTE $04,$7F,$02,$5F,$0F,$7F,$06,$7D,$08,$7F,$02,$7D,$05,$7F,$07,$6F ;08E
    BYTE $2D,$7F,$22,$7E,$01,$7F,$2C,$7D,$01,$7F,$3F,$7E,$05,$5E,$30,$7E ;09E
    BYTE $02,$6E,$05,$6F,$1C,$7F,$43,$7D,$05,$5D,$35,$7D,$0F,$6D,$15,$7D ;0AE
    BYTE $01,$7F,$0A,$6F,$E0,$7F                                         ;0BE

bank1_data_A5BC    
    BYTE $4D,$7F,$09,$7D,$09,$6D,$02,$7D,$1C,$7F,$09,$6F,$64,$7F,$12,$7D
    BYTE $1E,$7F,$08,$5F,$20,$7F,$1E,$7D,$0A,$6F,$5E,$7F,$36,$7E,$05,$7F
    BYTE $08,$7D,$18,$7F,$09,$5F,$10,$7F,$09,$5F,$0F,$7F,$09,$5F,$1D,$7F
    BYTE $14,$7D,$08,$6F,$2D,$7F,$18,$7D,$03,$7F,$0A,$5F,$05,$7F,$1E,$7D
    BYTE $08,$6D,$4D,$6F,$14,$7F,$BE,$7E,$1C,$7F,$2F,$7D,$BC,$7F
    
bank1_data_A60A
    BYTE $04,$05
    BYTE $06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$1C,$1D,$1E,$1F,$20,$21
    BYTE $22,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$28,$29,$2A
    BYTE $2B,$2C,$2D,$2E
    
bank1_data_A630
    BYTE $23,$24,$25,$26,$27,$34,$35,$36,$37,$38,$39,$3A
    BYTE $3B,$3C,$3D,$3E,$3F,$4C,$2F,$30,$31,$32,$33,$40,$41,$42,$43,$44
    BYTE $45,$46,$47,$48,$49,$4A,$4B,$58
bank1_data_A654    
    BYTE $4D,$4E,$4F,$50,$51,$52,$53,$54
    BYTE $55,$56,$57,$64,$65,$66,$67,$68,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60
    BYTE $61,$62,$63,$70,$71,$72,$73,$74
    
bank1_data_A674
    BYTE $69,$6A,$6B,$6C,$6D,$6E,$6F,$7C
    BYTE $7D,$7E,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$94,$95,$96,$75,$76
    BYTE $77,$78,$79,$7A,$7B,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$90,$91,$92
    BYTE $93,$A0,$A1,$A2
    
bank1_data_A6A0    
    BYTE $97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$AC,$AD,$AE
    BYTE $AF,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$C4,$C5,$C6,$C7,$A3,$A4,$A5

bank1_data_A6BC
    BYTE $A6,$A7,$A8,$A9,$AA,$AB,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$C0,$C1
    BYTE $C2,$C3,$D0,$D1,$D2,$D3
    
bank1_data_A6D2
    BYTE $B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA
    BYTE $BB,$BC,$BD,$BE,$BF,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA
    BYTE $CB
    
bank1_data_A6ED
    BYTE $CC,$CD,$CE,$CF,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA
    BYTE $DB,$DC,$DD,$DE,$DF,$E0,$E1,$E2,$E3,$E4,$E5,$E6
    
bank1_data_A708
    BYTE $00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


bank1_data_A73A
    incbin "../data/bank1_A73A.bin"     ;1122 bytes
    
;next address is $B85C