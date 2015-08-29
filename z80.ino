// govern a Z80 from an Arduino
// the z80 code sits as an array in the following file
#include "z80_code.h"

bool rd, mreq;
int spd = 100; //clock speed in ms delays

void setup() {
  // use C (analog in) port as Control Bus
  // clock
  pinMode(A5, OUTPUT);
  // rd
  pinMode(A4, INPUT);
  // reset
  pinMode(A3, OUTPUT);
  // mreq
  pinMode(A2, INPUT);
  // use D port as Data bus
  // use this to check address bus (works only with NOP)
  // DDRD = DDRD | B11111100; 
  DDRD = B11111111;
  PORTD = B00000000;
  //PORTD = B11111111;
  // use B port as Address bus
  DDRB = B00000000;
  // Serial.begin(9600);
  // reset z80 (four cycles);
  digitalWrite(A3, LOW);
  for (int i=0; i<5; i++) {
    digitalWrite(A5, HIGH);
    delay(spd);
    digitalWrite(A5, LOW);
    delay(spd);
  }
  digitalWrite(A3, HIGH);
}

void loop() {
  digitalWrite(A5, HIGH);
  // if (!rd) { 
  //  Serial.println(PINB);
  // }
 
  delay(spd);
  digitalWrite(A5, LOW);
  rd = digitalRead(A4);
  mreq = digitalRead(A2);
  // Serial.print("rd: ");  
  // Serial.print(rd);
  // Serial.print(", addr:  ");
  // Serial.print(PINB);
  if (!rd && !mreq) {
    DDRD = B11111111;
    PORTD = code[PINB];
    // Serial.print(", data: ");
    //Serial.print(code[PINB]);
  }
  else {
    DDRD = B00000000;
    PORTD = B00000000;
  }
  delay(spd);
  //Serial.println();
}
