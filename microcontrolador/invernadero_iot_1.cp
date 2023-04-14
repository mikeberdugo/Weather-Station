#line 1 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
#line 20 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
void incio();

void Inicializar_ADC();
unsigned int Leer_ADC(unsigned char canal);
char read_dth11();


char read_uart();
int temperatura=0;
int humedad=0;


void main(){

 char lec = 'A';
 unsigned int aux = 0;
 int humedad1 = 0;
 int temperatura1,humedad2,temperatura2;
 char entero[7];
 char flotante[15];

 ANSEL = 0X01;
 ANSELH = 0X00;

 TRISA = 0X01;
 PORTA = 0X00;

 TRISB = 0X00;
 PORTB = 0X08;
#line 53 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
 TRISD = 0X00;
 PORTD = 0X00;

 TRISE = 0X00;
 PORTE = 0X00;

 UART1_Init(9600);
 Delay_ms(100);

while( 1 ){
#line 69 "E:/Desktop/proyecto_iot_diplomado/Weather-Station/microcontrolador/invernadero_iot_1.c"
 if (lec == 'A'){
  RB6_bit  = ~ RB6_bit ;
 lec = 'J';
 }

 lec = read_uart();





 if (lec == 'B'){
 humedad1 = ADC_Read(0);
 IntToStr(humedad1,entero);
 UART1_Write_Text(entero);

 } else if (lec == 'C'){
 read_dth11() ;
 IntToStr(temperatura,entero);
 UART1_Write_Text(entero);

 }else if (lec == 'D'){
 read_dth11() ;
 IntToStr(humedad,entero);
 UART1_Write_Text(entero);

 }else if (lec == 'F'){
  RB1_bit  = ~ RB1_bit  ;
 }else if (lec == 'G'){
  RB2_bit  = ~ RB2_bit  ;
 }else if (lec == 'H'){
  RB3_bit  = ~ RB3_bit  ;
 }else if (lec == 'E'){
  RB7_bit  = ~ RB7_bit ;
  RB6_bit  = ~ RB6_bit ;
 }

 }
}



char read_uart(){
 char uart_rd = '0';
 if(UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 }
 return uart_rd;
}


void Inicializar_ADC(){
 PORTA = 0x00;
 TRISA = 0x01;
 ANSEL = 0x01;
 ADCON0 = 0x81;
 ADCON1 = 0X00;
}

unsigned int Leer_ADC(unsigned char canal){
 if(canal > 13){
 return 0;
 }

 ADCON0 |= canal<<2;
 Delay_us(2);
 ADCON0.f1 = 1;
 while(ADCON0.f1);
 return ((ADRESH<<8) + ADRESL);


}

char read_dth11(){
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

  trisb.b0 =0;
  RB0_bit =1;
 delay_us(20);
  RB0_bit =0;
 delay_ms(18);
  RB0_bit =1;
 delay_us(22);
  trisb.b0 =1;
 delay_us(10);
 if( RB0_bit ){return -1;}
 delay_us(80);
 if( RB0_bit ==0){return -1;}
 delay_us(80);

 for(i=0;i<5;i++){
 for(j=0;j<8;j++){
 while( RB0_bit ==0);
 delay_us(30);
 if( RB0_bit ){
 dato[i]=(dato[i]<<1) | 0x01;
 }
 if( RB0_bit ==0){
 dato[i]=(dato[i]<<1);}
 while( RB0_bit ==1);
 }
 }
  trisb.b0 =0;
  RB0_bit =1;

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
}
