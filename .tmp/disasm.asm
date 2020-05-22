L0073:       equ  0073h
L3868:       equ  3868h


             org 0000h


0000 L0000:
0000 38 71        JR   C,L0073 
0002 26 6F        LD   H,6Fh  
0004 36 00        LD   (HL),00h 
0006 E1           POP  HL     
0007 C9           RET         


0008 E5           defb E5h    
0009 26           defb 26h    
000A 26           defb 26h    
000B 6F           defb 6Fh    
000C 36           defb 36h    
000D 01           defb 01h    
000E E1           defb E1h    
000F C9           defb C9h    
0010 C5           defb C5h    
0011 D5           defb D5h    
0012 E5           defb E5h    
0013 C3           defb C3h    


             org 387Ah


387A L387A:
387A 00           NOP         
387B 00           NOP         
387C 00           NOP         
387D 00           NOP         
387E 00           NOP         
387F 00           NOP         
3880 00           NOP         
3881 00           NOP         
3882 00           NOP         
3883 00           NOP         
3884 00           NOP         
3885 00           NOP         
3886 00           NOP         
3887 00           NOP         
3888 00           NOP         
3889 00           NOP         
388A 00           NOP         
388B 00           NOP         
388C 00           NOP         
388D 00           NOP         
388E 00           NOP         
388F 00           NOP         
3890 00           NOP         
3891 00           NOP         
3892 00           NOP         
3893 00           NOP         
3894 00           NOP         
3895 00           NOP         
3896 20 D0        JR   NZ,L3868 
3898 3C           INC  A      
3899 8D           ADC  A,L    
389A 28 01        JR   Z,L389D 
389C 04           INC  B      
389D L389D:
389D 00           NOP         
389E 00           NOP         
389F 00           NOP         
38A0 00           NOP         
38A1 54           LD   D,H    
38A2 0B           DEC  BC     
38A3 00           NOP         
38A4 02           LD   (BC),A 
38A5 01 02 04     LD   BC,0402h 
38A8 00           NOP         
38A9 00           NOP         
38AA 00           NOP         
38AB 00           NOP         
38AC 00           NOP         
38AD 00           NOP         
38AE 00           NOP         
38AF 00           NOP         
38B0 00           NOP         
38B1 00           NOP         
38B2 00           NOP         
38B3 00           NOP         
38B4 00           NOP         
38B5 00           NOP         
38B6 00           NOP         
38B7 00           NOP         
38B8 00           NOP         
38B9 00           NOP         
38BA 00           NOP         
38BB 00           NOP         
38BC 00           NOP         
38BD 00           NOP         
38BE 00           NOP         
38BF 00           NOP         
38C0 00           NOP         
38C1 00           NOP         
38C2 00           NOP         
38C3 00           NOP         
38C4 00           NOP         
38C5 00           NOP         
38C6 00           NOP         
38C7 00           NOP         
38C8 00           NOP         
38C9 00           NOP         
38CA 00           NOP         
38CB 00           NOP         
38CC 00           NOP         
38CD 00           NOP         
38CE 00           NOP         
38CF 00           NOP         
38D0 00           NOP         
38D1 00           NOP         
38D2 00           NOP         
38D3 00           NOP         
38D4 00           NOP         
38D5 00           NOP         
38D6 00           NOP         
38D7 00           NOP         
38D8 00           NOP         
38D9 00           NOP         
38DA 00           NOP         
38DB 00           NOP         
38DC 00           NOP         
38DD 00           NOP         


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 