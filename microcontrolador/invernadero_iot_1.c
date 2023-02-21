


void incio();
void main() {
incio();

while(1){

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