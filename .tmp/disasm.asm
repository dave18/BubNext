L0038:       equ  0038h
L1FCC:       equ  1FCCh
LC1CC:       equ  C1CCh
LCC1C:       equ  CC1Ch
LCCCC:       equ  CCCCh


             org 5BFDh


5BFD L5BFD:
5BFD CC 1C CC     CALL Z,LCC1C 
5C00 FF           RST  38h    
5C01 FF           RST  38h    
5C02 FF           RST  38h    
5C03 FF           RST  38h    
5C04 FF           RST  38h    
5C05 11 11 FF     LD   DE,FF11h 
5C08 F1           POP  AF     
5C09 CC CC 1F     CALL Z,L1FCC 
5C0C 1C           INC  E      
5C0D CC CC C1     CALL Z,LC1CC 
5C10 CC CC CC     CALL Z,LCCCC 
5C13 C1           POP  BC     
5C14 CC CC CC     CALL Z,LCCCC 
5C17 C1           POP  BC     
5C18 CC CC CC     CALL Z,LCCCC 
5C1B C1           POP  BC     
5C1C CC CC CC     CALL Z,LCCCC 
5C1F 1F           RRA         
5C20 FF           RST  38h    
5C21 BF           CP   A      
5C22 FF           RST  38h    
5C23 FF           RST  38h    
5C24 FF           RST  38h    
5C25 FF           RST  38h    
5C26 FF           RST  38h    
5C27 FF           RST  38h    
5C28 FF           RST  38h    
5C29 FF           RST  38h    
5C2A FF           RST  38h    
5C2B FF           RST  38h    
5C2C FF           RST  38h    
5C2D FF           RST  38h    
5C2E FF           RST  38h    
5C2F FF           RST  38h    
5C30 FF           RST  38h    
5C31 FF           RST  38h    
5C32 FF           RST  38h    
5C33 FF           RST  38h    
5C34 FF           RST  38h    
5C35 FF           RST  38h    
5C36 FF           RST  38h    
5C37 FF           RST  38h    
5C38 FF           RST  38h    
5C39 FF           RST  38h    
5C3A FF           RST  38h    
5C3B FF           RST  38h    
5C3C FF           RST  38h    
5C3D FF           RST  38h    
5C3E FF           RST  38h    
5C3F FF           RST  38h    
5C40 FF           RST  38h    
5C41 FF           RST  38h    
5C42 FF           RST  38h    
5C43 FF           RST  38h    
5C44 FF           RST  38h    
5C45 FF           RST  38h    
5C46 FF           RST  38h    
5C47 FF           RST  38h    
5C48 FF           RST  38h    
5C49 FF           RST  38h    
5C4A FF           RST  38h    
5C4B FF           RST  38h    
5C4C FF           RST  38h    
5C4D FF           RST  38h    
5C4E FF           RST  38h    
5C4F FF           RST  38h    
5C50 FF           RST  38h    
5C51 FF           RST  38h    
5C52 FF           RST  38h    
5C53 FF           RST  38h    
5C54 FF           RST  38h    
5C55 FF           RST  38h    
5C56 FF           RST  38h    
5C57 FF           RST  38h    
5C58 FF           RST  38h    
5C59 FF           RST  38h    
5C5A FF           RST  38h    
5C5B FF           RST  38h    
5C5C FF           RST  38h    
5C5D FF           RST  38h    
5C5E FF           RST  38h    
5C5F FF           RST  38h    
5C60 FF           RST  38h    


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 