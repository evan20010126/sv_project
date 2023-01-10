#include  <p16Lf1826.inc>  ; Include file locate at defult directory
;
count       equ 0x22;ram34
answer      equ 0x23;ram35
c           equ 0x24;ram36
a           equ 0x25;ram37
;***************************************
;           Program start              *
;***************************************
            org 0x00

start       movlw .5
            movwf  a;a=5
            movlw .3
            movwf  c;c=3
            movwf  count;count=c
            movlw .0
            movwf  answer;answer=0

loop1       movf   answer, 0;w<=answer
            addwf  a, 0;w+=a
            movwf  answer;answer<=w
            decfsz  count, 1;count--
            bra     loop1     
            bra     cout

cout        movf    answer, 0
            movwf   PORTB       
            end