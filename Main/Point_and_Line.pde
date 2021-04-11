// Joe 09/04/2021 00:53 

class Point {
  
  String pointDate;
  int population;
  float speed;
  int xpos;
  float ypos;
  int counter;
  color pointColour;
  boolean mouseOver;
  
  Point( int population, float speed, int xpos, color pointColour, String pointDate ) {
    this.population = population;
    this.pointDate = pointDate;
    this.xpos = xpos;
    this.ypos = 900;
    this.speed = speed/60;
    this.counter = 0;
    this.pointColour = pointColour;
  }
  
  void draw() {
    if (mouseOver) {
      stroke(255);
    } else {
      stroke(0);
    }
    fill(pointColour);
    ellipse(xpos, ypos, 10, 10);
    if ( counter <= 90 ) {
      ypos -= speed;
      counter++;
      if ( speed - 0.075 > 0.5 ) {
        speed -= 0.075;
      }
    }
  }
  
}

class Line {
  
  Point point1;
  Point point2;
  color lineColour;
  
  Line ( Point p1, Point p2, color lineColour ) {
    this.point1 = p1;
    this.point2 = p2;
    this.lineColour = lineColour;
  }
  
  void draw() {
    stroke(lineColour);
    line( point1.xpos, point1.ypos, point2.xpos, point2.ypos );
    stroke(0);
  }
}

void setupLineChart() {
  firstPoints = new ArrayList();
  firstLines = new ArrayList();
  secondPoints = new ArrayList();
  secondLines = new ArrayList();
  caseDates = new StringList();
  firstCases = new IntList();
  secondCases = new IntList();

  graphDay = 13;
  graphMonth = 3;
  createLineChart(1, 3, 44);
}

void createPoint(ArrayList<Point> thePoints, int population, float speed, int xpos, color pointColour, String pointDate) {
  thePoints.add( new Point( population, speed, (xpos), pointColour, pointDate));
}

void drawPoints() {
  for ( int i = 0; i < firstPoints.size(); i++ ) {
    firstPoints.get(i).draw();
    if ( firstPoints.get(i).mouseOver == true ) {
      text(firstPoints.get(i).pointDate, mouseX + 10, mouseY - 20);
    }
  }
  for ( int i = 0; i < secondPoints.size(); i++ ) {
    secondPoints.get(i).draw();
  }
}

void createLine( ArrayList<Line> theLines, Point p1, Point p2, color lineColour ) {
  theLines.add( new Line( p1, p2, lineColour ));
}

void drawLines() { 
  for ( int i = 0; i < firstLines.size(); i++ ) {
    firstLines.get(i).draw();
  }
  for ( int i = 0; i < secondLines.size(); i++ ) {
    secondLines.get(i).draw();
  }
}

 //<>//

void createLineChart( int lineCheck, int state1, int state2 ) {
  for ( int l = 0; l <= lineCheck; l++  ) {
    graphDay = 13;
    for ( int i = 0; i < 9; i++ ) {

      String caseQuery = "SELECT cases, area FROM covidData WHERE county = '" + ((l == 0) ? STATES[state1] : STATES[state2] ) + "' AND date = '" + ConvertDate(((graphDay < 9) ? "0" : "") + graphDay + "/0" + graphMonth + "/2020")+"' ORDER BY area ASC";
      table = myConnection.runQuery(caseQuery);
      if ( l == 0 ) {
        firstCases.append(createTotalCases(table));
        caseDates.append(ConvertDate((graphDay < 9) ? "0" : "" + graphDay + "/0" + graphMonth + "/2020"));
      } else {
        secondCases.append(createTotalCases(table));
      }
      graphDay++;
    }
  }
 
  int mapRange = findMaxValue(firstCases, secondCases);
  float mapWidth = 1670.0/firstCases.size();

  for ( int l = 0; l <= lineCheck; l++ ) {
    int xpos = 100;

    
    if ( l == 0 ) {

      for (int i = 0; i < firstCases.size(); i++)
      {
        float measurePoint = map(firstCases.get(i), 0, mapRange, 0, 600);
        createPoint(firstPoints, firstCases.get(i), measurePoint, xpos, color (255, 0, 0), caseDates.get(i));
        xpos+=mapWidth;
      }
      for ( int i = 0; i < firstPoints.size() - 1; i++ ) {
        createLine( firstLines, firstPoints.get(i), firstPoints.get(i + 1), color (255, 0, 0));
      }
    }

    else {
      for (int i = 0; i < secondCases.size(); i++)
      {
        float measurePoint = map(secondCases.get(i), 0, mapRange, 0, 600);
        createPoint(secondPoints, secondCases.get(i), measurePoint, xpos, color (0, 0, 255), caseDates.get(i));
        xpos+=mapWidth;
      }
      for ( int i = 0; i < secondPoints.size() - 1; i++ ) {
        createLine( secondLines, secondPoints.get(i), secondPoints.get(i + 1), color (0, 0, 255));
      }
    }
  }
}

void drawLineChart() {
  // Joe 30/03/21 00:50
  stroke(0);
  fill(83, 83, 83);
  rect(190, 929, 200, 35); // rectangle for the state
  rect(610, 929, 200, 35); // rectangle for the date
  fill(255);
  text(STATES[stateIndex], 200, 956); // title for state over the buttons
  text((graphDay + "/0" + graphMonth + "/2020"), 620, 956); 
  //rect(910, 882, 910, 150); // rectangle for bottom right, needs to be aligned
  fill(240,235,245);
  rect(90, 220, 1735, 709); // rectangle for the white background of the chart
  fill(0);
  drawPoints();
  drawLines();
  fill(0);
  line(100, 230, 100, 900); // line for y - axis of the bar chart
  line(100, 900, 1770, 900); // line for the x - axis of the bar chart
  stroke(57, 57, 57);
  textFont(loadFont("ProcessingSansPro-Regular-78.vlw"));
  fill(193, 193, 193);
  rect(70, 70, 1470, 103); // outer rectangle of header
  fill(209, 209, 209);
  rect(80, 80, 1450, 83); // inner rectangle of header
  fill(46, 46, 46);
  textSize(78); // size of the text
  text("Cases in " + STATES[stateIndex] + " at " + ((graphDay < 10) ? "0" : "") + graphDay + "/0" + graphMonth + "/2020", 100, 150); // header of the title
}



int findMaxValue(IntList firstCases, IntList secondCases ) {
  int maxValue = 0;
  for ( int i = 0; i < firstCases.size(); i++ ) {
    if ( maxValue < firstCases.get(i) ) {
      maxValue = firstCases.get(i);
    }
    if ( maxValue < secondCases.get(i) ) {
      maxValue = secondCases.get(i);
    }
  }
  return maxValue;
}

int createTotalCases ( Table table ) {
  int totalCases = 0;
  for (TableRow row : table.rows()) {
    for ( int i = 0; i < row.getColumnCount() - 1; i++ ) {
      totalCases += int(row.getString(i));
    }
  }
  return totalCases;
}

void emptyLineChart() {
  for( int i = firstPoints.size() - 1; i >= 0; i-- ) {
    firstPoints.remove(i);
    secondPoints.remove(i);
    if ( i > 0 ) {
    firstLines.remove(i - 1);
    secondLines.remove(i - 1);
  }
    caseDates.remove(i);
    firstCases.remove(i);
    secondCases.remove(i);
  } 
}
