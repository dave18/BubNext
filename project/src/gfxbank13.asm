    ORG $c000
gfx13
    IFDEF DEVBUILD
        incbin "../data/gfxb13.bin"
    ELSE
        defb "GFXBANK13"
        defs $3FF7 * $00
    ENDIF
    