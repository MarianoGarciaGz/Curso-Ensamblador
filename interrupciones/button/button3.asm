ldi r16, 0xff
out ddrb, r16

ldi r17 0x04
out tccr0b, r17
ldi r18, 0x00
sts timsk0, r18
out tcnt0, r18

conteo:
    in r19, tcnt0
    out portb, r19
    rjmp conteo