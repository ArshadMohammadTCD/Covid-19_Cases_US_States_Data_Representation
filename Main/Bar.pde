class Bar {

  String areaName;
  int population;
  float speed;
  int xpos;
  float ypos;
  int counter;
  color blockColour;
  float blockWidth;
  float blockHeight;
  boolean mouseOver;

  Bar( int population, float speed, int xpos, float mappedWidth, String areaName ) {
    this.population = population;
    this.areaName = areaName;
    this.xpos = xpos;
    this.ypos = 850;
    this.speed = speed;
    this.counter = 0;
    this.blockHeight = 0;
    this.blockWidth = mappedWidth;
    this.blockColour = color(random(0, 255), random(0, 255), random(0, 255));
    mouseOver = false;
  }

  void draw() {
    if (mouseOver) {
      stroke(255);
    } else {
      stroke(0);
    }
    fill(blockColour);
    rect(xpos, ypos, blockWidth, blockHeight);
    if ( counter <= 90 ) {
      ypos -= speed;
      counter++;
      blockHeight += speed;
      if ( speed - 0.075 > 0.5 ) {
        speed -= 0.075;
      }
    }
  }
}

void createBar(int population, float speed, int xpos, float mappedWidth, String areaName) {
  // Joe 30/03/21 00:50
  theBars.add( new Bar( population, speed, (xpos), mappedWidth, areaName));
}

void drawBars() {
  // Joe 30/03/21 00:50
  for ( int i = 0; i < theBars.size(); i++ ) {
    theBars.get(i).draw();
    if ( theBars.get(i).mouseOver ) {
      fill(0);
      text("Area: " + theBars.get(i).areaName, 920, 915);
      text("Recorded Cases: " + theBars.get(i).population, 1500, 915);
      text((float(theBars.get(i).population) / getTotalCases(theBars)) * 100 + "% of cases for the state of " + STATES[stateIndex], 920, 945);
      stroke(0);
    }
  }
}

void createChart() {
  // Joe 30/03/21 00:50
  String caseQuery = "SELECT cases, area FROM covidData WHERE county = '" + STATES[stateIndex] + "' AND date = '" + ((graphDay < 10) ? "0" : "") + graphDay + "/0" + graphMonth + "/2020' ORDER BY area ASC";
  table = myConnection.runQuery(caseQuery);
  int xpos = 50;
  int mapRange = findMaxValue(table);
  if ( table.getRowCount() > 0) {
    float mapWidth = 1720/table.getRowCount();
    for (TableRow row : table.rows())
    {
      for (int i = 0; i < row.getColumnCount() - 1; i++)
      {
        String caseString = row.getString(i);
        String areaString = row.getString(i + 1);
        float measureBar = map(int(caseString), 0, mapRange, 0, 600);
        createBar(int(caseString), measureBar / 60, xpos, mapWidth, areaString);
      }
      xpos+=mapWidth;
    }
  }
}

void drawChart() {
  // Joe 30/03/21 00:50
  stroke(0);
  fill(83, 83, 83);
  rect(75, 917, 200, 35);
  rect(300, 917, 200, 35);
  fill(255);
  text(STATES[stateIndex], 85, 944);
  text((graphDay + "/0" + graphMonth + "/2020"), 310, 944); 
  rect(910, 882, 910, 150);
  rect(35, 132, 1785, 750);
  fill(0);
  drawBars();
  fill(0);
  line(50, 150, 50, 850);
  line(50, 850, 1770, 850);
  stroke(57, 57, 57);
  textFont(loadFont("ProcessingSansPro-Regular-78.vlw"));
  fill(193, 193, 193);
  rect(70, 28, 1470, 103);
  fill(209, 209, 209);
  rect(80, 38, 1450, 83);
  fill(46, 46, 46);
  textSize(78);
  text("Cases in " + STATES[stateIndex] + " at " + ((graphDay < 10) ? "0" : "") + graphDay + "/0" + graphMonth + "/2020", 100, 102);
}

int findMaxValue(Table table ) {
  // Joe 30/03/21 00:50
  int maxValue = 0;
  for (TableRow row : table.rows()) {
    System.out.println(row.getColumnCount());
    for ( int i = 0; i < row.getColumnCount() - 1; i++ ) {
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

int getTotalCases ( ArrayList<Bar> theBars ) {
  int totalCases = 0;
  for ( int i = 0; i < theBars.size(); i++ ) {
    totalCases = totalCases + int(theBars.get(i).population);
  }
  return totalCases;
}
