    ORG $c000
gfx02    
    IFDEF DEVBUILD
        incbin "../data/gfxb02.bin"
    ELSE
        defb "GFXBANK02"
        defs $3FF7 * $00
    ENDIF
    