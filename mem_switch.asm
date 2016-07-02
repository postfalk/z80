;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                          ;
; Test CPM ROM to RAM switch on new setup. ;
;                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

org 0000h

setup:              ld sp, 0ffffh ; set stack pointer
                

loop:               ld bc, 1000h
                    call wait
                    ld a, 0
                    out(000h), a

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

