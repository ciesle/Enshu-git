#include <Mouse.h>
#include "ADNS2083.h"
#define ENCODER_DO_NOT_USE_INTERRUPTS
#define SCLK 2                            // Serial clock pin on the Arduino
#define SDIO 3                            // Serial data (I/O) pin on the Arduino
#define LEFT 4
#define RIGHT 5
 
ADNS2083 Optical1 = ADNS2083(SCLK, SDIO);

void setup() { 
  Mouse.begin();
  Serial.begin(9600);
}


void loop() {
  Serial.println("Hello");
  Mouse.move(1,0,0);
  delay(500);
}
