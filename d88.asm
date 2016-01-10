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
display:    db 021h, 055h, 077h, 055h, 055h, 055h, 055h, 055h

setup:              ld sp, 0ffffh   ; set stack pointer
                    ld hl, 00ff00h  ; begin page to store datasheet
                    ld a, 00fh       ; set PIO B to output mode
                    out (003h),a    ;
                    ld a, 000h       ; set PIO B OUT to 00fh
                    out (002h),a    ;

loop:               nop
                    call i2cmessage
    ; just hanging out here for now
    loop2:          jp loop2

i2cmessage:         call startTransmission
                    ; start oscillator
                    ld a, 021h
                    call write
                    call endTransmission
                    ; set brightness
                    call startTransmission
                    ld a, 0e0h
                    call write
                    call endTransmission
                    ; turn display on
                    call startTransmission
                    ld a, 081h
                    call write
                    call endTransmission
                    call startTransmission
                    ld a, 000h
                    call write
                    ; write datasheet
                    ld b, 0fh
    lp10:           ld a, (display)
                    call write
                    dec b
                    jp nz, lp10
                    call endTransmission
                    ret

; use terminology similar to Wire.h C-library
startTransmission:  ld a,003h
                    call output
                    ld a,002h
                    call output
                    ld a, 0e0h      ; call device address, move to variable as needed
                    call write
                    ret

endTransmission:    ld a, 000h
                    call output
                    ld a, 002h
                    call output
                    ld a, 003h
                    call output
                    ld a, 000h
                    call output
                    ret

write:              push bc
                    ld b, 008h      ; for i=0 to 7
                    ld c, a         ; using c here since I have to push bc anyways
    lp1:            rlc c           ; rotate to left so that most significant bit becomes least significant
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
clbit:              push bc
                    call output
                    or 002h
                    call output
                    pop bc
                    ret

; send acknowledge sequence
; TODO: actually acknowledge and not
; just assume ok
ackn:               ld a, 001h
                    call output
                    ld a, 003h
                    call output
                    ret

; simulate open drain by switching 
; between PIOs output modes
; see http://members.iinet.net.au/~daveb/downloads/Z80.zip
output:             ld c, 003h
                    ld b, 0ffh ; was 0cfh do not remember why
                    out(c), b
                    out(c), a
                    ret

; set relative wait time in bc
wait:               push de         ; protect affected registers
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
