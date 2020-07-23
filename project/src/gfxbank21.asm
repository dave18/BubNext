    ORG $c000
gfx21
    IFDEF DEVBUILD
        incbin "../data/gfxb21.bin"
    ELSE
        defb "GFXBANK21"
        defs $3FF7 * $00
    ENDIF
    