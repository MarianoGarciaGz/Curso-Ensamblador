start:
	LDI r16, 0x0F 
	OUT DDRB, r16 
	OUT DDRC, r16
	LDI r16, 0x00
	OUT DDRD, r16

loop:
	IN r22, PIND 
	CPI r22, 0x01 
	BREQ ani
	RJMP loop 

ani:
	LDI r30,0x05
	ani1:
	CALL animacion1
	CALL animacion2
	CALL animacion3
	CALL animacion2
	CALL animacion1
	CALL animacion0

animacion1:
 LDI r20,0x06
 animacion1a:
	
	LDI r19,0x06
 animacion1b:
	LDI r17, 0b00000001 
	OUT PORTB, r17 
	LDI r18, 0b00000011 
	OUT portc, r18
	LDI r18, 0b00000100
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000010 
	OUT portc, r18
	LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000001 
	OUT portc, r18
	LDI r18, 0b00000010 
	OUT portc, r18
	LDI r18, 0b00000101
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
    LDI r18, 0b00000010 
	OUT portc, r18
	LDI r18, 0b00000110
	OUT portc, r18
    LDI r18, 0b00000111
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000010
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000110
	OUT portc, r18
	LDI r18, 0b00000111
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
	LDI r18, 0b00000100
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	DEC r19
	BRNE ranimacion1b
	DEC r20
	BRNE ranimacion1a
	ret

 ranimacion1b:
	RJMP animacion1b
 ranimacion1a:
	RJMP animacion1a


 animacion2:
    LDI r20,0x03
 animacion2a:
	LDI r19,0x09
 animacion2b:
    LDI r17, 0b00000001 
	OUT PORTB, r17 
	LDI r18, 0b00000011 
	OUT portc, r18
	LDI r18, 0b00000100
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000010 
	OUT portc, r18
    LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000100 
	OUT portc, r18
	LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000001 
	OUT portc, r18
	LDI r18, 0b00000010 
	OUT portc, r18
	LDI r18, 0b00000101
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
    LDI r18, 0b00000010 
	OUT portc, r18
	LDI r18, 0b00000110
	OUT portc, r18
    LDI r18, 0b00000111
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000010 
	OUT portc, r18
	LDI r18, 0b00000110
	OUT portc, r18
    LDI r18, 0b00000111
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000100
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
    LDI r18, 0b00000110
	OUT portc, r18
	LDI r18, 0b00000111
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
	LDI r18, 0b00000100
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	DEC r19
	BRNE ranimacion2b
	DEC r20
	BRNE ranimacion2a
	ret

 ranimacion2b:
	RJMP animacion2b
 ranimacion2a:
	RJMP animacion2a

 animacion3:
    LDI r20,0x06
 animacion3a:
	LDI r19,0x06
 animacion3b:
	LDI r17, 0b00000001 
	OUT PORTB, r17 
	LDI r18, 0b00000011 
	OUT portc, r18
	LDI r18, 0b00000100
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000010 
	OUT portc, r18
    LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000100 
	OUT portc, r18
	LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000001 
	OUT portc, r18
	LDI r18, 0b00000010 
	OUT portc, r18
    LDI r18, 0b00000100 
	OUT portc, r18
	LDI r18, 0b00000101
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
    LDI r18, 0b00000010 
	OUT portc, r18
    LDI r18, 0b00000011 
	OUT portc, r18
    LDI r18, 0b00000100 
	OUT portc, r18
    LDI r18, 0b00000101 
	OUT portc, r18
	LDI r18, 0b00000110
	OUT portc, r18
    LDI r18, 0b00000111
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000010 
	OUT portc, r18
    LDI r18, 0b00000011 
	OUT portc, r18
    LDI r18, 0b00000100 
	OUT portc, r18
    LDI r18, 0b00000101 
	OUT portc, r18
	LDI r18, 0b00000110
	OUT portc, r18
    LDI r18, 0b00000111
	OUT portc, r18
	LDI r18, 0b00001000
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000100
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
    LDI r18, 0b00000110
	OUT portc, r18
	LDI r18, 0b00000111
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
	LDI r18, 0b00000100
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	INC r17 
	OUT PORTB, r17 
	LDI r18, 0b00000011
	OUT portc, r18
    LDI r18, 0b00000101
	OUT portc, r18
	CALL clear

	DEC r19
	BRNE ranimacion3b
	DEC r20
	BRNE ranimacion3a
	ret

 ranimacion3b:
	RJMP animacion3b
 ranimacion3a:
	RJMP animacion3a


 animacion0:
    LDI r20,0x03
 animacion0a:
	LDI r19,0xE4
 animacion0b:

    DEC r19
	BRNE animacion0b
	DEC r20
	BRNE animacion0a
	RJMP loop
	ret

 clear:
    LDI r18, 0b00000000  
    OUT portc, r18
    ret