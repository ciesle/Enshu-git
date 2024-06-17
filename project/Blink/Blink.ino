//#include "Keypad_Matrix.h"
//#include "Keyboard.h"
//#include "Mouse.h"
#include "ADNS2083.h"
#define ENCODER_DO_NOT_USE_INTERRUPTS
//#include "Encoder.h"
#define KEY_SPACE 0x20
#define SCLK 2                            // Serial clock pin on the Arduino
#define SDIO 3                            // Serial data (I/O) pin on the Arduino
#define _Config 0x06
 
ADNS2083 Optical1 = ADNS2083(SCLK, SDIO);

signed char x = 0;                        
signed char y = 0;                        
static signed char r = 0;
//Encoder myEnc(2,3);		//ロータリーエンコーダーに使う端子。

const byte ROWS = 3;		//キーマトリクスの数設定
const byte COLS = 3;

// how the keypad has its keys laid out　キーマトリクス。使いたいキーと使用端子の設定。
/*
const char keys[ROWS][COLS] = {
  {'w', 'e', KEY_SPACE},
  {'d', '1', MOUSE_RIGHT},
  {'a', '2', MOUSE_LEFT},
  
};
*/

const byte rowPins[ROWS] = {9, 10, 16}; //connect to the row pinouts of the keypad
const byte colPins[COLS] = {4, 7, 8}; //connect to the column pinouts of the keypad

  // Create the Keypad
//Keypad_Matrix kpd = Keypad_Matrix( makeKeymap (keys), rowPins, colPins, ROWS, COLS );




void setup() 
{ 
  Serial.begin (9600);
  
  Optical1.begin();                       // Resync (not really necessary?)
  writeRegister(_Config,0x00);     //CPI設定  800 0 / 1000 0x01 / 1200 0x02 /1600 0x03

  //Keyboard.begin();
  //Mouse.begin();

  //kpd.begin ();
  //kpd.setKeyDownHandler (keyDown);
  //kpd.setKeyUpHandler   (keyUp);
 
 delay(100); //なんとなく。　無くて良いかも。
}


void loop()
{
  /*
//ホイール　ロータリーエンコーダー
  r = myEnc.read();
 if(r <= -1)
 r= 1;
 else if(r >= 1)
 r= -1;
 myEnc.write(0);
 //
 */
   
  //kpd.scan ();  //キーボード
  
    int res=Optical1.mo();
    if((res&(1<<7))){    
      x = Optical1.dx();
      y = Optical1.dy();                   
      Serial.println(x);
      Serial.println(y);
    }
}



//レジスタ書き込み関数
void writeRegister(uint8_t address, uint8_t data)
{
  int i = 7;
  
  // Set MSB high, to indicate write operation:
  address |= 0x80;
  
  // Write the address:
  pinMode (3, OUTPUT);
  for (; i>=0; i--)
  {
    digitalWrite (SCLK, LOW);
    digitalWrite (SDIO, address & (1 << i));
    digitalWrite (SCLK, HIGH);
  }
  
  // Write the data:
  for (i=7; i>=0; i--)
  {
    digitalWrite (SCLK, LOW);
    digitalWrite (SDIO, data & (1 << i));
    digitalWrite (SCLK, HIGH);
  }
}

///////////////////////////////////////
//キー検出関数
void keyDown (const char which)
  {
  Serial.print (F("Key down: "));
  Serial.println (which);
  /*
    Keyboard.press(which);
    
    if(which == MOUSE_LEFT)
     if (!Mouse.isPressed(MOUSE_LEFT))
    Mouse.press(MOUSE_LEFT);

    if(which == MOUSE_RIGHT)
     if (!Mouse.isPressed(MOUSE_RIGHT))
    Mouse.press(MOUSE_RIGHT);
   */
  }

void keyUp (const char which)
  {
  Serial.print (F("Key up: "));
  Serial.println (which);
  //Keyboard.release(which);
  /*
  if(which == MOUSE_LEFT)
    if (Mouse.isPressed(MOUSE_LEFT))
    Mouse.release(MOUSE_LEFT);

    if(which == MOUSE_RIGHT)
    if (Mouse.isPressed(MOUSE_RIGHT))
    Mouse.release(MOUSE_RIGHT);
    */
  }
