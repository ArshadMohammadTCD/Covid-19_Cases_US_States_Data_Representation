// Arshad 15/04/2021 //<>// //<>//
import squarify.library.*;
import java.util.Arrays;
import java.util.ArrayList;
PFont stdFont;
Squarify[] treeMap;
TreeMapData[] treeMapDataSet;


// Here I just initialise the key variables
// Arshad 02/04/21 19:49
final int NUMBER_OF_STATES = STATES.length;
final int SIZE_OF_TREE_MAP = 10;       
final int DAYS_SINCE_COVID = 365;
final int SPEED_OF_DAY_CYCLE_IN_SECONDS = 1;
final int SPEED_OF_TREEMAP = 10;
int WORKING_DATES = 95;
int day = 1;
boolean isPaused = true;

// SQUARIFY DATA

class TreeMap {
  // I just initialise the key replicated variables for each
  // The rects list will contain geometry for each rectangle to draw
  ArrayList<SquarifyRect> rects; 
  // Arshad Thu 25th March 13:24
  float[] previousX, previousY, previousDx, previousDy;
  float[] caseNumber;
  String[] states;
  String[] stateNames; 
  float x = 890, y = 595, dy, dx;
  Button moveForward;
  int currentTreeMap, time;
  ArrayList<Float> values;
  int xM = 0, yM = 0;
  boolean isWhite = false;

  TreeMap()
  {
    // Arshad 02/04/21 Just Setting it up so that it works well with the data provided I have also altered the code so that it works in a OOP fashion
    //Initialise Floating Values to Data Set.
    smooth();
    // initialising variables to be assigned for each object.
    caseNumber = new float[SIZE_OF_TREE_MAP];
    treeMap = new Squarify[WORKING_DATES];
    treeMapDataSet = new TreeMapData[WORKING_DATES];
    previousX = new float[NUMBER_OF_STATES];
    previousY = new float[NUMBER_OF_STATES];
    previousDx = new float[NUMBER_OF_STATES];
    previousDy = new float[NUMBER_OF_STATES];
    states = new String[10];

    // Passing in Parameters into the recursive constructor in the library. (It takes in as many caseNumbers as specified)
    values = new ArrayList<Float>(Arrays.asList(caseNumber[0], caseNumber[1], caseNumber[2], caseNumber[3], caseNumber[4], caseNumber[5], caseNumber[6], caseNumber[7], caseNumber[8], caseNumber[9] )); // Values defining the squarified layout
    init_treeMap(treeMap, treeMapDataSet);
  }
  void draw() {
    // Code for the border.
    // Zemyna's border copy pasted
    stroke(57, 57, 57);
    fill(193, 193, 193);
    rect(240, 200, 1300, 789);
    stroke(57, 57, 57);
    fill(107, 108, 147);
    rect(250, 210, 1280, 769);
    tint(255, 255, 255);


    //This is timing system I built - Arshad Thu 25th March 17:45
   
    time++;
    if (day < WORKING_DATES) {
      if (time%(SPEED_OF_DAY_CYCLE_IN_SECONDS*50) == 0 && day < WORKING_DATES-1 && isPaused == false) {
        day++; 
       }
    }

    x = 1530;
    y = 979;
    rects = treeMap[day].getRects();
    for (int i = 0; i < rects.size(); i++) {

      
      // Arshad I made this work around and move the rectangles around Thu 25th March 17:30
      SquarifyRect r = rects.get(i);
      if (r.getValue() == 0) {
        noStroke();
      } else {
        stroke(57, 57, 57);
        fill(255, 255, 255);
        if (r.getValue() > 0) {
          fill(242, 229, 255);
        }
        if (r.getValue() > 5) {
          fill(230, 212, 247);
        }
        if (r.getValue() > 10) {
          fill(213, 189, 237);
        }
        if (r.getValue() > 20) {
          fill(198, 169, 227);
        }
        if (r.getValue() > 50) {
          fill(183, 151, 216);
        }
        if (r.getValue() > 100) {
          fill(166, 129, 203);
        }
        if (r.getValue() > 200) {
          fill(152, 111, 193);
        }
        if (r.getValue() > 500) {
          fill(139, 96, 183);
        }
        if (r.getValue() > 1000) {
          fill(128, 81, 175);
          isWhite = true;
        }
        if (r.getValue() > 10000) {
          fill(117, 70, 165);
        }
        if (r.getValue() > 50000) {
          fill(103, 57, 149);
        }
        if (r.getValue() > 100000) {
          fill(48, 18, 90);
        }
        if (previousX[i]+11 > r.getX() && previousX[i]-11 < r.getX())
        {
          x = r.getX();
        } else if (previousX[i] < r.getX())
        {
          x = previousX[i]+SPEED_OF_TREEMAP;
        } else if (previousX[i] > r.getX())
        {
          x = previousX[i]-SPEED_OF_TREEMAP;
        }
        if (previousY[i]+11 > r.getY() && previousY[i]-11 < r.getY())
        { 
          y = r.getY();
        } else if (previousY[i] < r.getY())
        {
          y = previousY[i]+SPEED_OF_TREEMAP;
        } else if (previousY[i] > r.getY())
        {
          y = previousY[i]-SPEED_OF_TREEMAP;
        }

        if (previousDy[i]+11 > r.getDy() && previousDy[i]-11 < r.getDy())
        {
          dy = r.getDy();
        } else if (previousDy[i] < r.getDy())
        {
          dy = previousDy[i]+SPEED_OF_TREEMAP;
        } else if (previousDy[i] > r.getDy())
        {
          dy = previousDy[i]-SPEED_OF_TREEMAP;
        }
        if (previousDx[i]+11 > r.getDx() && previousDx[i]-11 < r.getDx())
        {
          dx = r.getDx();
        } else if (previousDx[i] < r.getDx())
        {
          dx = previousDx[i]+SPEED_OF_TREEMAP;
        } else if (previousDx[i] > r.getDx())
        {
          dx = previousDx[i]-SPEED_OF_TREEMAP;
        }

        rect(x, y, dx, dy);
        previousX[i] = x;
        previousY[i] = y;
        previousDx[i] = dx;
        previousDy[i] = dy;
      }

      // Draw rectangle value
      // This is just default for now im gonna have to change this to countries

      textAlign(CENTER, CENTER);

      if (dx < 1600/2)
      {
        textFont(smallFont);
      } 
      else
      {
        textFont(mainFont);
      }
      if (r.getValue() > 50000){
        fill(255); 
      }
      else{
       fill(0); 
      }
      if (r.getValue() != 0)
      {
        text("State: "+ treeMapDataSet[day].stateNames[i], x + dx/2, y + dy/2);
        text("Covid Cases: " + (int)(r.getValue()), x + dx/2, y + (dy/2) + 20);
      }
      textAlign(0);
    }
    noStroke();

    // 17/04/2021 - Arshad
    stroke(57, 57, 57);
    textFont(header);
    fill(193, 193, 193);
    rect(70, 70, 1470, 103);
    fill(209, 209, 209);
    rect(80, 80, 1450, 83);
    fill(46, 46, 46);
    textSize(78);
    text("Tree Map Visualisation", 100, 150);
    fill(193, 193, 193);
    rect(70, 200, 170, 789);
    fill(107, 108, 147);
    rect(80, 210, 150, 769);

    // 17/04/2021 - Arshad
    stroke(57, 57, 57);
    fill(242, 229, 255);
    rect(90, 220, 130, 30);
    fill(230, 212, 247);
    rect(90, 290, 130, 30);
    fill(213, 189, 237);
    rect(90, 360, 130, 30);
    fill(198, 169, 227);
    rect(90, 430, 130, 30);
    fill(183, 151, 216);
    rect(90, 500, 130, 30);
    fill(166, 129, 203);
    rect(90, 570, 130, 30);
    fill(152, 111, 193);
    rect(90, 640, 130, 30);
    fill(139, 96, 183);
    rect(90, 710, 130, 30);
    fill(128, 81, 175);
    rect(90, 780, 130, 30);
    fill(117, 70, 165);
    rect(90, 850, 130, 30);
    fill(48, 18, 90);
    rect(90, 920, 130, 30);
    fill(193, 193, 193);
    textSize(18);
        // 17/04/2021 - Arshad
    text("0+", 140, 270);
    text("5+", 140, 340);
    text("10+", 135, 410);
    text("50+", 135, 480);
    text("100+", 130, 550);
    text("200+", 130, 620);
    text("500+", 130, 690);
    text("1000+", 125, 760);
    text("10000+", 120, 830);
    text("50000+", 120, 900);
    text("100000+", 115, 970);

    textFont(largeFont);
    fill(193, 193, 193);
    rect(1540, 200, 305, 789);
    rect(1540, 200, 305, 100);
    fill(107, 108, 147);
    rect(1550, 210, 285, 80);
    rect(1550, 310, 285, 669);
    fill(237, 237, 237);
    textSize(36);

    // 17/04/2021 - Arshad
    text("DATE " + treeMapDataSet[day].date, 1570, 260);
    fill(237, 237, 237);
    rect(1570, 270, 250, 3);
    rect(1570, 330, 250, 3);
    textSize(24);
    text("This tree map takes the", 1570, 360);
    text("top 10 US states ordered", 1570, 390);
    text("by covid cases. The tree", 1570, 420);
    text("map starts from 20th of ", 1570, 450);
    text("January to April 27th", 1570, 480);
    rect(1570, 490, 250, 3);
    
    
    
        // 20/04/2021 - Arshad
    // The buttons below are actually an overlay. So imagine rectangles on top of another pre-existing button which highlight when hovered
    if (mouseX > 1570 && mouseX < 1570+250 && mouseY > 510 && mouseY < 510 + 50 )
    {
      fill(128, 81, 175);
    }
    rect(1570, 510, 250, 50); // Pause Button
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Pause/Play Visuals",1570+ 250/2, 510+50/2); 
  
    fill(255);
    if (mouseX > 1570 && mouseX < 1570+250 && mouseY > 590 && mouseY < 590 + 50 )
    {
      fill(128, 81, 175);
    }
    
    rect(1570, 590, 250, 50); // Next day button
    fill(0);
    text("Next Day",1570+ 250/2, 590+50/2); 
    
    fill(255);
    if (mouseX > 1570 && mouseX < 1570+250 && mouseY > 670 && mouseY < 670 + 50 )
    {
      fill(128, 81, 175);
    }
   
    rect(1570, 670, 250, 50); // Previous Day Button
    fill(0);
    text("Previous Day",1570+ 250/2, 670+50/2);
    
    fill(255);
     if (mouseX > 1570 && mouseX < 1570+250 && mouseY > 750 && mouseY < 750 + 50 )
    {
      fill(128, 81, 175);
    }
    
    rect(1570, 750, 250, 50); // Next Week Button
    fill(0);
    text("Next Week",1570+ 250/2, 750+50/2); 
    fill(255); // without highlight color
    
    if (mouseX > 1570 && mouseX < 1570+250 && mouseY > 830 && mouseY < 830 + 50 )
    {
      fill(128, 81, 175);
    }
    
    rect(1570, 830, 250, 50); // Previous Week button
    fill(0);
    text("Previous Week",1570+ 250/2, 830+50/2); 
    fill(255); // without highlight color
    
    
    textAlign(0);
    
  }


  // Arshad initializing treeMap Thu 25th March 13:24
  // So What this does is that it loops through for every date making a new SQL Query which fetches data into the table
  // I then use loops to assign those data into Arrays and
  // whilst looping I assign data into parallel object arrays. 
  // This is so I can call back to the data later in the draw function
  void init_treeMap(Squarify theArray[], TreeMapData theData[])
  {
    String date = "";
    int workingMonth = 1;
    int workingDays = 20;
    for (int i = 1; i<theArray.length; i++)
    {  
      workingDays++;
      String query1 = ""; 
      if ((workingDays == 31 && workingMonth == 1) || (workingDays == 28 && workingMonth == 2) || (workingDays == 31 && workingMonth == 3) || (workingDays == 30 && workingMonth == 4))
      {
        workingMonth++; 
        workingDays = 1;
      } 
      if (workingDays < 10)
      {
        String a = "SELECT county,SUM(cases) AS cases FROM covidData WHERE  date = '2020-0"+workingMonth+"-0"+workingDays+"' GROUP BY 1 ORDER BY cases DESC";
        date = "2020-0"+workingMonth+"-0"+workingDays+"";
        query1 = a;
      } else
      {
        String a = "SELECT county,SUM(cases) AS cases FROM covidData WHERE  date = '2020-0"+workingMonth+"-"+workingDays+"' GROUP BY 1 ORDER BY cases DESC";
        query1 = a;
        date = "2020-0"+workingMonth+"-"+workingDays+"";
      }

      DataSource arshadsData1 = new DataSource(myConnection, query1);
      println(i);
      stateNames = new String[SIZE_OF_TREE_MAP];
      int k = SIZE_OF_TREE_MAP;
      if (arshadsData1.table.getRowCount() < SIZE_OF_TREE_MAP) {
        k = arshadsData1.table.getRowCount();
      }

      for (int j = 0; j < k; j++)
      {

        float b = arshadsData1.table.getFloat(j, 1);
        stateNames[j] = arshadsData1.table.getString(j, 0);

        values.set(j, b);
      }
      theArray[i] = new Squarify(values, 250, 210, 1280, 769);
      theData[i] = new TreeMapData(stateNames, date);
    }
  }


  void sortCases(float theArray[], String theArray2[], Table table)
  {

    for (int i = 0; i<theArray.length; i++)
    {

      theArray[i] = table.getFloat(i, 1);
      theArray2[i] = table.getString(i, 0);
      println("Setting values "+theArray[i]);
    }
  }
}
