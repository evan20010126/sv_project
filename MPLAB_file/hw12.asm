#include 	<p16Lf1826.inc>		; Include file locate at defult directory
;

temp		equ	0x25
count		equ 0x24
count1		equ h'20'
count2		equ h'21'
count3		equ h'22'
;***************************************
;           Program start              *
;***************************************
			org 	0x00		; reset vector
			
start		movlw .0 ;move 0 into w
			movwf PORTB ;output to PORTB
            movwf temp ;move w into memory
            movlw .59
            movwf count ;count: for loop1
loop1       
			;call delay
    		movlw .1
			addwf temp, 0 ;add w and f to w
			movwf PORTB ;output to PORTB
            movwf temp
            decfsz count, 1
            bra loop1
            bra start

delay		movlw .30
			movwf count1
delay1		clrf count2
delay2		clrf count3
delay3		decfsz count3, 1
			goto delay3
			decfsz count2, 1
			goto delay2
			decfsz count1, 1
			goto delay1
			return

			end
			