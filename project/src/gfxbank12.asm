    ORG $c000
gfx12
    IFDEF DEVBUILD
        incbin "../data/gfxb12.bin"
    ELSE
        defb "GFXBANK12"
        defs $3FF7 * $00
    ENDIF
    