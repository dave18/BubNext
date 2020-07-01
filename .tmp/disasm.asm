L9ECC:       equ  9ECCh
LCC9E:       equ  CC9Eh
LCCCC:       equ  CCCCh


             org 5912h


5912 L5912:
5912 CC 9E CC     CALL Z,LCC9E 
5915 EC CC 9E     CALL PE,L9ECC 
5918 CC CC CC     CALL Z,LCCCC 
591B 9E           SBC  A,(HL) 
591C EE EE        XOR  EEh    
591E EE E8        XOR  E8h    
5920 EE EE        XOR  EEh    
5922 EE EE        XOR  EEh    
5924 EE EE        XOR  EEh    
5926 EE EE        XOR  EEh    
5928 EE EE        XOR  EEh    
592A EE EE        XOR  EEh    
592C EE EE        XOR  EEh    
592E E8           RET  PE     
592F EE EE        XOR  EEh    
5931 EE EE        XOR  EEh    
5933 EE EE        XOR  EEh    
5935 E8           RET  PE     
5936 EE EE        XOR  EEh    
5938 EE EE        XOR  EEh    
593A EE EE        XOR  EEh    
593C 88           ADC  A,B    
593D 88           ADC  A,B    
593E 88           ADC  A,B    
593F 88           ADC  A,B    
5940 EE EE        XOR  EEh    
5942 EE EE        XOR  EEh    
5944 EE EE        XOR  EEh    
5946 EE EE        XOR  EEh    
5948 EE EE        XOR  EEh    
594A EE EE        XOR  EEh    
594C EE E8        XOR  E8h    
594E EE EE        XOR  EEh    
5950 EE EE        XOR  EEh    
5952 EE EE        XOR  EEh    
5954 EE EE        XOR  EEh    
5956 EE 8E        XOR  8Eh    
5958 EE EE        XOR  EEh    
595A EE EE        XOR  EEh    
595C 88           ADC  A,B    
595D 88           ADC  A,B    
595E 88           ADC  A,B    
595F 88           ADC  A,B    
5960 EE EE        XOR  EEh    
5962 EE EE        XOR  EEh    
5964 EE EE        XOR  EEh    
5966 EE E8        XOR  E8h    
5968 8E           ADC  A,(HL) 
5969 EE EE        XOR  EEh    
596B 8E           ADC  A,(HL) 
596C EE EE        XOR  EEh    
596E EE EE        XOR  EEh    
5970 EE EE        XOR  EEh    
5972 8E           ADC  A,(HL) 
5973 EE E8        XOR  E8h    
5975 EE 00        XOR  00h    


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 