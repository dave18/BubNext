L39CC:       equ  39CCh
L99DA:       equ  99DAh
LADAD:       equ  ADADh
LBC39:       equ  BC39h
LCB9D:       equ  CB9Dh
LCDBB:       equ  CDBBh
LDB9A:       equ  DB9Ah
LEECC:       equ  EECCh


             org 5130h


5130 L5130:
5130 CC CC EE     CALL Z,LEECC 
5133 EE CC        XOR  CCh    
5135 CE EE        ADC  A,EEh  
5137 EC CC EE     CALL PE,LEECC 
513A EE CC        XOR  CCh    
513C CE EE        ADC  A,EEh  
513E EC CC 39     CALL PE,L39CC 
5141 DD AD        XOR  IXL    
5143 AC           XOR  H      
5144 93           SUB  E      
5145 99           SBC  A,C    
5146 99           SBC  A,C    
5147 99           SBC  A,C    
5148 93           SUB  E      
5149 9A           SBC  A,D    
514A AA           XOR  D      
514B AA           XOR  D      
514C 39           ADD  HL,SP  
514D DD CD DA 99  CALL L99DA  
5151 CC BB CD     CALL Z,LCDBB 
5154 9D           SBC  A,L    
5155 CB BB        RES  7,E    
5157 CD 9D CB     CALL LCB9D  
515A BC           CP   H      
515B DA 9A DB     JP   C,LDB9A 
515E BD           CP   L      
515F AC           XOR  H      
5160 DA AD AD     JP   C,LADAD 
5163 93           SUB  E      
5164 99           SBC  A,C    
5165 99           SBC  A,C    
5166 99           SBC  A,C    
5167 39           ADD  HL,SP  
5168 AA           XOR  D      
5169 AA           XOR  D      
516A A9           XOR  C      
516B 39           ADD  HL,SP  
516C AA           XOR  D      
516D AD           XOR  L      
516E C9           RET         


516F 93           defb 93h    
5170 AD           defb ADh    
5171 CA           defb CAh    
5172 AA           defb AAh    
5173 99           defb 99h    
5174 AD           defb ADh    
5175 DC           defb DCh    
5176 AC           defb ACh    
5177 A9           defb A9h    
5178 CA           defb CAh    
5179 DA           defb DAh    
517A DA           defb DAh    
517B D9           defb D9h    
517C CD           defb CDh    
517D AD           defb ADh    
517E CD           defb CDh    
517F A9           defb A9h    
5180 9C           defb 9Ch    
5181 AD           defb ADh    
5182 AA           defb AAh    
5183 DA           defb DAh    
5184 9C           defb 9Ch    
5185 DA           defb DAh    
5186 DD           defb DDh    
5187 CD           defb CDh    
5188 9A           defb 9Ah    
5189 AD           defb ADh    
518A CC           defb CCh    
518B CD           defb CDh    
518C 39           defb 39h    
518D AD           defb ADh    
518E DD           defb DDh    
518F DA           defb DAh    
5190 93           defb 93h    
5191 9A           defb 9Ah    
5192 AA           defb AAh    
5193 AA           defb AAh    


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 


             org BFC0h


BFC0 LBFC0:
BFC0 CD 39 BC     CALL LBC39  
BFC3 C9           RET         


BFC4 00           defb 00h    
BFC5 00           defb 00h    
BFC6 00           defb 00h    
BFC7 00           defb 00h    
BFC8 00           defb 00h    
BFC9 00           defb 00h    
BFCA 00           defb 00h    
BFCB 00           defb 00h    
BFCC 00           defb 00h    
BFCD 00           defb 00h    
BFCE 00           defb 00h    
BFCF 00           defb 00h    
BFD0 00           defb 00h    
BFD1 00           defb 00h    
BFD2 00           defb 00h    
BFD3 00           defb 00h    
BFD4 00           defb 00h    
BFD5 00           defb 00h    
BFD6 00           defb 00h    
BFD7 00           defb 00h    
BFD8 00           defb 00h    
BFD9 00           defb 00h    
BFDA 00           defb 00h    
BFDB 00           defb 00h    
BFDC 00           defb 00h    
BFDD 00           defb 00h    
BFDE 00           defb 00h    
BFDF 00           defb 00h    
BFE0 00           defb 00h    
BFE1 00           defb 00h    
BFE2 00           defb 00h    
BFE3 00           defb 00h    
BFE4 00           defb 00h    
BFE5 00           defb 00h    
BFE6 00           defb 00h    
BFE7 00           defb 00h    
BFE8 00           defb 00h    
BFE9 00           defb 00h    
BFEA 00           defb 00h    
BFEB 00           defb 00h    
BFEC 00           defb 00h    
BFED 00           defb 00h    
BFEE 00           defb 00h    
BFEF 00           defb 00h    
BFF0 00           defb 00h    
BFF1 00           defb 00h    
BFF2 00           defb 00h    
BFF3 00           defb 00h    
BFF4 00           defb 00h    
BFF5 00           defb 00h    
BFF6 00           defb 00h    
BFF7 00           defb 00h    
BFF8 00           defb 00h    
BFF9 00           defb 00h    
BFFA 00           defb 00h    
BFFB 00           defb 00h    
BFFC 00           defb 00h    
BFFD 00           defb 00h    
BFFE 00           defb 00h    
BFFF 00           defb 00h    
C000 3A           defb 3Ah    
C001 38           defb 38h    
C002 29           defb 29h    
C003 21           defb 21h    
C004 6C           defb 6Ch    
C005 3C           defb 3Ch    
C006 BE           defb BEh    
C007 77           defb 77h    
C008 23           defb 23h    
C009 20           defb 20h    
C00A 1B           defb 1Bh    
C00B 34           defb 34h    
C00C 7E           defb 7Eh    
C00D FE           defb FEh    
C00E 3C           defb 3Ch    
C00F D8           defb D8h    
C010 21           defb 21h    
C011 00           defb 00h    
C012 2E           defb 2Eh    
C013 11           defb 11h    
C014 00           defb 00h    
C015 26           defb 26h    
C016 01           defb 01h    
C017 00           defb 00h    
C018 08           defb 08h    
C019 7E           defb 7Eh    
C01A 2F           defb 2Fh    
C01B 12           defb 12h    
C01C 23           defb 23h    
C01D 13           defb 13h    
C01E 0B           defb 0Bh    
C01F 79           defb 79h    
C020 B0           defb B0h    
C021 20           defb 20h    
C022 F6           defb F6h    
C023 C3           defb C3h    