    ORG $c000
gfx00    
    IFDEF DEVBUILD
        incbin "../data/gfxb00.bin"
    ELSE
        defb "GFXBANK00"
        defs $3FF7 * $00
    ENDIF