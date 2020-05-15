MACRO nextreg,nreg,nval

db $ed

IF NUL nval
;.WARNING "nextreg rr,a"
    db $92,nreg
ELSE
;.WARNING "nextreg rr,nn"
    db $91,nreg,nval
ENDIF

ENDM


