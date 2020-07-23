    ORG $c000
gfx24
    IFDEF DEVBUILD
        incbin "../data/gfxb24.bin"
    ELSE
        defb "GFXBANK24"
        defs $3FF7 * $00
    ENDIF
    