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
    if ((currentScreen==statsGraphsScreen)||(currentScreen==lineChartScreen))
    {
      //Zemyna 08/04/2021 06:43
      stroke(57, 57, 57);
      fill(193,193,193);
      rect(70,200,1775,789);
      fill(107, 108, 147);
      rect(80, 210, 1755, 769);
      for (int i=0; i<buttonList.size(); i++)
      {
      Button currentButton = (Button) buttonList.get(i);
      currentButton.draw();
      }
    }
    //Zemyna 13/04/2021 07:10
    if (currentScreen==timelineCasesScreen)
    {
      stroke(57, 57, 57);
      fill(193,193,193);
      rect(70,330,1020,659);
      rect(70,200,1020,130);
      rect(1090,200,755,789);
      fill(107, 108, 147);
      rect(80, 340, 1000, 639);
      rect(1100,210,735,769);
      rect(80,210,1000,110);
      
      fill(193,193,193);
      rect(1520,460,155,250);
      fill(107, 108, 147);
      rect(1530,470,135,230);
      //header
      stroke(57, 57, 57);
      textFont(header);
      fill(193, 193, 193);
      rect(70, 70, 1470, 103);
      fill(209, 209, 209);
      rect(80, 80, 1450, 83);
      fill(46, 46, 46);
      textSize(78);
      text("Covid-19 Timeline Cases by State/Area", 100, 150);
      for (int i=0; i<buttonList.size(); i++)
      {
      Button currentButton = (Button) buttonList.get(i);
      currentButton.draw();
      }
    }
    
    //Zemyna 14/04/2021 10:47
    if ((currentScreen==dataTableScreen))
    {
      stroke(57, 57, 57);
      fill(193,193,193);
      rect(70,200,591.6,789);
      rect(661.6,200,591.6,789);
      rect(1253.2,200,591.6,789);
      fill(107, 108, 147);
      rect(80, 210, 571.6, 769);
      rect(671.6,210,571.6,769);
      rect(1263.2,210,571.6,769);
      //header
      stroke(57, 57, 57);
      textFont(header);
      fill(193, 193, 193);
      rect(70, 70, 1470, 103);
      fill(209, 209, 209);
      rect(80, 80, 1450, 83);
      fill(46, 46, 46);
      textSize(78);
      text("Covid-19 Cumulative Cases by State/Area", 100, 150);
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
