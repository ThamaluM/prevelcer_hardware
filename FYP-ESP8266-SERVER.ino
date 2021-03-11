#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <Arduino_JSON.h>


String PressureData = "56";

const char* ssid = "Dialog 4G";
const char* password =  "73JH8G0YJ8Q";
 
const char* url1 = "http://prevelcer.herokuapp.com/pressure/startcyc?serial=uom160140j";
const char* url3 = "http://prevelcer.herokuapp.com/pressure/endcyc?serial=uom160140j";

unsigned long lastTime = 0;
unsigned long timerDelay = 10000;

int session = 0;

void setup() {
  
  Serial.begin(9600);  
  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
 
  Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
    
}


void loop() {

  while(Serial.available()>0){

    String input = Serial.readStringUntil('\n');

    if(input == "start_cycle"){

      HTTPClient http;      
      http.begin(url3);
      http.addHeader("Authorization", "Token b34b772ad43b6fc871e5f2a0c7351f976430285e");
      int httpResponseCode_end = http.GET();      
      Serial.print("HTTP Response code: ");
      Serial.println(httpResponseCode_end);
      String payload_end = http.getString();
      Serial.println(payload_end);     
      http.end();
      
      HTTPClient http2;      
      http2.begin(url1);
      http2.addHeader("Authorization", "Token b34b772ad43b6fc871e5f2a0c7351f976430285e");
      int httpResponseCode = http2.GET();      
      Serial.print("HTTP Response code: ");
      Serial.println(httpResponseCode);
      String payload = http2.getString();
      Serial.println(payload);
      JSONVar myObject = JSON.parse(payload);  
      JSONVar value = myObject["session"];
      session = value;
      Serial.println("Session = "+session);     
      http2.end();
      continue;
    } 
    
       
    PressureData = input;
    Serial.println("Pressure = "+ PressureData+"\n");
    
    if ((millis() - lastTime) > timerDelay) {
    if(WiFi.status()== WL_CONNECTED){      
      
      String url2 = "http://prevelcer.herokuapp.com/pressure/enter?serial=uom160140j&lx=16&ly=32&"+PressureData+"&n="+String(session);
            
      HTTPClient http; 
      http.begin(url2);
      http.addHeader("Authorization", "Token b34b772ad43b6fc871e5f2a0c7351f976430285e");  
                                          
      int httpResponseCode = http.GET();      
      Serial.print("HTTP Response code: ");
      String payload = http.getString();
      Serial.println(httpResponseCode);
      Serial.println(payload);
      http.end();
      
    }
    else {
      Serial.println("WiFi Disconnected");
    }
  }
} 

}
