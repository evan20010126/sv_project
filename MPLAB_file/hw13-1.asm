#include 	<p16Lf1826.inc>		; Include file locate at defult directory


count		equ 0x24
count1		equ 0x25

hour		equ 0x21
minute		equ 0x22

;count1		equ h'25'
;count2		equ h'26'
;count3		equ h'27'
;***************************************
;           Program start              *
;***************************************
			org 	0x00		; reset vector
			
init		movlw .0 
			movwf hour ;init hour to zero
			movlw .23
			movwf count1

start		movlw .0 ;move 0 into w
            movwf minute ;move w into memory
            movlw .59
            movwf count ;count: for loop1

loop1       
			;call delay
    		movlw .1
			addwf minute, 0 ;add w and f to w
            movwf minute
            decfsz count, 1
            bra loop1

			movlw .1
			addwf hour, 1 ;hour += 1
            decfsz count1, 1
			bra start

			bra init

;delay		movlw .30
;			movwf count1
;delay1		clrf count2
;delay2		clrf count3
;delay3		decfsz count3, 1
;			goto delay3
;			decfsz count2, 1
;			goto delay2
;			decfsz count1, 1
;			goto delay1
;			return

			end
			