; Minimal serial smoke test ROM for the Falk Z80 SBC.
; Initializes the TL16C550A UART and repeatedly emits a test pattern.

CR              .EQU     0DH
LF              .EQU     0AH
TEMPSTACK       .EQU     $FFFF

                .ORG $0000

RST00:          DI
                JP      SETUP

                .ORG $0008
RST08:          JP      CONOUT

                .ORG $0010
RST10:          JP      CONIN

                .ORG $0018
RST18:          JP      CONST

CONIN:          IN      A,(085H)
                AND     001H
                JR      Z,CONIN
                IN      A,(080H)
                AND     07FH
                RET

CONOUT:         PUSH    AF
TXWAIT:         IN      A,(085H)
                AND     040H
                JR      Z,TXWAIT
                POP     AF
                OUT     (080H),A
                RET

CONST:          IN      A,(085H)
                AND     001H
                JR      Z,NOCHAR
                LD      A,$FF
                RET
NOCHAR:         XOR     A
                RET

PRINTL:         LD      A,(HL)
                OR      A
                RET     Z
                RST     08H
                INC     HL
                JR      PRINTL

SETUP:          LD      HL,TEMPSTACK
                LD      SP,HL
                LD      BC,$0001
                CALL    WAITX
                LD      A,$80
                OUT     ($83),A
                LD      A,$0C
                OUT     ($80),A
                XOR     A
                OUT     ($81),A
                LD      A,$03
                OUT     ($83),A
                LD      HL,SIGNON
                CALL    PRINTL

MAINLOOP:       LD      A,'U'
                RST     08H
                LD      A,'A'
                RST     08H
                LD      A,'R'
                RST     08H
                LD      A,'T'
                RST     08H
                LD      A,' '
                RST     08H
                LD      A,'O'
                RST     08H
                LD      A,'K'
                RST     08H
                LD      A,CR
                RST     08H
                LD      A,LF
                RST     08H
                LD      BC,$0800
                CALL    WAITX
                JR      MAINLOOP

WAITX:          PUSH    DE
                PUSH    AF
OUTER:          LD      DE,$0100
INNER:          DEC     DE
                LD      A,D
                OR      E
                JP      NZ,INNER
                DEC     BC
                LD      A,B
                OR      C
                JP      NZ,OUTER
                POP     AF
                POP     DE
                RET

SIGNON:         .BYTE   CR,LF,"UART smoke test",CR,LF,0

                .END
