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
Button unusedButton2; //free button
Button unusedButton3; //free button
Button unusedButton4; //free button
Screen headlineFiguresScreen;
Button returnButton;
Screen statsGraphsScreen;
Screen worldMapScreen;
Screen liveUpdatesScreen;
Screen covidUSMapScreen;
Screen unused2;
Screen unused3;
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
Button forwardDate;
Button backwardDate;

//Andrey 24/03/2021 16:00
import samuelal.squelized.*;
Table table;
SQLConnection myConnection;

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
  StringBuilder stringBuilder = new StringBuilder(16000);
  //myConnection = new SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\sqlite\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\Users\\jdaha\\sqlite\\covid_data.db");
  myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\sqlite3\\covid_data.db");
  // Arshad    myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\Users\\jdaha\\sqlite\\covid_data.db");

  // Forming strings to delete previous table if it previously existed and creating new one if it had not existed previously
  String dropTable = "DROP TABLE IF EXISTS covidData";
  String createNewTable = "CREATE TABLE IF NOT EXISTS covidData(date DATE NOT NULL,area TEXT (100) NOT NULL,county TEXT (100) NOT NULL,geoid INTEGER,cases  INTEGER,country TEXT (100));";

  // Passing those queries to the database
  myConnection.updateQuery(dropTable);
  myConnection.updateQuery(createNewTable);

  // Loading lines from csv file and seperating into variables for their specific columns using .split()
  String[] lines = loadStrings("cases-97k.csv");
  String date[] = new String[lines.length];
  String[] area = new String[lines.length];
  String[] county = new String[lines.length];
  String[] geoid = new String[lines.length];
  String[] cases = new String[lines.length];
  String[] country = new String[lines.length];
  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    String string = lines[i];
    String[] splitString = string.split(",", -1);
    date[i] = splitString[0];
    area[i] = splitString[1];
    county[i] = splitString[2];
    geoid[i] = splitString[3];
    cases[i] = splitString[4];
    country[i]= splitString[5];
  }

  // For loop that goes through each row of data and forms a query using stringBuilder class and variables of data
  stringBuilder.append("INSERT INTO covidData(date,area,county,geoid,cases,country) VALUES");
  for (int k = 1; k<lines.length; k++) {
    stringBuilder.append("(");
    stringBuilder.append('"');
    stringBuilder.append(date[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(area[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(county[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(geoid[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(cases[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(country[k]);
    stringBuilder.append("\")");
    //Print for testing purposes(Can be removed)
    if (k % 3000 == 0) {
      println(k);
    }
    // Joins each line  except last line of string together using commas so it registers as one long query
    if (k != lines.length-1) {
      stringBuilder.append(",");
    }
  }
  // Sends that query to database
  myConnection.updateQuery(stringBuilder.toString());
  print("done");

  // Andrey 25/03/2021 #17:56
  // Deleting previous and creating Index to make query's more effective
  String deleteIndex = "DROP INDEX IF EXISTS county_id";
  String createIndex = "CREATE INDEX IF NOT EXISTS county_id ON covidData(county);";
  myConnection.updateQuery(deleteIndex);
  myConnection.updateQuery(createIndex);


  // Code with several examples of how to form queries for data, Look at sqlite tutorial site from important links for more commands and examples
  // String query = "SELECT * FROM covidData WHERE county = 'Wyoming'";
  //int time1 = millis();
  //Table testTable = myConnection.runQuery(query);
  // int time2 = millis();
  //printTable(testTable);
  // System.out.println(time2-time1);
  String query2 = "SELECT area,county,cases FROM covidData WHERE date = DATE('2021-02-20') AND area LIKE '%Virginia%'";  
  String query = "SELECT county, SUM(cases) AS SUM, AVG(cases) AS AVG FROM covidData WHERE date = DATE('2021-02-20') GROUP BY county ORDER BY SUM DESC LIMIT 10";
  String query3 = "SELECT * FROM covidData WHERE county = 'Wyoming'";
  int time1 = millis();
  myConnection.runQuery(query3);
  int time2 = millis();

  // printTable(testTable2);
  System.out.println(time2-time1);

  // Joe : Code for the tables of data, delete later
  recentQuery = "SELECT date,area,cases FROM covidData WHERE date = '28/04/2020' AND county = 'Alabama'";
  recentSamples = myConnection.runQuery(recentQuery);
  counter = 0;
  stateIndex = 0;
  dateIndex = 0;
  theBars = new ArrayList();
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
   if(currentScreen==covidUSMapScreen)
   {
     USmap.draw();
     drawMapTabs();
     if(displayPopUp==true)
     {
       popUpStatsTable();
     }
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
  else if ( currentScreen == headlineFiguresScreen ) {
    switch(event)
    {
      case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }
  else if ( currentScreen == statsGraphsScreen ) {
    switch(event)
    {
      case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      emptyArray(theBars);
      stateIndex = 0;
      break;
      case 1:
      emptyArray(theBars);
      stateIndex++;
      createChart();
      break;
      case 2:
      emptyArray(theBars);
      stateIndex--;
      createChart();
      break;
    }
  }
  else if ( currentScreen == worldMapScreen ) {
    switch(event) 
    {
      case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }
  else if ( currentScreen == liveUpdatesScreen ) {
    switch(event)
    {
      case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }
  else if ( currentScreen == covidUSMapScreen ) {
    switch(event)
    {
      case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }
  else if ( currentScreen == unused2 ) {
    switch(event)
    {
      case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }
  else if ( currentScreen == unused3 ) {
    switch(event)
    {
      case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    }
  }
  
  String stateEvent = USmap.getMapEvent();//Zemyna 01/04/2021 05:35
  if(currentScreen==covidUSMapScreen)
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
  //Zemyna 01/04/2021 05:37
  if(currentScreen==covidUSMapScreen)
  {
    for(int i=0; i<USmap.statesList.size(); i++)
    {
      State currentState = (State) USmap.statesList.get(i);
        if ((mouseX > currentState.xT) && (mouseX < currentState.xT+ currentState.width) && 
        (mouseY > currentState.yT) && (mouseY < currentState.yT+ currentState.height))
        {
          currentState.hover = true;
        }
        else
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

void createBar(float population, int xpos, float mappedWidth) {
  // Joe 30/03/21 00:50
  theBars.add( new Bar( population, (xpos), mappedWidth));
}

void drawBars() {
  // Joe 30/03/21 00:50
  for ( int i = 0; i < theBars.size(); i++ ) {
    theBars.get(i).draw();
  }
}

void createChart() {
  // Joe 30/03/21 00:50
  String caseQuery = "SELECT cases FROM covidData WHERE county = '" + STATES[stateIndex] + "' AND date = '28/04/2020'";
  table = myConnection.runQuery(caseQuery);
  int xpos = 50;
  int mapRange = findMaxValue(table);
  float mapWidth = 1720/table.getRowCount();
  for (TableRow row : table.rows())
  {
    for (int i = 0; i < row.getColumnCount(); i++)
    {
      String caseString = row.getString(i);
      float measureBar = map(Integer.parseInt(caseString), 0, mapRange, 0, 600);
      createBar(measureBar, xpos, mapWidth);
    }
    xpos+=mapWidth;
  }
}

void drawChart() {
  // Joe 30/03/21 00:50
  stroke(0);
  fill(255);
  rect(35, 125, 1785, 775);
  fill(0);
  drawBars();
  fill(0);
  line(50, 150, 50, 850);
  line(50, 850, 1770, 850);
  text(STATES[stateIndex], 490, 950);
}

int findMaxValue(Table table ) {
  // Joe 30/03/21 00:50
  int maxValue = 0;
  for (TableRow row : table.rows()) {
    for ( int i = 0; i < row.getColumnCount(); i++ ) {
      String stringToCheck = row.getString(i);
      if ( Integer.parseInt(stringToCheck) > maxValue ) {
        maxValue = Integer.parseInt(stringToCheck);
      }
    }
  }
  return maxValue;
}

void emptyArray ( ArrayList<Bar> theBars ) {
  // Joe 30/03/21 00:50
  for ( int i = theBars.size() - 1; i >= 0; i--) {
    theBars.remove(i);
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
  worldMap = new Button(480, 450, 960, 50, "World Map", buttonColor, mainFont, EVENT_WORLD_MAP, 901);
  liveUpdates = new Button(480, 525, 960, 50, "Live Updates", buttonColor, mainFont, EVENT_LIVE_UPDATES, 889);
  covidUSMapButton = new Button(480, 600, 960, 50, "Covid-19 Cases in the US: Map", buttonColor, mainFont, EVENT_FREE_1, 790);//change label if using
  unusedButton2 = new Button(480, 675, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using
  unusedButton3 = new Button(480, 750, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using
  unusedButton4 = new Button(480, 825, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using
  
  // Joe 30/03/21 00:50
  forwardCounty = new Button ( 650, 950, 30, 30, "->", buttonColor, smallFont, 1, 910);
  backwardCounty = new Button ( 450, 950, 30, 30, "<-", buttonColor, smallFont, 2, 910);
  //forwardDate = new Button ( 1050, 950, 30, 30, "->", buttonColor, smallFont, 3, 910);
  //backwardDate = new Button ( 850, 950, 30, 30, "<-", buttonColor, smallFont, 4, 910);

  homeScreen.addButton(headlineFigures); 
  homeScreen.addButton(statisticsAndGraphs); 
  homeScreen.addButton(worldMap);
  homeScreen.addButton(liveUpdates);
  homeScreen.addButton(covidUSMapButton);//change if using 
  homeScreen.addButton(unusedButton2);//change if using 
  homeScreen.addButton(unusedButton3);//change if using
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
  //statsGraphsScreen.addButton(forwardDate);
  //statsGraphsScreen.addButton(backwardDate);
  
  //World Map Screen
  worldMapScreen = new Screen(defaultBackground);
  worldMapScreen.addButton(returnButton);
  //Live Updates
  liveUpdatesScreen = new Screen(defaultBackground);
  liveUpdatesScreen.addButton(returnButton);
  //extra screens
  covidUSMapScreen = new Screen(defaultBackground);
  covidUSMapScreen.addButton(returnButton);
  unused2 = new Screen(defaultBackground);
  unused2.addButton(returnButton);
  unused3 = new Screen(defaultBackground);
  unused3.addButton(returnButton);
  unused4 = new Screen(defaultBackground);
  unused4.addButton(returnButton);
}

//Zemyna 01/04/2021 05:39
State Alabama, Alaska, Arizona, Arkansas, California, Colorado, Connecticut, Delaware, Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, 
Kansas, Kentucky, Louisiana, Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana, Nebraska, Nevada, NewHampshire, 
NewJersey, NewMexico, NewYork, NorthCarolina, NorthDakota, Ohio, Oklahoma, Oregon, Pennsylvania, RhodeIsland, SouthCarolina, SouthDakota, Tennessee, 
Texas, Utah, Vermont, Virginia, Washington, WestVirginia, Wisconsin, Wyoming; 
//Zemyna 01/04/2021 05:39
void setupStates()
{
  Alabama = new State(loadImage("Alabama.png"),1060,715,70,20,STATES[0]);USmap.addState(Alabama);
  Alaska = new State(loadImage("Alaska.png"),370,830,70,20,STATES[1]);USmap.addState(Alaska);
  Arizona = new State(loadImage("Arizona.png"),470,662,70,20,STATES[2]); USmap.addState(Arizona);
  Arkansas = new State(loadImage("Arkansas.png"),920,662,80,20,STATES[3]); USmap.addState(Arkansas);
  California = new State(loadImage("California.png"),320,580,80,20,STATES[4]);USmap.addState(California);
  Colorado = new State(loadImage("Colorado.png"),625,555,80,20,STATES[5]);USmap.addState(Colorado);
  Connecticut = new State(loadImage("Connecticut.png"),1420,485,100,20,STATES[6]);USmap.addState(Connecticut);
  Delaware = new State(loadImage("Delaware.png"),1425,555,90,20,STATES[7]);USmap.addState(Delaware);
  Florida = new State(loadImage("Florida.png"),1200,860,90,20,STATES[8]);USmap.addState(Florida);
  Georgia = new State(loadImage("Georgia.png"),1140,725,90,20,STATES[9]);USmap.addState(Georgia);
  Hawaii = new State(loadImage("Hawaii.png"),570,900,90,20,STATES[10]);USmap.addState(Hawaii);
  Idaho = new State(loadImage("Idaho.png"),460,410,90,20,STATES[11]);USmap.addState(Idaho);
  Illinois = new State(loadImage("Illinois.png"),980,530,80,20,STATES[12]);USmap.addState(Illinois);
  Indiana = new State(loadImage("Indiana.png"),1060,530,60,20,STATES[13]);USmap.addState(Indiana);
  Iowa = new State(loadImage("Iowa.png"),900,480,60,20,STATES[14]);USmap.addState(Iowa);
  Kansas = new State(loadImage("Kansas.png"),780,580,90,20,STATES[15]);USmap.addState(Kansas);
  Kentucky = new State(loadImage("Kentucky.png"),1065,600,90,20,STATES[16]);USmap.addState(Kentucky);
  Louisiana = new State(loadImage("Louisiana.png"),930,800,90,20,STATES[17]);USmap.addState(Louisiana);
  Maine = new State(loadImage("Maine.png"),1370,315,90,20,STATES[18]);USmap.addState(Maine);
  Maryland = new State(loadImage("Maryland.png"),1435,585,90,20,STATES[19]);USmap.addState(Maryland);
  Massachusetts = new State(loadImage("Massachusetts.png"),1170,315,130,20,STATES[20]);USmap.addState(Massachusetts);
  Michigan = new State(loadImage("Michigan.png"),1080,435,80,20,STATES[21]);USmap.addState(Michigan);
  Minnesota = new State(loadImage("Minnesota.png"),870,355,80,20,STATES[22]);USmap.addState(Minnesota);
  Mississippi = new State(loadImage("Mississippi.png"),980,730,90,20,STATES[23]);USmap.addState(Mississippi);
  Missouri = new State(loadImage("Missouri.png"),910,575,90,20,STATES[24]);USmap.addState(Missouri);
  Montana = new State(loadImage("Montana.png"),550,320,120,20,STATES[25]);USmap.addState(Montana);
  Nebraska = new State(loadImage("Nebraska.png"),730,485,120,20,STATES[26]);USmap.addState(Nebraska);
  Nevada = new State(loadImage("Nevada.png"),380,500,90,20,STATES[27]);USmap.addState(Nevada);
  NewHampshire = new State(loadImage("NewHampshire.png"),1170,250,130,20,STATES[28]);USmap.addState(NewHampshire);
  NewJersey = new State(loadImage("NewJersey.png"),1420,520,100,20,STATES[29]); USmap.addState(NewJersey);
  NewMexico = new State(loadImage("NewMexico.png"),580,680,120,20,STATES[30]); USmap.addState(NewMexico);
  NewYork = new State(loadImage("NewYork.png"),1240,420,90,20,STATES[31]); USmap.addState(NewYork);
  NorthCarolina = new State(loadImage("NorthCarolina.png"),1190,630,130,20,STATES[32]); USmap.addState(NorthCarolina);
  NorthDakota = new State(loadImage("NorthDakota.png"),720,330,130,20,STATES[33]); USmap.addState(NorthDakota);
  Ohio = new State(loadImage("Ohio.png"),1125,510,80,20,STATES[34]); USmap.addState(Ohio);
  Oklahoma = new State(loadImage("Oklahoma.png"),780,655,130,20,STATES[35]); USmap.addState(Oklahoma);
  Oregon = new State(loadImage("Oregon.png"),340,365,90,20,STATES[36]); USmap.addState(Oregon);
  Pennsylvania = new State(loadImage("Pennsylvania.png"),1210,475,120,20,STATES[37]); USmap.addState(Pennsylvania);
  RhodeIsland = new State(loadImage("RhodeIsland.png"),1410,455,115,20,STATES[38]); USmap.addState(RhodeIsland);
  SouthCarolina = new State(loadImage("SouthCarolina.png"),1195,665,90,40,STATES[39]); USmap.addState(SouthCarolina);
  SouthDakota = new State(loadImage("SouthDakota.png"),720,410,130,20,STATES[40]); USmap.addState(SouthDakota);
  Tennessee = new State(loadImage("Tennessee.png"),1035,640,130,20,STATES[41]); USmap.addState(Tennessee);
  Texas = new State(loadImage("Texas.png"),750,770,130,20,STATES[42]); USmap.addState(Texas);
  Utah = new State(loadImage("Utah.png"),490,530,80,20,STATES[43]); USmap.addState(Utah);
  Vermont = new State(loadImage("Vermont.png"),1200,280,100,20,STATES[44]); USmap.addState(Vermont);
  Virginia = new State(loadImage("Virginia.png"),1200,580,100,20,STATES[45]); USmap.addState(Virginia);
  Washington = new State(loadImage("Washington.png"),360,270,100,20,STATES[46]); USmap.addState(Washington);
  WestVirginia = new State(loadImage("WestVirginia.png"),1410,645,115,20,STATES[47]); USmap.addState(WestVirginia);
  Wisconsin = new State(loadImage("Wisconsin.png"),940,390,115,20,STATES[48]); USmap.addState(Wisconsin);
  Wyoming = new State(loadImage("Wyoming.png"),580,445,120,20,STATES[49]); USmap.addState(Wyoming);
}
//Zemyna 01/04/2021 05:39
void drawMapTabs()
{
  //header
  stroke(57,57,57);
  textFont(loadFont("ProcessingSansPro-Regular-78.vlw"));
  fill(193,193,193);
  rect(70,70,1470,103);
  fill(209,209,209);
  rect(80,80,1450,83);
  fill(46,46,46);
  textSize(78);
  text("Covid-19 Cases in the United States",100,150);
  //right ui tab
  textFont(largeFont);
  fill(193,193,193);
  rect(1540,200,305,789);
  rect(1540,200,305,100);
  fill(107,108,147);
  rect(1550,210,285,80);
  rect(1550,310,285,669);
  fill(237,237,237);
  textSize(36);
  text("Case Statistics", 1570, 260);
  fill(237,237,237);
  rect(1570,270,250,3);
  rect(1570,330,250,3);
  textSize(24);
  text("Hover over a state or", 1570,360);
  text("click on any state ",1570,390);
  text("name to see detailed",1570,420);
  text("statistics of Covid-19",1570,450);
  text("cases in that state.", 1570,480);
  rect(1570,490,250,3);
  //left key tab
  fill(193,193,193);
  rect(70,200,170,789);
  fill(107,108,147);
  rect(80,210,150,769);
  //keys
  stroke(57,57,57);
  fill(242,229,255);
  rect(90,220,130,30);
  fill(230,212,247);
  rect(90,290,130,30);
  fill(213,189,237);
  rect(90,360,130,30);
  fill(198,169,227);
  rect(90,430,130,30);
  fill(183,151,216);
  rect(90,500,130,30);
  fill(166,129,203);
  rect(90,570,130,30);
  fill(152,111,193);
  rect(90,640,130,30);
  fill(139,96,183);
  rect(90,710,130,30);
  fill(128,81,175);
  rect(90,780,130,30);
  fill(117,70,165);
  rect(90,850,130,30);
  fill(103,57,149);
  rect(90,920,130,30);
  fill(193,193,193);
  textSize(18);
  text("0+",140,270);
  text("1,000+",125,340);
  text("10,000+",120,410);
  text("100,000+",115,480);
  text("300,000+",115,550);
  text("500,000+",115,620);
  text("1,000,000+",110,690);
  text("1,500,000+",110,760);
  text("2,000,000+",110,830);
  text("2,500,000+",110,900);
  text("3,000,000+",110,970);
}
//Zemyna 01/04/2021 05:39
void popUpStatsTable()
{
  stroke(57,57,57);
  fill(193,193,193);
  rect(1570,510,250,450);
  fill(237,237,237);
  textFont(largeFont);
  textSize(24);
  text("State: ", 1580,550);
  text("Population: ",1580,620);
  text("Total Cases: ",1580,690);
  text("Cases per 1M: ",1580,760);
  text("Cases by  ",1580,830);
  text("percentage: ",1580,860);
  fill(250,250,250);
  text(currentState.title,1580,585);
  text(currentState.population,1580,655);
  text(currentState.totalCases,1580,725);
  text(currentState.cases1M,1580,795);
  text(currentState.percentageCases + "%",1580,895);
}
