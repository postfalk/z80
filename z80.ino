// govern a Z80 from an Arduino

bool rd;
int spd = 400; //clock speed in ms delays
byte code[] {
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xc3, 0x04, 0x00,
};

void setup() {
  // use C (analog in) port as Control Bus
  // clock
  pinMode(A5, OUTPUT);
  // rd
  pinMode(A4, INPUT);
  // reset
  pinMode(A3, OUTPUT);
  // use D port as Data bus
  // use this to check address bus (works only with NOP)
  // DDRD = DDRD | B11111100; 
  DDRD = B11111111;
  PORTD = B00000000;
  //PORTD = B11111111;
  // use B port as Address bus
  DDRB = B00000000;
  Serial.begin(9600);
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
  delay(spd);
  digitalWrite(A5, LOW);
  rd = digitalRead(A4);
  Serial.print("rd: ");  
  Serial.print(rd);
  Serial.print(", addr:  ");
  Serial.print(PINB);
  if (!rd) {
    DDRD = B11111111;
    PORTD = code[PINB];
    Serial.print(", data: ");
    Serial.println(code[PINB]);
  }
  else {
    DDRD = B00000000;
    PORTD = B00000000;
  }
  delay(spd);
  Serial.println();
}
