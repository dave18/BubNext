    ORG $c000
gfx06    
    IFDEF DEVBUILD
        incbin "../data/gfxb06.bin"
    ELSE
        defb "GFXBANK06"
        defs $3FF7 * $00
    ENDIF
    