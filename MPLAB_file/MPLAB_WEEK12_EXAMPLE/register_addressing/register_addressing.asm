#include 	<p16Lf1826.inc>		; Include file locate at defult directory
;

temp		equ	0x25
temp1		equ	0x24
;***************************************
;           Program start              *
;***************************************
			org 	0x00		; reset vector
			movlw 03
			movwf temp		
			movlw 01
			movwf temp1
			
loop		movf temp1,0
			incf temp1,1     
			decfsz temp,1
			goto loop
			movf temp1,0
			goto $
			end
			
			
	