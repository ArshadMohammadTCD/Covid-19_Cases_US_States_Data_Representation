

//Andrey 24/03/2021  16:00
//importing squelized library to use sqlite
import samuelal.squelized.*;
//Zemyna 23/03/2021 20:15
PFont mainFont;
PFont smallFont;
PFont largeFont;
PImage defaultBackground;
PImage homeScreenBackground;
Screen homeScreen;
Button headlineFigures;
Button statisticsAndGraphs;
Button worldMapButton;
Button timelineCasesButton;
Button covidUSMapButton; //free button
Button dataTableButton; //free button
Button treeMapButton; //free button
Button lineChartButton; //free button
Screen headlineFiguresScreen;
Button returnButton;
Screen statsGraphsScreen;
Screen worldMapScreen;
TimelineCasesScreen timelineCasesScreen;
Screen covidUSMapScreen;
CumulativeCasesScreen dataTableScreen;
Screen treeMapScreen;
Screen lineChartScreen;
Screen currentScreen;
Map USmap;
PImage mapImageUS;
boolean displayPopUp;
State currentState;
//Zemyna 05/04/2021 20:24
PImage worldMapImage;
WorldMap worldMap;
Table table;
PFont header;


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
// Buttons for the Line Chart
Button forwardFirstCounty;
Button forwardSecondCounty;
Button backwardFirstCounty;
Button backwardSecondCounty;
Button forwardFirstDay;
Button forwardSecondDay;
Button backwardFirstDay;
Button backwardSecondDay;
Button forwardFirstMonth;
Button forwardSecondMonth;
Button backwardFirstMonth;
Button backwardSecondMonth;

// Button Arshad
Button pause;
Button forwardOneDay;
Button backwardOneDay;
Button forwardOneWeek;
Button backwardOneWeek;
Button speedUp;
Button slowDown;

int graphDay;
int graphMonth;
int firstDay;
int secondDay;
int firstMonth;
int secondMonth;
int firstState;
int secondState;
int dateCount;
IntList firstCases;
IntList secondCases;
StringList caseDates;
ArrayList<Point> firstPoints;
ArrayList<Line> firstLines;
ArrayList<Point> secondPoints;
ArrayList<Line> secondLines;

//Andrey 24/03/2021 16:00
SQLConnection myConnection;
// Andrey 11/04/2020 18:07
// Function to convert dates from dd/mm/yyyy to yyyy-mm-dd
String ConvertDate(String date) {
  String result;
  String items[] = date.split("/");
  result = items[2]+"-"+items[1]+"-"+items[0];
  return result;
}

//Arshad 02/04/2121 22:42
TreeMap treeMap1;


void setup() {
  //Zemyna 23/03/2021 20:15
  size(1920, 1080);
  mainFont = loadFont("ProcessingSansPro-Regular-26.vlw");
  smallFont = loadFont("ProcessingSansPro-Regular-18.vlw");
  largeFont = loadFont("ProcessingSansPro-Regular-48.vlw");
  defaultBackground = loadImage("Default Screen1.png");
  header = loadFont("ProcessingSansPro-Regular-78.vlw");

  // Andrey 01/04/2021 17:28
  // Establishes connection to sqlite database
  myConnection = new SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\Desktop\\Programming project repoistory\\CS1013-2021-9.\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\Users\\jdaha\\sqlite\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\sqlite3\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/Users/rehaman/Downloads/covid_data.db");
  //Andrey 24/03/2021  16:00

 // Running import of files for tables of data
  DbImport job = new DbImport();
  job.Run(myConnection);


  setupScreens();
  currentScreen=homeScreen;
  //Zemyna 01/04/2021 05:23
  mapImageUS = loadImage("1280px-Map_of_USA_States_with_names_white.svg.png");
  USmap = new Map();
  setupStates();
  currentState=null;
  //Zemyna 05/04/2021 20:24
  worldMapImage = loadImage("World Map.png");
  worldMap = new WorldMap();

  // Joe : Code for the tables of data, delete later
  stateIndex = 0;
  dateIndex = 0;
  theBars = new ArrayList();
  setupLineChart();

  treeMap1 = new TreeMap();
}

void draw() {
  currentScreen.draw();

  // Joe 25/03/21 10:20
  if (currentScreen == statsGraphsScreen) {
    drawChart();
  }

  if (currentScreen == lineChartScreen) {
    drawLineChart();
  }

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
  // Arshad 02/04/2021 22:54
  if (currentScreen == treeMapScreen) {


    treeMap1.draw();
  }
  //Zemyna 05/04/2021 20:24
  if (currentScreen == worldMapScreen)
  {
    worldMap.draw();
  }

  if (currentScreen == headlineFiguresScreen)
  {
    drawHeadlineFiguresScreen();
  }
}
//Andrey 01/04/2021 14:34
void keyPressed() {
  //Enables key controls while on the dataTableScreen
  if (currentScreen == dataTableScreen) {
    dataTableScreen.processKey(keyCode, key);
  }
  //Andrey 11/04/2021 16:04
  //Enables key controls while on the timelineCasesScreen
  if (currentScreen == timelineCasesScreen) {
    timelineCasesScreen.processKey(keyCode, key);
  }
}

void mousePressed() {
  // Arshad 
  //Arshad 19/04

  int eventTreeMap;
  eventTreeMap = currentScreen.getEvent();
  if (currentScreen == treeMapScreen){
    switch(eventTreeMap)
    {
      case 1:
      if (isPaused == false){
        isPaused = true;
      }
      else{
       isPaused = false; 
      }
      break;
      case 2:
      if (day < WORKING_DATES-1){
        day++;
      }
      break;
      case 3:
      if (day > 1){
        day--;
      }
      break;
      case 4:
      if (day+7 < WORKING_DATES-1){
        day = day+7;
      }
      else{
        day =  WORKING_DATES-1;
      }
      break;
      
      case 5:
      if (day-7 > 0){
        day = day-7;
      }
      else{
        day =  1;
      }
      break;
    }
    
    
  }
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
    case EVENT_TIMELINE_CASES:
      currentScreen= timelineCasesScreen;
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
      currentScreen=lineChartScreen;
      createLineChart(dateCount, firstState, secondState);
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
  } else if ( currentScreen ==  timelineCasesScreen ) {
    //Andrey  11/04/2021 16:03
    //Checks for which button was pressed on timelineCasesScreen
    timelineCasesScreen.processEvent(event);
    if (event == EVENT_UPDATE_TABLE) {
      println("Refresh");
      timelineCasesScreen.setupData(true);
    }
    switch(event)
    {
      //exit button to main screen
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
    // Andrey  06/04/2021
   // Checks for which button was pressed on dataTableScreen
    dataTableScreen.processEvent(event);
    if (event == EVENT_UPDATE_TABLE) {
      println("Refresh");
      dataTableScreen.setupData(true);
    }
    switch(event) {
    case EVENT_BACK_TO_HOME:
      println("CurrentScreen Main");
      currentScreen=homeScreen;
      break;
    }
  } 
  // End Andrey 06/04/2021
  else if ( currentScreen == treeMapScreen ) {
    switch(event)
    {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }

  // Joe 09/04/2021 00:51
  else if (currentScreen==lineChartScreen) {
    switch(event) {
    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      emptyLineChart();
      break;
    case 1:
      if ( firstState < STATES.length - 1) {
        emptyLineChart();
        firstState++;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
    case 2:
      if ( firstState > 0 ) {
        emptyLineChart();
        firstState--;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
    case 3:
      if ( secondState < STATES.length - 1) {
        emptyLineChart();
        secondState++;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
    case 4:
      if ( secondState > 0 ) {
        emptyLineChart();
        secondState--;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
      // forward first day
    case 5:
      if ( dateCount > 2 && (firstDay < 31 && (firstMonth == 1 || firstMonth == 3 )) || (firstDay < 29 && firstMonth == 2) || (firstDay < 28 && firstMonth == 4 )) {
        emptyLineChart();
        firstDay++;
        dateCount--;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
      // backward first day
    case 6:
      if ( firstMonth == 1 && firstDay > 21) {
        emptyLineChart();
        firstDay--;
        dateCount++;
        createLineChart(dateCount, firstState, secondState);
      } else if ( firstDay > 1 ) {
        emptyLineChart();
        firstDay--;
        dateCount++;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
      // forward first month
    case 7:
      if ( secondDay > 1 && secondMonth > firstMonth ) {
        emptyLineChart();
        firstMonth++;
        firstDay = 1;
        dateCount = secondDay - firstDay;
        createLineChart( dateCount, firstState, secondState);
      }
      break;
      // backward first month
    case 8:
      if ( firstMonth == 3 ) {
        emptyLineChart();
        firstMonth--;
        dateCount += firstDay;
        firstDay = 29;
        createLineChart( dateCount, firstState, secondState);
      } else if ( firstMonth == 2 || firstMonth == 4 ) {
        emptyLineChart();
        firstMonth--;
        dateCount += firstDay;
        firstDay = 31;
        createLineChart( dateCount, firstState, secondState);
      }
      break;
      // forward second day
    case 10:
      if ((secondDay < 31 && (secondMonth == 1 || secondMonth == 3 )) || (secondDay < 29 && secondMonth == 2) || (secondDay < 28 && secondMonth == 4 ) ) {
        emptyLineChart();
        secondDay++;
        dateCount++;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
      // backward second day
    case 11:
      if ( dateCount > 2 && ((secondDay > 21 && secondMonth == 1) || (secondDay > 1 && (secondMonth == 2 || secondMonth == 3 || secondMonth == 4 )))) {
        emptyLineChart();
        secondDay--;
        dateCount--;
        createLineChart(dateCount, firstState, secondState);
      } 
      break;
      // forward second month
    case 12:
      if ( secondMonth == 1 || secondMonth == 3) {
        emptyLineChart();
        secondMonth++; 
        dateCount += ( 32 - secondDay);
        secondDay = 1;
        createLineChart(dateCount, firstState, secondState);
      } else if ( secondMonth == 2 ) {
        emptyLineChart();
        secondMonth++;
        dateCount += ( 30 - secondDay );
        secondDay = 1;
        createLineChart(dateCount, firstState, secondState);
      }
      break;
      // backward second month
    case 13:
      if ( secondMonth > firstMonth && ( firstMonth == 2 && firstDay < 29 )) {
        emptyLineChart();
        secondMonth--;
        dateCount -= secondDay;
        secondDay = 29;
        createLineChart(dateCount, firstState, secondState);
      } else if ( secondMonth > firstMonth && ( (firstMonth == 1 || firstMonth == 3 ) && firstDay < 31 )) {
        emptyLineChart();
        secondMonth--;
        dateCount -= secondDay;
        secondDay = 31;
        createLineChart(dateCount, firstState, secondState);
      }

      break;
    }
  }
  // End Joe

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
  if ( currentScreen == statsGraphsScreen ) {
    for (int i = 0; i<theBars.size(); i++) {
      Bar theBar = (Bar) theBars.get(i);
      if ( mouseY >= 220 && mouseY <= 900 && mouseX >= theBar.xpos && mouseX < theBar.xpos + theBar.blockWidth ) {
        theBars.get(i).mouseOver = true;
      } else {
        theBars.get(i).mouseOver = false;
      }
    }
  } else if ( currentScreen == lineChartScreen ) {
    for ( int i = 0; i < firstPoints.size(); i++ ) {
      Point thePoint = (Point) firstPoints.get(i);
      if ( mouseY >= 220 && mouseY <= 929 && mouseX >= thePoint.xpos - 20 && mouseX <= thePoint.xpos + 20 ) {
        thePoint.mouseOver = true;
        secondPoints.get(i).mouseOver = true;
      } else {
        thePoint.mouseOver = false;
        secondPoints.get(i).mouseOver = false;
      }
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


void setupScreens() 
{
  //Zemyna 23/03/2021 20:15
  color buttonColor = color(83, 83, 83);
  //home screen
  homeScreenBackground = loadImage("Home Screen1.png");
  homeScreen = new Screen(homeScreenBackground);
  headlineFigures = new Button(480, 300, 960, 50, "Headline Figures", buttonColor, mainFont, EVENT_HEADLINE_FIGURES, 867);
  statisticsAndGraphs = new Button(480, 375, 960, 50, "Statistics & Graphs", buttonColor, mainFont, EVENT_STATS_N_GRAPHS, 858);
  worldMapButton = new Button(480, 825, 960, 50, "World Map", buttonColor, mainFont, EVENT_WORLD_MAP, 901);
  timelineCasesButton = new Button(480, 525, 960, 50, "Covid-19 Timeline Cases in the US by State/Area", buttonColor, mainFont, EVENT_TIMELINE_CASES, 710);
  covidUSMapButton = new Button(480, 600, 960, 50, "Covid-19 Cases in the US: Map", buttonColor, mainFont, EVENT_FREE_1, 790);//change label if using
  dataTableButton = new Button(480, 675, 960, 50, "Covid-19 Cumulative Cases in the US by State/Area", buttonColor, mainFont, EVENT_DATA_TABLE, 695);//change label if using
  treeMapButton = new Button(480, 750, 960, 50, "Tree Map Visualisation", buttonColor, mainFont, EVENT_TREE_MAP, 835);//change label if using
  lineChartButton = new Button(480, 450, 960, 50, "Line Chart of Cases", buttonColor, mainFont, EVENT_FREE_4, 860);//change label if using

  // Joe 30/03/21 00:50
  forwardCounty = new Button ( 390, 935, 100, 30, " --------->", buttonColor, smallFont, 1, 390); // right button under the box with the state name
  backwardCounty = new Button ( 90, 935, 100, 30, "  <----------", buttonColor, smallFont, 2, 80); // left button under the box with the state name
  forwardDay = new Button ( 810, 935, 50, 30, "->", buttonColor, smallFont, 3, 815); // center-left button under the box with the date
  backwardDay = new Button ( 560, 935, 50, 30, "<-", buttonColor, smallFont, 4, 565); // left most button under the box with the date
  forwardMonth = new Button ( 860, 935, 50, 30, "->>", buttonColor, smallFont, 5, 865); // right most button under the box with the date
  backwardMonth = new Button ( 510, 935, 50, 30, "<<-", buttonColor, smallFont, 6, 515); // center right button under the box with the date

  // Joe: Adding buttons for the line chart, for changing dates and both states
  forwardFirstCounty = new Button ( 390, 935, 50, 30, "->", buttonColor, smallFont, 1, 395); 
  forwardSecondCounty = new Button ( 690, 935, 50, 30, "->", buttonColor, smallFont, 3, 695);
  backwardFirstCounty = new Button ( 140, 935, 50, 30, "<-", buttonColor, smallFont, 2, 145);
  backwardSecondCounty = new Button ( 440, 935, 50, 30, "<-", buttonColor, smallFont, 4, 445);
  forwardFirstDay = new Button ( 1050, 935, 50, 30, "->", buttonColor, smallFont, 5, 1055);
  forwardSecondDay = new Button ( 1450, 935, 50, 30, "->", buttonColor, smallFont, 10, 1455);
  backwardFirstDay = new Button ( 800, 935, 50, 30, "<-", buttonColor, smallFont, 6, 805); 
  backwardSecondDay = new Button ( 1200, 935, 50, 30, "<-", buttonColor, smallFont, 11, 1205);
  forwardFirstMonth = new Button ( 1100, 935, 50, 30, "->>", buttonColor, smallFont, 7, 1105);
  forwardSecondMonth = new Button ( 1500, 935, 50, 30, "->>", buttonColor, smallFont, 12, 1505);
  backwardFirstMonth = new Button ( 750, 935, 50, 30, "<<-", buttonColor, smallFont, 8, 755);
  backwardSecondMonth = new Button ( 1150, 935, 50, 30, "<<-", buttonColor, smallFont, 13, 1155);


// Arshad 
  pause = new Button (1570, 510, 250, 50, "Pause", buttonColor, mainFont, 1, 1575);
  forwardOneDay = new Button (1570, 590, 250, 50," Next Day ", buttonColor, mainFont, 2, 1575); 
  backwardOneDay = new Button (1570, 670, 250, 50, " Previous Day", buttonColor, mainFont, 3, 1575);
  forwardOneWeek = new Button (1570, 750, 250, 50, "Next Week", buttonColor, mainFont, 4, 1575);
  backwardOneWeek = new Button (1570, 830, 250, 50," Previous Week ", buttonColor, mainFont, 5, 1575); 
  speedUp = new Button (1570, 670, 250, 50, " Speed Up", buttonColor, mainFont, 6, 1575);
  slowDown = new Button (1570, 670, 250, 50, " Slow Down", buttonColor, mainFont, 7, 1575);

  homeScreen.addButton(headlineFigures); 
  homeScreen.addButton(statisticsAndGraphs); 
  homeScreen.addButton(worldMapButton);
  homeScreen.addButton(timelineCasesButton);
  homeScreen.addButton(covidUSMapButton);//change if using 
  homeScreen.addButton(dataTableButton);//change if using 
  homeScreen.addButton(treeMapButton);//change if using
  homeScreen.addButton(lineChartButton);//change if using
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
  timelineCasesScreen = new  TimelineCasesScreen(myConnection, defaultBackground);
  timelineCasesScreen.addButton(returnButton);
  //extra screens
  covidUSMapScreen = new Screen(defaultBackground);
  covidUSMapScreen.addButton(returnButton);
  //Andrey 06/04/2021 12:25
  dataTableScreen = new CumulativeCasesScreen(myConnection, defaultBackground);
  dataTableScreen.addButton(returnButton);

  treeMapScreen = new Screen(defaultBackground);
  treeMapScreen.addButton(returnButton);
   treeMapScreen.addButton(pause);
  treeMapScreen.addButton(forwardOneDay);
  treeMapScreen.addButton(backwardOneDay);
  treeMapScreen.addButton(forwardOneWeek);
  treeMapScreen.addButton(backwardOneWeek);
  treeMapScreen.addButton(slowDown);
  treeMapScreen.addButton(speedUp);

  lineChartScreen = new Screen(defaultBackground);
  lineChartScreen.addButton(returnButton);
  lineChartScreen.addButton(forwardFirstCounty);
  lineChartScreen.addButton(forwardSecondCounty);
  lineChartScreen.addButton(backwardFirstCounty);
  lineChartScreen.addButton(backwardSecondCounty);
  lineChartScreen.addButton(forwardFirstDay);
  lineChartScreen.addButton(forwardSecondDay);
  lineChartScreen.addButton(backwardFirstDay);
  lineChartScreen.addButton(backwardSecondDay);
  lineChartScreen.addButton(forwardFirstMonth);
  lineChartScreen.addButton(forwardSecondMonth);
  lineChartScreen.addButton(backwardFirstMonth);
  lineChartScreen.addButton(backwardSecondMonth);
}

//Zemyna 07/04/2021 16:20
void drawHeadlineFiguresScreen()
{
  //header
  stroke(57, 57, 57);
  textFont(header);
  fill(193, 193, 193);
  rect(70, 70, 1470, 103);
  fill(209, 209, 209);
  rect(80, 80, 1450, 83);
  fill(46, 46, 46);
  textSize(78);
  text("Headline Figures", 100, 150);

  fill(193, 193, 193);
  rect(120, 270, 700, 3);
  rect(70, 200, 1775, 789);
  fill(107, 108, 147);
  rect(80, 210, 1755, 769);
  fill(193, 193, 193);
  rect(90, 220, 857.5, 364.5);
  rect(967.5, 220, 857.5, 364.5);
  rect(90, 604.5, 857.5, 364.5);
  rect(967.5, 604.5, 857.5, 364.5);
  fill(107, 108, 147);
  rect(100, 230, 837.5, 344.5);
  rect(977.5, 230, 837.5, 344.5);
  rect(100, 614.5, 837.5, 344.5);
  rect(977.5, 614.5, 837.5, 344.5);
  //text
  fill(237, 237, 237);
  textSize(46);
  text("Total Confirmed Cases in the US", 180, 280);
  text("Total Confirmed Cases in Washington DC", 120, 670);
  text("Total Confirmed Cases in California", 1030, 280);
  text("Last Updated:", 1250, 670);
  fill(193, 193, 193);
  rect(120, 300, 780, 3);
  rect(120, 700, 780, 3);
  rect(1000, 700, 780, 3);
  rect(1000, 300, 780, 3);
  //Zemyna 13/04/2021 09:45
  int totalCases = getTotalUSCases();
  String formattedTotalCases = String.format("%,d", totalCases);
  String myQuery = "SELECT date, cases FROM covidData WHERE county = 'Maryland' AND area = 'Washington'";
  Table myTable = myConnection.runQuery(myQuery);
  int totalWashington = getCases(myTable);
  String formattedWashington = String.format("%,d", totalWashington);
  String myCaliQuery = "SELECT area, SUM(cases) AS cases FROM covidData WHERE county = 'California' GROUP BY 1 ORDER BY 1 ASC";
  Table myCaliTable = myConnection.runQuery(myCaliQuery);
  int totalCali = getCases(myCaliTable); 
  String formattedCali = String.format("%,d", totalCali);
  textSize(78);
  fill(237, 237, 237);
  text(formattedTotalCases, 340, 450);
  text(formattedWashington, 400, 850);
  text(formattedCali, 1250, 450);
  text("2020-04-28", 1210, 850);
}

//Zemyna 13/04/2021
int getTotalUSCases()
{
  int totalCases=0;
  for (int i=0; i<STATES.length; i++)
  {
    String currentState = STATES[i];
    String myQuery = "SELECT area, SUM(cases) AS cases FROM covidData WHERE county = '" + currentState + "' GROUP BY 1 ORDER BY 1 ASC";
    Table myTable = myConnection.runQuery(myQuery);
    int stateCases = getCases(myTable);
    totalCases+=stateCases;
  }
  return totalCases;
}

int getCases(Table table)
{
  int totalCases=0;
  for (int i=0; i<table.getRowCount(); i++)
  {
    totalCases+=int(table.getString(i, 1));
  }
  return totalCases;
}
