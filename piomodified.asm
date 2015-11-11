org 00000h

setup:  ld sp, 0ffffh
        ld a,00fh
        out (003h),a

loop:   nop
        ld a, 010000101b
        ld hl, 0ff00h   ; pass argument through random memory location
        ld (hl), a
        call parse
        ld bc, 0400h
        call wait
        jp loop

parse:  nop             ; parse a byte from a register
        ld b, 008h      ; for i=0 to 7
lp1:    ld a, (hl)
        rlca
        ld (hl), a
        jr nc, off
        ld a, 001h
        jr cont
off:    ld a, 000h
cont:   out (002h), a
        push bc
        ld bc, 0100h
        call wait
        pop bc
        dec b
        jp nz, lp1
        ld a, 000h
        out (002h), a
        ret

wait:   nop             ; set relative wait time in bc before calling
outer:  ld de, 0100h
inner:  dec de
        ld a, d
        or e
        jp nz, inner
        dec bc
        ld a, b
        or c
        jp nz, outer
        ret
