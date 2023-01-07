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
			
loop		incf temp1,1     
			decfsz temp,1
			goto loop
			movf temp1,0
			bcf temp1, 2
			bsf temp, 3
			btfsc temp, 3
			btfss temp, 3
			movf temp1, 0
			movf temp, 0
			goto $
			end
			
			
	