    ORG $c000
gfx03    
    IFDEF DEVBUILD
        incbin "../data/gfxb03.bin"
    ELSE
        defb "GFXBANK03"
        defs $3FF7 * $00
    ENDIF
    