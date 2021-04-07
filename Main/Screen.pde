//Zemyna 23/03/2021 20:15 
class Screen {
  ArrayList buttonList=new ArrayList();
  ArrayList checkboxList = new ArrayList();
  ArrayList textWidgetList = new ArrayList();
  PImage screenBackground;
  int event;

  Screen(PImage screenBackground)
  {
    this.screenBackground=screenBackground;
  }

  void draw()
  {
    background(screenBackground);
    for (int i=0; i<buttonList.size(); i++)
    {
      Button currentButton = (Button) buttonList.get(i);
      currentButton.draw();
    }
    //Zemyna 07/04/2021 16:19
    if (currentScreen == homeScreen)
    {
      background(screenBackground);
      stroke(57, 57, 57);
      fill(193,193,193);
      rect(460,280,1000,615);
      for (int i=0; i<buttonList.size(); i++)
      {
      Button currentButton = (Button) buttonList.get(i);
      currentButton.draw();
      }
    }
  }

  int getEvent()
  {
    for (int i=0; i<buttonList.size(); i++)
    {
      Button currentbutton = (Button) buttonList.get(i);
      event = currentbutton.getEvent(mouseX, mouseY);
      if (event!=EVENT_NULL)
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
  // Andrey 06/04/2021 12:27 Checkboxes for table screen

  void addCheckbox(Checkbox checkboxName) {
    checkboxList.add(checkboxName);
  }
  void drawCheckbox() {
    for (int i=0; i<checkboxList.size(); i++)
    {
      Checkbox currentCheckbox = (Checkbox) checkboxList.get(i);
      currentCheckbox.draw();
    }
  }

  int getCheckboxEvent(){
    for (int i=0; i<checkboxList.size(); i++)
    {
      Checkbox currentcheckbox = (Checkbox) checkboxList.get(i);
      event = currentcheckbox.getEvent(mouseX, mouseY);
      if (event!=EVENT_NULL)
      {
        println(event);
        return event;
      }
    }
    println("NULL");
    return EVENT_NULL;
  }

  void addTextWidget(TextWidget TextWidgetName) {
    textWidgetList.add(TextWidgetName);
  }
  void drawTextWidget() {
    for (int i=0; i<textWidgetList.size(); i++) {
      TextWidget currentTextWidget = (TextWidget) textWidgetList.get(i);
      currentTextWidget.draw();
    }
  }
  int getTextWidgetEvent(){
    for (int i=0; i<textWidgetList.size(); i++)
    {
      TextWidget currentTextWidget = (TextWidget) textWidgetList.get(i);
     
      event = currentTextWidget.getEvent(mouseX, mouseY);
      if (event!=EVENT_NULL)
      {
        println(event);
        return event;
      }
    }
    println("NULL");
    return EVENT_NULL;
  }
}
