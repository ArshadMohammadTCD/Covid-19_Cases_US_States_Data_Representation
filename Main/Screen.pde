//Zemyna 23/03/2021 20:15
class Screen {
  ArrayList buttonList=new ArrayList();
  PImage screenBackground;
  int event;
  
  Screen(PImage screenBackground)
  {
    this.screenBackground=screenBackground;
  }
  
  void draw()
  {
    background(screenBackground);
    for(int i=0; i<buttonList.size(); i++)
    {
      Button currentButton = (Button) buttonList.get(i);
      currentButton.draw();
    }
  }
  
  int getEvent()
  {
    for(int i=0; i<buttonList.size(); i++)
    {
      Button currentbutton = (Button) buttonList.get(i);
      event = currentbutton.getEvent(mouseX, mouseY);
      if(event!=EVENT_NULL)
      {
        return event;
      }
    }
    return EVENT_NULL;
    
  }
  
  void addButton(Button inputButton)
  {
    buttonList.add(inputButton);
  }
}
