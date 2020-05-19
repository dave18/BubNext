             org 0000h


0000 L0000:
0000 00           NOP         
0001 00           NOP         
0002 00           NOP         
0003 00           NOP         
0004 00           NOP         
0005 00           NOP         
0006 00           NOP         
0007 00           NOP         
0008 00           NOP         
0009 00           NOP         
000A 00           NOP         
000B 00           NOP         
000C 00           NOP         
000D 00           NOP         
000E 00           NOP         
000F 00           NOP         
0010 00           NOP         
0011 00           NOP         
0012 00           NOP         
0013 00           NOP         
0014 00           NOP         
0015 00           NOP         
0016 00           NOP         
0017 00           NOP         
0018 00           NOP         
0019 00           NOP         
001A 00           NOP         
001B 00           NOP         
001C 00           NOP         
001D 00           NOP         
001E 00           NOP         
001F 00           NOP         
0020 00           NOP         
0021 00           NOP         
0022 00           NOP         
0023 00           NOP         
0024 00           NOP         
0025 00           NOP         
0026 00           NOP         
0027 00           NOP         
0028 00           NOP         
0029 00           NOP         
002A 00           NOP         
002B 00           NOP         
002C 00           NOP         
002D 00           NOP         
002E 00           NOP         
002F 00           NOP         
0030 00           NOP         
0031 00           NOP         
0032 00           NOP         
0033 00           NOP         
0034 00           NOP         
0035 00           NOP         
0036 00           NOP         
0037 00           NOP         
0038 00           NOP         
0039 00           NOP         
003A 00           NOP         
003B 00           NOP         
003C 00           NOP         
003D 00           NOP         
003E 00           NOP         
003F 00           NOP         
0040 00           NOP         
0041 00           NOP         
0042 00           NOP         
0043 00           NOP         
0044 00           NOP         
0045 00           NOP         
0046 00           NOP         
0047 00           NOP         
0048 00           NOP         
0049 00           NOP         
004A 00           NOP         
004B 00           NOP         
004C 00           NOP         
004D 00           NOP         
004E 00           NOP         
004F 00           NOP         
0050 00           NOP         
0051 00           NOP         
0052 00           NOP         
0053 00           NOP         
0054 00           NOP         
0055 00           NOP         
0056 00           NOP         
0057 00           NOP         
0058 00           NOP         
0059 00           NOP         
005A 00           NOP         
005B 00           NOP         
005C 00           NOP         
005D 00           NOP         
005E 00           NOP         
005F 00           NOP         
0060 00           NOP         
0061 00           NOP         
0062 00           NOP         
0063 00           NOP         
0064 00           NOP         
0065 00           NOP         
0066 00           NOP         


             org 8180h


8180 L8180:
8180 F3           DI          
8181 ED 91 07 03  NEXTREG REG_TURBO_MODE,RTM_28MHZ 
8185 ED 91 12 08  NEXTREG REG_LAYER_2_RAM_PAGE,08h 
8189 ED 91 13 08  NEXTREG REG_LAYER_2_SHADOW_RAM_PAGE,08h 
818D ED 91 50 5E  NEXTREG REG_MMU0,5Eh 
8191 ED 91 51 00  NEXTREG REG_MMU1,00h 