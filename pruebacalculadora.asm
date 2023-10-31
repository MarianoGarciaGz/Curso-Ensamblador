conf:
    ldi r16, 0x7F
    out DDRD, r16 ; Configura los primeros 7 pines del puerto D como entrada
    ldi r16, 0xFF
    out DDRB, r16 ; Configura todos los pines del puerto B como salida
main:
    in r16, PIND ; Lee el valor del puerto C
    andi r16, 0x0F ; Aísla los primeros 4 bits (número binario de entrada)    ; Convierte el número binario a decimal
    ldi r17, 0 ; Inicializa el contador de decenas a 0
    ldi r18, 0 ; Inicializa el contador de unidades a 0
    ldi r19, 10 ; Valor constante para la comparación
sumar:
    sbis PIND,4 ; Si el pin D4 está desactivado, salta a multiplicar
    add r17,r18 ; Suma las decenas y las unidades
    adc r18,r19 ; Suma el acarreo y guarda el resultado en r18
    out PORTB,r18 ; Escribe el resultado en el puerto B
    sbi PORTD,6 ; Activa el pin D6 para indicar que se ha realizado la suma
    ret ; Vuelve al bucle principal
multiplicar:
    sbis PIND,5 ; Si el pin D5 está desactivado, salta a resultado
    mul r17,r18 ; Multiplica las decenas y las unidades
    movw r18,r0 ; Mueve el resultado a los registros r18 y r19
    out PORTB,r18 ; Escribe el resultado en el puerto B
    sbi PORTD,6 ; Activa el pin D6 para indicar que se ha realizado la multiplicación
    ret ; Vuelve al bucle principal
resultado:
    sbis PIND,6 ; Si el pin D6 está desactivado, salta a convertir
    out PORTB,r18 ; Escribe el resultado en el puerto B
    ret ; Vuelve al bucle principal
convert:
    cp r16, r19 ; Compara el valor actual con 10
    brlo done ; Si es menor que 10, hemos terminado
    subi r16, 10 ; Resta 10 del valor actual
    inc r17 ; Incrementa el contador de decenas
    rjmp convert ; Repite el proceso
done:
    mov r18, r16 ; El valor restante es el número de unidades    ; Muestra el resultado en el puerto B
    swap r17 ; Mueve las decenas a los primeros 4 bits
    or r17, r18 ; Combina las decenas y las unidades en un solo registro
    out PORTB, r17 ; Escribe el resultado en el puerto B    rjmp main ; Vuelve al inicio