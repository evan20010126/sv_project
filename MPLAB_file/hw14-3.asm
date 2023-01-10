#include  <p16Lf1826.inc>  ; Include file locate at defult directory
;
temp        equ 0x21;ram33
count       equ 0x22;ram34
answer      equ 0x23;ram35
c           equ 0x24;ram36
a           equ 0x25;ram37
;***************************************
;           Program start              *
;***************************************
            org 0x00

start       movlw .21
            movwf  a
            movlw .3
            movwf  c
            movlw .0
            movwf  count
            movwf  answer

loop1       movf   c, 0
            subwf  a, 1
            incf   count, 1
            btfss  a, 7
            bra    loop1 
            bra    cout

cout        decf   count, 1
            movf   count, 0
            movwf  PORTB 
            movlw  .0
            movwf  temp
            movf   a, 0
            subwf  temp, 1
            movf   temp, 0
            subwf  c,  0
            movwf  PORTB


            end