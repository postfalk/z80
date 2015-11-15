org 00000h

setup:      ld sp, 0ffffh
            ld a,00fh
            out (003h),a

loop:       nop
            call i2cmessage
            jp loop

i2cmessage: call startcond
            ld hl, 0ff00h
            ld a, 070h
            ld (hl), a
            call parse
            ld a, 000100001b
            ld hl, 0ff00h
            ld (hl), a
            call parse
            call endcond
            call startcond
            ld a, 070h
            ld hl, 0ff00h
            ld (hl), a
            call parse
            ld a, 010000001b
            ld hl, 0ff00h
            ld (hl), a
            call parse
            call endcond
            call startcond
            ld a, 070h
            ld hl, 0ff00h
            ld (hl), a
            call parse
            ld a, 001h
            ld hl, 0ff00h
            ld (hl), a
            call parse
            ld a, 00fh
            ld hl, 0ff00h
            ld (hl), a
            call parse
            call endcond
            ret

startcond:  ld a,003h
            out(002h),a
            ld bc,0300h
            call wait
            ld a,002h
            out(002h),a
            ld bc, 00080h
            call wait
            ld a, 000h
            out(002h), a
            ld bc, 00080h
            call wait
            ret

endcond:    ld a, 002h
            out(002h), a
            ld bc, 00080h
            call wait
            ld a, 003h
            out(002h), a
            ld bc, 00080h
            call wait
            ret

ackn:       ld a, 011001111b
            out(003h), a
            ld a, 001h
            out(003h), a
            ld bc, 00080h
            call wait
            ld a, 002h
            out(002h), a
            ld bc, 00080h
            call wait
            ld a, 000h
            out(002h), a
            ld bc, 00080h
            call wait
            ld a, 00fh
            out(003h), a
            ret

parse:      nop
            ld b, 008h      ; for i=0 to 7
lp1:        ld a, (hl)
            rlca
            ld (hl), a
            jr nc, off
            ld a, 001h
            jr cont
off:        ld a, 000h
cont:       call clbit
            ;out(002h), a
            ;push bc
            ;ld bc, 00080h
            ;call wait
            ;pop bc
            dec b
            jp nz, lp1
            ; call ackn
            ret

; clock cycle around bit, from register a
clbit:      push bc
            and 001h
            out (002h), a
            ld bc, 00280h
            call wait
            or 002h
            out (002h), a
            ld bc, 00280h
            call wait
            and 001h
            out (002h), a
            ld bc, 00280h
            call wait
            pop bc
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
