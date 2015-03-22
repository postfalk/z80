// govern a Z80 from an Arduino

bool rd;
int spd = 20; //clock speed in ms delays

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
  if (rd) {
    Serial.print(PINB);
    Serial.print(" ");
    Serial.println(rd);
  };
  delay(spd);
}
