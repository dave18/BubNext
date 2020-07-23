    ORG $c000
gfx23
    IFDEF DEVBUILD
        incbin "../data/gfxb23.bin"
    ELSE
        defb "GFXBANK23"
        defs $3FF7 * $00
    ENDIF
    