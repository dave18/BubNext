    ORG $c000
gfx22
    IFDEF DEVBUILD
        incbin "../data/gfxb22.bin"
    ELSE
        defb "GFXBANK22"
        defs $3FF7 * $00
    ENDIF
    