
_main:

;invernadero_iot_1.c,25 :: 		void main() {
;invernadero_iot_1.c,26 :: 		incio();
	CALL       _incio+0
;invernadero_iot_1.c,27 :: 		max6675_init();
	CALL       _max6675_init+0
;invernadero_iot_1.c,28 :: 		while(1){
L_main0:
;invernadero_iot_1.c,29 :: 		max6675_read();
	CALL       _max6675_read+0
;invernadero_iot_1.c,30 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;invernadero_iot_1.c,31 :: 		}
	GOTO       L_main0
;invernadero_iot_1.c,32 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_incio:

;invernadero_iot_1.c,36 :: 		void incio(){
;invernadero_iot_1.c,37 :: 		ANSEL = ANSELH = 0X00 ;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;invernadero_iot_1.c,40 :: 		TRISA = 0X00;
	CLRF       TRISA+0
;invernadero_iot_1.c,41 :: 		PORTA = 0X00;
	CLRF       PORTA+0
;invernadero_iot_1.c,44 :: 		TRISB = 0X00;
	CLRF       TRISB+0
;invernadero_iot_1.c,45 :: 		PORTB = 0X00;
	CLRF       PORTB+0
;invernadero_iot_1.c,48 :: 		TRISC = 0X00;
	CLRF       TRISC+0
;invernadero_iot_1.c,49 :: 		PORTC = 0X00;
	CLRF       PORTC+0
;invernadero_iot_1.c,52 :: 		TRISD = 0X00;
	CLRF       TRISD+0
;invernadero_iot_1.c,53 :: 		PORTD = 0X00;
	CLRF       PORTD+0
;invernadero_iot_1.c,55 :: 		}
L_end_incio:
	RETURN
; end of _incio

_max6675_init:

;invernadero_iot_1.c,57 :: 		void max6675_init(){
;invernadero_iot_1.c,58 :: 		max6675_ck_dir=0;   //salida reloj
	BCF        TRISC+0, 3
;invernadero_iot_1.c,59 :: 		max6675_cs_dir=0;  //salida cs
	BCF        TRISC+0, 0
;invernadero_iot_1.c,60 :: 		max6675_dat_dir=1;  //entrada dato
	BSF        TRISC+0, 4
;invernadero_iot_1.c,62 :: 		max6675_cs=1;//salida 1
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;invernadero_iot_1.c,63 :: 		max6675_ck=0; //saca cero por el reloj
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;invernadero_iot_1.c,64 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_max6675_init3:
	DECFSZ     R13+0, 1
	GOTO       L_max6675_init3
	DECFSZ     R12+0, 1
	GOTO       L_max6675_init3
	DECFSZ     R11+0, 1
	GOTO       L_max6675_init3
	NOP
;invernadero_iot_1.c,65 :: 		}
L_end_max6675_init:
	RETURN
; end of _max6675_init

_max6675_pulso:

;invernadero_iot_1.c,67 :: 		char max6675_pulso(){
;invernadero_iot_1.c,69 :: 		max6675_ck=1; //saca uno por el reloj
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;invernadero_iot_1.c,70 :: 		Delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_max6675_pulso4:
	DECFSZ     R13+0, 1
	GOTO       L_max6675_pulso4
	NOP
;invernadero_iot_1.c,71 :: 		lei=max6675_dat;
	MOVLW      0
	BTFSC      RC4_bit+0, BitPos(RC4_bit+0)
	MOVLW      1
	MOVWF      R1+0
;invernadero_iot_1.c,72 :: 		max6675_ck=0; //saca cero por el reloj
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;invernadero_iot_1.c,73 :: 		Delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_max6675_pulso5:
	DECFSZ     R13+0, 1
	GOTO       L_max6675_pulso5
	NOP
;invernadero_iot_1.c,74 :: 		return lei;
	MOVF       R1+0, 0
	MOVWF      R0+0
;invernadero_iot_1.c,75 :: 		}
L_end_max6675_pulso:
	RETURN
; end of _max6675_pulso

_max6675_read:

;invernadero_iot_1.c,77 :: 		float max6675_read(){
;invernadero_iot_1.c,79 :: 		unsigned int max6675_dato=0;
	CLRF       max6675_read_max6675_dato_L0+0
	CLRF       max6675_read_max6675_dato_L0+1
;invernadero_iot_1.c,82 :: 		max6675_cs=0;   // habilita el modulo
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;invernadero_iot_1.c,83 :: 		for (cont=15;cont>=0;cont--){
	MOVLW      15
	MOVWF      max6675_read_cont_L0+0
L_max6675_read6:
	MOVLW      128
	XORWF      max6675_read_cont_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_max6675_read7
;invernadero_iot_1.c,84 :: 		if(max6675_pulso()==1){
	CALL       _max6675_pulso+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_max6675_read9
;invernadero_iot_1.c,85 :: 		max6675_dato=max6675_dato | 1<<cont ;
	MOVF       max6675_read_cont_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__max6675_read15:
	BTFSC      STATUS+0, 2
	GOTO       L__max6675_read16
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__max6675_read15
L__max6675_read16:
	MOVF       R0+0, 0
	IORWF      max6675_read_max6675_dato_L0+0, 1
	MOVF       R0+1, 0
	IORWF      max6675_read_max6675_dato_L0+1, 1
;invernadero_iot_1.c,86 :: 		}// fin if
L_max6675_read9:
;invernadero_iot_1.c,83 :: 		for (cont=15;cont>=0;cont--){
	DECF       max6675_read_cont_L0+0, 1
;invernadero_iot_1.c,87 :: 		}//fin for
	GOTO       L_max6675_read6
L_max6675_read7:
;invernadero_iot_1.c,88 :: 		max6675_cs=1;  //apagar modulo
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;invernadero_iot_1.c,89 :: 		sensor_dato=(max6675_dato>>3 ); //desplaz 3 veces
	MOVF       max6675_read_max6675_dato_L0+0, 0
	MOVWF      R0+0
	MOVF       max6675_read_max6675_dato_L0+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
;invernadero_iot_1.c,90 :: 		return((sensor_dato*0.25));
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
;invernadero_iot_1.c,91 :: 		}
L_end_max6675_read:
	RETURN
; end of _max6675_read
