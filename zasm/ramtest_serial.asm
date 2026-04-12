; Serial RAM test ROM for the Falk Z80 SBC.
; Tests RAM from 8000h upward and reports the highest good address.

CR              .EQU     0DH
LF              .EQU     0AH
TEMPSTACK       .EQU     $FFFF
RAMSTART        .EQU     $8000

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

PRINTCRLF:      LD      A,CR
                RST     08H
                LD      A,LF
                RST     08H
                RET

PRINTHEXHL:     LD      A,H
                CALL    PRINTHEXBYTE
                LD      A,L
                CALL    PRINTHEXBYTE
                RET

PRINTHEXBYTE:   PUSH    AF
                RRCA
                RRCA
                RRCA
                RRCA
                CALL    PRINTNIBBLE
                POP     AF
                CALL    PRINTNIBBLE
                RET

PRINTNIBBLE:    AND     $0F
                ADD     A,'0'
                CP      '9'+1
                JR      C,PRINTCHR
                ADD     A,7
PRINTCHR:       RST     08H
                RET

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

                LD      HL,RAMSTART
TESTLOOP:       LD      A,(HL)
                LD      C,A
                LD      A,$55
                LD      (HL),A
                CP      (HL)
                JR      NZ,FAIL55
                LD      A,$AA
                LD      (HL),A
                CP      (HL)
                JR      NZ,FAILAA
                LD      A,C
                LD      (HL),A
                INC     HL
                LD      A,H
                CP      $00
                JR      NZ,TESTLOOP

PASSALL:        LD      HL,PASSMSG
                CALL    PRINTL
                LD      HL,$FFFF
                CALL    PRINTHEXHL
                CALL    PRINTCRLF
                JR      DONE

FAIL55:         LD      B,$55
                JR      REPORTFAIL
FAILAA:         LD      B,$AA

REPORTFAIL:     LD      A,C
                LD      (HL),A
                PUSH    HL
                DEC     HL
                LD      DE,HL
                POP     HL
                LD      A,H
                OR      L
                JR      NZ,HAVEGOOD
                LD      DE,$0000
HAVEGOOD:       LD      HL,FAILMSG
                CALL    PRINTL
                EX      DE,HL
                CALL    PRINTHEXHL
                LD      HL,ATMSG
                CALL    PRINTL
                EX      DE,HL
                INC     HL
                CALL    PRINTHEXHL
                LD      HL,EXPMSG
                CALL    PRINTL
                LD      A,B
                CALL    PRINTHEXBYTE
                CALL    PRINTCRLF

DONE:           LD      HL,DONEMSG
                CALL    PRINTL
HALT:           JR      HALT

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

SIGNON:         .BYTE   CR,LF,"Serial RAM test",CR,LF,0
PASSMSG:        .BYTE   "PASS to ",0
FAILMSG:        .BYTE   "GOOD to ",0
ATMSG:          .BYTE   ", FAIL at ",0
EXPMSG:         .BYTE   ", expected ",0
DONEMSG:        .BYTE   "Done",CR,LF,0

                .END
