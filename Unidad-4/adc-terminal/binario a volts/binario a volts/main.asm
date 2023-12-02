conf:
    ldi r16, 0x00
    out DDRD, r16 ; Configura los pines del puerto D como entrada
    ldi r16, 0xFF
    out DDRB, r16 ; Configura todos los pines del puerto B como salida
    ldi r16, 0xFF
    out DDRC, r16 ; Configura todos los pines del puerto B como salida
	ldi r20, 0x05
	ldi r16, 0x00
	ldi r21, 0x80

main:
    in r16, PIND ; Lee el valor del puerto D
	cpi r16, 128
	brsh inc_value
	add r16, r16
	cp r16, r20
	brlo convert_c
	sub r16, r20

	; Convierte el n?mero binario a decimal
    ldi r17, 0 ; Inicializa el contador de decenas a 0
    ldi r18, 0 ; Inicializa el contador de unidades a 0
    ldi r19, 0 ; Inicializa el contador de centenas a 0
	   
convert_c:
    cpi r16, 100 ; Compara el valor actual con 100
    brlo convert_d ; Si es menor que 100, pasamos a convertir decimales
    subi r16, 100 ; Resta 10 del valor actual
    inc r19 ; Incrementa el contador de centenas
    rjmp convert_c ; Repite el proceso

convert_d:
    cpi r16, 10 ; Compara el valor actual con 10
    brlo done ; Si es menor que 10, hemos terminado
    subi r16, 10 ; Resta 10 del valor actual
    inc r17 ; Incrementa el contador de decenas
    rjmp convert_d ; Repite el proceso
inc_value:
	ldi r19, 2
	ldi r17, 5
	ldi r18, 0
	add r16, r16
	cp r16, r20
	brlo convert_c
	sub r16, r20
	rjmp convert_c
done:
    mov r18, r16 ; El valor restante es el n?mero de unidades

    ; Muestra el resultado en el puerto B
    swap r17 ; Mueve las decenas a los primeros 4 bits
    or r17, r18 ; Combina las decenas y las unidades en un solo registro
    out PORTB, r17 ; Escribe el resultado en el puerto B
    out PORTC, r19

    rjmp main ; Vuelve al inicio
