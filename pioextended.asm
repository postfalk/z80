org 00000h

setup:  ld sp, 0ffffh
        ld a,00fh
        out (003h),a

loop:   ld a,0ffh
        out (002h),a
        call wait
        ld a,000h
        out (002h),a
        call wait
        jp loop

wait:   ld bc, 00010h
outer:  ld de, 00100h
inner:  dec de
        ld a, d
        or e
        jp nz, inner
        dec bc
        ld a, b
        or c
        jp nz, outer
        ret
