;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Program that tests RAM and outputs    ;
;   faulty address                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UARTBASE        .EQU     80H
TEMPSTACK       .EQU     $FFFF
MEMSTART        .EQU     $3f01           ; Start of memory to scan
MEMEND          .EQU     $F000           ; End of memory to scan

CR              .EQU     0DH
LF              .EQU     0AH
CS              .EQU     0CH             ; Clear screen

                .ORG $0000

;------------------------------------------------------------------------------
; Reset

RST00           DI                        ;Disable interrupts
                JP       SETUP            ;Initialize Hardware and go

;------------------------------------------------------------------------------
; TX a character over RS232 

                .ORG     0008H
RST08            JP      CONOUT

;------------------------------------------------------------------------------
; RX a character over RS232 Channel A [Console], hold here until char ready.

                .ORG 0010H
RST10            JP      CONIN

CONIN:          in a, (085h)  ; read line status register
                and 001h      ; check data ready
                jr z, CONIN   ; wait until data ready=1
                in a, (080h)
                and 7fh       ;strip parity bit
                ret

CONOUT:         push af
serialx:        in a, (085h)        ; make sure transmitter reg is
                and 040h            ; empty
                jr z, serialx
                ; ld a, c
                pop af
                out (080h), a
                ret

CONST:          in a, (085h)  ; read line status register
                and 001h      ; check data ready
                jp z, nochar   ; wait until data ready=1
                ld a, 0ffh
                ret
nochar:         ld a,00h
                ret

WAIT:           push de             ; protect affected registers
                push af
outer:          ld de, 0100h
inner:          dec de
                ld a, d
                or e
                jp nz, inner
                dec bc
                ld a, b
                or c
                jp nz, outer
                pop af
                pop de
                ret

PRINT:          LD       A,(HL)          ; Get character
                OR       A               ; Is it $00 ?
                RET      Z               ; Then RETurn on terminator
                RST      08H             ; Print it
                INC      HL              ; Next Character
                JR       PRINT           ; Continue until $00
                RET

SETUP:          LD HL,TEMPSTACK          ; Temp stack
                LD SP,HL                 ; Set up a temporary stack
                ld bc, 0001h
                call WAIT                ; wait for reset finished
                ld a, 080h               ; initialize serial interface
                out (083h), a            ; enable access to the divisor regs
                ld a, 0ch                ; set divisor to 12, causes 9600 
                out (080h), a            ; baud rate
                ld a, 00h                ; set least significant bit of divisor
                out (081h), a
                ld a, 03h                ; set serial mode to 8-N-1
                out (083h), a
                LD HL,SIGNON             ; Sign-on message
                LD A, (HL)
                CALL PRINT               ; print string
                JP LOOP

output_pres:    INC A
                LD HL,HEX
next1:          INC HL
                DEC A
                JP NZ, next1
                LD A, (HL)
                RST 08H
                RET

parse_hex:      LD A, B
                RRA
                RRA
                RRA
                RRA
                AND 0fh
                call output_pres
                LD A, B
                AND 0fh
                call output_pres
                LD A, C
                RRA
                RRA
                RRA
                RRA
                AND 0fh
                call output_pres
                LD A, C
                AND 0fh
                call output_pres
                RET

TESTMEM:        LD HL, BC
                LD (HL), 0ffh
                LD A, (HL)
                SUB 0ffh
                JP NZ, ERROR
                LD (HL), 00h
                LD A, (HL)
                SUB 00h
                JP NZ, ERROR
                LD (HL), 0aah
                LD A, (HL)
                SUB 0aah
                JP NZ, ERROR
                LD (HL), 055h
                LD A, (HL)
                SUB 055h
                CALL NZ, ERROR
                RET

TESTMEM2:       LD HL, BC
                LD A, (HL)
                SUB 055h
                CALL NZ, ERROR
                LD (HL), 0aah
                LD A, (HL)
                SUB 0aah
                CALL NZ, ERROR
                RET

ERROR:          call parse_hex
                LD HL, MEMERR
                call PRINT
                LD HL, NEWLINE
                LD A, (HL)
                call PRINT
                RET

LOOP:           ld bc, MEMSTART
loop2:          ld a, c
                dec a
                jp nz, dontprint
                call parse_hex
                ld hl, NEWLINE
                ld a, (hl)
                call PRINT
dontprint:      ld hl, MEMEND
                sbc hl, bc
                jp z, endtest1
                inc bc
                call TESTMEM
                jp loop2
endtest1:       ld bc, MEMSTART
loop3:          ld a, c
                dec a
                jp nz, dontprint2
                call parse_hex
                ld hl, NEWLINE
                ld a, (hl)
                call PRINT
dontprint2:     ld hl, MEMEND
                sbc hl, bc
                jp z, endtest2
                inc bc
                call TESTMEM2
                jp loop3
endtest2:       ld hl, ENDMSG
                ld a, (hl)
                call PRINT
hangout:        jp hangout

SIGNON:         .BYTE     CS,"Falk's simple memory test",CR,LF,0
HEX:            .BYTE    "_0123456789abcdef"
NEWLINE:        .BYTE    CR,LF,0
MEMERR:         .BYTE    " faulty memory or rom",0
ENDMSG:         .BYTE    "Test ended",CR,LF,0

.end
