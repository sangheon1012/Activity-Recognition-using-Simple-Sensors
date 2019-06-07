//using arduino uno

#include "WiFiEsp.h"

// Emulate Serial1 on pins 6/7 if not present
#ifndef HAVE_HWSERIAL1
#include "SoftwareSerial.h"
SoftwareSerial Serial1(3, 2); // TX, RX
#endif

char ssid[] = "iptime";            // your network SSID (name)
char pass[] = "";        // your network password
int status = WL_IDLE_STATUS;     // the Wifi radio's status

//Set sensor value
int pirCount = 3;
int switchCount = 1;
int pirPin[] = {4,5,6};
int pirState[] = {0,0,0};
int switchPin[] = {A0};
int switchState[] = {0};
int doorPin = 7;
int doorState = 0;
String LivingPIR = "BathR";
String LivingPhoto = "BathP";
String LivingDoor = "BathD";
String On = " On";
String Off = " Off";

char server[] = "192.168.0.108";

// Initialize the Ethernet client object
WiFiEspClient client;

void setup()
{
  // initialize serial for debugging
  Serial.begin(9600);
  // initialize serial for ESP module
  Serial1.begin(9600);
  // initialize ESP module
  WiFi.init(&Serial1);

  // check for the presence of the shield
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    // don't continue
    while (true);
  }

  // attempt to connect to WiFi network
  while ( status != WL_CONNECTED) {
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    // Connect to WPA/WPA2 network
    status = WiFi.begin(ssid, pass);
  }

  // you're connected now, so print out the data
  Serial.println("You're connected to the network");
  
  printWifiStatus();

  Serial.println();
  Serial.println("Starting connection to server...");
  // if you get a connection, report back via serial
  if (client.connect(server, 9999)) {
    Serial.println("Connected to server");
    }
  for(int i=0; i<pirCount; i++){
    pinMode(pirPin[i], INPUT);
  }
  pinMode(doorPin, INPUT_PULLUP);
}

void loop()
{
  if(client){
    //set PIR detection(On/Off) 
    for(int i=0; i<pirCount; i++){
      if (digitalRead(pirPin[i]) == HIGH && pirState[i] == 0 ) {
        String State = LivingPIR + i + On;
        client.print(State);
        pirState[i] = 1;
      } else if (digitalRead(pirPin[i]) == LOW && pirState[i] == 1) {
        String State = LivingPIR + i + Off;
        client.print(State);
        pirState[i] = 0;
        }
    }
    
    //set photo sensor detection
    //if analog > 750 On else Off 
    for(int i=0; i<switchCount; i++){
      if (analogRead(switchPin[i]) > 750 && switchState[i] == 0 ) {
        String State = LivingPhoto + i + On;
        client.print(State);
        switchState[i] = 1;
      } else if (analogRead(switchPin[i]) < 750 && switchState[i] == 1) {
        String State = LivingPhoto + i + Off;
        client.print(State);
        switchState[i] = 0;
      }
    }

    //set door sensor on/off
    if(digitalRead(doorPin)==HIGH && doorState==1){
      String State = LivingDoor + On;
      client.print(State);
      doorState = 0;
    }else if(digitalRead(doorPin)==LOW && doorState==0){
      String State = LivingDoor + Off;
      client.print(State);
      doorState = 1;
    }
    delay(200);
  }

  // if the server's disconnected, stop the client
  if (!client.connected()) {
    Serial.println();
    Serial.println("Disconnecting from server...");
    client.stop();

    // do nothing forevermore
    while (true);
  }
}


void printWifiStatus()
{
  // print the SSID of the network you're attached to
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  // print the received signal strength
  long rssi = WiFi.RSSI();
  Serial.print("Signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
}
