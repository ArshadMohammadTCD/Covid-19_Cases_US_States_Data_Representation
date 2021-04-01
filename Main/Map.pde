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
    fill(193,193,193);
    rect(240,200,1300,789);
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
