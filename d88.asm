;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                        ;
;  This is a software implementation of I2C for my little Z80 project    ;
;  ==================================================================    ;
;  It currently drives Adafruits LED backpacks based on ht16k33 chip     ;
;                                                                        ;
;  See datasheet here                                                    ;
;  http://www.adafruit.com/datasheets/ht16K33v110.pdf                    ;
;                                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO; streamline!

org 00000h
display:    db 080h, 055h, 077h, 055h, 055h, 055h, 055h, 055h

setup:      ld sp, 0ffffh   ; set stack pointer
            ld hl, 00ff00h  ; begin page to store datasheet
            ld a,00fh       ; set PIO B to output mode
            out (003h),a    ;
            ld a,000h       ; set PIO B OUT to 00fh
            out (002h),a    ;

loop:       nop
            call i2cmessage
loop2:      call oscillate  ; provide the display with a clock
            jp loop2

oscillate:  ld a, 000h      ; there has to be a clock signal
            call output     ; to make the display work
            ld a, 002h
            call output
            ret

i2cmessage: call startcond
            call address
            ; start oscillator
            ld a, 021h
            call parse
            call endcond
            ; set brightness
            call startcond
            call address
            ld a, 0e0h
            call parse
            call endcond
            ; turn display on
            call startcond
            call address
            ld a, 081h
            call parse
            call endcond
            call startcond
            call address
            ld a, 000h
            call parse
            ; write data
            ld b, 08h
lp10:       ld a, (display)
            call parse
            dec b
            jp nz, lp10
            call endcond
            ret

address:    ld a, 0e0h      ; call device address
            call parse
            ret

startcond:  ld a,003h
            call output
            ld bc, 00001h   ; wait here to make start condition stable, could be much shorter
            call wait
            ld a,002h
            call output
            ret

skip:       ld a,000h
            call parse
            ret

endcond:    ld a, 000h
            call output
            ld a, 002h
            call output
            ld a, 003h
            call output
            ret

parse:      push bc
            ld b, 008h      ; for i=0 to 7
            ld c, a         ; using c here since I have to push bc anyways
lp1:        rlc c           ; rotate to left so that most significant bit becomes least significant
            ld a, 001h      ; load mask
            and c           ; and deletes all not masked bits
            call clbit
            dec b
            jp nz, lp1
            call ackn
            pop bc
            ret

; clock cycle around bit, from register a
; removed getting back to original state
; seems to work without it
clbit:      push bc
            call output
            or 002h
            call output
            pop bc
            ret

; send acknowledge sequence
; TODO: actually acknowledge and not
; just assume ok
ackn:       ld a, 001h
            call output
            ld a, 003h
            call output
            ld a, 001h
            call output
            ret

; simulate open drain by switching 
; between PIOs output modes
; see http://members.iinet.net.au/~daveb/downloads/Z80.zip
output:     ld c, 003h
            ld b, 0cfh
            out(c), b
            out(c), a
            ret

; set relative wait time in bc
wait:       push de         ; protect affected registers
            push af
outer:      ld de, 0100h
inner:      dec de
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
