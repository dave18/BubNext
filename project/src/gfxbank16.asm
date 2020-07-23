    ORG $c000
gfx16
    IFDEF DEVBUILD
        incbin "../data/gfxb16.bin"
    ELSE
        defb "GFXBANK16"
        defs $3FF7 * $00
    ENDIF
    