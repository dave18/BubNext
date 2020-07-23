    ORG $c000
gfx09    
    IFDEF DEVBUILD
        incbin "../data/gfxb09.bin"
    ELSE
        defb "GFXBANK09"
        defs $3FF7 * $00
    ENDIF
    