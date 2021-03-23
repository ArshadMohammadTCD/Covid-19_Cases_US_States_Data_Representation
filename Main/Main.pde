//Zemyna 23/03/2021 20:15
PFont mainFont;
PFont smallFont;
PImage defaultBackground;
PImage homeScreenBackground;
Screen homeScreen;
Button headlineFigures;
Button statisticsAndGraphs;
Button worldMap;
Button liveUpdates;
Button unusedButton; //free button
Button unusedButton2; //free button
Button unusedButton3; //free button
Button unusedButton4; //free button
Screen headlineFiguresScreen;
Button returnButton;
Screen statsGraphsScreen;
Screen worldMapScreen;
Screen liveUpdatesScreen;
Screen unused;
Screen unused2;
Screen unused3;
Screen unused4;
Screen currentScreen;

void setup() {
  //Zemyna 23/03/2021 20:15
  size(1920, 1080);
  mainFont = loadFont("ProcessingSansPro-Regular-26.vlw");
  smallFont = loadFont("ProcessingSansPro-Regular-18.vlw");
  defaultBackground = loadImage("Default Screen1.png");  
  color buttonColor = color(83,83,83);
  //home screen
  homeScreenBackground = loadImage("Home Screen1.png");
  homeScreen = new Screen(homeScreenBackground);
  headlineFigures = new Button(480,300,960,50,"Headline Figures",buttonColor,mainFont,EVENT_HEADLINE_FIGURES,867);
  statisticsAndGraphs = new Button(480,375,960,50, "Statistics & Graphs", buttonColor,mainFont,EVENT_STATS_N_GRAPHS,858);
  worldMap = new Button(480,450,960,50,"World Map",buttonColor,mainFont,EVENT_WORLD_MAP,901);
  liveUpdates = new Button(480,525,960,50,"Live Updates",buttonColor,mainFont,EVENT_LIVE_UPDATES,889);
  unusedButton = new Button(480,600,960,50,"//Unused",buttonColor,mainFont,EVENT_FREE_1,910);//change label if using
  unusedButton2 = new Button(480,675,960,50,"//Unused",buttonColor,mainFont,EVENT_FREE_1,910);//change label if using
  unusedButton3 = new Button(480,750,960,50,"//Unused",buttonColor,mainFont,EVENT_FREE_1,910);//change label if using
  unusedButton4 = new Button(480,825,960,50,"//Unused",buttonColor,mainFont,EVENT_FREE_1,910);//change label if using
  homeScreen.addButton(headlineFigures); homeScreen.addButton(statisticsAndGraphs); homeScreen.addButton(worldMap);
  homeScreen.addButton(liveUpdates);
  homeScreen.addButton(unusedButton);//change if using 
  homeScreen.addButton(unusedButton2);//change if using 
  homeScreen.addButton(unusedButton3);//change if using
  homeScreen.addButton(unusedButton4);//change if using
  //Headline Figures
  headlineFiguresScreen = new Screen(defaultBackground);
  returnButton = new Button(50,50,80,30,"← Home",buttonColor,smallFont,EVENT_BACK_TO_HOME,60);
  headlineFiguresScreen.addButton(returnButton);
  //Statistics & Graphs
  statsGraphsScreen = new Screen(defaultBackground);
  statsGraphsScreen.addButton(returnButton);
  //World Map Screen
  worldMapScreen = new Screen(defaultBackground);
  worldMapScreen.addButton(returnButton);
  //Live Updates
  liveUpdatesScreen = new Screen(defaultBackground);
  liveUpdatesScreen.addButton(returnButton);
  //extra screens
  unused = new Screen(defaultBackground);
  unused.addButton(returnButton);
  unused2 = new Screen(defaultBackground);
  unused2.addButton(returnButton);
  unused3 = new Screen(defaultBackground);
  unused3.addButton(returnButton);
  unused4 = new Screen(defaultBackground);
  unused4.addButton(returnButton);
  currentScreen=homeScreen;
}

void draw() {
  currentScreen.draw();
}

void mousePressed(){
  //Zemyna 23/03/2021 20:15
  int event;
  event = currentScreen.getEvent();
  switch(event)
  {
    case EVENT_HEADLINE_FIGURES: 
       currentScreen=headlineFiguresScreen;
       break;
    case EVENT_STATS_N_GRAPHS:
       currentScreen=statsGraphsScreen;
       break;
    case EVENT_WORLD_MAP:
       currentScreen=worldMapScreen;
       break;
    case EVENT_LIVE_UPDATES:
       currentScreen=liveUpdatesScreen;
       break;
    case EVENT_FREE_1:
       currentScreen=unused;
       break;
    case EVENT_FREE_2:
       currentScreen=unused2;
       break;
    case EVENT_FREE_3:
       currentScreen=unused3;
       break;
    case EVENT_FREE_4:
       currentScreen=unused4;
       break;
    case EVENT_BACK_TO_HOME:
       currentScreen=homeScreen;
       break;
  }
}

void mouseMoved()
{
  //Zemyna 23/03/2021 20:15
  for(int i=0; i<currentScreen.buttonList.size(); i++)
  {
    Button currentButton = (Button) currentScreen.buttonList.get(i);
      if ((mouseX > currentButton.x) && (mouseX < currentButton.x+ currentButton.width) && 
      (mouseY > currentButton.y) && (mouseY < currentButton.y+ currentButton.height))
      {
        currentButton.hover = true;
      }
      else
      {
        currentButton.hover = false;
      }
  }
}
