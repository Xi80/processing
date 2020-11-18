PImage img;
PFont  font;

/*
 *  Electric Bulletin Board Simulator
 *  This Programme was coded by H31E26 Itsuki Hashimoto
*/


//------------
//constants
  int[]   HOUR = {1,1};
  int[]   MINUTE = {3,0};

  int[]   _BACKGROUND_COLOUR = {102,102,102};

  int[]   _UPPER_EDGE_COLOUR = {225,225,225};
  int[]   _UPPER_EDGE_OFFSET = {0,0};
  int[]   _UPPER_EDGE_SIZE = {800,30};

  int[]   _DISPLAY_BACKGROUND_COLOUR = {51,51,51};
  int[]   _DISPLAY_BACKGROUND_OFFSET = {180,60};
  int[]   _DISPLAY_BACKGROUND_SIZE = {580,420};

  String  _FRAME_CHARACTER_PATH = "background/";
  int[][] _FRAME_CHARACTER_OFFSET = {{5,40},{180,35}};
  int[][] _FRAME_CHARACTER_SIZE = {{165,360},{570,18}};

  int[]   _DISPLAY_SLOT_COLOUR = {0,0,0};
  int[][] _DISPLAY_SLOT_START_OFFSET = {{190,72},{480,72}};
  int     _DISPLAY_SLOT_SEPARATER_OFFSET = 80;
  int     _DISPLAY_SLOT_STEP = 65;
  int[]   _DISPLAY_SLOT_SIZE = {260,64};

  String  _TIME_CHARACTER_PATH = "time/";
  int[]   _TIME_CHARACTER_SIZE = {10,38};
  int     _TIME_CHARACTER_STEP = 10;
  int[]   _TIME_CHARACTER_OFFSET = {0,0};

  String  _TRAIN_TYPE_PATH = "type/";
  int[]   _TRAIN_TYPE_SIZE = {60,35};
  int[]   _TRAIN_TYPE_OFFSET = {0,0};

  String  _DEST_STATION_PATH = "dest/";
  int[]   _DEST_STATION_SIZE = {80,35};
  int[]   _DEST_STATION_OFFSET = {0,0};

  String  _DEPT_PLATFORM_PATH = "home/";
  int[]   _DEPT_PLATFORM_SIZE = {35,35};
  int[]   _DEPT_PLATFORM_OFFSET = {0,0};

  int[][] _TEXT_AREA_OFFSET = {{0,0},{0,0},{0,0}};
  int     _TEXT_AREA_CHARACTER_SIZE = 10;
  int     _TEXT_AREA_CAPACITY = 20;
  String  _TIME_TABLE_PATH = "table/";
//------------

//Summary :Initialise
//Param   :None
//Return  :None
void setup(){
  size(800,500);
  showBackground();

  drawTime(195,85,HOUR,MINUTE);
  drawTrainType(250,85,"express");
  drawDestination(320,85,"shiroko");
  drawPlatformNumber(405,85,1);

}

//Summary :Draw Background
//Param   :None
//Return  :None
void showBackground(){
  background(_BACKGROUND_COLOUR[0],_BACKGROUND_COLOUR[1],_BACKGROUND_COLOUR[2]);

  noStroke();
  fill(_UPPER_EDGE_COLOUR[0],_UPPER_EDGE_COLOUR[1],_UPPER_EDGE_COLOUR[2]);
  rect(_UPPER_EDGE_OFFSET[0],_UPPER_EDGE_OFFSET[1],_UPPER_EDGE_SIZE[0],_UPPER_EDGE_SIZE[1]);

  fill(_DISPLAY_BACKGROUND_COLOUR[0],_DISPLAY_BACKGROUND_COLOUR[1],_DISPLAY_BACKGROUND_COLOUR[2]);
  rect(_DISPLAY_BACKGROUND_OFFSET[0],_DISPLAY_BACKGROUND_OFFSET[1],_DISPLAY_BACKGROUND_SIZE[0],_DISPLAY_BACKGROUND_SIZE[1]);

  for(int i = 0;i < 2;i++){
    img = loadImage(_FRAME_CHARACTER_PATH + "kyotaiCharacter" + i + ".png");
    image(img,_FRAME_CHARACTER_OFFSET[i][0],_FRAME_CHARACTER_OFFSET[i][1],_FRAME_CHARACTER_SIZE[i][0],_FRAME_CHARACTER_SIZE[i][1]);
  }

  fill(_DISPLAY_SLOT_COLOUR[0],_DISPLAY_SLOT_COLOUR[1],_DISPLAY_SLOT_COLOUR[2]);

  for(int i = 0;i < 2;i++){
    for(int j = 0;j < 3;j++){
      for(int k = 0;k < 2;k++){
        rect(
          _DISPLAY_SLOT_START_OFFSET[k][0],
          ((i==0)? 0 : _DISPLAY_SLOT_SEPARATER_OFFSET + _DISPLAY_SLOT_STEP * 2) + _DISPLAY_SLOT_START_OFFSET[k][1] + _DISPLAY_SLOT_STEP * j,
          _DISPLAY_SLOT_SIZE[0],
          _DISPLAY_SLOT_SIZE[1]
        );
      }
    }
  }
}

//Summary :Draw Time
//Param   :(int)XPos,(int)YPos, (int)H-H, (int)M-M
//Return  :None
void drawTime(int x,int y,int[] h,int[] m){
  for(int i = 0;i < 5;i++){
    img = loadImage(_TIME_CHARACTER_PATH + ((i==2)? "colon": ((i < 2)? h[i]:m[i - 3])) + ".png");
    image(
      img,
      _TIME_CHARACTER_OFFSET[0] + _TIME_CHARACTER_STEP * i + x,
      _TIME_CHARACTER_OFFSET[1] + y,
      _TIME_CHARACTER_SIZE[0],
      _TIME_CHARACTER_SIZE[1]
    );
  }
}

//Summary :Draw Train Type
//Param   :(int)XPos,(int)YPos, (String)Type
//Return  :None
void drawTrainType(int x,int y,String type){
  img = loadImage(_TRAIN_TYPE_PATH + type + ".png");
  image(img,_TRAIN_TYPE_OFFSET[0] + x,_TRAIN_TYPE_OFFSET[1] + y,_TRAIN_TYPE_SIZE[0],_TRAIN_TYPE_SIZE[1]);
}

//Summary :Draw Destination
//Param   :(int)XPos,(int)YPos, (String)Station Name
//Return  :None
void drawDestination(int x,int y,String stationName){
  img = loadImage(_DEST_STATION_PATH + stationName + ".png");
  image(img,x,y,_DEST_STATION_SIZE[0],_DEST_STATION_SIZE[1]);
}

//Summary :Draw Platform Number
//Param   :(int)XPos,(int)YPos, (int)Platform Number
//Return  :None
void drawPlatformNumber(int x,int y,int number){
  img = loadImage(_DEPT_PLATFORM_PATH + number + ".png");
  image(img,_DEPT_PLATFORM_OFFSET[0] + x,_DEPT_PLATFORM_OFFSET[1] + y,_DEPT_PLATFORM_SIZE[0],_DEPT_PLATFORM_SIZE[1]);
}


