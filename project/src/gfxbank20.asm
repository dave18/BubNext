    ORG $c000
gfx20
    IFDEF DEVBUILD
        incbin "../data/gfxb20.bin"
    ELSE
        defb "GFXBANK20"
        defs $3FF7 * $00
    ENDIF
    