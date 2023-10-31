conf:
    ldi r16, 0x0F
    out DDRD, r16 ; Configura los primeros 4 pines del puerto C como entrada
    ldi r16, 0xFF
    out DDRB, r16 ; Configura todos los pines del puerto B como salida

; Bucle principal
main:
    in r16, PIND ; Lee el valor del puerto C
    andi r16, 0x0F ; Aísla los primeros 4 bits (número binario de entrada)

    ; Convierte el número binario a decimal
    ldi r17, 0 ; Inicializa el contador de decenas a 0
    ldi r18, 0 ; Inicializa el contador de unidades a 0
    ldi r19, 10 ; Valor constante para la comparación


; --- Rutina binario a decimal
convert:
    cp r16, r19 ; Compara el valor actual con 10
    brlo done ; Si es menor que 10, hemos terminado
    subi r16, 10 ; Resta 10 del valor actual
    inc r17 ; Incrementa el contador de decenas
    rjmp convert ; Repite el proceso


done:
    mov r18, r16 ; El valor restante es el número de unidades

    ; Muestra el resultado en el puerto B
    swap r17 ; Mueve las decenas a los primeros 4 bits
    or r17, r18 ; Combina las decenas y las unidades en un solo registro
    out PORTB, r17 ; Escribe el resultado en el puerto B

    rjmp main ; Vuelve al inicio
