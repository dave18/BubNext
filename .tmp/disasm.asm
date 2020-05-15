LBB75:       equ  BB75h


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
BFC0 CD 75 BB     CALL LBB75  
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