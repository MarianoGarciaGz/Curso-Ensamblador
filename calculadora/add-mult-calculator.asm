inicio: ; Punto de inicio del programa
    ldi r16, 0xFF ; Configura todos los pines de PORTB como salidas
    out DDRB, r16

    ldi r16, 0x00 ; Configura todos los pines de PORTD como entradas
    out DDRD, r16

    ldi r17, 0 ; Inicializa registros
    ldi r18, 0
    ldi r19, 0
    ldi r20, 0
    ldi r21, 0

ciclo: ; Bucle principal
    in r16, PINC ; Lee el estado de los pines de PINC
    andi r16, 0x07 ; Filtra los bits de interés
    cpi r16, 0x01 ; Comprueba si es igual a 0x01
    breq selop ; Salta a la sección de selección de operación si es igual a 0x01
    cpi r16, 0x02 ; Comprueba si es igual a 0x02
    breq selop ; Salta a la sección de selección de operación si es igual a 0x02
    cpi r16, 0x04 ; Comprueba si es igual a 0x04
    breq calcres ; Salta a la sección de cálculo del resultado si es igual a 0x04
    cpi r16, 0x00 ; Comprueba si es igual a 0x00
    breq sinop ; Salta a la sección de operación nula si es igual a 0x00
    rjmp ciclo ; Vuelve al inicio del bucle si no cumple ninguna condición

;operaciones y funcionamiento
selop: ; Selección de operación
    mov r19, r16 ; Guarda el valor de r16 en r19
    in r17, PIND ; Lee el estado de los pines de PIND
    mov r18, r17 ; Guarda el valor de r17 en r18
    clr r20 ; Limpia r20

mostrarnum:
    mov r16, r18
    subi r16, 0x0A
    andi r16, 0x80
    cpi r16, 0x80
    breq nummen10
    subi r18, 0x0A
    inc r20
    rjmp mostrarnum

nummen10:
    lsl r20
    lsl r20
    lsl r20
    lsl r20
    add r18, r20
    out PORTB, r18
    rjmp ciclo

calcres:
    clr r20
    clr r18
    cpi r21, 0x01
    breq ciclo

    cpi r19, 0x00
    breq mulpor0

    in r18, PIND

    cpi r19, 0x01
    breq sumnum
    cpi r19, 0x02
    breq mulnum

sumnum:
    add r17, r18
    rjmp mostrares

mulpor0:
    clr r17
    rjmp mostrares

mulnum:
    mov r20, r17
    clr r17

calcmul:
    add r17, r20
    dec r18
    breq mostrares
    rjmp calcmul

mostrares:
    clr r20

mostraresnum:
    mov r16, r17
    subi r16, 0x0A
    andi r16, 0x80
    cpi r16, 0x80
    breq nummen10res

    subi r17, 0x0A
    inc r20
    rjmp mostraresnum

nummen10res:
    lsl r20
    lsl r20
    lsl r20
    lsl r20
    add r17, r20
    out PORTB, r17
    ldi r21, 0x01
    clr r19
    rjmp ciclo

sinop:
    clr r21
    rjmp ciclo
