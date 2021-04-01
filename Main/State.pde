class State {////Zemyna 01/04/2021 05:39
  PImage state;
  String stateEvent, title;
  int xT, yT, width, height, population, totalCases, cases1M, percentageCases;
  boolean hover=false;
  color tintColor;
  
  State(PImage state, int xT, int yT, int width, int height, String stateEvent)
  {
    this.state=state;
    this.xT = xT; this.yT = yT;
    this.width = width; this.height = height;
    this.stateEvent = stateEvent;
    title = stateEvent;
    population = int(random(578759,39512223)); //random population for demonstration purposes
    totalCases = int(random(population/4)); //random fraction of population = random case numbers
    cases1M = int(random(population/8));  // random cases/1 mill
    percentageCases = int(random(50)); // random percentage
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
}
