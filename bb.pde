PImage img;
PFont  font;

//Summary :Initialise
//Param   :None
//Return  :None
void setup(){
  size(800,500);
  showBackground();
  int[] h = {1,1};
  int[] m = {3,0};
  drawTime(195,77,h,m);
  drawTrainType(250,77,"urban-liner");
  drawDestination(320,77,"yunoyama-onsen");
  drawPlatformNumber(405,77,1);
}

//Summary :Draw Background
//Param   :None
//Return  :None
void showBackground(){
  background(102,102,102);
  noStroke();
  fill(225,225,225);
  rect(0,0, 800, 30);
  fill(51,51,51);
  rect(180,60, 580, 420);
  
  img = loadImage("background/kyotaiCharacter0.png");
  image(img,5,40,img.width / 3 ,img.height / 3);

  img = loadImage("background/kyotaiCharacter1.png");
  image(img,185,35,img.width / 2.8,img.height / 2.8);
  
  fill(0,0,0);
  
  for(int i = 0;i < 3;i++){
    rect(190,      68 + 60 * i,260,58);
    rect(190 + 290,68 + 60 * i,260,58);
  }
  
  for(int i = 0;i < 3;i++){
    rect(190,      280 + 60 * i,260,58);
    rect(190 + 290,280 + 60 * i,260,58);
  }
}

//Summary :Draw Time
//Param   :(int)XPos,(int)YPos, (int)H-H, (int)M-M
//Return  :None
void drawTime(int x,int y,int[] h,int[] m){
  for(int i = 0;i < 2;i++){
    img = loadImage("time/" + h[i] + ".png");
    println("time/" + h[i] + ".png");
    image(img,x + 10 * i,y,10,38);
  }
  
  img = loadImage("time/colon.png");
  image(img,x + 20,y,10,38);
  
  for(int i = 0;i < 2;i++){
    img = loadImage("time/" + m[i] + ".png");
    println("time/" + h[i] + ".png");
    image(img,30 + x + 10 * i,y,10,38);
  }
}

//Summary :Draw Train Type
//Param   :(int)XPos,(int)YPos, (String)Type
//Return  :None
void drawTrainType(int x,int y,String type){
  img = loadImage("type/" + type + ".png");
  image(img,x,y,60,35);
}

//Summary :Draw Destination
//Param   :(int)XPos,(int)YPos, (String)Station Name
//Return  :None
void drawDestination(int x,int y,String stationName){
  img = loadImage("dest/" + stationName + ".png");
  image(img,x,y,80,35);
}

//Summary :Draw Platform Number
//Param   :(int)XPos,(int)YPos, (int)Platform Number
//Return  :None
void drawPlatformNumber(int x,int y,int number){
  img = loadImage("home/" + number + ".png");
  image(img,x,y,35,35);
}


