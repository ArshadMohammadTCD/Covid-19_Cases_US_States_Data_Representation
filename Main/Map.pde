class Map { ////Zemyna 01/04/2021 05:39
  PImage map;
  ArrayList statesList = new ArrayList();
  String stateEvent;
  
  Map()
  {
    map = mapImageUS;
  }
  
  void draw()
  {
    stroke(57, 57, 57);
    fill(193,193,193);
    rect(240,200,1300,789);
    stroke(57, 57, 57);
    fill(107,108,147);
    rect(250,210,1280,769);
    tint(255,255,255);
    image(map, 250, 210);
    for(int i=0; i<statesList.size(); i++)
    {
      State currentState = (State) statesList.get(i);
      currentState.draw();
    }
  }
  
  String getMapEvent()
  {
    for(int i=0; i<statesList.size(); i++)
    {
      State currentState = (State) statesList.get(i);
      stateEvent = currentState.getStateEvent(mouseX, mouseY);
      if (stateEvent != "")
      {
        return stateEvent;
      }
    }
    return "";
  }
  
  void addState(State usState)
  {
    statesList.add(usState);
  }
}

//Zemyna 01/04/2021 05:39
State Alabama, Alaska, Arizona, Arkansas, California, Colorado, Connecticut, Delaware, Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, 
  Kansas, Kentucky, Louisiana, Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana, Nebraska, Nevada, NewHampshire, 
  NewJersey, NewMexico, NewYork, NorthCarolina, NorthDakota, Ohio, Oklahoma, Oregon, Pennsylvania, RhodeIsland, SouthCarolina, SouthDakota, Tennessee, 
  Texas, Utah, Vermont, Virginia, Washington, WestVirginia, Wisconsin, Wyoming; 
//Zemyna 01/04/2021 05:39
void setupStates()
{
  Alabama = new State(loadImage("Alabama.png"), 1060, 715, 70, 20, STATES[0]);
  USmap.addState(Alabama);
  Alaska = new State(loadImage("Alaska.png"), 370, 830, 70, 20, STATES[1]);
  USmap.addState(Alaska);
  Arizona = new State(loadImage("Arizona.png"), 470, 662, 70, 20, STATES[2]); 
  USmap.addState(Arizona);
  Arkansas = new State(loadImage("Arkansas.png"), 920, 662, 80, 20, STATES[3]); 
  USmap.addState(Arkansas);
  California = new State(loadImage("California.png"), 320, 580, 80, 20, STATES[4]);
  USmap.addState(California);
  Colorado = new State(loadImage("Colorado.png"), 625, 555, 80, 20, STATES[5]);
  USmap.addState(Colorado);
  Connecticut = new State(loadImage("Connecticut.png"), 1420, 485, 100, 20, STATES[6]);
  USmap.addState(Connecticut);
  Delaware = new State(loadImage("Delaware.png"), 1425, 555, 90, 20, STATES[7]);
  USmap.addState(Delaware);
  Florida = new State(loadImage("Florida.png"), 1200, 860, 90, 20, STATES[8]);
  USmap.addState(Florida);
  Georgia = new State(loadImage("Georgia.png"), 1140, 725, 90, 20, STATES[9]);
  USmap.addState(Georgia);
  Hawaii = new State(loadImage("Hawaii.png"), 570, 900, 90, 20, STATES[10]);
  USmap.addState(Hawaii);
  Idaho = new State(loadImage("Idaho.png"), 460, 410, 90, 20, STATES[11]);
  USmap.addState(Idaho);
  Illinois = new State(loadImage("Illinois.png"), 980, 530, 80, 20, STATES[12]);
  USmap.addState(Illinois);
  Indiana = new State(loadImage("Indiana.png"), 1060, 530, 60, 20, STATES[13]);
  USmap.addState(Indiana);
  Iowa = new State(loadImage("Iowa.png"), 900, 480, 60, 20, STATES[14]);
  USmap.addState(Iowa);
  Kansas = new State(loadImage("Kansas.png"), 780, 580, 90, 20, STATES[15]);
  USmap.addState(Kansas);
  Kentucky = new State(loadImage("Kentucky.png"), 1065, 600, 90, 20, STATES[16]);
  USmap.addState(Kentucky);
  Louisiana = new State(loadImage("Louisiana.png"), 930, 800, 90, 20, STATES[17]);
  USmap.addState(Louisiana);
  Maine = new State(loadImage("Maine.png"), 1370, 315, 90, 20, STATES[18]);
  USmap.addState(Maine);
  Maryland = new State(loadImage("Maryland.png"), 1435, 585, 90, 20, STATES[19]);
  USmap.addState(Maryland);
  Massachusetts = new State(loadImage("Massachusetts.png"), 1170, 315, 130, 20, STATES[20]);
  USmap.addState(Massachusetts);
  Michigan = new State(loadImage("Michigan.png"), 1080, 435, 80, 20, STATES[21]);
  USmap.addState(Michigan);
  Minnesota = new State(loadImage("Minnesota.png"), 870, 355, 80, 20, STATES[22]);
  USmap.addState(Minnesota);
  Mississippi = new State(loadImage("Mississippi.png"), 980, 730, 90, 20, STATES[23]);
  USmap.addState(Mississippi);
  Missouri = new State(loadImage("Missouri.png"), 910, 575, 90, 20, STATES[24]);
  USmap.addState(Missouri);
  Montana = new State(loadImage("Montana.png"), 550, 320, 120, 20, STATES[25]);
  USmap.addState(Montana);
  Nebraska = new State(loadImage("Nebraska.png"), 730, 485, 120, 20, STATES[26]);
  USmap.addState(Nebraska);
  Nevada = new State(loadImage("Nevada.png"), 380, 500, 90, 20, STATES[27]);
  USmap.addState(Nevada);
  NewHampshire = new State(loadImage("NewHampshire.png"), 1170, 250, 130, 20, STATES[28]);
  USmap.addState(NewHampshire);
  NewJersey = new State(loadImage("NewJersey.png"), 1420, 520, 100, 20, STATES[29]); 
  USmap.addState(NewJersey);
  NewMexico = new State(loadImage("NewMexico.png"), 580, 680, 120, 20, STATES[30]); 
  USmap.addState(NewMexico);
  NewYork = new State(loadImage("NewYork.png"), 1240, 420, 90, 20, STATES[31]); 
  USmap.addState(NewYork);
  NorthCarolina = new State(loadImage("NorthCarolina.png"), 1190, 630, 130, 20, STATES[32]); 
  USmap.addState(NorthCarolina);
  NorthDakota = new State(loadImage("NorthDakota.png"), 720, 330, 130, 20, STATES[33]); 
  USmap.addState(NorthDakota);
  Ohio = new State(loadImage("Ohio.png"), 1125, 510, 80, 20, STATES[34]); 
  USmap.addState(Ohio);
  Oklahoma = new State(loadImage("Oklahoma.png"), 780, 655, 130, 20, STATES[35]); 
  USmap.addState(Oklahoma);
  Oregon = new State(loadImage("Oregon.png"), 340, 365, 90, 20, STATES[36]); 
  USmap.addState(Oregon);
  Pennsylvania = new State(loadImage("Pennsylvania.png"), 1210, 475, 120, 20, STATES[37]); 
  USmap.addState(Pennsylvania);
  RhodeIsland = new State(loadImage("RhodeIsland.png"), 1410, 455, 115, 20, STATES[38]); 
  USmap.addState(RhodeIsland);
  SouthCarolina = new State(loadImage("SouthCarolina.png"), 1195, 665, 90, 40, STATES[39]); 
  USmap.addState(SouthCarolina);
  SouthDakota = new State(loadImage("SouthDakota.png"), 720, 410, 130, 20, STATES[40]); 
  USmap.addState(SouthDakota);
  Tennessee = new State(loadImage("Tennessee.png"), 1035, 640, 130, 20, STATES[41]); 
  USmap.addState(Tennessee);
  Texas = new State(loadImage("Texas.png"), 750, 770, 130, 20, STATES[42]); 
  USmap.addState(Texas);
  Utah = new State(loadImage("Utah.png"), 490, 530, 80, 20, STATES[43]); 
  USmap.addState(Utah);
  Vermont = new State(loadImage("Vermont.png"), 1200, 280, 100, 20, STATES[44]); 
  USmap.addState(Vermont);
  Virginia = new State(loadImage("Virginia.png"), 1200, 580, 100, 20, STATES[45]); 
  USmap.addState(Virginia);
  Washington = new State(loadImage("Washington.png"), 360, 270, 100, 20, STATES[46]); 
  USmap.addState(Washington);
  WestVirginia = new State(loadImage("WestVirginia.png"), 1410, 645, 115, 20, STATES[47]); 
  USmap.addState(WestVirginia);
  Wisconsin = new State(loadImage("Wisconsin.png"), 940, 390, 115, 20, STATES[48]); 
  USmap.addState(Wisconsin);
  Wyoming = new State(loadImage("Wyoming.png"), 580, 445, 120, 20, STATES[49]); 
  USmap.addState(Wyoming);
}
//Zemyna 01/04/2021 05:39
void drawMapTabs()
{
  //header
  stroke(57, 57, 57);
  textFont(header);
  fill(193, 193, 193);
  rect(70, 70, 1470, 103);
  fill(209, 209, 209);
  rect(80, 80, 1450, 83);
  fill(46, 46, 46);
  textSize(78);
  text("Covid-19 Cases in the United States", 100, 150);
  //right ui tab
  textFont(largeFont);
  fill(193, 193, 193);
  rect(1540, 200, 305, 789);
  rect(1540, 200, 305, 100);
  fill(107, 108, 147);
  rect(1550, 210, 285, 80);
  rect(1550, 310, 285, 669);
  fill(237, 237, 237);
  textSize(36);
  text("Case Statistics", 1570, 260);
  fill(237, 237, 237);
  rect(1570, 270, 250, 3);
  rect(1570, 330, 250, 3);
  textSize(24);
  text("Hover over a state or", 1570, 360);
  text("click on any state ", 1570, 390);
  text("name to see detailed", 1570, 420);
  text("statistics of Covid-19", 1570, 450);
  text("cases in that state.", 1570, 480);
  rect(1570, 490, 250, 3);
  //left key tab
  fill(193, 193, 193);
  rect(70, 200, 170, 789);
  fill(107, 108, 147);
  rect(80, 210, 150, 769);
  //keys
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
  fill(103, 57, 149);
  rect(90, 920, 130, 30);
  fill(193, 193, 193);
  textSize(18);
  text("0+", 140, 270);
  text("1,000+", 125, 340);
  text("10,000+", 120, 410);
  text("100,000+", 115, 480);
  text("300,000+", 115, 550);
  text("500,000+", 115, 620);
  text("1,000,000+", 110, 690);
  text("1,500,000+", 110, 760);
  text("2,000,000+", 110, 830);
  text("2,500,000+", 110, 900);
  text("3,000,000+", 110, 970);
}
//Zemyna 01/04/2021 05:39
void popUpStatsTable()
{
  stroke(57, 57, 57);
  fill(193, 193, 193);
  rect(1570, 510, 250, 450);
  fill(237, 237, 237);
  textFont(largeFont);
  textSize(24);
  text("State: ", 1580, 550);
  text("Population: ", 1580, 620);
  text("Total Cases: ", 1580, 690);
  text("Cases per 1M: ", 1580, 760);
  text("Cases by  ", 1580, 830);
  text("percentage: ", 1580, 860);
  fill(250, 250, 250);
  text(currentState.title, 1580, 585);
  text(currentState.population, 1580, 655);
  text(currentState.totalCases, 1580, 725);
  text(currentState.cases1M, 1580, 795);
  text(currentState.percentageCases + "%", 1580, 895);
}
