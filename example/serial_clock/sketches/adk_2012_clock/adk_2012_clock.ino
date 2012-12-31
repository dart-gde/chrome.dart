#include <ADK.h>
static const int serial_speed = 115200;

ADK L;

String content = "";
String time_str="      ";
char character;

static uint8_t ledrgb[6][3]={
  0x13, 0xac, 0xfa,
  0x13, 0xac, 0xfa,
  0xc0, 0x00, 0x0b,
  0xc0, 0x00, 0x0b,
  0x00, 0x9a, 0x49,
  0x00, 0x9a, 0x49
};

void adkPutchar(char c){
  Serial.write(c);
}

extern "C" void dbgPrintf(const char *, ... );

void setup(void)
{
  Serial.begin(serial_speed);
  L.adkSetPutchar(adkPutchar);
  L.adkInit();
}

void loop(){
  L.adkEventProcess();
  
  if (Serial.available()) {
    character = Serial.read();
    content.concat(character);
    Serial.print(content);
    if (character == '\n') {
      Serial.print("replacing " + time_str + " with " + content);
      time_str = String(content);
      content = String("");
    }
  }
    
  for (int i = 0; i < 6; i++) {
    L.ledDrawLetter(i, time_str.charAt(i), ledrgb[i][0], ledrgb[i][1], ledrgb[i][2]);
  }
}
