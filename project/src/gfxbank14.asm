    ORG $c000
gfx14
    IFDEF DEVBUILD
        incbin "../data/gfxb14.bin"
    ELSE
        defb "GFXBANK14"
        defs $3FF7 * $00
    ENDIF
    