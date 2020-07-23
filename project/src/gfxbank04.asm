    ORG $c000
gfx04    
    IFDEF DEVBUILD
        incbin "../data/gfxb04.bin"
    ELSE
        defb "GFXBANK04"
        defs $3FF7 * $00
    ENDIF
    