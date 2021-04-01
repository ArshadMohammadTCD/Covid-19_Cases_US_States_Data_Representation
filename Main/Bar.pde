class Bar {

  String areaName;
  float population;
  float speed;
  int xpos;
  float ypos;
  int counter;
  color blockColour;
  float blockWidth;
  float blockHeight;
  boolean mouseOver;

  Bar( float population, int xpos, float mappedWidth, String areaName ) {
    this.areaName = areaName;
    this.xpos = xpos;
    this.ypos = 850;
    this.speed = population/60;
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

void createBar(float population, int xpos, float mappedWidth, String areaName) {
  // Joe 30/03/21 00:50
  theBars.add( new Bar( population, (xpos), mappedWidth, areaName));
}

void drawBars() {
  // Joe 30/03/21 00:50
  for ( int i = 0; i < theBars.size(); i++ ) {
    theBars.get(i).draw();
    if ( theBars.get(i).mouseOver ) {
      fill(0);
      text(theBars.get(i).areaName, mouseX + 15, mouseY - 30);
    }
  }
}

void createChart() {
  // Joe 30/03/21 00:50
  String caseQuery = "SELECT cases, area FROM covidData WHERE county = '" + STATES[stateIndex] + "' AND date = '28/04/2020'";
  table = myConnection.runQuery(caseQuery);
  int xpos = 50;
  int mapRange = findMaxValue(table);
  float mapWidth = 1720/table.getRowCount();
  for (TableRow row : table.rows())
  {
    for (int i = 0; i < row.getColumnCount() - 1; i++)
    {
      String caseString = row.getString(i);
      String areaString = row.getString(i + 1);
      float measureBar = map(Integer.parseInt(caseString), 0, mapRange, 0, 600);
      createBar(measureBar, xpos, mapWidth, areaString);
    }
    xpos+=mapWidth;
  }
}

void drawChart() {
  // Joe 30/03/21 00:50
  stroke(0);
  fill(83, 83, 83);
  rect(490, 945, 150, 35);
  fill(255);
  text(STATES[stateIndex], 510, 970);
  rect(35, 125, 1785, 775);
  fill(0);
  drawBars();
  fill(0);
  line(50, 150, 50, 850);
  line(50, 850, 1770, 850);
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
