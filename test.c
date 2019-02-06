#include <Arduino.h>

int main() {
  pinMode(D1, OUTPUT);
  while(true) {
    digitalWrite(D1, HIGH);
    delay(1000);
    digitalWrite(D1, LOW);
    delay(1000);
  }
  return 0;
}
