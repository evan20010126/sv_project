#include  <p16Lf1826.inc>  ; Include file locate at defult directory
;

;***************************************
;           Program start              *
;***************************************
            org 0x00

start       movlw   .0
            movwf   PORTB
            movlw   .0
            movwf   PORTB
            movlw   .9
            movwf   PORTB
            movlw   .5
            movwf   PORTB
            movlw   .7
            movwf   PORTB
            movlw   .2
            movwf   PORTB
            movlw   .0
            movwf   PORTB
            movlw   .9
            movwf   PORTB
            bra     start

            end