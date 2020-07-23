    ORG $c000
gfx01    
    IFDEF DEVBUILD
        incbin "../data/gfxb01.bin"
    ELSE
        defb "GFXBANK01"
        defs $3FF7 * $00
    ENDIF
    