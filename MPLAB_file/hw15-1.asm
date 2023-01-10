#include  <p16Lf1826.inc>  ; Include file locate at defult directory
;

temp  equ 0x25
;***************************************
;           Program start              *
;***************************************
            org 0x00    ;reset vector

            
loop        clrw
            clrf    temp
            movlw   .1
            addlw   .2
            sublw   .3
            movlw   .10
            movwf   temp
            incf    temp,   1
            subwf   temp,   0
            bcf     temp,   3
            btfsc   temp,   3
            btfsc   temp,   1
            brw     
            nop
            lslf    temp,   1
            lsrf    temp,   0
            goto    loop

            end