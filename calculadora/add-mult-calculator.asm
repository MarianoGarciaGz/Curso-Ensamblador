; Configuración de pines de entrada y salida
conf:
    ldi r16, 0xff       ; Carga el valor 0xFF en el registro r16
    out ddrb, r16       ; Configura todos los pines del puerto B como salidas

    ldi r16, 0x00       ; Carga el valor 0x00 en el registro r16
    out ddrd, r16       ; Configura todos los pines del puerto D como entradas

    ldi r17, 0          ; Inicializa r17 en 0
    ldi r18, 0          ; Inicializa r18 en 0
    ldi r19, 0          ; Inicializa r19 en 0
    ldi r20, 0          ; Inicializa r20 en 0
    ldi r21, 0          ; Inicializa r21 en 0

; Bucle principal
loop:
    in r16, pinc         ; Lee el estado de los pines del puerto C
    andi r16, 0x07       ; Aplica una máscara para obtener los 3 bits menos significativos
    cpi r16, 0x01        ; Compara r16 con 0x01
    breq selop           ; Salta a la etiqueta selop si son iguales
    cpi r16, 0x02        ; Compara r16 con 0x02
    breq selop           ; Salta a la etiqueta selop si son iguales
    cpi r16, 0x04        ; Compara r16 con 0x04
    breq calcres         ; Salta a la etiqueta calcres si son iguales
    cpi r16, 0x00        ; Compara r16 con 0x00
    breq nooper          ; Salta a la etiqueta nooper si son iguales
    rjmp loop              ; Salta de nuevo al bucle principal

; Sección de operaciones
selop:
    mov r19, r16         ; Mueve el valor de r16 a r19
    in r17, pind         ; Lee el estado de los pines del puerto D y lo guarda en r17
    mov r18, r17         ; Mueve el valor de r17 a r18
    clr r20              ; Limpia el registro r20

shownum:
    mov r16, r18         ; Mueve el valor de r18 a r16
    subi r16, 0x0a       ; Resta 0x0A al valor de r16
    andi r16, 0x80       ; Aplica una máscara para el bit más significativo
    cpi r16, 0x80        ; Compara r16 con 0x80
    breq numless10       ; Salta a numless10 si son iguales
    subi r18, 0x0a       ; Resta 0x0A al valor de r18
    inc r20              ; Incrementa r20
    rjmp shownum         ; Salta de nuevo a shownum

numless10:
    lsl r20              ; Desplaza el contenido del registro r20 un bit a la izquierda
    lsl r20              ; Repite el desplazamiento dos veces más
    lsl r20
    lsl r20
    add r18, r20         ; Suma el contenido de r20 al registro r18
    out portb, r18       ; Envía el valor de r18 al puerto B
    rjmp loop              ; Salta de nuevo al bucle principal

    ; Sección para calcular el resultado
    calcres:
        clr r20           ; Limpia el registro r20
        clr r18           ; Limpia el registro r18
        cpi r21, 0x01     ; Compara r21 con 0x01
        breq loop           ; Salta al bucle principal si son iguales

        cpi r19, 0x00     ; Compara r19 con 0x00
        breq multbyzero   ; Salta a multbyzero si son iguales

        in r18, pind      ; Lee el estado de los pines del puerto D y lo guarda en r18

        cpi r19, 0x01     ; Compara r19 con 0x01
        breq addnums      ; Salta a addnums si son iguales
        cpi r19, 0x02     ; Compara r19 con 0x02
        breq multnums     ; Salta a multnums si son iguales

    addnums:
        add r17, r18      ; Suma el contenido de r18 a r17
        rjmp showres      ; Salta a la sección de mostrar resultado

    multbyzero:
        clr r17           ; Establece r17 en 0
        rjmp showres      ; Salta a la sección de mostrar resultado

    multnums:
        mov r20, r17      ; Mueve el valor de r17 a r20
        clr r17           ; Limpia el registro r17

    calcmult:
        add r17, r20      ; Suma el contenido de r20 a r17
        dec r18           ; Decrementa r18
        breq showres      ; Salta a la sección de mostrar resultado si r18 es igual a 0
        rjmp calcmult     ; Salta de nuevo a calcmult para continuar la multiplicación

    showres:
        clr r20           ; Limpia el registro r20

    showresnum:
        mov r16, r17      ; Mueve el valor de r17 a r16
        subi r16, 0x0a    ; Resta 0x0A al valor de r16
        andi r16, 0x80    ; Aplica una máscara para el bit más significativo
        cpi r16, 0x80     ; Compara r16 con 0x80

        ; (Continuar con la lógica de la sección "showresnum" y "nooper")

    nooper:
        clr r21           ; Establece r21 en 0
        rjmp loop           ; Salta al bucle principal
