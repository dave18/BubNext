L02BF:       equ  02BFh
L5C78:       equ  5C78h


             org 0038h


0038 L0038:
0038 F5           PUSH AF     
0039 E5           PUSH HL     
003A 2A 78 5C     LD   HL,(L5C78) 
003D 23           INC  HL     
003E 22 78 5C     LD   (L5C78),HL 
0041 7C           LD   A,H    
0042 B5           OR   L      
0043 20 03        JR   NZ,L0048 
0045 FD 34 40     INC  (IY+64) 
0048 L0048:
0048 C5           PUSH BC     
0049 D5           PUSH DE     
004A CD BF 02     CALL L02BF  
004D D1           POP  DE     
004E C1           POP  BC     
004F E1           POP  HL     
0050 F1           POP  AF     
0051 FB           EI          
0052 C9           RET         


0053 E1           defb E1h    
0054 6E           defb 6Eh    
0055 FD           defb FDh    
0056 75           defb 75h    
0057 00           defb 00h    
0058 ED           defb EDh    
0059 7B           defb 7Bh    
005A 3D           defb 3Dh    
005B 5C           defb 5Ch    
005C C3           defb C3h    
005D C5           defb C5h    
005E 16           defb 16h    
005F FF           defb FFh    
0060 FF           defb FFh    
0061 FF           defb FFh    
0062 FF           defb FFh    
0063 FF           defb FFh    
0064 FF           defb FFh    
0065 FF           defb FFh    
0066 F5           defb F5h    
0067 E5           defb E5h    
0068 2A           defb 2Ah    
0069 B0           defb B0h    
006A 5C           defb 5Ch    
006B 7C           defb 7Ch    
006C B5           defb B5h    
006D 20           defb 20h    
006E 01           defb 01h    
006F E9           defb E9h    
0070 E1           defb E1h    
0071 F1           defb F1h    
0072 ED           defb EDh    
0073 45           defb 45h    
0074 2A           defb 2Ah    
0075 5D           defb 5Dh    
0076 5C           defb 5Ch    
0077 23           defb 23h    
0078 22           defb 22h    
0079 5D           defb 5Dh    
007A 5C           defb 5Ch    
007B 7E           defb 7Eh    
007C C9           defb C9h    
007D FE           defb FEh    
007E 21           defb 21h    
007F D0           defb D0h    
0080 FE           defb FEh    
0081 0D           defb 0Dh    
0082 C8           defb C8h    
0083 FE           defb FEh    
0084 10           defb 10h    
0085 D8           defb D8h    
0086 FE           defb FEh    
0087 18           defb 18h    
0088 3F           defb 3Fh    
0089 D8           defb D8h    
008A 23           defb 23h    
008B FE           defb FEh    
008C 16           defb 16h    
008D 38           defb 38h    
008E 01           defb 01h    
008F 23           defb 23h    
0090 37           defb 37h    
0091 22           defb 22h    
0092 5D           defb 5Dh    
0093 5C           defb 5Ch    
0094 C9           defb C9h    
0095 BF           defb BFh    
0096 52           defb 52h    
0097 4E           defb 4Eh    
0098 C4           defb C4h    
0099 49           defb 49h    
009A 4E           defb 4Eh    
009B 4B           defb 4Bh    


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 