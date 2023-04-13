
_main:

;invernadero_iot_1.c,32 :: 		void main(){
;invernadero_iot_1.c,34 :: 		char lec = 'A';
	MOVLW      65
	MOVWF      main_lec_L0+0
;invernadero_iot_1.c,41 :: 		ANSEL = ANSELH = 0X00 ;
	CLRF       ANSELH+0
	CLRF       ANSEL+0
;invernadero_iot_1.c,43 :: 		TRISA = 0X00;
	CLRF       TRISA+0
;invernadero_iot_1.c,44 :: 		PORTA = 0X00;
	CLRF       PORTA+0
;invernadero_iot_1.c,46 :: 		TRISB = 0X00;
	CLRF       TRISB+0
;invernadero_iot_1.c,47 :: 		PORTB = 0X08;
	MOVLW      8
	MOVWF      PORTB+0
;invernadero_iot_1.c,52 :: 		TRISD = 0X00;
	CLRF       TRISD+0
;invernadero_iot_1.c,53 :: 		PORTD = 0X00;
	CLRF       PORTD+0
;invernadero_iot_1.c,55 :: 		TRISE = 0X00;
	CLRF       TRISE+0
;invernadero_iot_1.c,56 :: 		PORTE = 0X00;
	CLRF       PORTE+0
;invernadero_iot_1.c,58 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;invernadero_iot_1.c,59 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
	NOP
;invernadero_iot_1.c,61 :: 		while(true){
L_main1:
;invernadero_iot_1.c,68 :: 		if (lec == 'A'){
	MOVF       main_lec_L0+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;invernadero_iot_1.c,69 :: 		PIN_OK = ~PIN_OK;
	MOVLW
	XORWF      RB6_bit+0, 1
;invernadero_iot_1.c,70 :: 		lec = 'J';
	MOVLW      74
	MOVWF      main_lec_L0+0
;invernadero_iot_1.c,71 :: 		}
L_main3:
;invernadero_iot_1.c,73 :: 		lec = read_uart();
	CALL       _read_uart+0
	MOVF       R0+0, 0
	MOVWF      main_lec_L0+0
;invernadero_iot_1.c,75 :: 		read_dth11() ;
	CALL       _read_dth11+0
;invernadero_iot_1.c,79 :: 		if (lec == 'B'){
	MOVF       main_lec_L0+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;invernadero_iot_1.c,80 :: 		humedad1 = ADC_Read(0);    /// humedad terrestre
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;invernadero_iot_1.c,81 :: 		IntToStr(humedad1,entero);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_entero_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;invernadero_iot_1.c,82 :: 		UART1_Write_Text(entero);
	MOVLW      main_entero_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;invernadero_iot_1.c,83 :: 		UART1_Write_Text("hola 1");
	MOVLW      ?lstr1_invernadero_iot_1+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;invernadero_iot_1.c,84 :: 		} else if (lec == 'C'){ /// temperatura relativa
	GOTO       L_main5
L_main4:
	MOVF       main_lec_L0+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;invernadero_iot_1.c,85 :: 		IntToStr(temperatura,entero);
	MOVF       _temperatura+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _temperatura+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_entero_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;invernadero_iot_1.c,86 :: 		UART1_Write_Text(entero);
	MOVLW      main_entero_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;invernadero_iot_1.c,87 :: 		UART1_Write_Text("hola 2 ");
	MOVLW      ?lstr2_invernadero_iot_1+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;invernadero_iot_1.c,88 :: 		}else if (lec == 'D'){   /// humedad relativa
	GOTO       L_main7
L_main6:
	MOVF       main_lec_L0+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;invernadero_iot_1.c,89 :: 		IntToStr(humedad,entero);
	MOVF       _humedad+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _humedad+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_entero_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;invernadero_iot_1.c,90 :: 		UART1_Write_Text(entero);
	MOVLW      main_entero_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;invernadero_iot_1.c,91 :: 		UART1_Write_Text("hola 3 ");
	MOVLW      ?lstr3_invernadero_iot_1+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;invernadero_iot_1.c,92 :: 		}else if (lec == 'F'){ /// rele 1 luces
	GOTO       L_main9
L_main8:
	MOVF       main_lec_L0+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;invernadero_iot_1.c,93 :: 		PIN_RELE1 = ~PIN_RELE1 ;
	MOVLW
	XORWF      RB1_bit+0, 1
;invernadero_iot_1.c,94 :: 		}else if (lec == 'G'){ /// rele 2 agua
	GOTO       L_main11
L_main10:
	MOVF       main_lec_L0+0, 0
	XORLW      71
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;invernadero_iot_1.c,95 :: 		PIN_RELE2 = ~PIN_RELE2 ;
	MOVLW
	XORWF      RB2_bit+0, 1
;invernadero_iot_1.c,96 :: 		}else if (lec == 'H'){    /// rele 3 humidificador
	GOTO       L_main13
L_main12:
	MOVF       main_lec_L0+0, 0
	XORLW      72
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;invernadero_iot_1.c,97 :: 		PIN_RELE3 = ~PIN_RELE3 ;
	MOVLW
	XORWF      RB3_bit+0, 1
;invernadero_iot_1.c,98 :: 		}else if (lec == 'E'){   /// error
	GOTO       L_main15
L_main14:
	MOVF       main_lec_L0+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;invernadero_iot_1.c,99 :: 		PIN_ERROR = ~PIN_ERROR;
	MOVLW
	XORWF      RB7_bit+0, 1
;invernadero_iot_1.c,100 :: 		PIN_OK = ~PIN_OK;
	MOVLW
	XORWF      RB6_bit+0, 1
;invernadero_iot_1.c,101 :: 		}
L_main16:
L_main15:
L_main13:
L_main11:
L_main9:
L_main7:
L_main5:
;invernadero_iot_1.c,103 :: 		}// end while --------------------
	GOTO       L_main1
;invernadero_iot_1.c,104 :: 		}// end main ---------------------
L_end_main:
	GOTO       $+0
; end of _main

_read_uart:

;invernadero_iot_1.c,108 :: 		char read_uart(){
;invernadero_iot_1.c,109 :: 		char uart_rd = '0';
	MOVLW      48
	MOVWF      read_uart_uart_rd_L0+0
;invernadero_iot_1.c,110 :: 		if(UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_read_uart17
;invernadero_iot_1.c,111 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      read_uart_uart_rd_L0+0
;invernadero_iot_1.c,112 :: 		}
L_read_uart17:
;invernadero_iot_1.c,113 :: 		return uart_rd;
	MOVF       read_uart_uart_rd_L0+0, 0
	MOVWF      R0+0
;invernadero_iot_1.c,114 :: 		}
L_end_read_uart:
	RETURN
; end of _read_uart

_Inicializar_ADC:

;invernadero_iot_1.c,117 :: 		void Inicializar_ADC(){
;invernadero_iot_1.c,118 :: 		PORTA  = 0x00; //Limpiar el puerto A.
	CLRF       PORTA+0
;invernadero_iot_1.c,119 :: 		TRISA  = 0x01; //RA0 como entrada.
	MOVLW      1
	MOVWF      TRISA+0
;invernadero_iot_1.c,120 :: 		ANSEL  = 0x01; //RA0 como entrada analógica.
	MOVLW      1
	MOVWF      ANSEL+0
;invernadero_iot_1.c,121 :: 		ADCON0 = 0x81; //Encender ADC y seleccionar el reloj: Fosc/32.
	MOVLW      129
	MOVWF      ADCON0+0
;invernadero_iot_1.c,122 :: 		ADCON1 = 0X00; //Referencia en Vss y Vdd, Justificado a la izqueirda.
	CLRF       ADCON1+0
;invernadero_iot_1.c,123 :: 		}
L_end_Inicializar_ADC:
	RETURN
; end of _Inicializar_ADC

_Leer_ADC:

;invernadero_iot_1.c,125 :: 		unsigned int Leer_ADC(unsigned char canal){
;invernadero_iot_1.c,126 :: 		if(canal > 13){
	MOVF       FARG_Leer_ADC_canal+0, 0
	SUBLW      13
	BTFSC      STATUS+0, 0
	GOTO       L_Leer_ADC18
;invernadero_iot_1.c,127 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_Leer_ADC
;invernadero_iot_1.c,128 :: 		}
L_Leer_ADC18:
;invernadero_iot_1.c,130 :: 		ADCON0 |= canal<<2; //Se establecen los bits CHS3, CHS2, CHS1 y CHS0.
	MOVF       FARG_Leer_ADC_canal+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      ADCON0+0, 1
;invernadero_iot_1.c,131 :: 		Delay_us(2);      //Tiempo de adquisición.
	NOP
	NOP
;invernadero_iot_1.c,132 :: 		ADCON0.f1 = 1;       //Inicialozar la conersión ADC.
	BSF        ADCON0+0, 1
;invernadero_iot_1.c,133 :: 		while(ADCON0.f1);    //Esperar a que la conversión se complete.
L_Leer_ADC19:
	BTFSS      ADCON0+0, 1
	GOTO       L_Leer_ADC20
	GOTO       L_Leer_ADC19
L_Leer_ADC20:
;invernadero_iot_1.c,134 :: 		return ((ADRESH<<8) + ADRESL); //Retornar resultado.
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
;invernadero_iot_1.c,137 :: 		}
L_end_Leer_ADC:
	RETURN
; end of _Leer_ADC

_read_dth11:

;invernadero_iot_1.c,139 :: 		char read_dth11(){            //funcion para realizar la lectura del sensor dht11
;invernadero_iot_1.c,141 :: 		unsigned char i=0;
	CLRF       read_dth11_i_L0+0
	CLRF       read_dth11_j_L0+0
	CLRF       read_dth11_hum_L0+0
	CLRF       read_dth11_hum_L0+1
	CLRF       read_dth11_temp_L0+0
	CLRF       read_dth11_temp_L0+1
	MOVLW      10
	MOVWF      read_dth11_base_L0+0
	MOVLW      0
	MOVWF      read_dth11_base_L0+1
;invernadero_iot_1.c,148 :: 		temperatura=-1;
	MOVLW      255
	MOVWF      _temperatura+0
	MOVLW      255
	MOVWF      _temperatura+1
;invernadero_iot_1.c,149 :: 		humedad=-1;
	MOVLW      255
	MOVWF      _humedad+0
	MOVLW      255
	MOVWF      _humedad+1
;invernadero_iot_1.c,153 :: 		PIN_SENSOR_Direction=0;  //rb0 de salida
	BCF        TRISB+0, 0
;invernadero_iot_1.c,154 :: 		PIN_SENSOR=1;  //rb0 en alto
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;invernadero_iot_1.c,155 :: 		delay_us(20);
	MOVLW      6
	MOVWF      R13+0
L_read_dth1123:
	DECFSZ     R13+0, 1
	GOTO       L_read_dth1123
	NOP
;invernadero_iot_1.c,156 :: 		PIN_SENSOR=0;     //rbo en bajo
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;invernadero_iot_1.c,157 :: 		delay_ms(18);
	MOVLW      24
	MOVWF      R12+0
	MOVLW      95
	MOVWF      R13+0
L_read_dth1124:
	DECFSZ     R13+0, 1
	GOTO       L_read_dth1124
	DECFSZ     R12+0, 1
	GOTO       L_read_dth1124
;invernadero_iot_1.c,158 :: 		PIN_SENSOR=1;     //rbo en alto
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;invernadero_iot_1.c,159 :: 		delay_us(22);
	MOVLW      7
	MOVWF      R13+0
L_read_dth1125:
	DECFSZ     R13+0, 1
	GOTO       L_read_dth1125
;invernadero_iot_1.c,160 :: 		PIN_SENSOR_Direction=1; //rbo como entrada para leer la respuesta del sensor
	BSF        TRISB+0, 0
;invernadero_iot_1.c,161 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_dth1126:
	DECFSZ     R13+0, 1
	GOTO       L_read_dth1126
;invernadero_iot_1.c,162 :: 		if(PIN_SENSOR){return -1;}    //comprueba si el sensor envio un estado bajo
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_dth1127
	MOVLW      255
	MOVWF      R0+0
	GOTO       L_end_read_dth11
L_read_dth1127:
;invernadero_iot_1.c,163 :: 		delay_us(80);
	MOVLW      26
	MOVWF      R13+0
L_read_dth1128:
	DECFSZ     R13+0, 1
	GOTO       L_read_dth1128
	NOP
;invernadero_iot_1.c,164 :: 		if(PIN_SENSOR==0){return -1;}      //comprueba si el sensor envio un estado alto despues de 80ms
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_dth1129
	MOVLW      255
	MOVWF      R0+0
	GOTO       L_end_read_dth11
L_read_dth1129:
;invernadero_iot_1.c,165 :: 		delay_us(80);
	MOVLW      26
	MOVWF      R13+0
L_read_dth1130:
	DECFSZ     R13+0, 1
	GOTO       L_read_dth1130
	NOP
;invernadero_iot_1.c,167 :: 		for(i=0;i<5;i++){
	CLRF       read_dth11_i_L0+0
L_read_dth1131:
	MOVLW      5
	SUBWF      read_dth11_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_dth1132
;invernadero_iot_1.c,168 :: 		for(j=0;j<8;j++){
	CLRF       read_dth11_j_L0+0
L_read_dth1134:
	MOVLW      8
	SUBWF      read_dth11_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_dth1135
;invernadero_iot_1.c,169 :: 		while(PIN_SENSOR==0);   //espera a que la entrada sea distinta de 0
L_read_dth1137:
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_dth1138
	GOTO       L_read_dth1137
L_read_dth1138:
;invernadero_iot_1.c,170 :: 		delay_us(30);     //espera 30 us
	MOVLW      9
	MOVWF      R13+0
L_read_dth1139:
	DECFSZ     R13+0, 1
	GOTO       L_read_dth1139
	NOP
	NOP
;invernadero_iot_1.c,171 :: 		if(PIN_SENSOR){    // si el pulso despues de 30us esta en alto es porque es un 1
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_dth1140
;invernadero_iot_1.c,172 :: 		dato[i]=(dato[i]<<1) | 0x01;   // se le agrega un 1 al bit
	MOVF       read_dth11_i_L0+0, 0
	ADDLW      read_dth11_dato_L0+0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	BSF        R0+0, 0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;invernadero_iot_1.c,173 :: 		}
L_read_dth1140:
;invernadero_iot_1.c,174 :: 		if(PIN_SENSOR==0){       // si el pulso despues de 30us esta en bajo es porque es un 0
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_dth1141
;invernadero_iot_1.c,175 :: 		dato[i]=(dato[i]<<1);}  // se le agrega un 0 corriendo a la izquierda            }
	MOVF       read_dth11_i_L0+0, 0
	ADDLW      read_dth11_dato_L0+0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_read_dth1141:
;invernadero_iot_1.c,176 :: 		while(PIN_SENSOR==1);
L_read_dth1142:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_dth1143
	GOTO       L_read_dth1142
L_read_dth1143:
;invernadero_iot_1.c,168 :: 		for(j=0;j<8;j++){
	INCF       read_dth11_j_L0+0, 1
;invernadero_iot_1.c,177 :: 		}//fin for de 8
	GOTO       L_read_dth1134
L_read_dth1135:
;invernadero_iot_1.c,167 :: 		for(i=0;i<5;i++){
	INCF       read_dth11_i_L0+0, 1
;invernadero_iot_1.c,178 :: 		}// fin for de 5
	GOTO       L_read_dth1131
L_read_dth1132:
;invernadero_iot_1.c,179 :: 		PIN_SENSOR_Direction=0;    //rb0 de salida
	BCF        TRISB+0, 0
;invernadero_iot_1.c,180 :: 		PIN_SENSOR=1;     //rb0  en alto
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;invernadero_iot_1.c,182 :: 		if((dato[0]+dato[1]+dato[2]+dato[3])==dato[4]){
	MOVF       read_dth11_dato_L0+1, 0
	ADDWF      read_dth11_dato_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       read_dth11_dato_L0+2, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       read_dth11_dato_L0+3, 0
	ADDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_dth1157
	MOVF       read_dth11_dato_L0+4, 0
	XORWF      R2+0, 0
L__read_dth1157:
	BTFSS      STATUS+0, 2
	GOTO       L_read_dth1144
;invernadero_iot_1.c,183 :: 		hum=dato[0];
	MOVF       read_dth11_dato_L0+0, 0
	MOVWF      read_dth11_hum_L0+0
	CLRF       read_dth11_hum_L0+1
;invernadero_iot_1.c,184 :: 		temp=dato[2];
	MOVF       read_dth11_dato_L0+2, 0
	MOVWF      read_dth11_temp_L0+0
	CLRF       read_dth11_temp_L0+1
;invernadero_iot_1.c,186 :: 		base=10;
	MOVLW      10
	MOVWF      read_dth11_base_L0+0
	MOVLW      0
	MOVWF      read_dth11_base_L0+1
;invernadero_iot_1.c,187 :: 		for(i=0;i<2;i++){
	CLRF       read_dth11_i_L0+0
L_read_dth1145:
	MOVLW      2
	SUBWF      read_dth11_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_dth1146
;invernadero_iot_1.c,188 :: 		valor[i]=(hum/base);
	MOVF       read_dth11_i_L0+0, 0
	ADDLW      read_dth11_valor_L0+0
	MOVWF      FLOC__read_dth11+0
	MOVF       read_dth11_base_L0+0, 0
	MOVWF      R4+0
	MOVF       read_dth11_base_L0+1, 0
	MOVWF      R4+1
	MOVF       read_dth11_hum_L0+0, 0
	MOVWF      R0+0
	MOVF       read_dth11_hum_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       FLOC__read_dth11+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;invernadero_iot_1.c,189 :: 		hum=hum-(valor[i]*base);
	MOVF       read_dth11_i_L0+0, 0
	ADDLW      read_dth11_valor_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       read_dth11_base_L0+0, 0
	MOVWF      R4+0
	MOVF       read_dth11_base_L0+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	SUBWF      read_dth11_hum_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_dth11_hum_L0+1, 1
	MOVF       R0+1, 0
	SUBWF      read_dth11_hum_L0+1, 1
;invernadero_iot_1.c,190 :: 		base=base/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       read_dth11_base_L0+0, 0
	MOVWF      R0+0
	MOVF       read_dth11_base_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      read_dth11_base_L0+0
	MOVF       R0+1, 0
	MOVWF      read_dth11_base_L0+1
;invernadero_iot_1.c,187 :: 		for(i=0;i<2;i++){
	INCF       read_dth11_i_L0+0, 1
;invernadero_iot_1.c,191 :: 		}
	GOTO       L_read_dth1145
L_read_dth1146:
;invernadero_iot_1.c,192 :: 		base=10;
	MOVLW      10
	MOVWF      read_dth11_base_L0+0
	MOVLW      0
	MOVWF      read_dth11_base_L0+1
;invernadero_iot_1.c,193 :: 		for(i=2;i<4;i++){
	MOVLW      2
	MOVWF      read_dth11_i_L0+0
L_read_dth1148:
	MOVLW      4
	SUBWF      read_dth11_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_dth1149
;invernadero_iot_1.c,194 :: 		valor[i]=(temp/base);
	MOVF       read_dth11_i_L0+0, 0
	ADDLW      read_dth11_valor_L0+0
	MOVWF      FLOC__read_dth11+0
	MOVF       read_dth11_base_L0+0, 0
	MOVWF      R4+0
	MOVF       read_dth11_base_L0+1, 0
	MOVWF      R4+1
	MOVF       read_dth11_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       read_dth11_temp_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       FLOC__read_dth11+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;invernadero_iot_1.c,195 :: 		temp=temp-(valor[i]*base);
	MOVF       read_dth11_i_L0+0, 0
	ADDLW      read_dth11_valor_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       read_dth11_base_L0+0, 0
	MOVWF      R4+0
	MOVF       read_dth11_base_L0+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	SUBWF      read_dth11_temp_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       read_dth11_temp_L0+1, 1
	MOVF       R0+1, 0
	SUBWF      read_dth11_temp_L0+1, 1
;invernadero_iot_1.c,196 :: 		base=base/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       read_dth11_base_L0+0, 0
	MOVWF      R0+0
	MOVF       read_dth11_base_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      read_dth11_base_L0+0
	MOVF       R0+1, 0
	MOVWF      read_dth11_base_L0+1
;invernadero_iot_1.c,193 :: 		for(i=2;i<4;i++){
	INCF       read_dth11_i_L0+0, 1
;invernadero_iot_1.c,197 :: 		}
	GOTO       L_read_dth1148
L_read_dth1149:
;invernadero_iot_1.c,199 :: 		temperatura=(valor[2]*10)+valor[3];
	MOVF       read_dth11_valor_L0+2, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       read_dth11_valor_L0+3, 0
	ADDWF      R0+0, 0
	MOVWF      _temperatura+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      _temperatura+1
;invernadero_iot_1.c,200 :: 		humedad=(valor[0]*10)+valor[1];
	MOVF       read_dth11_valor_L0+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       read_dth11_valor_L0+1, 0
	ADDWF      R0+0, 0
	MOVWF      _humedad+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      _humedad+1
;invernadero_iot_1.c,201 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_read_dth11
;invernadero_iot_1.c,203 :: 		}else{return -1;}
L_read_dth1144:
	MOVLW      255
	MOVWF      R0+0
;invernadero_iot_1.c,205 :: 		}//fin read_dht
L_end_read_dth11:
	RETURN
; end of _read_dth11
