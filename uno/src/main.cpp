#include <Arduino.h>

int inp = A0;
int led = 10;
int val = 0;

void setup() {
  pinMode(led,OUTPUT);
  Serial.begin(9600);
}

void loop() {

  val = analogRead(inp);
  Serial.print(val);
  Serial.println();

  if (val>10) {
    digitalWrite(led,LOW);
  }
  else {
    digitalWrite(led,HIGH);
  }

  delay(25);
}