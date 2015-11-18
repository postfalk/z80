org 00000h

setup:      ld sp, 0ffffh
            ld a,00fh
            out (003h),a

loop:       nop
            call i2cmessage
            jp loop

i2cmessage: call startcond
            call address
            ; start oscillator
            ld a, 021h
            ld hl, 0ff00h
            ld (hl), a
            call parse
            call endcond
            ; set brightness
            call startcond
            call address
            ld a, 0e0h
            ld hl, 0ff00h
            ld (hl), a
            call parse
            call endcond
            ; turn display on
            call startcond
            call address
            ld a, 081h
            ld hl, 0ff00h
            ld (hl), a
            call parse
            call endcond
            ; write address
            call startcond
            call address
            ld a, 010h
            ld hl, 00ff00h
            ld (hl), a
            call parse
            ; write data
            ld a, 0ffh
            ld hl, 0ff00h
            ld (hl), a
            call parse
            call endcond
            ret

address:    ld hl, 0ff00h
            ; call device address
            ld a, 0e0h
            ld (hl), a
            call parse
            ld bc, 00001h
            call wait
            ret

startcond:  ld a,003h
            call output
            ld bc, 00001h
            call wait
            ld a,002h
            call output
            ld bc, 00001h
            call wait
            ld a, 000h
            call output
            ld bc, 00001h
            call wait
            ret

endcond:    ld a, 000h
            call output
            ld bc, 00001h
            call wait
            ld a, 002h
            call output
            ld bc, 00001h
            call wait
            ld a, 003h
            call output
            ld bc, 00001h
            call wait
            ret

parse:      ld b, 008h      ; for i=0 to 7
lp1:        ld a, (hl)
            rlca
            ld (hl), a
            jr nc, off
            ld a, 001h
            jr cont
off:        ld a, 000h
cont:       call clbit
            dec b
            jp nz, lp1
            call ackn
            ret

; clock cycle around bit, from register a
clbit:      push bc
            and 001h
            call output
            ld bc, 00001h
            call wait
            or 002h
            call output
            ld bc, 00001h
            call wait
            and 001h
            call output
            ld bc, 00001h
            call wait
            pop bc
            ret

ackn:       ld a, 001h
            call output
            ld bc, 00002h
            call wait
            ld a, 003h
            call output
            ld bc, 00002h
            call wait
            ld a, 001h
            call output
            ld bc, 00002h
            call wait
            ret

; wrap output for alternative output modes
; e.g. to simulate open drain by switching 
; the PIOs output mode
; see http://members.iinet.net.au/~daveb/downloads/Z80.zip
output:     ld c, a
            ld a, 000h
            out(002h), a
            ld a, 011001111b
            out(003h), a
            ld a, c
            out(003h), a
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
