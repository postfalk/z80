;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                        ;
;  Basic serial output implementation
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


org 08000h

setup:              ld sp, 0ffffh       ; set stack pointer
                    ld hl, 00ff00h      ; begin page to store data
                    ;
                    ld a, 080h          ; initialize serial interface
                    out (083h), a       ; enable access to the divisor regs
                    ld a, 0ch           ; set divisor to 12, causes 9600 
                    out (080h), a       ; baud rate
                    ld a, 00h           ; set least significant bit of divisor
                    out (081h), a
                    ld a, 03h           ; set serial mode to 8-N-1
                    out (083h), a
                    ld a, 080h
                    out (080h), a

loop:               ld hl, 00ff00h
                    ld hl, text
                    call print
                    jp loop             ; just hanging out here for now

print:              ld c, (hl)
                    inc hl
                    call serial
                    sub 00ah
                    jr nz, print
                    ret

serial:             in a, (085h)        ; make sure transmitter reg is
                    and 040h            ; empty
                    jr z, serial
                    ld a, c
                    out (080h), a
                    ret

; set relative wait time in bc
wait:               push de             ; protect affected registers
                    push af
    outer:          ld de, 0100h
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

; store data here
text:               db "I love Cynthia!\r\n"
