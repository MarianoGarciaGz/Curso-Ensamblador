;
; examen_2.asm
;
; Created: 24/11/2023 08:21:57 p. m.
; Author : Aide Perez
;	Chris Rojas

rjmp inicio
.org 0x0028 ; USART_TXC -> USART, TX se activa cuando se completa la transmisión de un byte
rjmp transmision
.org 0x002A ; Interrupción de Conversión Completa del ADC
rjmp captura_adc

inicio:
    SEI 
    SBI DDRD,1
    ldi r16, 0x01
    sts ADMUX, r16 ; Configurar que se trabajará con el pin ADC1
    ldi r16, 0xFF
    out DDRB, r16 
    ldi r16, 0xCC
    sts ADCSRA, r16 ; Configurar el ADC

    ; Configuración de USART
    ldi r16, 0x0C
    sts UBRR0L, r16
    ldi r16, 0x00
    sts UBRR0H, r16 
    LDI r16, 0x22
    sts UCSR0A, r16 
    ldi  R16, 0x48
    sts UCSR0B, r16 
    ldi r16, 0x06
    sts UCSR0C, r16 
    loop:
        rjmp loop

captura_adc:
    lds r18, ADCL
    lds r19, ADCH
    cp r18, r30
    brne entro_adc
    cp r19, r31
    brne entro_adc
    jmp volver_adc

entro_adc:
    ldi r16, 30

    forini_adc:
        ldi r17, 0x08
        sts UDR0, r17
        call espera
        dec r16
        brne forini_adc

    clr r25
    call imV ; imprime 'V: '
    call imTotu
    call imVolt
    lds r30, ADCL
    lds r31, ADCH

volver_adc:
    ldi r16, 0xCC
    sts ADCSRA, r16
    reti

transmision:
    ldi r29, 0x01
    reti 

ESPERA:
    ldi r28, 0x0A

IMPRIMIR:
    LDI R29, 0XFF
    imprimir2:
        dec r29
        brne imprimir2
        dec r28
        brne imprimir
        RET

imTotu:
    ldi r25, 0XFF
    rjmp ivl

imV:
    LDI r16, 0x56
    sts UDR0, r16 ; V
    call ESPERA
    LDI r16, 0x3A
    sts UDR0, r16 ; :
    CALL ESPERA
    LDI r16, 0x20
    sts UDR0, r16 ; ESPACIO
    call ESPERA
    RET

imVolt:
    LDI r16, 0x20
    sts UDR0, r16 ; ESPACIO
    call ESPERA
    LDI r16, 0x56
    sts UDR0, r16 ; V
    call ESPERA
    LDI r16, 0x6F
    sts UDR0, r16 ; o
    call ESPERA
    LDI r16, 0x6C
    sts UDR0, r16 ; l
    CALL ESPERA
    LDI r16, 0x74
    sts UDR0, r16 ; t
    CALL ESPERA
    LDI r16, 0x73
    sts UDR0, r16 ; s
    CALL ESPERA
    RET

mostrar:
    ldi r18, 0x30 
    add r19, r18 
    add r20, r18
    add r21, r18
    add r22, r18
    sts UDR0, r19 
    call ESPERA
    sts UDR0, r20
    call ESPERA
    sts UDR0, r21 
    call ESPERA
    sts UDR0, r22 
    call ESPERA
    ret

ivh:
    lds r31, ADCH
    ldi r19, 0x00 
    ldi r20, 0xFE 
    ldi r21, 0x00 
    ldi r22, 0x00
    ldi r23, 0x00
    cpi r31, 0x00
    breq finh
    for1h:
        inc r19
        inc r23
        ldi r18, 2
        add r21, r18
        ldi r18, 5
        add r22, r18
        dec r31
        cpi r31, 0x00
        breq mostrarh
        rjmp for1h

mostrarh:
    cpi r22, 10
    brcs finh
    subi r22, 10
    inc r21

finh:
    ret

ivl:
    lds r30, ADCL
    ldi r19, 0x00 ; unidades
    ldi r20, 0xFE ; '.'
    ldi r21, 0x00 ; décimas
    ldi r22, 0x00 ; centécimas
    ldi r23, 0x00 ; milésimas
    ldi r24, 0x00 ; diezmilésimas
    cpi r30, 100
    brcs decimalesl 
    for1l:
        subi r30, 100
        ldi r18, 4
        add r21, r18
        ldi r18, 9
        add r22, r18
        cpi r30, 100
        brcs decimalesl
        rjmp for1l
    
decimalesl:
	cpi r30,10
	brcs centecimasl
	for2l:
		subi r30,10
		ldi r18,4
		add r22,r18
		ldi r18,9
		add r23,r18
		cpi r30,10
		brcs centecimasl
		rjmp for2l

centecimasl:
	cpi r30,0x00
	breq mostrarl
	for3l:
		subi r30,1
		ldi r18,4
		add r23,r18
		ldi r18,9
		add r24,r18
		cpi r30,1
		brcs mostrarl
		rjmp for3l

mostrarl:
	cpi r24,10
	brcs milecimas2l
	for4l:
		subi r24,10
		inc r23
		cpi r24,10
		brcs milecimas2l
		rjmp for4l
	
milecimas2l:
    cpi r23,10
	brcs centecimas2l
	for5l:
		subi r23,10
		inc r22
		cpi r23,10
		brcs centecimas2l
		rjmp for5l

centecimas2l:
	cpi r22,10
	brcs decimas2l
	for6l:
		subi r22,10
		inc r21
		cpi r22,10
		brcs decimas2l
		rjmp for6l
	
decimas2l:
	cpi r21,10
	brcs fin2l
	for7l:
		subi r21,10
		inc r19
		cpi r21,10
		brcs fin2l
		rjmp for7l

fin2l:
mov r28, r19
mov r27, r21
mov r26, r22
call ivh

suma:
add r22, r26
cpi r22, 10
brcs reg21
subi r22, 10
inc r21
reg21:
add r21, r27
cpi r21, 10
brcs reg19
subi r21, 10
inc r19
reg19:
add r19, r28
rjmp mostrar