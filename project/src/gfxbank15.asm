    ORG $c000
gfx15
    IFDEF DEVBUILD
        incbin "../data/gfxb15.bin"
    ELSE
        defb "GFXBANK15"
        defs $3FF7 * $00
    ENDIF
    