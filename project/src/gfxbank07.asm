    ORG $c000
gfx07    
    IFDEF DEVBUILD
        incbin "../data/gfxb07.bin"
    ELSE
        defb "GFXBANK07"
        defs $3FF7 * $00
    ENDIF
    