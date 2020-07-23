    ORG $c000
gfx18
    IFDEF DEVBUILD
        incbin "../data/gfxb18.bin"
    ELSE
        defb "GFXBANK18"
        defs $3FF7 * $00
    ENDIF
    