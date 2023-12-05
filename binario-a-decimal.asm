main:
    in r24, PIND ; Lee el valor del puerto C
    andi r24, 0x0F ; Aísla los primeros 4 bits (número binario de entrada)

    ; Convierte el número binario a decimal
    ldi r25, 0 ; Inicializa el contador de decenas a 0
    ldi r18, 0 ; Inicializa el contador de unidades a 0
    ldi r19, 10 ; Valor constante para la comparación

; --- Rutina binario a decimal
convert:
    cp r24, r19 ; Compara el valor actual con 10
    brlo done ; Si es menor que 10, hemos terminado
    subi r24, 10 ; Resta 10 del valor actual
    inc r25 ; Incrementa el contador de decenas
    rjmp convert ; Repite el proceso


done:
    mov r18, r24 ; El valor restante es el número de unidades

    ; Muestra el resultado en el puerto B
    swap r25 ; Mueve las decenas a los primeros 4 bits
    or r25, r18 ; Combina las decenas y las unidades en un solo registro
    out PORTB, r25 ; Escribe el resultado en el puerto B

    rjmp main ; Vuelve al inicio
