
_main:

;invernadero_iot_1.c,87 :: 		void main() {
;invernadero_iot_1.c,88 :: 		incio();
	CALL       _incio+0
;invernadero_iot_1.c,90 :: 		max6675_init();
	CALL       _max6675_init+0
;invernadero_iot_1.c,92 :: 		Inicializar_ADC();
	CALL       _Inicializar_ADC+0
;invernadero_iot_1.c,94 :: 		while(1){
L_main0:
;invernadero_iot_1.c,98 :: 		moden_coneccion();
	CALL       _moden_coneccion+0
;invernadero_iot_1.c,99 :: 		Delay_ms(10000);
	MOVLW      102
	MOVWF      R11+0
	MOVLW      118
	MOVWF      R12+0
	MOVLW      193
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
;invernadero_iot_1.c,100 :: 		}
	GOTO       L_main0
;invernadero_iot_1.c,101 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_incio:

;invernadero_iot_1.c,105 :: 		void incio(){
;invernadero_iot_1.c,106 :: 		ANSEL = ANSELH = 0X00 ;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;invernadero_iot_1.c,109 :: 		TRISA = 0X00;
	CLRF       TRISA+0
;invernadero_iot_1.c,110 :: 		PORTA = 0X00;
	CLRF       PORTA+0
;invernadero_iot_1.c,113 :: 		TRISB = 0X00;
	CLRF       TRISB+0
;invernadero_iot_1.c,114 :: 		PORTB = 0X00;
	CLRF       PORTB+0
;invernadero_iot_1.c,117 :: 		TRISC = 0X00;
	CLRF       TRISC+0
;invernadero_iot_1.c,118 :: 		PORTC = 0X00;
	CLRF       PORTC+0
;invernadero_iot_1.c,121 :: 		TRISD = 0X00;
	CLRF       TRISD+0
;invernadero_iot_1.c,122 :: 		PORTD = 0X00;
	CLRF       PORTD+0
;invernadero_iot_1.c,125 :: 		TRISE = 0X00;
	CLRF       TRISE+0
;invernadero_iot_1.c,126 :: 		PORTE = 0X00;
	CLRF       PORTE+0
;invernadero_iot_1.c,129 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;invernadero_iot_1.c,130 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_incio3:
	DECFSZ     R13+0, 1
	GOTO       L_incio3
	DECFSZ     R12+0, 1
	GOTO       L_incio3
	DECFSZ     R11+0, 1
	GOTO       L_incio3
	NOP
;invernadero_iot_1.c,132 :: 		iniciar_moden();
	CALL       _iniciar_moden+0
;invernadero_iot_1.c,133 :: 		}
L_end_incio:
	RETURN
; end of _incio

_max6675_init:

;invernadero_iot_1.c,135 :: 		void max6675_init(){
;invernadero_iot_1.c,136 :: 		max6675_ck_dir=0;   //salida reloj
	BCF        TRISC+0, 3
;invernadero_iot_1.c,137 :: 		max6675_cs_dir=0;  //salida cs
	BCF        TRISC+0, 0
;invernadero_iot_1.c,138 :: 		max6675_dat_dir=1;  //entrada dato
	BSF        TRISC+0, 4
;invernadero_iot_1.c,140 :: 		max6675_cs=1;//salida 1
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;invernadero_iot_1.c,141 :: 		max6675_ck=0; //saca cero por el reloj
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;invernadero_iot_1.c,142 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_max6675_init4:
	DECFSZ     R13+0, 1
	GOTO       L_max6675_init4
	DECFSZ     R12+0, 1
	GOTO       L_max6675_init4
	DECFSZ     R11+0, 1
	GOTO       L_max6675_init4
	NOP
;invernadero_iot_1.c,143 :: 		}
L_end_max6675_init:
	RETURN
; end of _max6675_init

_max6675_pulso:

;invernadero_iot_1.c,145 :: 		char max6675_pulso(){
;invernadero_iot_1.c,147 :: 		max6675_ck=1; //saca uno por el reloj
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;invernadero_iot_1.c,148 :: 		Delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_max6675_pulso5:
	DECFSZ     R13+0, 1
	GOTO       L_max6675_pulso5
	NOP
;invernadero_iot_1.c,149 :: 		lei=max6675_dat;
	MOVLW      0
	BTFSC      RC4_bit+0, BitPos(RC4_bit+0)
	MOVLW      1
	MOVWF      R1+0
;invernadero_iot_1.c,150 :: 		max6675_ck=0; //saca cero por el reloj
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;invernadero_iot_1.c,151 :: 		Delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_max6675_pulso6:
	DECFSZ     R13+0, 1
	GOTO       L_max6675_pulso6
	NOP
;invernadero_iot_1.c,152 :: 		return lei;
	MOVF       R1+0, 0
	MOVWF      R0+0
;invernadero_iot_1.c,153 :: 		}
L_end_max6675_pulso:
	RETURN
; end of _max6675_pulso

_max6675_read:

;invernadero_iot_1.c,155 :: 		float max6675_read(){
;invernadero_iot_1.c,157 :: 		unsigned int max6675_dato=0;
	CLRF       max6675_read_max6675_dato_L0+0
	CLRF       max6675_read_max6675_dato_L0+1
;invernadero_iot_1.c,160 :: 		max6675_cs=0;   // habilita el modulo
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;invernadero_iot_1.c,161 :: 		for (cont=15;cont>=0;cont--){
	MOVLW      15
	MOVWF      max6675_read_cont_L0+0
L_max6675_read7:
	MOVLW      128
	XORWF      max6675_read_cont_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_max6675_read8
;invernadero_iot_1.c,162 :: 		if(max6675_pulso()==1){
	CALL       _max6675_pulso+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_max6675_read10
;invernadero_iot_1.c,163 :: 		max6675_dato=max6675_dato | 1<<cont ;
	MOVF       max6675_read_cont_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__max6675_read27:
	BTFSC      STATUS+0, 2
	GOTO       L__max6675_read28
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__max6675_read27
L__max6675_read28:
	MOVF       R0+0, 0
	IORWF      max6675_read_max6675_dato_L0+0, 1
	MOVF       R0+1, 0
	IORWF      max6675_read_max6675_dato_L0+1, 1
;invernadero_iot_1.c,164 :: 		}// fin if
L_max6675_read10:
;invernadero_iot_1.c,161 :: 		for (cont=15;cont>=0;cont--){
	DECF       max6675_read_cont_L0+0, 1
;invernadero_iot_1.c,165 :: 		}//fin for
	GOTO       L_max6675_read7
L_max6675_read8:
;invernadero_iot_1.c,166 :: 		max6675_cs=1;  //apagar modulo
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;invernadero_iot_1.c,167 :: 		sensor_dato=(max6675_dato>>3 ); //desplaz 3 veces
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
;invernadero_iot_1.c,168 :: 		return((sensor_dato*0.25));
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
;invernadero_iot_1.c,169 :: 		}
L_end_max6675_read:
	RETURN
; end of _max6675_read

_Inicializar_ADC:

;invernadero_iot_1.c,173 :: 		void Inicializar_ADC(){
;invernadero_iot_1.c,174 :: 		PORTA  = 0x00; //Limpiar el puerto A.
	CLRF       PORTA+0
;invernadero_iot_1.c,175 :: 		TRISA  = 0x01; //RA0 como entrada.
	MOVLW      1
	MOVWF      TRISA+0
;invernadero_iot_1.c,176 :: 		ANSEL  = 0x01; //RA0 como entrada analógica.
	MOVLW      1
	MOVWF      ANSEL+0
;invernadero_iot_1.c,177 :: 		ADCON0 = 0x81; //Encender ADC y seleccionar el reloj: Fosc/32.
	MOVLW      129
	MOVWF      ADCON0+0
;invernadero_iot_1.c,178 :: 		ADCON1 = 0X00; //Referencia en Vss y Vdd, Justificado a la izqueirda.
	CLRF       ADCON1+0
;invernadero_iot_1.c,179 :: 		}
L_end_Inicializar_ADC:
	RETURN
; end of _Inicializar_ADC

_Leer_ADC:

;invernadero_iot_1.c,181 :: 		unsigned int Leer_ADC(unsigned char canal){
;invernadero_iot_1.c,182 :: 		if(canal > 13)
	MOVF       FARG_Leer_ADC_canal+0, 0
	SUBLW      13
	BTFSC      STATUS+0, 0
	GOTO       L_Leer_ADC11
;invernadero_iot_1.c,183 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_Leer_ADC
L_Leer_ADC11:
;invernadero_iot_1.c,185 :: 		ADCON0 &= 0xC5;     //Limpiar la selección de bits.
	MOVLW      197
	ANDWF      ADCON0+0, 1
;invernadero_iot_1.c,186 :: 		ADCON0 |= canal<<2; //Se establecen los bits CHS3, CHS2, CHS1 y CHS0.
	MOVF       FARG_Leer_ADC_canal+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      ADCON0+0, 1
;invernadero_iot_1.c,187 :: 		Delay_us(2);      //Tiempo de adquisición.
	NOP
	NOP
	NOP
	NOP
;invernadero_iot_1.c,188 :: 		ADCON0 = 1;       //Inicialozar la conersión ADC.
	MOVLW      1
	MOVWF      ADCON0+0
;invernadero_iot_1.c,189 :: 		while(ADCON0);    //Esperar a que la conversión se complete.
L_Leer_ADC12:
	MOVF       ADCON0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Leer_ADC13
	GOTO       L_Leer_ADC12
L_Leer_ADC13:
;invernadero_iot_1.c,191 :: 		return ((ADRESH<<8) + ADRESL); //Retornar resultado.
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
;invernadero_iot_1.c,192 :: 		}
L_end_Leer_ADC:
	RETURN
; end of _Leer_ADC

_iniciar_moden:

;invernadero_iot_1.c,194 :: 		void iniciar_moden(){
;invernadero_iot_1.c,195 :: 		ec_fsm.anterior=kFSM_ENVIANDO_AT;
	MOVLW      1
	MOVWF      _ec_fsm+0
;invernadero_iot_1.c,196 :: 		ec_fsm.actual=kFSM_ENVIANDO_AT;
	MOVLW      1
	MOVWF      _ec_fsm+1
;invernadero_iot_1.c,197 :: 		}
L_end_iniciar_moden:
	RETURN
; end of _iniciar_moden

_ms_error:

;invernadero_iot_1.c,200 :: 		void ms_error(){
;invernadero_iot_1.c,202 :: 		}
L_end_ms_error:
	RETURN
; end of _ms_error

_moden_coneccion:

;invernadero_iot_1.c,205 :: 		void moden_coneccion(){
;invernadero_iot_1.c,207 :: 		switch(ec_fsm.actual) {
	GOTO       L_moden_coneccion14
;invernadero_iot_1.c,208 :: 		case kFSM_INICIO:
L_moden_coneccion16:
;invernadero_iot_1.c,209 :: 		break;
	GOTO       L_moden_coneccion15
;invernadero_iot_1.c,210 :: 		case kFSM_ENVIANDO_AT:
L_moden_coneccion17:
;invernadero_iot_1.c,211 :: 		UART1_Write_Text(&ec25_comandos_at[kAT]);	//Envia comando AT
	MOVLW      _ec25_comandos_at+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;invernadero_iot_1.c,212 :: 		ec_fsm.anterior = ec_fsm.actual;		//almacena el estado actual
	MOVF       _ec_fsm+1, 0
	MOVWF      _ec_fsm+0
;invernadero_iot_1.c,213 :: 		ec_fsm.actual = kFSM_ESPERANDO_RESPUESTA;	//avanza a esperar respuesta del modem
	MOVLW      8
	MOVWF      _ec_fsm+1
;invernadero_iot_1.c,214 :: 		break;
	GOTO       L_moden_coneccion15
;invernadero_iot_1.c,215 :: 		case kFSM_RESULTADO_ERROR:
L_moden_coneccion18:
;invernadero_iot_1.c,216 :: 		break;
	GOTO       L_moden_coneccion15
;invernadero_iot_1.c,217 :: 		case kFSM_RESULTADO_EXITOSO:
L_moden_coneccion19:
;invernadero_iot_1.c,218 :: 		break;
	GOTO       L_moden_coneccion15
;invernadero_iot_1.c,219 :: 		case kFSM_ESPERANDO_RESPUESTA:
L_moden_coneccion20:
;invernadero_iot_1.c,221 :: 		default: ;
L_moden_coneccion21:
;invernadero_iot_1.c,222 :: 		}
	GOTO       L_moden_coneccion15
L_moden_coneccion14:
	MOVF       _ec_fsm+1, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_moden_coneccion16
	MOVF       _ec_fsm+1, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_moden_coneccion17
	MOVF       _ec_fsm+1, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_moden_coneccion18
	MOVF       _ec_fsm+1, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_moden_coneccion19
	MOVF       _ec_fsm+1, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_moden_coneccion20
	GOTO       L_moden_coneccion21
L_moden_coneccion15:
;invernadero_iot_1.c,226 :: 		}
L_end_moden_coneccion:
	RETURN
; end of _moden_coneccion
