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
    this.ypos = 900; // y position of the bottom of each bar, along the line
    this.speed = speed;
    this.counter = 0;
    this.blockHeight = 0;
    this.blockWidth = mappedWidth;
    this.blockColour = color(random(100, 198), random(5, 170), 235); // colour of the bars, currently random
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
      text("Area: " + theBars.get(i).areaName, 100, 1020); // text on the bottom right for the bar the mouse is hovering over
      text("Recorded Cases: " + theBars.get(i).population, 600, 1020); // recorded cases
      text((float(theBars.get(i).population) / getTotalCases(theBars)) * 100 + "% of cases for the state of " + STATES[stateIndex], 950, 1020); // % of total cases in the state from that area
      stroke(0);
    }
  }
}

void createChart() {
  // Joe 30/03/21 00:50
  String caseQuery = "SELECT cases, area FROM covidData WHERE county = '" + STATES[stateIndex] + "' AND date = '" + ConvertDate(((graphDay < 10) ? "0" : "") + graphDay + "/0" + graphMonth + "/2020")+"' ORDER BY area ASC";
  table = myConnection.runQuery(caseQuery);
  int xpos = 100;
  int mapRange = findMaxValue(table);
  if ( table.getRowCount() > 0) {
    float mapWidth = 1670/table.getRowCount(); // change this for the length of the x-axis line
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
  rect(190, 929, 200, 35); // rectangle for the state
  rect(610, 929, 200, 35); // rectangle for the date
  fill(255);
  text(STATES[stateIndex], 200, 956); // title for state over the buttons
  text((graphDay + "/0" + graphMonth + "/2020"), 620, 956); 
  rect(70, 990, 520, 45); // rectangle displaying information
  rect(590, 990, 350, 45);
  rect(940, 990, 905, 45);
  fill(240, 235, 245);
  rect(90, 220, 1735, 709); // rectangle for the white background of the chart
  fill(0);
  drawBars();
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
  textSize(78); // size of the text
  text("Cases in " + STATES[stateIndex] + " at " + ((graphDay < 10) ? "0" : "") + graphDay + "/0" + graphMonth + "/2020", 100, 150); // header of the title
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
