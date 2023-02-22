 //// definiciones de conexiones
 
 //define conexiones termocuplas
#define max6675_ck RC3_bit
#define max6675_dat RC4_bit

#define max6675_ck_dir trisc.b3
#define max6675_dat_dir   trisc.b4

#define max6675_cs  RC0_bit
#define max6675_cs_dir  trisc.b0

/// funciones sensor de temperatura 1 -- termocupla
void max6675_init();
float max6675_read();

///  funciones sensor de humedad 1 -- terrestre





void incio();
void sensor_1_temperatura();
void main() {
incio();
max6675_init();
while(1){
  max6675_read();
  Delay_ms(1000);
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