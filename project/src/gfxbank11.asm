    ORG $c000
gfx11
    IFDEF DEVBUILD
        incbin "../data/gfxb11.bin"
    ELSE
        defb "GFXBANK11"
        defs $3FF7 * $00
    ENDIF
    