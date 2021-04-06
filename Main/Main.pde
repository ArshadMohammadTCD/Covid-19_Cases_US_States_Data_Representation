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


//Andrey 06/04/2021 12:22
Checkbox checkbox0;
Checkbox checkbox1;
Checkbox checkbox2;
Checkbox checkbox3;
Checkbox checkbox4;
Checkbox checkbox5;
Button updateTable;

TextWidget textWidget1;
TextWidget textWidget2;
TextWidget textWidget3;
TextWidget textWidget4;
TextWidget textWidget5;
TextWidget textWidget6;
TextWidget focus;


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
  myConnection = new SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\sqlite\\covid_data.db");
  //myConnection = new SQLiteConnection("jdbc:sqlite:/C:\\Users\\jdaha\\sqlite\\covid_data.db");
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
  grid = new Grid(data.table, 50, 100, 600, 500);
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
    //background(232, 232, 152);
    grid.draw();
    textSize(20);
    text("Tick the columns you would like to include in the table \n and enter keywords in the respective fields if you want to limit a column to a specific result", 800, 100);
    currentScreen.drawCheckbox();
    currentScreen.drawTextWidget();
  }
  // Arshad 02/04/2021 22:54
  if (currentScreen == treeMapScreen) {


    treeMap1.draw();
  }
}
//Andrey 01/04/2021 14:34
void keyReleased() {
  println(key);
  String result = grid.keyProcess(keyCode, key);
  if (!result.equals("")) {
    println(result);
  }

if(mousePressed == false){
 if(keyCode != 38 && keyCode != 40 && keyCode != 27 && keyCode != 16){
   focus.append(key);
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

int textWidgetEvent = currentScreen.getTextWidgetEvent(); 
    switch(textWidgetEvent) {
    case EVENT_TEXTWIDGET_1:
      focus = (TextWidget)textWidget1;
      break; 
    case EVENT_TEXTWIDGET_2:
      focus = (TextWidget)textWidget2;
      break; 
    case EVENT_TEXTWIDGET_3:
      focus = (TextWidget)textWidget3;
      break; 
    case EVENT_TEXTWIDGET_4:
      focus = (TextWidget)textWidget4;
      break; 
    case EVENT_TEXTWIDGET_5:
      focus = (TextWidget)textWidget5;
      break; 
    case EVENT_TEXTWIDGET_6:
      focus = (TextWidget)textWidget6;
      break; 
    default:
     
    }

String newQuery = "SELECT ";
    //Andrey 06/04/2021 13:27
    int checkboxEvent = currentScreen.getCheckboxEvent();
    switch(checkboxEvent) {
    case EVENT_CHECKBOX_0:
      checkbox0.is_checked = !checkbox0.is_checked;
      break;
    case EVENT_CHECKBOX_1:
      checkbox1.is_checked = !checkbox1.is_checked;
      break;
    case EVENT_CHECKBOX_2:
      checkbox2.is_checked = !checkbox2.is_checked;
      break;
    case EVENT_CHECKBOX_3:
      checkbox3.is_checked = !checkbox3.is_checked;
      break;
    case EVENT_CHECKBOX_4:
      checkbox4.is_checked = !checkbox4.is_checked;
      break;
    case EVENT_CHECKBOX_5:
      checkbox5.is_checked = !checkbox5.is_checked;
      break;
    }

    switch(event){

    case EVENT_BACK_TO_HOME:
      currentScreen=homeScreen;
      break;
    case EVENT_UPDATE_TABLE:

      if (checkbox0.is_checked) {
        newQuery += "date";
        if (checkbox1.is_checked || checkbox2.is_checked || checkbox3.is_checked  || checkbox4.is_checked|| checkbox5.is_checked) {
          newQuery += ",";
        }
      }

      if (checkbox1.is_checked) {
        newQuery += "area";
        if (checkbox2.is_checked || checkbox3.is_checked || checkbox4.is_checked|| checkbox5.is_checked) {
          newQuery += ",";
        }
      }

      if (checkbox2.is_checked) {
        newQuery += "county";
        if (checkbox3.is_checked || checkbox4.is_checked || checkbox5.is_checked) {
          newQuery += ",";
        }
      }

      if (checkbox3.is_checked) {
        newQuery += "geoid";
        if (checkbox4.is_checked || checkbox5.is_checked ) {
          newQuery += ",";
        }
      }

      if (checkbox4.is_checked) {
        newQuery += "cases";
        if (checkbox5.is_checked) {
          newQuery += ",";
        }
      }

      if (checkbox5.is_checked) {
        newQuery += "country";
      }
      if(newQuery.equals("SELECT")){
      newQuery += " *";
    }
      newQuery += " FROM covidData WHERE ";

      if (!textWidget1.label.isEmpty()) {
        newQuery += "date = ";
        newQuery += "'";
        newQuery += textWidget1.label;
        newQuery += "'";
        if (!textWidget2.label.isEmpty() || !textWidget3.label.isEmpty() || !textWidget4.label.isEmpty()  || !textWidget5.label.isEmpty()|| !textWidget6.label.isEmpty()) {
          newQuery += " AND ";
        }
      }

      if (!textWidget2.label.isEmpty()) {
        newQuery += "area = ";
        newQuery += "'";
        newQuery += textWidget2.label;
        newQuery += "'";
        if (!textWidget3.label.isEmpty() || !textWidget4.label.isEmpty() || !textWidget5.label.isEmpty()|| !textWidget6.label.isEmpty()) {
          newQuery += "  AND ";
        }
      }
      if (!textWidget3.label.isEmpty()) {
        newQuery += " county = ";
        newQuery += "'";
        newQuery += textWidget3.label;
        newQuery += "'";
        if (!textWidget4.label.isEmpty() || !textWidget5.label.isEmpty() || !textWidget6.label.isEmpty()) {
          newQuery += "  AND ";
        }
      }
      if (!textWidget4.label.isEmpty()) {
        newQuery += "geoid = ";
        newQuery += textWidget4.label;
        if (!textWidget5.label.isEmpty()|| !textWidget6.label.isEmpty()) {
          newQuery += "  AND ";
        }
      }
      if (!textWidget5.label.isEmpty()) {
        newQuery += "cases = ";
        newQuery += textWidget5.label;
        if (!textWidget6.label.isEmpty()) {
          newQuery += " AND ";
        }
      }
      if (!textWidget6.label.isEmpty()) {
        newQuery += "country = ";
        newQuery += "'";
        newQuery += textWidget6.label;
        newQuery += "'";
      }

     
      checkbox0.is_checked = false;
      checkbox1.is_checked = false;
      checkbox2.is_checked = false;
      checkbox3.is_checked = false;
      checkbox4.is_checked = false;
      checkbox5.is_checked = false;
      break;
      default:
      newQuery += "* FROM covidData WHERE county = 'California'";
    }
    //Andrey 06/04/2021 16:21
    
     println(newQuery);
    DataSource data2 = new DataSource(myConnection, newQuery);
    newQuery = "";
    grid = new Grid(data2.table, 50, 100, 600, 500);
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
  //Andrey 06/04/2021 12:25
  dataTableScreen = new Screen(defaultBackground);
  dataTableScreen.addButton(returnButton);
  checkbox0 = new Checkbox(800, 150, 30, 30, "Date:", color(255), EVENT_CHECKBOX_0, -80);
  checkbox1 = new Checkbox(800, 200, 30, 30, "Area:", color(255), EVENT_CHECKBOX_1, -80);
  checkbox2 = new Checkbox(800, 250, 30, 30, "County:", color(255), EVENT_CHECKBOX_2, -80);
  checkbox3 = new Checkbox(800, 300, 30, 30, "Geo-id:", color(255), EVENT_CHECKBOX_3, -80);
  checkbox4 = new Checkbox(800, 350, 30, 30, "cases:", color(255), EVENT_CHECKBOX_4, -80);
  checkbox5 = new Checkbox(800, 400, 30, 30, "Country:", color(255), EVENT_CHECKBOX_5, -80);
  updateTable = new Button(800, 500, 150, 30, "Update Table", color(100), mainFont, EVENT_UPDATE_TABLE, 800);
  textWidget1 = new TextWidget(900, 150, 200, 30, "", color(255), EVENT_TEXTWIDGET_1, 20);
  textWidget2 = new TextWidget(900, 200, 200, 30, "Orange", color(255), EVENT_TEXTWIDGET_2, 20);
  textWidget3 = new TextWidget(900, 250, 200, 30, "", color(255), EVENT_TEXTWIDGET_3, 20);
  textWidget4 = new TextWidget(900, 300, 200, 30, "", color(255), EVENT_TEXTWIDGET_4, 20);
  textWidget5 = new TextWidget(900, 350, 200, 30, "", color(255), EVENT_TEXTWIDGET_5, 20);
  textWidget6 = new TextWidget(900, 400, 200, 30, "", color(255), EVENT_TEXTWIDGET_6, 20);
  dataTableScreen.addCheckbox(checkbox0);
  dataTableScreen.addCheckbox(checkbox1);
  dataTableScreen.addCheckbox(checkbox2);
  dataTableScreen.addCheckbox(checkbox3);
  dataTableScreen.addCheckbox(checkbox4);
  dataTableScreen.addCheckbox(checkbox5);
  dataTableScreen.addButton(updateTable);
  dataTableScreen.addTextWidget(textWidget1);
  dataTableScreen.addTextWidget(textWidget2);
  dataTableScreen.addTextWidget(textWidget3);
  dataTableScreen.addTextWidget(textWidget4);
  dataTableScreen.addTextWidget(textWidget5);
  dataTableScreen.addTextWidget(textWidget6);


  treeMapScreen = new Screen(defaultBackground);
  treeMapScreen.addButton(returnButton);

  unused4 = new Screen(defaultBackground);
  unused4.addButton(returnButton);
}
