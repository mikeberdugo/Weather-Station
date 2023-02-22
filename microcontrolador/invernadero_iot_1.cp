#line 1 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
#line 14 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
void max6675_init();
float max6675_read();







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


TRISA = 0X00;
PORTA = 0X00;


TRISB = 0X00;
PORTB = 0X00;


TRISC = 0X00;
PORTC = 0X00;


TRISD = 0X00;
PORTD = 0X00;

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
