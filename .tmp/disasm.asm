LBD00:       equ  BD00h


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 


             org BFA5h


BFA5 LBFA5:
BFA5 00           NOP         
BFA6 00           NOP         
BFA7 00           NOP         
BFA8 00           NOP         
BFA9 00           NOP         
BFAA 00           NOP         
BFAB 00           NOP         
BFAC 00           NOP         
BFAD 00           NOP         
BFAE 00           NOP         
BFAF 00           NOP         
BFB0 00           NOP         
BFB1 00           NOP         
BFB2 00           NOP         
BFB3 00           NOP         
BFB4 00           NOP         
BFB5 00           NOP         
BFB6 00           NOP         
BFB7 00           NOP         
BFB8 00           NOP         
BFB9 00           NOP         
BFBA 00           NOP         
BFBB 00           NOP         
BFBC 00           NOP         
BFBD 00           NOP         
BFBE 00           NOP         
BFBF F3           DI          
BFC0 CD 00 BD     CALL LBD00  
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
BFDA C3           defb C3h    
BFDB BF           defb BFh    
BFDC 1C           defb 1Ch    
BFDD 4A           defb 4Ah    
BFDE 2A           defb 2Ah    
BFDF BD           defb BDh    
BFE0 42           defb 42h    
BFE1 00           defb 00h    
BFE2 00           defb 00h    
BFE3 08           defb 08h    
BFE4 1C           defb 1Ch    
BFE5 4A           defb 4Ah    
BFE6 1F           defb 1Fh    
BFE7 3E           defb 3Eh    
BFE8 0D           defb 0Dh    
BFE9 28           defb 28h    
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
C000 C8           defb C8h    
C001 DD           defb DDh    
C002 CB           defb CBh    
C003 00           defb 00h    
C004 66           defb 66h    
C005 C8           defb C8h    
C006 35           defb 35h    
C007 C9           defb C9h    
C008 90           defb 90h    