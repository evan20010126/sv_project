#include 	<p16Lf1826.inc>		; Include file locate at defult directory

temp		equ	0x25
temp1		equ 0x24
count1		equ h'20'
count2		equ h'21'
count3		equ h'22'
;***************************************
;           Program start              *
;***************************************
			org 	0x00		; reset vector

start   movlw   .59 ;integer addressing
        movwf   temp1
        clrf    temp
        clrw

loop1   movlw   .0
        add


