    ORG $c000
gfx08    
    IFDEF DEVBUILD
        incbin "../data/gfxb08.bin"
    ELSE
        defb "GFXBANK08"
        defs $3FF7 * $00
    ENDIF
    