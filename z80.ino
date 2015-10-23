// govern a Z80 from an Arduino
// the z80 is stored in a array, see
#include "z80_code.h"

bool rd, mreq;
int spd = 0; //clock speed in ms delays

void reset() {
  // reset z80 (four cycles);
  PORTC = PORTC ^ B00000000;
  for (int i=0; i<10; i++) {
    PORTC = PORTC ^ B00100000;
    // Serial.println(PORTC | B10000000, BIN);
    delay(50);
    PORTC = PORTC ^ B00100000;
    // Serial.println(PORTC | B10000000, BIN);
    delay(50);
  }
  PORTC = PORTC | B00001000;
}

void setup() {
  // Serial.begin(9600);
  // use C (analog in) port as Control Bus
  // clock
  // pinMode(A5, OUTPUT);
  // rd
  // pinMode(A4, INPUT);
  // reset
  // pinMode(A3, OUTPUT);
  // mreq
  // pinMode(A2, INPUT);
  // use D port as Data bus
  // input only simulating ROM
  DDRD = B11111111;
  PORTD = B00000000;
  // use B port as Address bus
  // which has six lines available
  // 64 byte address space
  DDRB = B00000000;
  DDRC = B00101000;
  // PORTC = PORTC | B00100000;
  reset();
}

void loop() {
  // delay(100);
  PORTC = PORTC | B00100000;
  // Serial.println(PORTC | B10000000, BIN);
  // delay(100);
  PORTC = PORTC ^ B00100000;
  // Serial.println(PORTC | B10000000, BIN);
  // digitalWrite(A5, HIGH);
  // delay(spd);
  // digitalWrite(A5, LOW);
  // rd = digitalRead(A4);
  // mreq = digitalRead(A2);
  // delay(100);
  // Serial.println(PINC, BIN);
  // Serial.println(PINB);
  // Serial.println(PINC & B0000010, BIN);
  if (!(PINC & B00010100)) {
    DDRD = B11111111;
    PORTD = code[PINB];
  }
  else {
    DDRD = B00000000;
    PORTD = B00000000;
  }
  // delay(spd);
}
