;
; Examen.asm
;
; Created: 27/10/2023 16:57:11
; Author : dgflo
;          mariano
; Replace with your application code
start:
    ldi r16, 0xFF
	out DDRB, r16
	ldi r16, 0xF0
	out DDRD, r16
	ldi r16, 0x20
	out PORTD, r16
	ldi r16, 0x00

	ldi r17, 0x00 ;valor display 1
	ldi r18, 0x00 ;valor display 2
	ldi r19, 0x00 ;valor display 3
	ldi r20, 0x00 ;valor display 4

	ldi r25, 0x00 ;contador 1
	ldi r26, 0x00 ;contador 2
	ldi r27, 0x00 ;contador 3
	ldi r28, 0x00 ;contador 4
	
loop:
	out PORTB, r16	
	in r21, PIND
	andi r21, 0x0F
	cpi r21, 0x01 
	breq TAG  ;parar el display 1
	in r21, PIND
	andi r21, 0x0F
	cpi r21, 0x03
	breq TAG2_JUMP ;parar el display 2
	in r21, PIND
	andi r21, 0x0F
	cpi r21, 0x07
	breq TAG3_JUMP ;parar el display 3
	in r21, PIND
	andi r21, 0x0F
	cpi r21, 0x0F
	breq TAG4_JUMP	;parar el display 4
	sbi PORTB, 5
	call delay
	cbi PORTB, 5
	sbi PORTB, 6
	sbi PORTB, 4
	call delay
	cbi PORTB, 6
	cbi PORTB, 4
	sbi PORTB, 7
	call delay
	sbi PORTB, 4
	sbi PORTB, 5
	call delay
	inc r16
	andi r16, 0x0F
	cpi r16, 0x0A
	brlo loop
	ldi r16, 0x00
	rjmp loop
TAG2_JUMP:
	rjmp TAG2
TAG3_JUMP:
	rjmp TAG3
TAG4_JUMP:
	rjmp TAG4
MOV_R17:
	mov r17, r16
	inc r25
TAG:
	cpi r25, 0x00
	breq MOV_R17
	sbi PORTB, 6
	sbi PORTB, 4
	call delay
	cbi PORTB, 6
	cbi PORTB, 4
	sbi PORTB, 7
	call delay
	sbi PORTB, 4
	sbi PORTB, 5
	call delay
	inc r16
	andi r16, 0x0F
	cpi r16, 0x0A
	brlo loop
	ldi r16, 0x00
	rjmp loop
MOV_R18:
	mov r18, r16
	inc r26
LOOP_JUMP:
	rjmp loop
TAG2:
	cpi r26, 0x00
	breq MOV_R18
	sbi PORTB, 7
	call delay
	sbi PORTB, 4
	sbi PORTB, 5
	call delay
	inc r16
	andi r16, 0x0F
	cpi r16, 0x0A
	brlo LOOP_JUMP
	ldi r16, 0x00
	rjmp loop
MOV_R19:
	mov r19, r16
	inc r27
TAG3:
	cpi r27, 0x00
	breq MOV_R19
	sbi PORTB, 4
	sbi PORTB, 5
	sbi PORTB, 7
	call delay
	inc r16
	andi r16, 0x0F
	cpi r16, 0x0A
	brlo LOOP_JUMP
	ldi r16, 0x00
	rjmp loop
MOV_R20:
	mov r20, r16
	inc r28
TAG4:
	cpi r28, 0x00
	breq MOV_R20
	cpi r17, 0x03
	brne LOST
	cpi r18, 0x01
	brne LOST
	cpi r19, 0x01
	brne LOST
	cpi r20, 0x02
	brne LOST
WON:
	ldi r16, 0x40
	out PORTD, r16
	rjmp WON
LOST:

	ldi r16, 0x10
	out PORTD, r16
	rjmp LOST

delay:
	ldi r22, 0XFF
	 D1: 
		ldi r23, 0XD0
			D2: 
				ldi r24, 0X01
					D3:
						dec r24
						brne D3
						dec r23
						brne D2
						dec r22
						brne D1
ret
