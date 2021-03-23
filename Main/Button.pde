//Zemyna 23/03/2021 20:15
class Button {
  int x, y, width, height, labelx, labely, regularLabely, hoverLabely, hovery, regulary;
  String label; int event;
  color buttonColor, labelColor, strokeColor;
  PFont buttonFont;
  boolean hover=false;
  
  Button(int x, int y, int width, int height, String label, 
  color buttonColor, PFont buttonFont, int event, int labelx)
  {
    this.x=x; this.y=y; this.width=width; this.height=height;
    this.label=label; this.event=event; 
    this.buttonColor=buttonColor; this.buttonFont=buttonFont;
    labelColor=color(255);
    this.labelx=labelx; this.labely=y+((height/10)*7);
    hovery= y-10; regulary=y; hoverLabely=labely-10; regularLabely=labely;
  }
  
  void draw()
  {
    if (hover == true)
    {
      strokeColor = color(255,242,242);
      fill(color(62,62,62));
      y=hovery;
      labely=hoverLabely;
    }
    else
    {
      strokeColor = color(170,170,170);
      fill(buttonColor);
      y=regulary;
      labely=regularLabely;
    }
    stroke(strokeColor);
    rect(x,y,width,height);
    fill(labelColor);
    textFont(buttonFont);
    text(label, labelx, labely);
    if(currentScreen==homeScreen)
    {
      fill(color(250,250,250));
      stroke(170,170,170);
      rect(x,y,width-900,height);
      stroke(170,170,170);
      rect(x+900,y,width-900,height);
    }
  }
  
  int getEvent(int mX, int mY)
  {
    if ((mX > x) && (mX < x+width) && (mY > y) && (mY < y+height))
    {
      System.out.print("Button " + event + " pressed ");
      return event;
    }
    return EVENT_NULL;
  }
}
