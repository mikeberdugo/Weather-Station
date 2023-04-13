/// definiciones
#define true 1

/// sensor dth11
#define  PIN_SENSOR_Direction trisb.b0
#define PIN_SENSOR RB0_bit
/// reles
#define PIN_RELE1  RB1_bit
#define PIN_RELE2  RB2_bit
#define PIN_RELE3  RB3_bit

#define PIN_ERROR  RB7_bit
#define PIN_OK  RB6_bit





/// prototipos de funciones
void incio();
// sensor humedad 1
void Inicializar_ADC();
unsigned int Leer_ADC(unsigned char canal);
char read_dth11();


char read_uart();
int temperatura=0;
int  humedad=0;


void main(){
 /// VARIABLES
 char lec = 'A';
 unsigned int aux = 0;
 int humedad1 ;
 int temperatura1,humedad2,temperatura2;
 char entero[7];
 char flotante[15];

  ANSEL = ANSELH = 0X00 ;
  /// PUERTO A
  TRISA = 0X00;
  PORTA = 0X00;
  /// PUERTO B
  TRISB = 0X00;
  PORTB = 0X08;
  /// PUERTO C
  /*TRISC = 0X80;
  PORTC = 0X00;*/
  /// PUERTO D
  TRISD = 0X00;
  PORTD = 0X00;
  /// PUERTO E
  TRISE = 0X00;
  PORTE = 0X00;
  /// serial
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);

while(true){
 /*UART1_Write_Text("hola 1");
     UART1_Write('B');
     PORTA=0XFF;
     delay_ms(1000);
     PORTA=0X00;
     delay_ms(1000);*/
   if (lec == 'A'){
      PIN_OK = ~PIN_OK;
      lec = 'J';
   }

   lec = read_uart();
   
   read_dth11() ;

   

    if (lec == 'B'){
      humedad1 = ADC_Read(0);    /// humedad terrestre
      IntToStr(humedad1,entero);
      UART1_Write_Text(entero);
      UART1_Write_Text("hola 1");
   } else if (lec == 'C'){ /// temperatura relativa
      IntToStr(temperatura,entero);
      UART1_Write_Text(entero);
      UART1_Write_Text("hola 2 ");
   }else if (lec == 'D'){   /// humedad relativa
       IntToStr(humedad,entero);
      UART1_Write_Text(entero);
      UART1_Write_Text("hola 3 ");
   }else if (lec == 'F'){ /// rele 1 luces
         PIN_RELE1 = ~PIN_RELE1 ;
   }else if (lec == 'G'){ /// rele 2 agua
          PIN_RELE2 = ~PIN_RELE2 ;
   }else if (lec == 'H'){    /// rele 3 humidificador
         PIN_RELE3 = ~PIN_RELE3 ;
   }else if (lec == 'E'){   /// error
       PIN_ERROR = ~PIN_ERROR;
       PIN_OK = ~PIN_OK;
   }

 }// end while --------------------
}// end main ---------------------


/////////// UART --- LECTURA --- //////////////////////////////
char read_uart(){
 char uart_rd = '0';
 if(UART1_Data_Ready()) {     // If data is received,
      uart_rd = UART1_Read();     // read the received data,
  }
  return uart_rd;
}

///////////////////////////// LEER ADC -- SENSOR HUMEDAD INTERNO --- /////////////////////////////
void Inicializar_ADC(){
    PORTA  = 0x00; //Limpiar el puerto A.
    TRISA  = 0x01; //RA0 como entrada.
    ANSEL  = 0x01; //RA0 como entrada analógica.
    ADCON0 = 0x81; //Encender ADC y seleccionar el reloj: Fosc/32.
    ADCON1 = 0X00; //Referencia en Vss y Vdd, Justificado a la izqueirda.
}

unsigned int Leer_ADC(unsigned char canal){
    if(canal > 13){
        return 0;
    }
    //ADCON0 &= 0xC5;     //Limpiar la selección de bits.
    ADCON0 |= canal<<2; //Se establecen los bits CHS3, CHS2, CHS1 y CHS0.
    Delay_us(2);      //Tiempo de adquisición.
    ADCON0.f1 = 1;       //Inicialozar la conersión ADC.
    while(ADCON0.f1);    //Esperar a que la conversión se complete.
    return ((ADRESH<<8) + ADRESL); //Retornar resultado.


}
////////////////////////////
char read_dth11(){            //funcion para realizar la lectura del sensor dht11
  unsigned char dato[5];
  unsigned char i=0;
  unsigned char j=0;
  char valor[4];
  unsigned int hum=0;
  unsigned int temp=0;
  unsigned int base=10;

  temperatura=-1;
  humedad=-1;

   while(1){
    //protocolo
    PIN_SENSOR_Direction=0;  //rb0 de salida
    PIN_SENSOR=1;  //rb0 en alto
    delay_us(20);
    PIN_SENSOR=0;     //rbo en bajo
    delay_ms(18);
    PIN_SENSOR=1;     //rbo en alto
    delay_us(22);
    PIN_SENSOR_Direction=1; //rbo como entrada para leer la respuesta del sensor
    delay_us(10);
    if(PIN_SENSOR){return -1;}    //comprueba si el sensor envio un estado bajo
    delay_us(80);
    if(PIN_SENSOR==0){return -1;}      //comprueba si el sensor envio un estado alto despues de 80ms
    delay_us(80);
       //inicia la transmision
       for(i=0;i<5;i++){
         for(j=0;j<8;j++){
              while(PIN_SENSOR==0);   //espera a que la entrada sea distinta de 0
              delay_us(30);     //espera 30 us
              if(PIN_SENSOR){    // si el pulso despues de 30us esta en alto es porque es un 1
                 dato[i]=(dato[i]<<1) | 0x01;   // se le agrega un 1 al bit
              }
              if(PIN_SENSOR==0){       // si el pulso despues de 30us esta en bajo es porque es un 0
                 dato[i]=(dato[i]<<1);}  // se le agrega un 0 corriendo a la izquierda            }
              while(PIN_SENSOR==1);
         }//fin for de 8
       }// fin for de 5
    PIN_SENSOR_Direction=0;    //rb0 de salida
    PIN_SENSOR=1;     //rb0  en alto
    //operacion binaria
    if((dato[0]+dato[1]+dato[2]+dato[3])==dato[4]){
         hum=dato[0];
         temp=dato[2];

      base=10;
      for(i=0;i<2;i++){
       valor[i]=(hum/base);
       hum=hum-(valor[i]*base);
       base=base/10;
      }
      base=10;
      for(i=2;i<4;i++){
       valor[i]=(temp/base);
       temp=temp-(valor[i]*base);
       base=base/10;
      }

      temperatura=(valor[2]*10)+valor[3];
      humedad=(valor[0]*10)+valor[1];
      return 1;

    }else{return -1;}
   }
}//fin read_dht



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////