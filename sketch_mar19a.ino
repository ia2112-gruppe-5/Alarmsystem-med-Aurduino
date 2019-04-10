#include <LiquidCrystal.h>
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

int inputpin = 13;
bool value = false; 
String Status;
const int temperaturePin = 0; 
String temp;
String pir;
char data = "0";   

void setup() 
{
  
  pinMode(inputpin, INPUT);
  Serial.begin(9600);
  while(!Serial){}
  lcd.begin(16, 2);
  
  Status = "";
}

void loop()
{
   
  value = digitalRead(inputpin);
  pir = String(value);
  temp = String((getVoltage(temperaturePin)-0.5)*100);
  Status = pir;
  Status += ':';
  Status += temp;

  if (Serial.available()){
  data = Serial.read();
  if (data != ""){  
  Serial.println(Status);
  data = "";
  }
  }
  
  lcd.setCursor(0,1);
  lcd.print(pir);
  lcd.setCursor(0,0);
  lcd.print(temp);
  
  delay(1000);
} 
float getVoltage(int pin)
{ 
  return (analogRead(pin) * 0.004882814); 
}
