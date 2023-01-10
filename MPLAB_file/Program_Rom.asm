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
            movwf  a;a=21
            movlw .3
            movwf  c;c=3
            movlw .0
            movwf  count;count=0
            movwf  answer;answer=0

loop1       movf   c, 0;w<=c
            subwf  a, 1;a<=a-w(c)
            incf   count, 1;count++
            btfss  a, 7
            bra    loop1 
            bra    cout

cout        decf   count, 1
            movf   count, 0
            movwf  PORTB  ;cout<<count
            movlw  .0
            movwf  temp;temp=0
            movf   a, 0;w<=a
            subwf  temp, 1;temp=0(temp)-w(a)
            movf   temp, 0;w<=temp
            subwf  c,  0;c=c-w(temp)
            movf   c,  0;w<=c
            movwf  PORTB


            end