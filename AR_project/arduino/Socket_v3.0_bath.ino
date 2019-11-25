//아두이노 우노를 사용했습니다.
//화장실에 있는 PIR, Photo, Door 센서 값을 Wifi를 통해 클라이언트로 전송합니다
//시리얼 포트로 ESP8266 모듈로 데이터를 전송합니다

#include "WiFiEsp.h"
#ifndef HAVE_HWSERIAL1
#include "SoftwareSerial.h"
SoftwareSerial Serial1(3, 2); // TX, RX 시리얼 포트 설정
#endif

char ssid[] = "iptime";            // Wifi ID
char pass[] = "";        // Wifi Password
int status = WL_IDLE_STATUS;     // Wifi radio's status

//센서 핀 값을 설정합니다
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

char server[] = "192.168.0.108"; // 데이터를 보낼 클라이언트 주소

// Initialize the Ethernet client object
WiFiEspClient client;

void setup()
{
  //시리얼 속도와 모듈을 초기화합니다. ESP8266의 Example 코드와 동일합니다
  // initialize serial for debugging
  Serial.begin(9600);
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
  // if you get a connection, report back via serial 클라이언트의 9999 포트로 접속합니다
  if (client.connect(server, 9999)) {
    Serial.println("Connected to server");
    }
  //PIR센서의 핀값과 도어 센서의 핀값을 루프를 통해 설정합니다  
  for(int i=0; i<pirCount; i++){
    pinMode(pirPin[i], INPUT);
  }
  pinMode(doorPin, INPUT_PULLUP);
}

void loop()
{
  if(client){
    //PIR detection(On/Off) On일 경우 1, Off일 경우 0을 출력하여 클라이언트로 전송 
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
    //if analog > 750 On else Off, 값이 750 이상일 경우 On, 이하일 경우 Off 처리하여 클라이언트로 전송
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

    //set door sensor(on/off) On일 경우 1, Off일 경우 0을 출력하여 클라이언트로 전송 
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
