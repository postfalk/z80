org 00000h

setup:      ld sp, 0ffffh
            ld a,00fh
            out (003h),a
            ld hl, 00ff00h
            ld a,000h
            out (002h),a

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
            ld (hl), a
            call parse
            call endcond
            ; set brightness
            call startcond
            call address
            ld a, 0e0h
            ld (hl), a
            call parse
            call endcond
            ; turn display on
            call startcond
            call address
            ld a, 081h
            ld (hl), a
            call parse
            call endcond
            call startcond
            call address
            ld a, 000h
            ld (hl), a
            call parse
            ; write data
            ld a, 0ffh
            ld (hl), a
            call parse
            call endcond
            ret

address:    ld a, 0e0h      ; call device address
            ld (hl), a
            call parse
            ret

startcond:  ld a,003h
            call output
            ld bc, 00001h
            call wait
            ld a,002h
            call output
            ld a, 000h
            call output
            ret

endcond:    ld a, 000h
            call output
            ld a, 002h
            call output
            ld a, 003h
            call output
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
            or 002h
            call output
            and 001h
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
