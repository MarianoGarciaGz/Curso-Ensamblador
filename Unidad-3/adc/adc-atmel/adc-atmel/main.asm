start:
    ldi r16, 0x21 ; Aquí vamos a decir basicamente que trabajaremos con el adc 1
    sts ADMUX, r16 ; 
    ldi r16, 0xFF
    out DDRB, r16
    ldi r16, 0x84
    sts ADCSRA, r16 ; Aquí configuramos la velocidad de muestreo

loop:
    ldi r16, 0xC4
    sts ADCSRA, r16 ;Bucle continuo hasta que "ADIF" o mi bit 4 bandera sea activado

captura:
    lds r17, ADCSRA
    sbrs r17, 4
    rjmp captura
    lds r18, ADCH
    out PORTB, r18 ; Aquí la captura se imprime en el  puerto B

    rjmp loop