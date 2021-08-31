DELAY       MACRO       REG
DELAY       IDENT       1,0
;
;       Delay macro
;

            MOVE        REG,x:(r0)+
            MOVE        x:(r0),REG

            ENDM