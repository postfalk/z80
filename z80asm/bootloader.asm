;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                        ;
;   Simple boot loader to load code from serial into memory starting     ;
;   at 08000h. Starting code execution after loading.                                                           ;
;                                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

org 00000h

setup:              ld sp, 0ffffh       ; set stack pointer
                    ld bc, 0060h
                    call wait           ; wait for reset finished
                    ld a, 080h          ; UART: initialize
                    out (083h), a       ; UART: enable access to the divisor regs
                    ld a, 0ch           ; UART: set divisor to 12, causes 9600 
                    out (080h), a       ; baud rate
                    ld a, 00h           ; UART: set least significant bit of divisor
                    out (081h), a
                    ld a, 03h           ; UART: set serial mode to 8-N-1
                    out (083h), a

loop:               ld hl, newline      ; output some user friendly instructions
                    call print
                    ld hl, newline
                    call print
                    ld hl, text
                    call print
                    ld hl, 08000h
                    call load
                    ld hl, loaded
                    call print
                    ; ld hl, 08000h     ; reflect loaded data
                    ; call print
                    jp 08000h           ; start newly loaded program
    loop1:          jp loop1            ; just hanging out here

print:              ld c, (hl)          ; load byte
                    inc hl              ; move pointer up
                    call serial_out     ; send byte to output
                    sub 00ah            ; check for end of line
                    jr nz, print        ; next byte if not eol
                    ret

load:               in a, (085h)        ; check whether data available
                    and 001h
                    jr z, load          ; wait here until transmission
    load_1:         call serial_in      ; read byte
                    ld (hl), a          ; write byte to memory
                    inc hl              ; next address
                    ; sub 00ah
                    inc b               ; check whether timeout occurred
                    dec b
                    jr nz, load_1       ; load next character if not timeout
                    ret

serial_out:         in a, (085h)        ; read line status register
                    and 040h            ; check transmitter empty
                    jr z, serial_out    ; wait until transmitter empty=1
                    ld a, c
                    out (080h), a       ; send byte
                    ret

serial_in:          ld b, 0ffh          ; set timeout counter
    serial_in_1:    in a, (085h)        ; read line status register
                    dec b               ; dec timeout counter
                    jr z, return        ; check timeout
                    and 001h            ; check data ready
                    jr z, serial_in_1   ; wait until data ready=1
                    in a, (080h)
    return:         ret

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
newline:            db "\r\n"
text:               db "Welcome to little Zeighty, start loading code ...\r\n"
loaded:             db "Data loaded.\r\n"
