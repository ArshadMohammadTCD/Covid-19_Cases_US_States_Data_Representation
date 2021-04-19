// Joe 09/04/2021 00:53  //<>//

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

  firstState = 0;
  secondState = 1;
  firstDay = 13;
  secondDay = 14;
  firstMonth = 3;
  secondMonth = 3;
  dateCount = 2;

  graphDay = 13;
  graphMonth = 3;
}

void createPoint(ArrayList<Point> thePoints, int population, float speed, int xpos, color pointColour, String pointDate) {
  thePoints.add( new Point( population, speed, (xpos), pointColour, pointDate));
}

void drawPoints() {
  for ( int i = 0; i < firstPoints.size(); i++ ) {
    firstPoints.get(i).draw();
    secondPoints.get(i).draw();
    if ( firstPoints.get(i).mouseOver == true ) {
      text(firstPoints.get(i).pointDate, mouseX + 10, mouseY - 20);
      fill(0, 0, 255);
      text(STATES[secondState] + " : " + secondPoints.get(i).population, 120, 280);
      fill(255, 0, 0);
      text(STATES[firstState] + " : " + firstPoints.get(i).population, 120, 250);
    }
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



void createLineChart( int dateCount, int state1, int state2 ) {
  String caseQuery = "";
  for ( int l = 0; l <= 1; l++  ) {
    int lineChartDay = firstDay;
    int lineChartMonth = firstMonth;
    for ( int i = 0; i < dateCount; i++ ) {

      caseQuery = "SELECT cases, area FROM covidData WHERE county = '" +  (( l == 0 ? STATES[state1] : STATES[state2])+ "' AND date = '" 
        + "2020-0" + lineChartMonth + "-" + (lineChartDay < 10 ? "0" : "") + lineChartDay + "'");
          //+ ConvertDate(((lineChartDay >= 10) ? "" : "0") + lineChartDay + "/0" + lineChartMonth + "/2020")+"' ORDER BY area ASC";
      table = myConnection.runQuery(caseQuery);
      if ( l == 0 ) {
        firstCases.append(createTotalCases(table));
        caseDates.append("2020-0" + lineChartMonth + "-" + (lineChartDay < 10 ? "0" : "") + lineChartDay);
        //caseDates.append(ConvertDate((lineChartDay < 10) ? "0" : "" + lineChartDay + "/0" + lineChartMonth + "/2020"));
      } else {
        secondCases.append(createTotalCases(table));
      }
      lineChartDay++;
      if (lineChartDay > 31 && (lineChartMonth == 1 || lineChartMonth == 3)) {
        lineChartMonth++;
        lineChartDay = 1;
      }
      else if ( lineChartDay > 29 && lineChartMonth == 2 ) {
        lineChartMonth++;
        lineChartDay = 1;
      }
      // the last else if will just stop the loop if it gets to the end of the dataset
      else if ( lineChartDay > 28 && lineChartMonth == 4 ) {
        dateCount = i;
      }
    }
  }

  int mapRange = findMaxValue(firstCases, secondCases);
  float mapWidth = 1670.0/firstCases.size();

  for ( int l = 0; l <= 1; l++ ) {
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
    } else {
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
  rect(190, 929, 200, 35); // rectangle for the first state
  rect(490, 929, 200, 35); // rectangle for the second state
  rect(850, 929, 200, 35); // rectangle for the first date
  rect(1250, 929, 200, 35);// rectangle for the second date
  fill(255);
  text(STATES[firstState], 200, 956); // title for state over the buttons
  text(STATES[secondState], 500, 956); 
  text(((firstDay < 10) ? "0" : "") + firstDay + "/0" + firstMonth + "/2020", 860, 956);
  text((( secondDay < 10) ? "0" : "") + secondDay + "/0" + secondMonth + "/2020", 1260, 956);
  fill(240, 235, 245);
  rect(90, 220, 1735, 709); // rectangle for the white background of the chart
  fill(0);
  drawPoints();
  drawLines();
  fill(0);
  line(100, 230, 100, 900); // line for y - axis of the bar chart
  line(100, 900, 1770, 900); // line for the x - axis of the bar chart
  stroke(57, 57, 57);
  textFont(header);
  fill(193, 193, 193);
  rect(70, 70, 1470, 103); // outer rectangle of header
  fill(209, 209, 209);
  rect(80, 80, 1450, 83); // inner rectangle of header
  fill(46, 46, 46);
  textSize(50); // size of the text
  text("Case trend of " + STATES[firstState] + " and " + STATES[secondState] + " from " + ((firstDay < 10) ? "0" : "") + firstDay + "/0" + firstMonth + "/2020 to " 
        + ((secondDay < 10) ? "0" : "" ) + secondDay + "/0" + secondMonth + "/2020", 100, 150); // header of the title
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
  for ( int i = firstPoints.size() - 1; i >= 0; i-- ) {
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
