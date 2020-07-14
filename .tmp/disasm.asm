L0028:       equ  0028h
L0038:       equ  0038h
LCCCC:       equ  CCCCh
LEECC:       equ  EECCh
LFECF:       equ  FECFh
LFFCC:       equ  FFCCh


             org 65FDh


65FD L65FD:
65FD CC CF FE     CALL Z,LFECF 
6600 EE FF        XOR  FFh    
6602 FF           RST  38h    
6603 FF           RST  38h    
6604 EE EE        XOR  EEh    
6606 FF           RST  38h    
6607 FF           RST  38h    
6608 EE EE        XOR  EEh    
660A EE FF        XOR  FFh    
660C EE EE        XOR  EEh    
660E EE EE        XOR  EEh    
6610 EE EE        XOR  EEh    
6612 EE EE        XOR  EEh    
6614 EE EE        XOR  EEh    
6616 EE EE        XOR  EEh    
6618 EE EE        XOR  EEh    
661A EE EE        XOR  EEh    
661C EE EE        XOR  EEh    
661E EE EE        XOR  EEh    
6620 FF           RST  38h    
6621 EE EE        XOR  EEh    
6623 EE FF        XOR  FFh    
6625 FE EF        CP   EFh    
6627 FF           RST  38h    
6628 FF           RST  38h    
6629 FF           RST  38h    
662A EF           RST  28h    
662B FF           RST  38h    
662C FF           RST  38h    
662D FF           RST  38h    
662E EF           RST  28h    
662F FF           RST  38h    
6630 FF           RST  38h    
6631 FF           RST  38h    
6632 FF           RST  38h    
6633 FF           RST  38h    
6634 EF           RST  28h    
6635 FF           RST  38h    
6636 FF           RST  38h    
6637 FF           RST  38h    
6638 EF           RST  28h    
6639 FF           RST  38h    
663A FF           RST  38h    
663B FF           RST  38h    
663C EF           RST  28h    
663D FF           RST  38h    
663E EF           RST  28h    
663F FF           RST  38h    
6640 EE EE        XOR  EEh    
6642 EE EE        XOR  EEh    
6644 EE EE        XOR  EEh    
6646 EE EE        XOR  EEh    
6648 FF           RST  38h    
6649 EE EE        XOR  EEh    
664B EE FC        XOR  FCh    
664D FF           RST  38h    
664E EE EE        XOR  EEh    
6650 CC CC FF     CALL Z,LFFCC 
6653 EE FC        XOR  FCh    
6655 CC CC FF     CALL Z,LFFCC 
6658 FF           RST  38h    
6659 CC CC CC     CALL Z,LCCCC 
665C FF           RST  38h    
665D FF           RST  38h    
665E CC CC EE     CALL Z,LEECC 


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 