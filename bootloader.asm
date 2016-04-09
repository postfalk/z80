;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                        ;
;   Simple boot loader to load code from serial into memory starting     ;
;   at 08000h.                                                           ;
;                                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

org 00000h

setup:              ld sp, 0ffffh       ; set stack pointer
                    ld a, 080h          ; initialize serial interface
                    out (083h), a       ; enable access to the divisor regs
                    ld a, 0ch           ; set divisor to 12, causes 9600 
                    out (080h), a       ; baud rate
                    ld a, 00h           ; set least significant bit of divisor
                    out (081h), a
                    ld a, 03h           ; set serial mode to 8-N-1
                    out (083h), a

loop:               ld hl, text
                    call print
                    ld hl, 08000h
                    call load
                    ld hl, loaded
                    call print
                    ld hl, 08000h        ; reflect loaded data
                    call print
    loop1:          jp loop1             ; just hanging out here

print:              ld c, (hl)
                    inc hl
                    call serial_out
                    sub 00ah
                    jr nz, print
                    ret

load:               call serial_in
                    ld (hl), a
                    inc hl
                    sub 00ah
                    jr nz, load
                    ret

serial_out:         in a, (085h)        ; read line status register
                    and 040h            ; check transmitter empty
                    jr z, serial_out    ; wait until transmitter empty=1
                    ld a, c
                    out (080h), a
                    ret

serial_in:          in a, (085h)        ; read line status register
                    and 001h            ; check data ready
                    jr z, serial_in     ; wait until data ready=1
                    in a, (080h)
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
text:               db "Welcome to little Zeighty, start loading code ...\r\n"
loaded:             db "Data loaded.\r\n"
