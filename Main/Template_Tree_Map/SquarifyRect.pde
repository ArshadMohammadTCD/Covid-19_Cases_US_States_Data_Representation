import squarify.library.*; //<>// //<>//
import java.util.Arrays;
import java.util.ArrayList;



class TreeMap {
PFont stdFont;
Squarify[] treeMap;
// CONSTANTS
float CANVAS_WIDTH = 1000;    // The width of the canvas to fill
float CANVAS_HEIGHT = 1000;   // The height of the canvas to fill
float CANVAS_ORIGIN_X = 0;    // The x origin of the canvas to fill
float CANVAS_ORIGIN_Y = 0;    // The y origin of the canvas to fill

// SQUARIFY DATA
ArrayList<SquarifyRect> rects;  // The rects list will contain geometry for each rectangle to draw
// Arshad Changing the values to suit the situation Thu 25th March 13:24
ArrayList<Float> values = new ArrayList<Float>(Arrays.asList(50f, 25f, 100f, 10f, 75f, 10f, 10f, 100f, 12f, 100f, 122f)); // Values defining the squarified layout
int currentTreeMap, time;
float[] previousX, previousY, previousDx, previousDy;
float x, y, dy, dx;


  
  TreeMap(){
    smooth();
    treeMap = new Squarify[DAYS];
    previousX = new float[NUMBER_OF_COUNTRIES];
    previousY = new float[NUMBER_OF_COUNTRIES];
    previousDx = new float[NUMBER_OF_COUNTRIES];
    previousDy = new float[NUMBER_OF_COUNTRIES];
    init_treeMap(treeMap);
    stdFont=loadFont("AppleSDGothicNeo-Medium-14.vlw");
  }


    //s[0] = new Squarify(values, CANVAS_ORIGIN_X, CANVAS_ORIGIN_Y, CANVAS_WIDTH, CANVAS_HEIGHT);
  

  void draw() {
    background(100, 100, 200);
    noStroke();
    // This is timing system I built - Arshad Thu 25th March 17:45
    time++;
    if (time%(SPEED_OF_DAY_CYCLE_IN_SECONDS*50) == 0) {
      currentTreeMap++; // This increments the day cycle
    }
    rects = treeMap[currentTreeMap].getRects();
    for (int i = 0; i < rects.size(); i++) {
      // Draw a rectangle
      // Arshad I made this work around and move the rectangles around Thu 25th March 17:30
      SquarifyRect r = rects.get(i);
      fill(255, 255, 255);
      fill(256-(map(r.getValue(), 0, 100, 50, 255))); // This will also need to change
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
      textFont(stdFont);
      fill(255, 255, 0);
      text("Country: " + r.getId() + ", Covid Cases: " + round(r.getValue()), r.getX() + r.getDx()/2, r.getY() + r.getDy()/2);
    }
    text("DAY: " + currentTreeMap, 100, 100);
  }
  // Added mousePressed funtion to increase the Day count)
  void mousePressed() {
    currentTreeMap++;
  }
  // Arshad initializing treeMap Thu 25th March 13:24
  void init_treeMap(Squarify theArray[])
  {
    for (int i = 0; i<theArray.length; i++)
    {  
      for (int j = 0; j < values.size(); j++)
      {
        values.set(j, random(1, 100)); // Random numbers for now
      }
      theArray[i] = new Squarify(values, CANVAS_ORIGIN_X, CANVAS_ORIGIN_Y, CANVAS_WIDTH, CANVAS_HEIGHT);
    }
  }
  void nextDay() {
    currentTreeMap++;
  }
}
