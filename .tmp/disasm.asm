L0020:       equ  0020h
L0030:       equ  0030h
L0038:       equ  0038h
L4557:       equ  4557h
L55B7:       equ  55B7h
L9A55:       equ  9A55h


             org 00F0h


00F0 L00F0:
00F0 00           NOP         
00F1 00           NOP         
00F2 00           NOP         
00F3 00           NOP         
00F4 00           NOP         
00F5 00           NOP         
00F6 00           NOP         
00F7 00           NOP         
00F8 00           NOP         
00F9 00           NOP         
00FA 00           NOP         
00FB 00           NOP         
00FC 00           NOP         
00FD 00           NOP         
00FE 00           NOP         
00FF 00           NOP         
0100 E5           PUSH HL     
0101 26 26        LD   H,26h  
0103 6F           LD   L,A    
0104 36 00        LD   (HL),00h 
0106 E1           POP  HL     
0107 C9           RET         


0108 E5           defb E5h    
0109 26           defb 26h    
010A 26           defb 26h    
010B 6F           defb 6Fh    
010C 36           defb 36h    
010D 01           defb 01h    
010E E1           defb E1h    
010F C9           defb C9h    
0110 C5           defb C5h    
0111 D5           defb D5h    
0112 E5           defb E5h    
0113 C3           defb C3h    
0114 8A           defb 8Ah    
0115 01           defb 01h    
0116 C5           defb C5h    
0117 D5           defb D5h    
0118 E5           defb E5h    
0119 3E           defb 3Eh    
011A 01           defb 01h    
011B C3           defb C3h    
011C 8A           defb 8Ah    
011D 01           defb 01h    
011E 21           defb 21h    
011F 00           defb 00h    
0120 26           defb 26h    
0121 06           defb 06h    
0122 06           defb 06h    
0123 C3           defb C3h    
0124 84           defb 84h    
0125 01           defb 01h    
0126 21           defb 21h    
0127 00           defb 00h    
0128 26           defb 26h    
0129 6F           defb 6Fh    
012A 36           defb 36h    
012B 01           defb 01h    
012C C3           defb C3h    
012D AF           defb AFh    
012E 09           defb 09h    
012F C3           defb C3h    
0130 B9           defb B9h    
0131 09           defb 09h    
0132 00           defb 00h    
0133 19           defb 19h    
0134 EB           defb EBh    
0135 E1           defb E1h    
0136 CB           defb CBh    
0137 25           defb 25h    
0138 4D           defb 4Dh    
0139 3E           defb 3Eh    
013A 06           defb 06h    
013B 85           defb 85h    
013C 6F           defb 6Fh    
013D 73           defb 73h    
013E 23           defb 23h    
013F 72           defb 72h    
0140 3E           defb 3Eh    
0141 10           defb 10h    
0142 83           defb 83h    
0143 5F           defb 5Fh    
0144 30           defb 30h    
0145 01           defb 01h    
0146 14           defb 14h    
0147 21           defb 21h    
0148 E9           defb E9h    
0149 09           defb 09h    
014A 06           defb 06h    
014B 00           defb 00h    
014C 09           defb 09h    
014D 4E           defb 4Eh    
014E 23           defb 23h    
014F 46           defb 46h    
0150 EB           defb EBh    
0151 71           defb 71h    
0152 23           defb 23h    
0153 70           defb 70h    


             org 55D5h


55D5 L55D5:
55D5 F4 B7 55     CALL P,L55B7 
55D8 FF           RST  38h    
55D9 F7           RST  30h    
55DA 77           LD   (HL),A 
55DB 59           LD   E,C    
55DC FF           RST  38h    
55DD F4 55 9A     CALL P,L9A55 
55E0 FF           RST  38h    
55E1 FF           RST  38h    
55E2 FF           RST  38h    
55E3 FF           RST  38h    
55E4 FF           RST  38h    
55E5 FF           RST  38h    
55E6 FF           RST  38h    
55E7 FF           RST  38h    
55E8 B7           OR   A      
55E9 FF           RST  38h    
55EA FF           RST  38h    
55EB FF           RST  38h    
55EC 75           LD   (HL),L 
55ED 74           LD   (HL),H 
55EE FF           RST  38h    
55EF FF           RST  38h    
55F0 74           LD   (HL),H 
55F1 B5           OR   L      
55F2 FF           RST  38h    
55F3 FF           RST  38h    
55F4 57           LD   D,A    
55F5 54           LD   D,H    
55F6 7F           LD   A,A    
55F7 FF           RST  38h    
55F8 95           SUB  L      
55F9 45           LD   B,L    
55FA 4F           LD   C,A    
55FB FF           RST  38h    
55FC A9           XOR  C      
55FD 54           LD   D,H    
55FE 7F           LD   A,A    
55FF FF           RST  38h    
5600 FF           RST  38h    
5601 F7           RST  30h    
5602 75           LD   (HL),L 
5603 9A           SBC  A,D    
5604 FF           RST  38h    
5605 F5           PUSH AF     
5606 B7           OR   A      
5607 59           LD   E,C    
5608 FF           RST  38h    
5609 F4 57 45     CALL P,L4557 
560C FF           RST  38h    
560D FF           RST  38h    
560E 74           LD   (HL),H 
560F 54           LD   D,H    
5610 FF           RST  38h    
5611 FF           RST  38h    
5612 45           LD   B,L    
5613 77           LD   (HL),A 
5614 FF           RST  38h    
5615 FF           RST  38h    
5616 FF           RST  38h    
5617 47           LD   B,A    
5618 FF           RST  38h    
5619 FF           RST  38h    
561A FF           RST  38h    
561B FF           RST  38h    
561C FF           RST  38h    
561D FF           RST  38h    
561E FF           RST  38h    
561F FF           RST  38h    
5620 A9           XOR  C      
5621 5B           LD   E,E    
5622 7F           LD   A,A    
5623 FF           RST  38h    
5624 95           SUB  L      
5625 44           LD   B,H    
5626 7F           LD   A,A    
5627 FF           RST  38h    
5628 57           LD   D,A    
5629 B7           OR   A      
562A 5F           LD   E,A    
562B FF           RST  38h    
562C 74           LD   (HL),H 
562D 44           LD   B,H    
562E FF           RST  38h    
562F FF           RST  38h    
5630 4B           LD   C,E    
5631 45           LD   B,L    
5632 FF           RST  38h    
5633 FF           RST  38h    
5634 57           LD   D,A    
5635 FF           RST  38h    
5636 FF           RST  38h    
5637 FF           RST  38h    
5638 FF           RST  38h    


             org 8180h


8180 L8180:
8180 2D           DEC  L      
8181 07           RLCA        
8182 00           NOP         
8183 07           RLCA        
8184 00           NOP         
8185 07           RLCA        
8186 00           NOP         
8187 07           RLCA        
8188 00           NOP         
8189 07           RLCA        
818A E7           RST  20h    
818B 07           RLCA        
818C 00           NOP         
818D 07           RLCA        
818E 00           NOP         
818F 07           RLCA        
8190 00           NOP         
8191 07           RLCA        
8192 00           NOP         
8193 07           RLCA        