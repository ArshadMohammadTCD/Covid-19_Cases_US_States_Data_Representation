//Zemyna 23/03/2021 20:15
PFont mainFont;
PFont smallFont;
PFont largeFont;
PImage defaultBackground;
PImage homeScreenBackground;
Screen homeScreen;
Button headlineFigures;
Button statisticsAndGraphs;
Button worldMap;
Button liveUpdates;
Button covidUSMapButton; //free button
Button dataTableButton; //free button
Button treeMapButton; //free button
Button unusedButton4; //free button
Screen headlineFiguresScreen;
Button returnButton;
Screen statsGraphsScreen;
Screen worldMapScreen;
Screen liveUpdatesScreen;
Screen covidUSMapScreen;
Screen dataTableScreen;
Screen treeMapScreen;
Screen unused4;
Screen currentScreen;
Map USmap;
PImage mapImageUS;
boolean displayPopUp;
State currentState;


// Joe 25/03/21 10:20 : Values I made just for creating the tables of info on the screen, delete later
String recentQuery;
Table recentSamples;
int counter;
int stateIndex;
ArrayList<Bar> theBars;
int dateIndex;
Button forwardCounty;
Button backwardCounty;
Button forwardDay;
Button backwardDay;
Button forwardMonth;
Button backwardMonth;
int graphDay;
int graphMonth;

//Andrey 24/03/2021 16:00
Grid grid;
import samuelal.squelized.*;
Table table;
Table dataTable;
SQLConnection myConnection;


//Arshad 02/04/2121 22:42
TreeMap treeMap1;


void setup() {
  //Zemyna 23/03/2021 20:15
  size(1920, 1080);
  mainFont = loadFont("ProcessingSansPro-Regular-26.vlw");
  smallFont = loadFont("ProcessingSansPro-Regular-18.vlw");
  largeFont = loadFont("ProcessingSansPro-Regular-48.vlw");
  defaultBackground = loadImage("Default Screen1.png");  
  setupScreens();
  currentScreen=homeScreen;
  //Zemyna 01/04/2021 05:23
  mapImageUS = loadImage("1280px-Map_of_USA_States_with_names_white.svg.png");
  USmap = new Map();
  setupStates();
  currentState=null;

  //Andrey 24/03/2021  16:00

  // Using a stringBuilder in order to effisciently forms strings for queries
  // Andrey 01/04/2021 17:28
  //myConnection = new SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\sqlite\\covid_data.db");
  myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\Users\\jdaha\\sqlite\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\sqlite3\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/Users/rehaman/Downloads/covid_data.db");
  DbImport job = new DbImport();
  job.Run(myConnection);
  String query = "SELECT * FROM covidData WHERE county = 'California'"; 
  DataSource data = new DataSource(myConnection, query);


  // Andrey 25/03/2021 #17:56
  // Deleting previous and creating Index to make query's more effective
  String deleteIndex = "DROP INDEX IF EXISTS county_id";
  String createIndex = "CREATE INDEX IF NOT EXISTS county_id ON covidData(county);";
  myConnection.updateQuery(deleteIndex);
  myConnection.updateQuery(createIndex);


  // Joe : Code for the tables of data, delete later
  recentQuery = "SELECT date,area,cases FROM covidData WHERE date = '28/04/2020' AND county = 'Alabama'";
  recentSamples = myConnection.runQuery(recentQuery);
  counter = 0;
  stateIndex = 0;
  dateIndex = 0;
  theBars = new ArrayList();
  graphDay = 1;
  graphMonth = 3;

  // Andrey 01/04/2021 
  grid = new Grid(data.table, 100, 100, 600, 500);
}

void draw() {
  currentScreen.draw();
  // Joe 25/03/21 10:20
  if (currentScreen == statsGraphsScreen) {
    //drawTable(recentSamples);
    //counter++;
    drawChart();
  }
  /*
  else {
   counter = 0;
   stateIndex = 0;
   }*/

  //Zemyna 01/04/2021 05:23
  if (currentScreen==covidUSMapScreen)
  {
    USmap.draw();
    drawMapTabs();
    if (displayPopUp==true)
    {
      popUpStatsTable();
    }
  }
  //Andrey 01/04/2021 14:24
  if (currentScreen == dataTableScreen) {
    textSize(12);
    background(232, 232, 152);
    grid.draw();
  }
  // Arshad 02/04/2021 22:54
  if (currentScreen == treeMapScreen) {


    treeMap1.draw();
  }
}
//Andrey 01/04/2021 14:34
void keyPressed() {
  println(keyCode);
  String result = grid.keyProcess(keyCode, key);
  if (!result.equals("")) {
    println(result);
  }
}
void mousePressed() {
  //Zemyna 23/03/2021 20:15
  //Joe 30/03/21 00:50 : Created switch statements depending on the current screen
  int event;
  event = currentScreen.getEvent();
  if ( currentScreen == homeScreen ) {
    switch(event)
    {
    case EVENT_HEADLINE_FIGURES: 
      currentScreen=headlineFiguresScreen;
      break;
    case EVENT_STATS_N_GRAPHS:
      currentScreen=statsGraphsScreen;
      createChart();
      break;
    case EVENT_WORLD_MAP:
      currentScreen=worldMapScreen;
      break;
    case EVENT_LIVE_UPDATES:
      currentScreen=liveUpdatesScreen;
      break;
    case EVENT_FREE_1:
      currentScreen=covidUSMapScreen;
      break;
    case EVENT_DATA_TABLE:
      currentScreen=dataTableScreen;
      break;
    case EVENT_TREE_MAP:
      currentScreen=treeMapScreen;
      break;
    case EVENT_FREE_4:
      currentScreen=unused4;
      break;
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  } else if ( currentScreen == headlineFiguresScreen ) {
    switch(event)
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  } else if ( currentScreen == statsGraphsScreen ) {
    switch(event)
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      emptyArray(theBars);
      stateIndex = 0;
      break;
    case 1:
      if ( stateIndex < STATES.length - 1 ) {
        emptyArray(theBars);
        stateIndex++;
        createChart();
      }
      break;
    case 2:
      if ( stateIndex > 0 ) {
        emptyArray(theBars);
        stateIndex--;
        createChart();
      }
      break;
    case 3:
      if ( graphMonth == 1 && graphDay < 31 ) { 
        emptyArray(theBars);
        graphDay++;
        createChart();
      } else if ( graphMonth == 2 && graphDay < 29 ) {
        emptyArray(theBars);
        graphDay++;
        createChart();
      } else if ( graphMonth == 3 && graphDay < 31 ) {
        emptyArray(theBars);
        graphDay++;
        createChart();
      } else if ( graphMonth == 4 && graphDay < 28 ) {
        emptyArray(theBars);
        graphDay++;
        createChart();
      }
      break;
    case 4:
      if ( graphMonth == 1 && graphDay > 21 ) {
        emptyArray(theBars);
        graphDay--;
        createChart();
      } else if ( graphMonth == 2 && graphDay > 1 ) {
        emptyArray(theBars);
        graphDay--;
        createChart();
      } else if ( graphMonth == 3 && graphDay > 1 ) {
        emptyArray(theBars);
        graphDay--;
        createChart();
      } else if ( graphMonth == 4 && graphDay > 1 ) {
        emptyArray(theBars);
        graphDay--;
        createChart();
      }
      break;
    case 5:
      if  ( graphMonth < 4 ) {
        emptyArray(theBars);
        graphMonth++;
        graphDay = 1;
        createChart();
      }
      break;
    case 6:
      if ( graphMonth > 3 ) {
        emptyArray(theBars);
        graphMonth--;
        if ( graphMonth == 1 ) {
          graphDay = 21;
        } else {
          graphDay = 1;
        }
        createChart();
        break;
      }
    }
  } else if ( currentScreen == worldMapScreen ) {
    switch(event) 
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  } else if ( currentScreen == liveUpdatesScreen ) {
    switch(event)
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  } else if ( currentScreen == covidUSMapScreen ) {
    switch(event)
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  } else if ( currentScreen == dataTableScreen ) {
    switch(event)
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  } else if ( currentScreen == treeMapScreen ) {
    switch(event)
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }

  String stateEvent = USmap.getMapEvent();//Zemyna 01/04/2021 05:35
  if (currentScreen==covidUSMapScreen)
  {
    String stateEventString = USmap.getMapEvent();//Zemyna 01/04/2021 05:35
    switch(stateEventString)
    {
    case "Alabama":
      currentState=Alabama;
      displayPopUp=true;
      break;
    case "Alaska":
      currentState=Alaska;
      displayPopUp=true;
      break;
    case "Arizona":
      currentState=Arizona;
      displayPopUp=true;
      break;
    case "Arkansas":
      currentState=Arkansas;
      displayPopUp=true;
      break;
    case "California":
      currentState=California;
      displayPopUp=true;
      break;
    case "Colorado":
      currentState=Colorado;
      displayPopUp=true;
      break;
    case "Connecticut":
      currentState=Connecticut;
      displayPopUp=true;
      break;
    case "Delaware":
      currentState=Delaware;
      displayPopUp=true;
      break;
    case "Florida":
      currentState=Florida;
      displayPopUp=true;
      break;
    case "Georgia":
      currentState=Georgia;
      displayPopUp=true;
      break;
    case "Hawaii":
      currentState=Hawaii;
      displayPopUp=true;
      break;
    case "Idaho":
      currentState=Idaho;
      displayPopUp=true;
      break;
    case "Illinois":
      currentState=Illinois;
      displayPopUp=true;
      break;
    case "Indiana":
      currentState=Indiana;
      displayPopUp=true;
      break;
    case "Iowa":
      currentState=Iowa;
      displayPopUp=true;
      break;
    case "Kansas":
      currentState=Kansas;
      displayPopUp=true;
      break;
    case "Kentucky":
      currentState=Kentucky;
      displayPopUp=true;
      break;
    case "Louisiana":
      currentState=Louisiana;
      displayPopUp=true;
      break;
    case "Maine":
      currentState=Maine;
      displayPopUp=true;
      break;
    case "Maryland":
      currentState=Maryland;
      displayPopUp=true;
      break;
    case "Massachusetts":
      currentState=Massachusetts;
      displayPopUp=true;
      break;
    case "Michigan":
      currentState=Michigan;
      displayPopUp=true;
      break;
    case "Minnesota":
      currentState=Minnesota;
      displayPopUp=true;
      break;
    case "Mississippi":
      currentState=Mississippi;
      displayPopUp=true;
      break;
    case "Missouri":
      currentState=Missouri;
      displayPopUp=true;
      break;
    case "Montana":
      currentState=Montana;
      displayPopUp=true;
      break;
    case "Nebraska":
      currentState=Nebraska;
      displayPopUp=true;
      break;
    case "Nevada":
      currentState=Nevada;
      displayPopUp=true;
      break;
    case "New Hampshire":
      currentState=NewHampshire;
      displayPopUp=true;
      break;
    case "New Jersey":
      currentState=NewJersey;
      displayPopUp=true;
      break;
    case "New Mexico":
      currentState=NewMexico;
      displayPopUp=true;
      break;
    case "New York":
      currentState=NewYork;
      displayPopUp=true;
      break;
    case "North Carolina":
      currentState=NorthCarolina;
      displayPopUp=true;
      break;
    case "North Dakota":
      currentState=NorthDakota;
      displayPopUp=true;
      break;
    case "Ohio":
      currentState=Ohio;
      displayPopUp=true;
      break;
    case "Oklahoma":
      currentState=Oklahoma;
      displayPopUp=true;
      break;
    case "Oregon":
      currentState=Oregon;
      displayPopUp=true;
      break;
    case "Pennsylvania":
      currentState=Pennsylvania;
      displayPopUp=true;
      break;
    case "Rhode Island":
      currentState=RhodeIsland;
      displayPopUp=true;
      break;
    case "South Carolina":
      currentState=SouthCarolina;
      displayPopUp=true;
      break;
    case "South Dakota":
      currentState=SouthDakota;
      displayPopUp=true;
      break;
    case "Tennessee":
      currentState=Tennessee;
      displayPopUp=true;
      break;
    case "Texas":
      currentState=Texas;
      displayPopUp=true;
      break;
    case "Utah":
      currentState=Utah;
      displayPopUp=true;
      break;
    case "Vermont":
      currentState=Vermont;
      displayPopUp=true;
      break;
    case "Virginia":
      currentState=Virginia;
      displayPopUp=true;
      break;
    case "Washington":
      currentState=Washington;
      displayPopUp=true;
      break;
    case "West Virginia":
      currentState=WestVirginia;
      displayPopUp=true;
      break;
    case "Wisconsin":
      currentState=Wisconsin;
      displayPopUp=true;
      break;
    case "Wyoming":
      currentState=Wyoming;
      displayPopUp=true;
      break;
    case "":
      currentState=null;
      displayPopUp=false;
      break;
    }
  }
}

void mouseMoved()
{
  //Zemyna 23/03/2021 20:15
  for (int i=0; i<currentScreen.buttonList.size(); i++)
  {
    Button currentButton = (Button) currentScreen.buttonList.get(i);
    if ((mouseX > currentButton.x) && (mouseX < currentButton.x+ currentButton.width) && 
      (mouseY > currentButton.y) && (mouseY < currentButton.y+ currentButton.height))
    {
      currentButton.hover = true;
    } else
    {
      currentButton.hover = false;
    }
  }
  // Joe 01/04/2021 11:25 
  for (int i = 0; i<theBars.size(); i++) {
    Bar theBar = (Bar) theBars.get(i);
    if ( mouseY >= 850 - theBar.blockHeight - 20 && mouseY <= 850 && mouseX >= theBar.xpos && mouseX < theBar.xpos + theBar.blockWidth ) {
      theBars.get(i).mouseOver = true;
    } else {
      theBars.get(i).mouseOver = false;
    }
  }
  //Zemyna 01/04/2021 05:37
  if (currentScreen==covidUSMapScreen)
  {
    for (int i=0; i<USmap.statesList.size(); i++)
    {
      State currentState = (State) USmap.statesList.get(i);
      if ((mouseX > currentState.xT) && (mouseX < currentState.xT+ currentState.width) && 
        (mouseY > currentState.yT) && (mouseY < currentState.yT+ currentState.height))
      {
        currentState.hover = true;
      } else
      {
        currentState.hover = false;
      }
    }
  }
}

void printTable(Table table) {
  // Andrey 24/03/2021 16:00
  for (TableRow row : table.rows())
  {
    for (int i = 0; i < row.getColumnCount(); i++)
    {
      System.out.print(row.getString(i) + "  ");
    }
    System.out.println();
  }
}

void drawTable(Table table) {
  // Joe 25/03/21 10:19: Code to draw a table and the dates, cases and areas of each state in ascending order
  int textYpos = 130;
  int textXpos = 100;
  stroke(0);
  fill(255);
  for ( int i = 0; i < 6; i++) {
    rect(80 + (i * 270), 100, 270, 850);
  }
  fill(0);
  for (TableRow row : table.rows())
  {
    for (int i = 0; i < row.getColumnCount(); i++)
    {
      text(row.getString(i), (i*100) + textXpos, textYpos);
    }
    textYpos += 30;
    if ( textYpos >= height-130 ) {
      textYpos = 130;
      textXpos += 270;
    }
  }
  textFont(mainFont);
  text("The most recent reports from: " + STATES[stateIndex], 150, 72); 
  if (counter == 150 && stateIndex < STATES.length ) {
    counter = 0;
    stateIndex++;
  }
  recentQuery = "SELECT date,area,cases FROM covidData WHERE date = '28/04/2020' AND county = '" + STATES[stateIndex] + "'";




  int time1 = millis();
  recentSamples = myConnection.runQuery(recentQuery);
  int time2 = millis();
  System.out.println(time2-time1);
}


void setupScreens() 
{
  //Zemyna 23/03/2021 20:15
  color buttonColor = color(83, 83, 83);
  //home screen
  homeScreenBackground = loadImage("Home Screen1.png");
  homeScreen = new Screen(homeScreenBackground);
  headlineFigures = new Button(480, 300, 960, 50, "Headline Figures", buttonColor, mainFont, EVENT_HEADLINE_FIGURES, 867);
  statisticsAndGraphs = new Button(480, 375, 960, 50, "Statistics & Graphs", buttonColor, mainFont, EVENT_STATS_N_GRAPHS, 858);
  worldMap = new Button(480, 450, 960, 50, "World Map", buttonColor, mainFont, EVENT_WORLD_MAP, 901);
  liveUpdates = new Button(480, 525, 960, 50, "Live Updates", buttonColor, mainFont, EVENT_LIVE_UPDATES, 889);
  covidUSMapButton = new Button(480, 600, 960, 50, "Covid-19 Cases in the US: Map", buttonColor, mainFont, EVENT_FREE_1, 790);//change label if using
  dataTableButton = new Button(480, 675, 960, 50, "Data Table", buttonColor, mainFont, EVENT_DATA_TABLE, 910);//change label if using
  treeMapButton = new Button(480, 750, 960, 50, "Tree Map Visualisation", buttonColor, mainFont, EVENT_TREE_MAP, 910);//change label if using
  unusedButton4 = new Button(480, 825, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using

  // Joe 30/03/21 00:50
  forwardCounty = new Button ( 175, 963, 100, 30, "--------->", buttonColor, smallFont, 1, 180);
  backwardCounty = new Button ( 75, 963, 100, 30, "<---------", buttonColor, smallFont, 2, 80);
  forwardDay = new Button ( 350, 963, 50, 30, "->", buttonColor, smallFont, 3, 355);
  backwardDay = new Button ( 300, 963, 50, 30, "<-", buttonColor, smallFont, 4, 305);
  forwardMonth = new Button ( 450, 963, 50, 30, "->", buttonColor, smallFont, 5, 455);
  backwardMonth = new Button ( 400, 963, 50, 30, "<-", buttonColor, smallFont, 6, 405);

  homeScreen.addButton(headlineFigures); 
  homeScreen.addButton(statisticsAndGraphs); 
  homeScreen.addButton(worldMap);
  homeScreen.addButton(liveUpdates);
  homeScreen.addButton(covidUSMapButton);//change if using 
  homeScreen.addButton(dataTableButton);//change if using 
  homeScreen.addButton(treeMapButton);//change if using
  homeScreen.addButton(unusedButton4);//change if using
  //Headline Figures
  headlineFiguresScreen = new Screen(defaultBackground);
  returnButton = new Button(20, 30, 30, 30, "X", buttonColor, mainFont, EVENT_BACK_TO_HOME, 28);
  headlineFiguresScreen.addButton(returnButton);
  //Statistics & Graphs
  statsGraphsScreen = new Screen(defaultBackground);
  statsGraphsScreen.addButton(returnButton);
  // Joe 30/03/21 00:50 : Buttons to move between states on the bar charts
  statsGraphsScreen.addButton(forwardCounty);
  statsGraphsScreen.addButton(backwardCounty);
  statsGraphsScreen.addButton(forwardDay);
  statsGraphsScreen.addButton(backwardDay);
  statsGraphsScreen.addButton(forwardMonth);
  statsGraphsScreen.addButton(backwardMonth);

  //World Map Screen
  worldMapScreen = new Screen(defaultBackground);
  worldMapScreen.addButton(returnButton);
  //Live Updates
  liveUpdatesScreen = new Screen(defaultBackground);
  liveUpdatesScreen.addButton(returnButton);
  //extra screens
  covidUSMapScreen = new Screen(defaultBackground);
  covidUSMapScreen.addButton(returnButton);

  dataTableScreen = new Screen(defaultBackground);
  dataTableScreen.addButton(returnButton);

  treeMapScreen = new Screen(defaultBackground);
  treeMapScreen.addButton(returnButton);

  unused4 = new Screen(defaultBackground);
  unused4.addButton(returnButton);
}
