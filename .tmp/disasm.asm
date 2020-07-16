L0008:       equ  0008h
L2D3B:       equ  2D3Bh
L2FB8:       equ  2FB8h
L3014:       equ  3014h
LBD45:       equ  BD45h
LBDAF:       equ  BDAFh


             org 301Dh


301D L301D:
301D CD B8 2F     CALL L2FB8  
3020 21 DA D7     LD   HL,D7DAh 
3023 38 03        JR   C,L3028 
3025 21 0B 00     LD   HL,000Bh 
3028 L3028:
3028 CD 3B 2D     CALL L2D3B  
302B 18 E7        JR   L3014  


302D AF           defb AFh    
302E 32           defb 32h    
302F D5           defb D5h    
3030 D5           defb D5h    
3031 21           defb 21h    
3032 88           defb 88h    
3033 2A           defb 2Ah    
3034 1E           defb 1Eh    
3035 01           defb 01h    
3036 CD           defb CDh    
3037 11           defb 11h    
3038 31           defb 31h    
3039 C0           defb C0h    
303A E5           defb E5h    
303B 11           defb 11h    
303C D5           defb D5h    
303D D5           defb D5h    
303E CD           defb CDh    
303F AF           defb AFh    
3040 31           defb 31h    
3041 1A           defb 1Ah    
3042 13           defb 13h    
3043 3C           defb 3Ch    
3044 20           defb 20h    
3045 FB           defb FBh    
3046 1B           defb 1Bh    
3047 62           defb 62h    
3048 6B           defb 6Bh    
3049 01           defb 01h    
304A D5           defb D5h    
304B D5           defb D5h    
304C A7           defb A7h    
304D ED           defb EDh    
304E 42           defb 42h    
304F 22           defb 22h    
3050 18           defb 18h    
3051 DB           defb DBh    
3052 E1           defb E1h    
3053 7E           defb 7Eh    
3054 12           defb 12h    
3055 23           defb 23h    
3056 13           defb 13h    
3057 3C           defb 3Ch    
3058 20           defb 20h    
3059 F9           defb F9h    
305A 21           defb 21h    
305B 1C           defb 1Ch    
305C 2A           defb 2Ah    
305D CD           defb CDh    
305E 20           defb 20h    
305F 2D           defb 2Dh    
3060 37           defb 37h    
3061 C9           defb C9h    
3062 3A           defb 3Ah    
3063 D5           defb D5h    
3064 D5           defb D5h    
3065 A7           defb A7h    
3066 C8           defb C8h    
3067 21           defb 21h    
3068 7D           defb 7Dh    
3069 2A           defb 2Ah    
306A CD           defb CDh    
306B 18           defb 18h    
306C 31           defb 31h    
306D 11           defb 11h    
306E DA           defb DAh    
306F D7           defb D7h    
3070 CD           defb CDh    
3071 AF           defb AFh    
3072 31           defb 31h    
3073 21           defb 21h    
3074 D5           defb D5h    
3075 D5           defb D5h    
3076 ED           defb EDh    
3077 4B           defb 4Bh    
3078 18           defb 18h    
3079 DB           defb DBh    
307A 78           defb 78h    
307B B1           defb B1h    
307C 1A           defb 1Ah    
307D 28           defb 28h    
307E 0C           defb 0Ch    
307F FE           defb FEh    
3080 FF           defb FFh    


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 


             org 9852h


9852 L9852:
9852 CD 45 BD     CALL LBD45  
9855 DD 01 C9 00  LD   BC,00C9h 
9859 20 00        JR   NZ,L985B 
985B L985B:
985B 1F           RRA         
985C 49           LD   C,C    
985D 2E 46        LD   L,46h  
985F 00           NOP         
9860 20 00        JR   NZ,L9862 
9862 L9862:
9862 1B           DEC  DE     
9863 4D           LD   C,L    
9864 54           LD   D,H    
9865 4A           LD   C,D    


             org BD5Dh


BD5D LBD5D:
BD5D 3E 2A        LD   A,2Ah  
BD5F DD 21 A3 BD  LD   IX,BDA3h 
BD63 06 01        LD   B,01h  
BD65 CF 9A        RST  08h,9Ah 
BD67 DD 01 38 2B  LD   BC,2B38h 
BD6B 32 AF BD     LD   (LBDAF),A 
BD6E DD 21 B0 00  LD   IX,00B0h 