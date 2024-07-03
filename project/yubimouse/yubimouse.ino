#include "ADNS2083.h"
#include "BleMouse.h"
#define ENCODER_DO_NOT_USE_INTERRUPTS
#define SCLK 19                            // Serial clock pin on the Arduino
#define SDIO 18                            // Serial data (I/O) pin on the Arduino
#define LEFT 4
#define RIGHT 16
 
ADNS2083 Optical1 = ADNS2083(SCLK, SDIO);
BleMouse Mouse;

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
  //mouseControl();
  Mouse.move(1,0,0);
  delay(50);
}

void mouseScroll(double now){
  static double sum=0;
  sum+=now;
  if(abs(sum)>=1) {
    //Mouse.move(0,0,floor(sum));
    sum=sum-floor(sum);
  }
}

void mouseControl(){
  char x = 0, y = 0, r = 0;
  bool exist=(Optical1.mo()&(1<<7))>0;
  Serial.println(Optical1.dx());
  if(exist){
    x = -Optical1.dx();
    y = Optical1.dy();
  }
  
  bool left=digitalRead(LEFT)==LOW, right=digitalRead(RIGHT)==LOW;
  sendInformation(x, y, left, right);
}
void sendInformation(char x, char y, bool left, bool right){
  //クリックの安定性向上
  /*
  static long leftBegin=-1, rightBegin=-1;
  static bool leftPressing=false, rightPressing=false;
  const static char history_size=7;
  static bool history[2][7]={{false,false,false,false,false,false,false},{false,false,false,false,false,false,false}};
  static int count[2]={0,0},cursor=0;
  
  static long last_click[2]={-1,-1};
  const long last_click_thres=100;
  const long click_thres=50;

  static int roll_val=0;
  long decrease_count=0;

  long now=millis();

  for(int i=0;i<2;i++){
    bool tmp=left;
    if(i==1) tmp=right;
    if(tmp&&!history[i][cursor]) count[i]++;
    if(!tmp&&history[i][cursor]) count[i]--;
    history[i][cursor]=tmp;
  }
  (cursor+=1)%=history_size;

  if(left) {
    if(leftBegin<0) leftBegin=now;
  }
  if(count[0]>=history_size-2){
    Mouse.press(MOUSE_LEFT);
    leftPressing=true;
    leftBegin=-1;
  }
  else {
    if(leftPressing){
      Mouse.release(MOUSE_LEFT);
      leftPressing=false;
    }
  }
  if(~leftBegin&&now-leftBegin>=click_thres){
    if(now-last_click[0]>last_click_thres){
      Mouse.click(MOUSE_LEFT);
      last_click[0]=now;
    }
    leftBegin=-1;
  }

  if(right) {
    if(rightBegin<0) rightBegin=now;
  }
  if(count[1]>=history_size-2){
    rightPressing=true;
    rightBegin=-1;
  }
  else {
    if(rightPressing){
      rightPressing=false;
    }
  }
  if(~rightBegin&&now-rightBegin>=click_thres){
    if(now-last_click[1]>last_click_thres){
      Mouse.click(MOUSE_RIGHT);
      last_click[1]=now;
    }
    rightBegin=-1;
  }
*/
  if(abs(x)>0||abs(y)>0){
  /*  if(rightPressing){
      mouseScroll(-y/20.);
      //Serial.println((int)now);
    }
    else{*/
      //Mouse.move(x,y);
    //}
  }
}