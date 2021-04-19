 //<>//
import squarify.library.*;
import java.util.Arrays;
import java.util.ArrayList;
PFont stdFont;
Squarify[] treeMap;
// CONSTANTS
float CANVAS_WIDTH = 1000;    // The width of the canvas to fill
float CANVAS_HEIGHT = 1000;   // The height of the canvas to fill
float CANVAS_ORIGIN_X = 0;    // The x origin of the canvas to fill
float CANVAS_ORIGIN_Y = 0;    // The y origin of the canvas to fill
int day = 1;

// SQUARIFY DATA

class TreeMap {
  ArrayList<SquarifyRect> rects;  // The rects list will contain geometry for each rectangle to draw
  // Arshad Changing the values to suit the situation Thu 25th March 13:24
  float[] previousX, previousY, previousDx, previousDy;
  float[] caseNumber;
  String[] states;
  float x, y, dy, dx;
  int currentTreeMap, time;
  ArrayList<Float> values;
  TreeMap()
  {
    // Arshad 02/04/21 Just Setting it up so that it works well with the data provided I have also altered the code so that it works in a OOP fashion
    
    //Table topTen = myConnection.runQuery("SELECT  county, cases  FROM covidData WHERE date = 28/04/2020 ORDER BY  cases DESC LIMIT 10");
    //sortCases(caseNumber, topTen);
    
    

    
    //Initialise Floating Values to Data Set.
    smooth();
    caseNumber = new float[10];
    treeMap = new Squarify[29];
    previousX = new float[NUMBER_OF_STATES];
    previousY = new float[NUMBER_OF_STATES];
    previousDx = new float[NUMBER_OF_STATES];
    previousDy = new float[NUMBER_OF_STATES];
    states = new String[10];
    String query = "SELECT county,SUM(cases) AS cases FROM covidData WHERE  date = '2020-03-01' GROUP BY 1 ORDER BY cases DESC";
    //String query = "SELECT county,SUM(cases) AS cases FROM covidData GROUP BY 1 ORDER BY cases DESC";
    DataSource arshadsData = new DataSource(myConnection,query);
    sortCases(caseNumber, states,arshadsData.table);
    
    values = new ArrayList<Float>(Arrays.asList(caseNumber[0],caseNumber[1],caseNumber[2],caseNumber[3],caseNumber[4],caseNumber[5],caseNumber[6],caseNumber[7],caseNumber[8],caseNumber[9] )); // Values defining the squarified layout
    init_treeMap(treeMap);
    //stdFont=loadFont("Galvji-Bold-14.vlw");
  }
 

    //s[0] = new Squarify(values, CANVAS_ORIGIN_X, CANVAS_ORIGIN_Y, CANVAS_WIDTH, CANVAS_HEIGHT);
  

  void draw() {

    
    stroke(0,0,0);
    fill(100);
    rect(130, 70, 1660, 940);
    
    // This is timing system I built - Arshad Thu 25th March 17:45
    time++;
    if (time%(SPEED_OF_DAY_CYCLE_IN_SECONDS*50) == 0 && day < 30 ) {
      //currentTreeMap++; // This increments the day cycle
      day++;
      nextDay();
    }
    rects = treeMap[day].getRects();
    for (int i = 0; i < rects.size(); i++) {
      // Draw a rectangle
      // Arshad I made this work around and move the rectangles around Thu 25th March 17:30
      SquarifyRect r = rects.get(i);
      fill(255, 255, 255);
      float hashColor = (256-(map(r.getValue(), 0, 100000, 30, 230)));
      fill(0, hashColor ,0 ); // This will also need to change
      if (previousX[i]+20 > r.getX() && previousX[i]-20 < r.getX())
      {
        x = r.getX();
      } else if (previousX[i] < r.getX())
      {
        x = previousX[i]+5;
      } else if (previousX[i] > r.getX())
      {
        x = previousX[i]-5;
      }
      if (previousY[i]+20 > r.getY() && previousY[i]-20 < r.getY())
      {
        y = r.getY();
      } else if (previousY[i] < r.getY())
      {
        y = previousY[i]+5;
      } else if (previousY[i] > r.getY())
      {
        y = previousY[i]-5;
      }

      if (previousDy[i]+20 > r.getDy() && previousDy[i]-20 < r.getDy())
      {
        dy = r.getDy();
      } else if (previousDy[i] < r.getDy())
      {
        dy = previousDy[i]+5;
      } else if (previousDy[i] > r.getDy())
      {
        dy = previousDy[i]-5;
      }
      if (previousDx[i]+20 > r.getDx() && previousDx[i]-20 < r.getDx())
      {
        dx = r.getDx();
      } else if (previousDx[i] < r.getDx())
      {
        dx = previousDx[i]+5;
      } else if (previousDx[i] > r.getDx())
      {
        dx = previousDx[i]-5;
      }

      rect(x, y, dx, dy);
      previousX[i] = x;
      previousY[i] = y;
      previousDx[i] = dx;
      previousDy[i] = dy;
      // Draw rectangle value
      // This is just default for now im gonna have to change this to countries
      
      textAlign(CENTER, CENTER);
     // textFont(stdFont);
      if (hashColor < 90){
        fill(255);
        
      }
      else {
        fill(0);
      }
      
      text("Country: "+ states[i] , r.getX() + r.getDx()/2, r.getY() + r.getDy()/2);
      text("Covid Cases: " + r.getValue(), r.getX() + r.getDx()/2, r.getY() + (r.getDy()/2) + 20);
      textAlign(0);
    }
    noStroke();
    text("DAY: " + currentTreeMap, 100, 100);
  }
  // Added mousePressed funtion to increase the Day count)
  void mousePressed() 
  {
    currentTreeMap++;
  }
  // Arshad initializing treeMap Thu 25th March 13:24
  void init_treeMap(Squarify theArray[])
  {
    for (int i = 1; i<theArray.length; i++)
    {  
     String query1 = "";
     if (i < 10)
     {
       String a = "SELECT county,SUM(cases) AS cases FROM covidData WHERE  date = '2020-03-0"+i+"' GROUP BY 1 ORDER BY cases DESC";
       query1 = a;   
     }
     else
     {
       String a = "SELECT county,SUM(cases) AS cases FROM covidData WHERE  date = '2020-03-"+i+"' GROUP BY 1 ORDER BY cases DESC";
       query1 = a; 
     }
     DataSource arshadsData1 = new DataSource(myConnection,query1);
     //printTable(arshadsData1.table);
     for (int j = 0; j < 9; j++)
     {
        
        float a = arshadsData1.table.getFloat(j, 1);
        values.set(j, a);
     }
     theArray[i] = new Squarify(values, 160, 90, 1600, 900);
    }
  }
  void nextDay() {
    currentTreeMap++;
  }
  

  void sortCases(float theArray[], String theArray2[], Table table)
  {
    
    for (int i = 0; i<theArray.length; i++)
    {
      
      theArray[i] = table.getFloat(i, 1);
      theArray2[i] = table.getString(i,0);
      //println("Setting values "+theArray[i]);
    }
  } 
}
