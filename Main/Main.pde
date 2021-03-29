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


// Joe 25/03/21 10:20 : Values I made just for creating the tables of info on the screen, delete later
String recentQuery;
Table recentSamples;
int counter;
int stateIndex;

//Andrey 24/03/2021 16:00
import samuelal.squelized.*;
Table table;
SQLConnection myConnection;

void setup() {
  //Zemyna 23/03/2021 20:15
  size(1920, 1080);
  mainFont = loadFont("ProcessingSansPro-Regular-26.vlw");
  smallFont = loadFont("ProcessingSansPro-Regular-18.vlw");
  defaultBackground = loadImage("Default Screen1.png");  
  setupScreens();
  currentScreen=homeScreen;

  //Andrey 24/03/2021  16:00

  // Using a stringBuilder in order to effisciently forms strings for queries
  StringBuilder stringBuilder = new StringBuilder(16000);
  myConnection = new SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\sqlite\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\Users\\jdaha\\sqlite\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\sqlite3\\covid_data.db");
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
  stateIndex = 1;
}

void draw() {
  currentScreen.draw();
  // Joe 25/03/21 10:20
  if (currentScreen == statsGraphsScreen) {
    drawTable(recentSamples);
    counter++;
  }
  else {
    counter = 0;
    stateIndex = 0;
  }
}

void mousePressed() {
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
  unusedButton = new Button(480, 600, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using
  unusedButton2 = new Button(480, 675, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using
  unusedButton3 = new Button(480, 750, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using
  unusedButton4 = new Button(480, 825, 960, 50, "//Unused", buttonColor, mainFont, EVENT_FREE_1, 910);//change label if using
  homeScreen.addButton(headlineFigures); 
  homeScreen.addButton(statisticsAndGraphs); 
  homeScreen.addButton(worldMap);
  homeScreen.addButton(liveUpdates);
  homeScreen.addButton(unusedButton);//change if using 
  homeScreen.addButton(unusedButton2);//change if using 
  homeScreen.addButton(unusedButton3);//change if using
  homeScreen.addButton(unusedButton4);//change if using
  //Headline Figures
  headlineFiguresScreen = new Screen(defaultBackground);
  returnButton = new Button(50, 50, 80, 30, "← Home", buttonColor, smallFont, EVENT_BACK_TO_HOME, 60);
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
}
