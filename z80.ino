// govern a Z80 from an Arduino
// the z80 is stored in a array, see
#include "z80_code.h"

bool rd, mreq;
int spd = 0; //clock speed in ms delays

void reset() {
  // reset z80 (four cycles);
  digitalWrite(A3, LOW);
  for (int i=0; i<5; i++) {
    digitalWrite(A5, HIGH);
    delay(50);
    digitalWrite(A5, LOW);
    delay(50);
  }
  digitalWrite(A3, HIGH);
}

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
  DDRD = B11111111;
  PORTD = B00000000;
  // use B port as Address bus
  // which has six lines available
  // 64 byte address space
  DDRB = B00000000; 
  reset();
}

void loop() {
  digitalWrite(A5, HIGH);
  // delay(spd);
  digitalWrite(A5, LOW);
  rd = digitalRead(A4);
  mreq = digitalRead(A2);
  if (!rd && !mreq) {
    DDRD = B11111111;
    PORTD = code[PINB];
  }
  else {
    DDRD = B00000000;
    PORTD = B00000000;
  }
  // delay(spd);
}
