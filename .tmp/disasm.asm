L0008:       equ  0008h
L0028:       equ  0028h
L0038:       equ  0038h
LCCCC:       equ  CCCCh
LCFCC:       equ  CFCCh
LEECF:       equ  EECFh
LFECC:       equ  FECCh


             org 4FFDh


4FFD L4FFD:
4FFD CC CC CC     CALL Z,LCCCC 
5000 CC CC CC     CALL Z,LCCCC 
5003 FE CC        CP   CCh    
5005 CC CC FE     CALL Z,LFECC 
5008 CC CC CC     CALL Z,LCCCC 
500B FE CC        CP   CCh    
500D CC CC CF     CALL Z,LCFCC 
5010 CC CC CC     CALL Z,LCCCC 
5013 CF CC        RST  08h,CCh 
5015 CC CC CF     CALL Z,LCFCC 
5018 CC CC CC     CALL Z,LCCCC 
501B CF CC        RST  08h,CCh 
501D CC CC CF     CALL Z,LCFCC 
5020 EE EE        XOR  EEh    
5022 EE FF        XOR  FFh    
5024 EE EE        XOR  EEh    
5026 EE FF        XOR  FFh    
5028 EE EE        XOR  EEh    
502A EE FF        XOR  FFh    
502C EE EE        XOR  EEh    
502E EE FF        XOR  FFh    
5030 EE EE        XOR  EEh    
5032 EE EF        XOR  EFh    
5034 EE EE        XOR  EEh    
5036 EE EF        XOR  EFh    
5038 EE EE        XOR  EEh    
503A EE EF        XOR  EFh    
503C EE EE        XOR  EEh    
503E EE FE        XOR  FEh    
5040 FC CF EE     CALL M,LEECF 
5043 EE FC        XOR  FCh    
5045 CF EE        RST  08h,EEh 
5047 EE FC        XOR  FCh    
5049 FE EE        CP   EEh    
504B EF           RST  28h    
504C FF           RST  38h    
504D FE EE        CP   EEh    
504F FE FF        CP   FFh    
5051 EE EE        XOR  EEh    
5053 FE FE        CP   FEh    
5055 EE EE        XOR  EEh    
5057 FE EE        CP   EEh    
5059 EE EE        XOR  EEh    
505B FE EE        CP   EEh    
505D EE EE        XOR  EEh    
505F FE EE        CP   EEh    


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 