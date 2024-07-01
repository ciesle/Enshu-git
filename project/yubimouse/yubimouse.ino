#include <Mouse.h>
#include "ADNS2083.h"
#define ENCODER_DO_NOT_USE_INTERRUPTS
#define SCLK 2                            // Serial clock pin on the Arduino
#define SDIO 3                            // Serial data (I/O) pin on the Arduino
#define LEFT 4
#define RIGHT 5
 
ADNS2083 Optical1 = ADNS2083(SCLK, SDIO);

void setup() { 
  Optical1.begin();
  Optical1.config(0x00);
  Mouse.begin();
  Serial.begin(9600);
  while(!Serial);

  pinMode(LEFT, INPUT_PULLUP);
  pinMode(RIGHT, INPUT_PULLUP);

  delay(100);
}


void loop() {
  mouseControl();
  delay(20);
}

void mouseScroll(double now){
  static double sum=0;
  sum+=now;
  if(abs(sum)>=1) {
    Mouse.move(0,0,floor(sum));
    sum=sum-floor(sum);
  }
}

void mouseControl(){
  char x = 0, y = 0, r = 0;
  bool exist=(Optical1.mo()&(1<<7))>0;
  if(exist){    
    x = -Optical1.dx();
    y = Optical1.dy();
  }

  bool left=digitalRead(LEFT)==LOW, right=digitalRead(RIGHT)==LOW;
  sendInformation(x, y, left, right);
}
void sendInformation(char x, char y, bool left, bool right){
  //右ボタンをどれだけ長く押しているかを見る。
  static long leftBegin=-1, rightBegin=-1;
  static bool leftPressing=false, rightPressing=false;
  static int roll_val=0;
  long decrease_count=0;
  long now=millis();

  if(left) {
    if(leftBegin<0) leftBegin=now;
    if(now-leftBegin>10){
      Mouse.press(MOUSE_LEFT);
      leftPressing=true;
    }
  }
  else {
    if(~leftBegin){
      if(leftPressing) Mouse.release(MOUSE_LEFT);
      else Mouse.click(MOUSE_LEFT);
      leftBegin=-1;
      leftPressing=false;
    }
  }

  if(right) {
    if(rightBegin<0) rightBegin=now;
    if(now-rightBegin>10){
      rightPressing=true;
    }
  }
  else {
    if(~rightBegin){
      if(!rightPressing) Mouse.click(MOUSE_RIGHT);
      rightBegin=-1;
      rightPressing=false;
    }
  }

  if(abs(x)>0||abs(y)>0){
    if(rightPressing){
      mouseScroll(y/20.);
      //Serial.println((int)now);
    }
    else{
      Mouse.move(x,y);
      //Serial.println((int)x);
      //Serial.println((int)y);
    }
  }
}