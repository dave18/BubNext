    ORG $c000
gfx17
    IFDEF DEVBUILD
        incbin "../data/gfxb17.bin"
    ELSE
        defb "GFXBANK17"
        defs $3FF7 * $00
    ENDIF
    