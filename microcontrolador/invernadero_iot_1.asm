
_main:

;invernadero_iot_1.c,5 :: 		void main() {
;invernadero_iot_1.c,6 :: 		incio();
	CALL       _incio+0
;invernadero_iot_1.c,8 :: 		while(1){
L_main0:
;invernadero_iot_1.c,10 :: 		}
	GOTO       L_main0
;invernadero_iot_1.c,11 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_incio:

;invernadero_iot_1.c,13 :: 		void incio(){
;invernadero_iot_1.c,14 :: 		ANSEL = ANSELH = 0X00 ;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;invernadero_iot_1.c,17 :: 		TRISA = 0X00;
	CLRF       TRISA+0
;invernadero_iot_1.c,18 :: 		PORTA = 0X00;
	CLRF       PORTA+0
;invernadero_iot_1.c,21 :: 		TRISB = 0X00;
	CLRF       TRISB+0
;invernadero_iot_1.c,22 :: 		PORTB = 0X00;
	CLRF       PORTB+0
;invernadero_iot_1.c,25 :: 		TRISC = 0X00;
	CLRF       TRISC+0
;invernadero_iot_1.c,26 :: 		PORTC = 0X00;
	CLRF       PORTC+0
;invernadero_iot_1.c,29 :: 		TRISD = 0X00;
	CLRF       TRISD+0
;invernadero_iot_1.c,30 :: 		PORTD = 0X00;
	CLRF       PORTD+0
;invernadero_iot_1.c,33 :: 		}
L_end_incio:
	RETURN
; end of _incio
