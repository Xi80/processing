PImage img;
PFont  font;

/*
 *  Electric Bulletin Board Simulator
 *  This Programme was coded by H31E26 Itsuki Hashimoto
 */

//------------
//Variables
int[][] recentHour = new int[6][2];
int[][] recentMinute = new int[6][2];
int[] recentTrainType = new int[6];
int[] recentDest = new int[6];
int[] recentPlatform = new int[6];
String[][] recentMessage = new String[6][3];

String[] dests;
String[] types;

//debug mode
boolean DEBUG = false;

//constants
int[]   HOUR = {1, 9};
int[]   MINUTE = {3, 0};

int[]   _BACKGROUND_COLOUR = {102, 102, 102};

int[]   _UPPER_EDGE_COLOUR = {225, 225, 225};
int[]   _UPPER_EDGE_OFFSET = {0, 0};
int[]   _UPPER_EDGE_SIZE = {800, 30};

int[]   _DISPLAY_BACKGROUND_COLOUR = {51, 51, 51};
int[]   _DISPLAY_BACKGROUND_OFFSET = {180, 60};
int[]   _DISPLAY_BACKGROUND_SIZE = {580, 420};

String  _FRAME_CHARACTER_PATH = "background/";
int[][] _FRAME_CHARACTER_OFFSET = {{5, 40}, {180, 35}};
int[][] _FRAME_CHARACTER_SIZE = {{165, 360}, {570, 18}};

int[]   _DISPLAY_SLOT_COLOUR = {0, 0, 0};
int[][] _DISPLAY_SLOT_START_OFFSET = {{190, 72}, {480, 72}};
int     _DISPLAY_SLOT_SEPARATER_OFFSET = 80;
int     _DISPLAY_SLOT_STEP = 65;
int[]   _DISPLAY_SLOT_SIZE = {260, 64};

String  _TIME_CHARACTER_PATH = "time/";
int[]   _TIME_CHARACTER_SIZE = {10, 38};
int     _TIME_CHARACTER_STEP = 10;
int[]   _TIME_CHARACTER_OFFSET = {0, 15};

String  _TRAIN_TYPE_TABLE = "type.txt";
String  _TRAIN_TYPE_PATH = "type/";
int[]   _TRAIN_TYPE_SIZE = {60, 35};
int[]   _TRAIN_TYPE_OFFSET = {60, 17};

String  _DEST_STATION_TABLE = "dest.txt";
String  _DEST_STATION_PATH = "dest/";
int[]   _DEST_STATION_SIZE = {80, 35};
int[]   _DEST_STATION_OFFSET = {130, 15};

String  _DEPT_PLATFORM_PATH = "home/";
int[]   _DEPT_PLATFORM_SIZE = {35, 35};
int[]   _DEPT_PLATFORM_OFFSET = {220, 15};

int[]   _TEXT_AREA_OFFSET = {5, 5};
int     _TEXT_AREA_CHARACTER_SIZE = 12;
int     _TEXT_AREA_LEADING = 20;
String  _TABLE_PATH = "table/";
//------------

String[] lines;
int index = 0;

//Summary :Initialise
//Param   :None
//Return  :None
void setup() {
  /*,OPENGL*/
  size(800, 500);
  frameRate(60);
  lines = loadStrings(_TABLE_PATH + "table.txt");
  dests = loadStrings(_TABLE_PATH + _DEST_STATION_TABLE);
  types = loadStrings(_TABLE_PATH + _TRAIN_TYPE_TABLE);
  
  for(int i = 0;i < dests.length;i++){
    println(dests[i]);
  }
}

//Summary :Draw
//Param   :None
//Return  :None
void draw() {
  showBackground();
  show();
}

//Summary :Main Method
//Param   :None
//Return  :None
void show() {

  for (int i = 0; i < lines.length; i++) {
    String[] line = splitTokens(lines[i], "|");
    int h = int(line[0]) * 10 + int(line[1]);
    int m = int(line[2]) * 10 + int(line[3]);
    if (minute() + hour() * 60 <= m + h * 60) {
      index = i;
      break;
    }
  }

  for (int i = index; i < min(index + 6, lines.length); i++) {
    String[] line = splitTokens(lines[i], "|");
    if (DEBUG) {
      for (int j = 0; j < line.length; j++) {
        if (j % 10 == 0) {
          println();
        }
        print(line[j], " ");
      }
    }
    
    for (int j = 0; j < 2; j++) {
      HOUR[j] = int(line[j]);
      MINUTE[j] = int(line[j+2]);
    }
    
    for(int j = 0;j < 2;j++){
      if(recentHour[i-index][j] != HOUR[j]){
        recentHour[i-index][j] = (recentHour[i-index][j] + 1) % 10;
      }  
    }
    
    for(int j = 0;j < 2;j++){
      if(recentMinute[i-index][j] != MINUTE[j]){
        recentMinute[i-index][j] = (recentMinute[i-index][j] + 1) % 10;
      }    
    }
    
    if(
      recentHour[i-index][0] != (HOUR[0] + 1) % 10 ||
      recentHour[i-index][1] != (HOUR[1] + 1) % 10 ||
      recentMinute[i-index][0] != (MINUTE[0] + 1) % 10 ||
      recentMinute[i-index][1] != (MINUTE[1] + 1) % 10
    ){
      drawTime(
        _DISPLAY_SLOT_START_OFFSET[0][0],
        (((i - index) > 2)? _DISPLAY_SLOT_SEPARATER_OFFSET - _DISPLAY_SLOT_STEP : 0) + _DISPLAY_SLOT_START_OFFSET[0][1] + (i - index) * _DISPLAY_SLOT_STEP, 
        recentHour[i-index], 
        recentMinute[i-index]
      );    
    }
    
    if(types[recentTrainType[i-index]] != line[4]){
      recentTrainType[i-index] = (recentTrainType[i-index] + 1) % types.length;
    }
    println(types[recentTrainType[i-index]]);
    if(types[abs((recentTrainType[i-index] - 1) % types.length)] != line[4]){
      drawTrainType(
        _DISPLAY_SLOT_START_OFFSET[0][0], 
        (((i - index) > 2)? _DISPLAY_SLOT_SEPARATER_OFFSET - _DISPLAY_SLOT_STEP : 0) + _DISPLAY_SLOT_START_OFFSET[0][1] + (i - index) * _DISPLAY_SLOT_STEP, 
        types[recentTrainType[i-index]]
      );     
    }
      
    drawDestination(
      _DISPLAY_SLOT_START_OFFSET[0][0], 
      (((i - index) > 2)? _DISPLAY_SLOT_SEPARATER_OFFSET - _DISPLAY_SLOT_STEP : 0) + _DISPLAY_SLOT_START_OFFSET[0][1] + (i - index) * _DISPLAY_SLOT_STEP, 
      line[5]
    );
    
    if(recentPlatform[i-index] != int(line[6])){
      recentPlatform[i-index] = (recentPlatform[i-index] == 6)? 1 : recentPlatform[i-index] + 1;
    }
    
    if(recentPlatform[i-index] != ((int(line[6]) == 6)? 1 : int(line[6]) + 1)){
      drawPlatformNumber(
        _DISPLAY_SLOT_START_OFFSET[0][0], 
        (((i - index) > 2)? _DISPLAY_SLOT_SEPARATER_OFFSET - _DISPLAY_SLOT_STEP : 0) + _DISPLAY_SLOT_START_OFFSET[0][1] + (i - index) * _DISPLAY_SLOT_STEP, 
        (recentPlatform[i-index] == 0)? 1 : recentPlatform[i-index]
      );
    }
    
    String msg = line[7] + "\n" + line[8] + "\n" + line[9];
    
    drawMessage(
      _DISPLAY_SLOT_START_OFFSET[1][0], 
      (((i - index) > 2)? _DISPLAY_SLOT_SEPARATER_OFFSET - _DISPLAY_SLOT_STEP : 0) + _DISPLAY_SLOT_START_OFFSET[1][1] + (i - index) * _DISPLAY_SLOT_STEP, 
      msg
    );
  }
}

//Summary :Draw Background
//Param   :None
//Return  :None
void showBackground() {
  background(_BACKGROUND_COLOUR[0], _BACKGROUND_COLOUR[1], _BACKGROUND_COLOUR[2]);

  noStroke();
  
  fill(
    _UPPER_EDGE_COLOUR[0], 
    _UPPER_EDGE_COLOUR[1], 
    _UPPER_EDGE_COLOUR[2]
  );
  
  rect(
    _UPPER_EDGE_OFFSET[0], 
    _UPPER_EDGE_OFFSET[1], 
    _UPPER_EDGE_SIZE[0], 
    _UPPER_EDGE_SIZE[1]
  );

  fill(
    _DISPLAY_BACKGROUND_COLOUR[0], 
    _DISPLAY_BACKGROUND_COLOUR[1], 
    _DISPLAY_BACKGROUND_COLOUR[2]
  );
  
  rect(
    _DISPLAY_BACKGROUND_OFFSET[0], 
    _DISPLAY_BACKGROUND_OFFSET[1], 
    _DISPLAY_BACKGROUND_SIZE[0], 
    _DISPLAY_BACKGROUND_SIZE[1]
  );

  for (int i = 0; i < 2; i++) {
    img = loadImage(_FRAME_CHARACTER_PATH + "kyotaiCharacter" + i + ".png");
    image(
      img, 
      _FRAME_CHARACTER_OFFSET[i][0], 
      _FRAME_CHARACTER_OFFSET[i][1], 
      _FRAME_CHARACTER_SIZE[i][0], 
      _FRAME_CHARACTER_SIZE[i][1]
    );
  }

  fill(_DISPLAY_SLOT_COLOUR[0], _DISPLAY_SLOT_COLOUR[1], _DISPLAY_SLOT_COLOUR[2]);

  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 3; j++) {
      for (int k = 0; k < 2; k++) {
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
void drawTime(int x, int y, int[] h, int[] m) {
  for (int i = 0; i < 5; i++) {
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
void drawTrainType(int x, int y, String type) {
  img = loadImage(_TRAIN_TYPE_PATH + type + ".png");
  image(
    img, 
    _TRAIN_TYPE_OFFSET[0] + x, 
    _TRAIN_TYPE_OFFSET[1] + y, 
    _TRAIN_TYPE_SIZE[0], 
    _TRAIN_TYPE_SIZE[1]
  );
}

//Summary :Draw Destination
//Param   :(int)XPos,(int)YPos, (String)Station Name
//Return  :None

void drawDestination(int x, int y, String stationName) {
  img = loadImage(_DEST_STATION_PATH + stationName + ".png");
  image(
    img, 
    x + _DEST_STATION_OFFSET[0], 
    y + _DEST_STATION_OFFSET[1], 
    _DEST_STATION_SIZE[0], 
    _DEST_STATION_SIZE[1]
  );
}

//Summary :Draw Platform Number
//Param   :(int)XPos,(int)YPos, (int)Platform Number
//Return  :None
void drawPlatformNumber(int x, int y, int number) {
  img = loadImage(_DEPT_PLATFORM_PATH + number + ".png");
  image(
    img, 
    _DEPT_PLATFORM_OFFSET[0] + x, 
    _DEPT_PLATFORM_OFFSET[1] + y, 
    _DEPT_PLATFORM_SIZE[0], 
    _DEPT_PLATFORM_SIZE[1]
  );
}

//Summary :Draw Message
//Param   :None
//Return  :None
void drawMessage(int x, int y, String msg) {
  font =  createFont("MS UI Gothic", _TEXT_AREA_CHARACTER_SIZE);
  textFont(font, _TEXT_AREA_CHARACTER_SIZE);
  textAlign(LEFT, TOP);
  textLeading(_TEXT_AREA_LEADING);
  fill(255);
  text(msg, x + _TEXT_AREA_OFFSET[0], y + _TEXT_AREA_OFFSET[1]);
}
