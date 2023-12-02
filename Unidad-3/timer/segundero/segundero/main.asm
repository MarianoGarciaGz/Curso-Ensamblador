rjmp start
.org 0x0020
rjmp INT_T0

start:
    SEI
    ldi r20, 0x00
    ldi r22, 0x01
    ldi r23, 0x00
    ldi r24, 0x00

    ldi r16, 0xff
    out ddrb, r16

    ldi r17, 0x03
    out tccr0b, r17
    ldi r18, 0x01
    sts timsk0, r18
    ldi r19, 0
    out tcnt0, r19
    
espera:
    rjmp espera

INT_T0:
    inc r20
    cpi r20, 62
    brne eti
	out portb, r24
	inc r24
	clr r20

eti:
    reti