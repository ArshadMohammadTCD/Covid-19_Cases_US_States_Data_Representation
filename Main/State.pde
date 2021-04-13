class State {////Zemyna 01/04/2021 05:39
  PImage state;
  String stateEvent, title;
  int xT, yT, width, height, population, totalCases, cases1M;
  float percentageCases;
  boolean hover=false;
  color tintColor;
  int statePopulation;
  
  State(PImage state, int xT, int yT, int width, int height, String stateEvent)
  {
    this.state=state;
    this.xT = xT; this.yT = yT;
    this.width = width; this.height = height;
    this.stateEvent = stateEvent;
    title = stateEvent;
    population = int(random(578759,39512223)); //random population for demonstration purposes
    totalCases = getCases(queryTable());
    cases1M = int(random(population/8));  // random cases/1 mill
    percentageCases = getPercentage();
  }
  
  void draw()
  {
    if (hover==true)
    {
        if(totalCases>0&&totalCases<=1000)
        {
          tint(242,229,255);
        }
        if(totalCases>1000&&totalCases<=10000)
        {
          tint(230,212,247);
        }
        if(totalCases>10000&&totalCases<=100000)
        {
          tint(213,189,237);
        }
        if(totalCases>100000&&totalCases<=300000)
        {
          tint(198,169,227);
        }
        if(totalCases>300000&&totalCases<=500000)
        {
          tint(183,151,216);
        }
        if(totalCases>500000&&totalCases<=1000000)
        {
          tint(166,129,203);
        }
        if(totalCases>1000000&&totalCases<=1500000)
        {
          tint(152,111,193);
        }
        if(totalCases>1500000&&totalCases<=2000000)
        {
          tint(139,96,183);
        }
        if(totalCases>2000000&&totalCases<=25000000)
        {
          tint(128,81,175);
        }
        if(totalCases>2500000&&totalCases<=3000000)
        {
          tint(117,70,165);
        }
        if(totalCases>3000000)
        {
          tint(103,57,149);
        }
        image(state, 250, 210);
    }
  }
  
  String getStateEvent(int mX, int mY)
  {
    if ((mX > xT) && (mX < xT+width) && (mY > yT) && (mY < yT+height))
    {
      return stateEvent;
    }
    else
    {
      return "";
    }
  }
  
  
  //Zemyna 12/04/2021 06:11
  Table queryTable()
  {
    String myQuery = "SELECT area, SUM(cases) AS cases FROM covidData WHERE county = '" + stateEvent + "' GROUP BY 1 ORDER BY 1 ASC";
    Table myTable = myConnection.runQuery(myQuery);
    return myTable;
  }
  
  int getCases(Table table)
  {
    int totalCases=0;
    for(int i=0; i<table.getRowCount(); i++)
    {
      totalCases+=int(table.getString(i,1));
    }
    return totalCases;
  }
  
  float getPercentage()
  {
    return (float)(totalCases*100)/statePopulation;
  }
 
}
