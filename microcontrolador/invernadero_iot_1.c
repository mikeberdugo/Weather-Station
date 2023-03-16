 //// definiciones de conexiones
 
 //define conexiones termocuplas
#define max6675_ck RC3_bit
#define max6675_dat RC4_bit

#define max6675_ck_dir trisc.b3
#define max6675_dat_dir   trisc.b4

#define max6675_cs  RC0_bit
#define max6675_cs_dir  trisc.b0

/// definicion variables de control
//Listado de comando AT disponibles para ser enviados al modem Quectel

/// estrucura
struct estado_fsm{char anterior, actual;};


/// variables global
struct estado_fsm ec_fsm;


const char *ec25_comandos_at[] = {
        "AT",                        //comprueba disponibilidad de dispositivo
        "ATI",                        //consulta información del modem
        "AT+CPIN?",                //consulta estado de la simcard
        "AT+CREG?",                //consulta estado de la red celular y tecnología usada en red celular
        "AT+CMGF=1",        //asigna modo texto para enviar mensajes
        "AT+CMGS=\"3152849863\"",//envia mensaje de texto a numero definido
        "Mensaje", //MENSAJE & CTRL+Z
};

//Lista de respuestas a cada comando AT
const char  *ec25_repuestas_at[]={
                "OK",                //AT
                "EC20",                //ATI
                "READY",        //AT+CPIN?
                "0,1",                //AT+CREG? = GSM,REGISTERED
                "OK",                //AT+CMGF=1
                ">",                //AT+CMGS
                "OK",                //MENSAJE & CTRL+Z
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

/// funciones moden
void iniciar_moden();
void moden_coneccion();

/// funciones sensor de temperatura 1 -- termocupla
void max6675_init();
float max6675_read();

///  funciones sensor de humedad 1 -- terrestre
void Inicializar_ADC();
unsigned int Leer_ADC(unsigned char canal);



void incio();
void sensor_1_temperatura();


void main() {
incio();
//// iniciar modulos ////
max6675_init();

Inicializar_ADC();

while(1){
  //max6675_read();
  //Delay_ms(1000);
  //Leer_ADC(0);
  moden_coneccion();
  Delay_ms(10000);
 }
}



void incio(){
ANSEL = ANSELH = 0X00 ;

/// PUERTO A
TRISA = 0X00;
PORTA = 0X00;

/// PUERTO B
TRISB = 0X00;
PORTB = 0X00;

/// PUERTO C
TRISC = 0X00;
PORTC = 0X00;

/// PUERTO D
TRISD = 0X00;
PORTD = 0X00;

/// PUERTO E
TRISE = 0X00;
PORTE = 0X00;

/// serial
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);

iniciar_moden();
}

void max6675_init(){
   max6675_ck_dir=0;   //salida reloj
   max6675_cs_dir=0;  //salida cs
   max6675_dat_dir=1;  //entrada dato
   
   max6675_cs=1;//salida 1
   max6675_ck=0; //saca cero por el reloj
   Delay_ms(100);
}

char max6675_pulso(){
char lei;
  max6675_ck=1; //saca uno por el reloj
  Delay_us(10);
  lei=max6675_dat;
 max6675_ck=0; //saca cero por el reloj
  Delay_us(10);
  return lei;
}

float max6675_read(){
unsigned int sensor_dato;
unsigned int max6675_dato=0;
signed char cont;

    max6675_cs=0;   // habilita el modulo
    for (cont=15;cont>=0;cont--){
      if(max6675_pulso()==1){
         max6675_dato=max6675_dato | 1<<cont ;
       }// fin if
    }//fin for
    max6675_cs=1;  //apagar modulo
    sensor_dato=(max6675_dato>>3 ); //desplaz 3 veces
    return((sensor_dato*0.25));
}


///------------------------------- sensor humedad 2
void Inicializar_ADC(){
    PORTA  = 0x00; //Limpiar el puerto A.
    TRISA  = 0x01; //RA0 como entrada.
    ANSEL  = 0x01; //RA0 como entrada analógica.
    ADCON0 = 0x81; //Encender ADC y seleccionar el reloj: Fosc/32.
    ADCON1 = 0X00; //Referencia en Vss y Vdd, Justificado a la izqueirda.
}

unsigned int Leer_ADC(unsigned char canal){
    if(canal > 13)
        return 0;

    ADCON0 &= 0xC5;     //Limpiar la selección de bits.
    ADCON0 |= canal<<2; //Se establecen los bits CHS3, CHS2, CHS1 y CHS0.
    Delay_us(2);      //Tiempo de adquisición.
    ADCON0 = 1;       //Inicialozar la conersión ADC.
    while(ADCON0);    //Esperar a que la conversión se complete.

    return ((ADRESH<<8) + ADRESL); //Retornar resultado.
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
        UART1_Write_Text(&ec25_comandos_at[kAT]);        //Envia comando AT
        ec_fsm.anterior = ec_fsm.actual;                //almacena el estado actual
        ec_fsm.actual = kFSM_ESPERANDO_RESPUESTA;        //avanza a esperar respuesta del modem
        break;
   case kFSM_RESULTADO_ERROR:
        break;
   case kFSM_RESULTADO_EXITOSO:
        break;
   case kFSM_ESPERANDO_RESPUESTA:
          switch(){
          }
        break;
    default: ;
    }



}