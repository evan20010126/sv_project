#include 	<p16Lf1826.inc>		; Include file locate at defult directory
;

temp		equ	0x25
;***************************************
;           Program start              *
;***************************************
            org 0x00    ;reset vector

            movlw   .1
            movlw   .2
            movlw   .3
            movlw   .4
            movlw   .5
            call    first
            movlw   .6
            movlw   .7
            goto    $
first       movlw   .8
            movlw   .9
            return  
            end


