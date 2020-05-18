L33CC:       equ  33CCh
L3F33:       equ  3F33h
LFFFF:       equ  FFFFh


             org 7019h


7019 L7019:
7019 CC 33 3F     CALL Z,L3F33 
701C F3           DI          
701D CC CC 33     CALL Z,L33CC 
7020 F3           DI          
7021 33           INC  SP     
7022 3C           INC  A      
7023 C3 FF FF     JP   LFFFF  


7026 3C           defb 3Ch    
7027 C3           defb C3h    
7028 F3           defb F3h    
7029 33           defb 33h    
702A 3C           defb 3Ch    
702B C3           defb C3h    
702C F3           defb F3h    
702D CC           defb CCh    
702E CC           defb CCh    
702F 33           defb 33h    
7030 F3           defb F3h    
7031 33           defb 33h    
7032 33           defb 33h    
7033 3F           defb 3Fh    
7034 FF           defb FFh    
7035 FF           defb FFh    
7036 FF           defb FFh    
7037 FF           defb FFh    
7038 FF           defb FFh    
7039 FF           defb FFh    
703A FF           defb FFh    
703B FF           defb FFh    
703C FF           defb FFh    
703D FF           defb FFh    
703E FF           defb FFh    
703F FF           defb FFh    
7040 FF           defb FFh    
7041 FF           defb FFh    
7042 FF           defb FFh    
7043 FF           defb FFh    
7044 FF           defb FFh    
7045 FF           defb FFh    
7046 FF           defb FFh    
7047 FF           defb FFh    
7048 FF           defb FFh    
7049 FF           defb FFh    
704A FF           defb FFh    
704B FF           defb FFh    
704C FF           defb FFh    
704D 33           defb 33h    
704E 33           defb 33h    
704F 33           defb 33h    
7050 F3           defb F3h    
7051 3C           defb 3Ch    
7052 CC           defb CCh    
7053 C3           defb C3h    
7054 F3           defb F3h    
7055 CC           defb CCh    
7056 33           defb 33h    
7057 33           defb 33h    
7058 F3           defb F3h    
7059 CC           defb CCh    
705A 33           defb 33h    
705B 3F           defb 3Fh    
705C F3           defb F3h    
705D CC           defb CCh    
705E CC           defb CCh    
705F 33           defb 33h    
7060 F3           defb F3h    
7061 CC           defb CCh    
7062 33           defb 33h    
7063 C3           defb C3h    
7064 F3           defb F3h    
7065 CC           defb CCh    
7066 33           defb 33h    
7067 C3           defb C3h    
7068 F3           defb F3h    
7069 CC           defb CCh    
706A 33           defb 33h    
706B C3           defb C3h    
706C F3           defb F3h    
706D 3C           defb 3Ch    
706E CC           defb CCh    
706F 33           defb 33h    
7070 FF           defb FFh    
7071 33           defb 33h    
7072 33           defb 33h    
7073 3F           defb 3Fh    
7074 FF           defb FFh    
7075 FF           defb FFh    
7076 FF           defb FFh    
7077 FF           defb FFh    
7078 FF           defb FFh    
7079 FF           defb FFh    
707A FF           defb FFh    
707B FF           defb FFh    
707C FF           defb FFh    


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 