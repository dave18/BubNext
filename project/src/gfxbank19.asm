    ORG $c000
gfx19
    IFDEF DEVBUILD
        incbin "../data/gfxb19.bin"
    ELSE
        defb "GFXBANK19"
        defs $3FF7 * $00
    ENDIF
    