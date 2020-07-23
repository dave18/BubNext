    ORG $c000
gfx10   
    IFDEF DEVBUILD
        incbin "../data/gfxb10.bin"
    ELSE
        defb "GFXBANK10"
        defs $3FF7 * $00
    ENDIF
    