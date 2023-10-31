; Rutina para sumar dos números binarios
sumar:
    ldi r22, 0 ; Inicializa el acarreo a 0
    ldi r23, 0 ; Inicializa el resultado a 0

    ; Suma los bits más bajos de ambos números
    ld r24, X+ ; Carga el primer número en r24
    ld r25, Y+ ; Carga el segundo número en r25
    add r23, r24 ; Suma los bits más bajos
    adc r22, 0 ; Suma el acarreo

    ; Si el resultado es 0 o 1, escríbelo
    cpi r23, 2 ; Compara con 2
    brlo escribir_suma ; Si es menor o igual a 1, escribir

    ; Si el resultado es 2, escríbelo y lleva un 1 al siguiente bit
    subi r23, 2 ; Resta 2 del resultado
    ori r23, 0x01 ; Lleva un 1 al siguiente bit
    rjmp escribir_suma

escribir_suma:
    st Z+, r23 ; Escribe el resultado en la memoria
    cpi ZH, high(resultado)+length(resultado) ; Compara con la última posición de memoria disponible
    brlo sumar ; Si hay espacio disponible, sigue sumando

; Rutina para multiplicar dos números binarios
multiplicar:
    ldi r26, length(segundo_numero) - 1 ; Inicializa el contador de bits del segundo número

    ; Multiplica el primer número por cada bit del segundo número
multiplicar_bits:
    ld r27, Y+ ; Carga un bit del segundo número en r27
    cpse r27, zero_reg ; Si es cero, salta a la siguiente iteración
    call multiplicar_por_bit

    dec r26 ; Decrementa el contador de bits del segundo número
    brne multiplicar_bits ; Si quedan bits por multiplicar, sigue multiplicando

; Rutina auxiliar para multiplicar por un bit
multiplicar_por_bit:
    ldi r28, length(primer_numero) - 1 ; Inicializa el contador de bits del primer número
    ldi r29, 0x00 ; Inicializa el acarreo a cero

multiplicar_bits_por_bit:
    ld r30, X+ ; Carga un bit del primer número en r30
    and r30, r27 ; Multiplica los bits correspondientes
    add r31, r30 ; Acumula los resultados parciales

    dec r28 ; Decrementa el contador de bits del primer número
    brne multiplicar_bits_por_bit ; Si quedan bits por multiplicar, sigue multiplicando

    rol r31 ; Desplaza el resultado una posición a la izquierda según su posición en el segundo número
    adc r29, zero_reg ; Suma el acarreo al resultado final

    cpi ZH, high(resultado)+length(resultado) ; Compara con la última posición de memoria disponible
    brlo escribir_multiplicacion ; Si hay espacio disponible, escribe el resultado parcial

escribir_multiplicacion:
    st Z+, r29 ; Escribe el resultado parcial en la memoria

; Rutina para mostrar el resultado final en pantalla
mostrar