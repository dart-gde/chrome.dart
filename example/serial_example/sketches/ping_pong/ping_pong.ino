/**
 * financeCoding@gmail.com
 */
char character;
String content = "pong: ";

void setup() {
  Serial.begin(9600);
  Serial.println("Ping/Pong\n");
}

void loop() {
  if (Serial.available()) {
    character = Serial.read();
    content.concat(character);
    if (character == '\n') {
      Serial.print(content);
      content = "pong: ";
    }
  }
}











