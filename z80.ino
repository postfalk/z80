// govern a Z80 from an Arduino
// the z80 is stored in a array, see
#include "z80_code.h"

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
  // use D port as Data bus
  // input only simulating ROM
  DDRD = B11111111;
  PORTD = B00000000;
  // use B port as Address bus
  // which has six lines available
  // 64 byte address space
  DDRB = B00000000;
  // use C port as Control bus
  // 2 mreq <- in
  // 3 reset -> out
  // 4 read <- in
  // 5 clock -> out
  DDRC = B00101000;
  // PORTC = PORTC | B00100000;
  reset();
}

void loop() {
  PORTC = PORTC | B00100000;
  PORTC = PORTC ^ B00100000;
  if (!(PINC & B00010100)) {
    DDRD = B11111111;
    PORTD = code[PINB];
  }
  else {
    DDRD = B00000000;
  }
}
