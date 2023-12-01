rjmp start
.org ; interrumpicion de desbordamiento
rjmp INT_0

start:

    inc r24
    cpi r24, 4
    breq print


    SEI ;necesario para la interrupcion

    ldi r22,0x01
    ldi r23,0x02

    ldi r16,0xff
    out ddrb, r16

    ldi r17, 0x05
    out tccr0b, r17
    ldi r18, 0x01
    sts timsk0, r18
    ldi r19, 0x01
    sts timsk0, r19
    out tcnt0, r18
