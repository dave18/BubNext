    ORG $c000
gfx05    
    IFDEF DEVBUILD
        incbin "../data/gfxb05.bin"
    ELSE
        defb "GFXBANK05"
        defs $3FF7 * $00
    ENDIF
    