;==================================================================================
; Adapted from (no copyright claimed), implements CPM routines according
; to http://cpuville.com/cpm_on_new_computer.html
;
; Contents of this file are copyright Grant Searle
;
; You have permission to use this for NON COMMERCIAL USE ONLY
; If you wish to use it elsewhere, please include an acknowledgement to myself.
;
; http://searle.hostei.com/grant/index.html
;
; eMail: home.micros01@btinternet.com
;
; If the above don't work, please perform an Internet search to see if I have
; updated the web page hosting service.
;
;==================================================================================

; Minimum 6850 ACIA interrupt driven serial I/O to run modified NASCOM Basic 4.7
; Full input buffering with incoming data hardware handshaking
; Handshake shows full before the buffer is totally filled to allow run-on from the sender


SER_BUFSIZE     .EQU     3FH
; SER_FULLSIZE    .EQU     30H
; SER_EMPTYSIZE   .EQU     5

; RTS_HIGH        .EQU     0D6H
; RTS_LOW         .EQU     096H

serBuf          .EQU     $4000
serInPtr        .EQU     serBuf+SER_BUFSIZE
serRdPtr        .EQU     serInPtr+2
serBufUsed      .EQU     serRdPtr+2
UARTBaseAddress .EQU     80H
basicStarted    .EQU     serBufUsed+1
TEMPSTACK       .EQU     $ffff ; Top of BASIC line input buffer so is "free ram" when BASIC resets

CR              .EQU     0DH
LF              .EQU     0AH
CS              .EQU     0CH             ; Clear screen

                .ORG $0000
;------------------------------------------------------------------------------
; Reset

RST00           DI                       ;Disable interrupts
                JP       SETUP            ;Initialize Hardware and go

;------------------------------------------------------------------------------
; TX a character over RS232 

                .ORG     0008H
RST08            JP      CONOUT

;------------------------------------------------------------------------------
; RX a character over RS232 Channel A [Console], hold here until char ready.

                .ORG 0010H
RST10            JP      CONIN

;-----------------------------------------------------------------------------
; Check serial status

                 .ORG 0018H
RST18            JP      CONST

;------------------------------------------------------------------------------
; RST 38 - INTERRUPT VECTOR [ for IM 1 ]

;                 .ORG     0038H
; RST38            JR      serialInt

;------------------------------------------------------------------------------
; serialInt:      PUSH     AF
;                PUSH     HL
;
;                IN       A,($80)
;                AND      $01             ; Check if interupt due to read buffer full
;                JR       Z,rts0          ; if not, ignore
;
;                IN       A,($81)
;                PUSH     AF
;                LD       A,(serBufUsed)
;                CP       SER_BUFSIZE     ; If full then ignore
;                JR       NZ,notFull
;                POP      AF
;                JR       rts0

;notFull:        LD       HL,(serInPtr)
;                INC      HL
;                LD       A,L             ; Only need to check low byte because buffer<256 bytes
;                CP       (serBuf+SER_BUFSIZE) & $FF
;                JR       NZ, notWrap
;                LD       HL,serBuf
;notWrap:        LD       (serInPtr),HL
;                POP      AF
;                LD       (HL),A
;                LD       A,(serBufUsed)
;                INC      A
;                LD       (serBufUsed),A
;                CP       SER_FULLSIZE
;                JR       C,rts0
;                LD       A,RTS_HIGH
;                OUT      ($80),A
;rts0:           POP      HL
;                POP      AF
;                EI
;                RETI

;------------------------------------------------------------------------------
CONIN:                                    ; implement CONIN
                in a, (085h)  ; read line status register
                and 001h      ; check data ready
                jr z, CONIN   ; wait until data ready=1
                in a, (080h)
                and 7fh       ;strip parity bit
                ret

; waitForChar:    LD       A,(serBufUsed)
;                CP       $00
;                JR       Z, waitForChar
;                PUSH     HL
;                LD       HL,(serRdPtr)
;                INC      HL
;                LD       A,L             ; Only need to check low byte becasuse buffer<256 bytes
;                CP       (serBuf+SER_BUFSIZE) & $FF
;                JR       NZ, notRdWrap
;                LD       HL,serBuf
;notRdWrap:      DI
;                LD       (serRdPtr),HL
;                LD       A,(serBufUsed)
;                DEC      A
;                LD       (serBufUsed),A
;                CP       SER_EMPTYSIZE
;                JR       NC,rts1
;                LD       A,RTS_LOW
;                OUT      ($80),A
;rts1:
;                LD       A,(HL)
;                EI
;                POP      HL
;                RET; Char ready in A
;                 LD      A, $00
;                 RET

;------------------------------------------------------------------------------
CONOUT:                                    ; Implement CONIN
                push af
serialx:        in a, (085h)        ; make sure transmitter reg is
                and 040h            ; empty
                jr z, serialx
                ; ld a, c
                pop af
                out (080h), a
                ret
;                PUSH     AF              ; Store character
; conout1:        IN       A,($80)         ; Status byte       
;                BIT      1,A             ; Set Zero flag if still transmitting character       
;                JR       Z,conout1       ; Loop until flag signals ready
;                POP      AF              ; Retrieve character
;                OUT      ($81),A         ; Output the character
                 RET

;------------------------------------------------------------------------------
CONST:          
                in a, (085h)  ; read line status register
                and 001h      ; check data ready
                jp z, NOCHAR   ; wait until data ready=1
                ld a, 0ffh
                ret
NOCHAR:         ld a,00h
                ret


;------------------------------------------------------------------------------
PRINTL:         LD       A,(HL)          ; Get character
                OR       A               ; Is it $00 ?
                RET      Z               ; Then RETurn on terminator
                RST      08H             ; Print it
                INC      HL              ; Next Character
                JR       PRINTL           ; Continue until $00
                RET
;------------------------------------------------------------------------------
SETUP:
                LD        HL,TEMPSTACK    ; Temp stack
                LD        SP,HL           ; Set up a temporary stack
                ld bc, 0001h
                call waitx           ; wait for reset finished
                ld a, 080h          ; initialize serial interface
                out (083h), a       ; enable access to the divisor regs
                ld a, 0ch           ; set divisor to 12, causes 9600 
                out (080h), a       ; baud rate
                ld a, 00h           ; set least significant bit of divisor
                out (081h), a
                ld a, 03h           ; set serial mode to 8-N-1
                out (083h), a
;               LD        HL,serBuf
;               LD        (serInPtr),HL
;               LD        (serRdPtr),HL
;               XOR       A               ;0 to accumulator
;               LD        (serBufUsed),A
;               LD        A,RTS_LOW
;               OUT       ($80),A         ; Initialise ACIA
;               IM        1
;               EI
               LD        HL,SIGNON1      ; Sign-on message
               CALL      PRINTL           ; Output string
               JP       $0150
;               LD        A,(basicStarted); Check the BASIC STARTED flag
;               CP        'Y'             ; to see if this is power-up
               ; JR        NZ,COLDSTART    ; If not BASIC started then always do cold start
;               LD        HL,SIGNON2      ; Cold/warm message
;               CALL      PRINTL           ; Output string
CORW:
               CALL      CONIN
               AND       %11011111       ; lower to uppercase
               CP        'C'
               JR        NZ, CHECKWARM
               RST       08H
               LD        A,$0D
               RST       08H
               LD        A,$0A
               RST       08H
COLDSTART:     ; LD        A,'Y'           ; Set the BASIC STARTED flag
               ; LD        (basicStarted),A
               JP        $0150           ; Start BASIC COLD
CHECKWARM:
               CP        'W'
               JR        NZ, CORW
               RST       08H
               LD        A,$0D
               RST       08H
               LD        A,$0A
               RST       08H
               JP        $0153           ; Start BASIC WARM


; set relative wait time in bc
waitx:              push de             ; protect affected registers
                    push af
outer:              ld de, 0100h
inner:              dec de
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


#include "bas32K.asm"

SIGNON1:       .BYTE     CS
               .BYTE     "Z80 SBC By Grant Searle",CR,LF,0
SIGNON2:       .BYTE     CR,LF
               .BYTE     "Cold or warm start (C or W)? ",0

.END

