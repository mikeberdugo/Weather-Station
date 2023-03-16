#line 1 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
#line 17 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
struct estado_fsm{char anterior, actual;};



struct estado_fsm ec_fsm;


const char *ec25_comandos_at[] = {
 "AT",
 "ATI",
 "AT+CPIN?",
 "AT+CREG?",
 "AT+CMGF=1",
 "AT+CMGS=\"3152849863\"",
 "Mensaje",
};


const char *ec25_repuestas_at[]={
 "OK",
 "EC25",
 "READY",
 "0,1",
 "OK",
 ">",
 "OK",
};

enum _ec25_lista_comandos_at {
 kAT = 0,
 kATI,
 kAT_CPIN,
 kAT_CREG,
 kAT_CMGF_1,
 kAT_CMGS,
 kAT_TEXT_MSG_END,
};

enum _fsm_ec25_state{
 kFSM_INICIO=0,
 kFSM_ENVIANDO_AT,
 kFSM_ENVIANDO_ATI,
 kFSM_ENVIANDO_CPIN,
 kFSM_ENVIANDO_CREG,
 kFSM_ENVIANDO_CMGF,
 kFSM_ENVIANDO_CMGS,
 kFSM_ENVIANDO_MENSAJE_TXT,
 kFSM_ESPERANDO_RESPUESTA,
 kFSM_RESULTADO_ERROR,
 kFSM_RESULTADO_EXITOSO
};


void iniciar_moden();
void moden_coneccion();


void max6675_init();
float max6675_read();


void Inicializar_ADC();
unsigned int Leer_ADC(unsigned char canal);



void incio();
void sensor_1_temperatura();


void main() {
incio();

max6675_init();

Inicializar_ADC();

while(1){



 moden_coneccion();
 Delay_ms(10000);
 }
}



void incio(){
ANSEL = ANSELH = 0X00 ;


TRISA = 0X00;
PORTA = 0X00;


TRISB = 0X00;
PORTB = 0X00;


TRISC = 0X00;
PORTC = 0X00;


TRISD = 0X00;
PORTD = 0X00;


TRISE = 0X00;
PORTE = 0X00;


 UART1_Init(9600);
 Delay_ms(100);

iniciar_moden();
}

void max6675_init(){
  trisc.b3 =0;
  trisc.b0 =0;
  trisc.b4 =1;

  RC0_bit =1;
  RC3_bit =0;
 Delay_ms(100);
}

char max6675_pulso(){
char lei;
  RC3_bit =1;
 Delay_us(10);
 lei= RC4_bit ;
  RC3_bit =0;
 Delay_us(10);
 return lei;
}

float max6675_read(){
unsigned int sensor_dato;
unsigned int max6675_dato=0;
signed char cont;

  RC0_bit =0;
 for (cont=15;cont>=0;cont--){
 if(max6675_pulso()==1){
 max6675_dato=max6675_dato | 1<<cont ;
 }
 }
  RC0_bit =1;
 sensor_dato=(max6675_dato>>3 );
 return((sensor_dato*0.25));
}



void Inicializar_ADC(){
 PORTA = 0x00;
 TRISA = 0x01;
 ANSEL = 0x01;
 ADCON0 = 0x81;
 ADCON1 = 0X00;
}

unsigned int Leer_ADC(unsigned char canal){
 if(canal > 13)
 return 0;

 ADCON0 &= 0xC5;
 ADCON0 |= canal<<2;
 Delay_us(2);
 ADCON0 = 1;
 while(ADCON0);

 return ((ADRESH<<8) + ADRESL);
}

void iniciar_moden(){
 ec_fsm.anterior=kFSM_ENVIANDO_AT;
 ec_fsm.actual=kFSM_ENVIANDO_AT;
}


void ms_error(){

}


void moden_coneccion(){

switch(ec_fsm.actual) {
 case kFSM_INICIO:
 break;
 case kFSM_ENVIANDO_AT:
 UART1_Write_Text(&ec25_comandos_at[kAT]);
 ec_fsm.anterior = ec_fsm.actual;
 ec_fsm.actual = kFSM_ESPERANDO_RESPUESTA;
 break;
 case kFSM_RESULTADO_ERROR:
 break;
 case kFSM_RESULTADO_EXITOSO:
 break;
 case kFSM_ESPERANDO_RESPUESTA:

 default: ;
 }



}
