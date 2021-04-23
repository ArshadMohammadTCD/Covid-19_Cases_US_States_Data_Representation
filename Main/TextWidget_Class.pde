// Andrey 06/04/2021 16:06
/*
This class makes a text Widget which allows user input and has a cursor bar
*/
class TextWidget {
  int maxlen;
  int x;
  int y;
  int width;
  int height;
  String label;
  color widgetColor;
  PFont font; 
  int event;
  boolean hasCursor;
// Constructor

  TextWidget(int x, int y, int width, int height, String label, color widgetColor, int event, int maxlen, boolean hasCursor) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.maxlen=maxlen;
    this.hasCursor = hasCursor;
  }
  // Controls input through keys
  void append(char s) {
    if (s==BACKSPACE) {
      if (!label.equals(""))
        label=label.substring(0, label.length()-1);
    } else if (label.length() <maxlen)
      if(s != 16){
      label=label+String.valueOf(s);
      }
      println(s);
  }
// Draws the text Widgets
  void draw() {
    stroke(0);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(0);
    textSize(14);
    if(hasCursor){
    text(label+"|", x+5, y+height-6);
    }
    else {
      text(label, x+5, y+height-6);
    }
    stroke(0);
   
  }
  // Makes text Widgets interractable
  int getEvent(int mX, int mY)
  {
    if ((mX > x) && (mX < x+width) && (mY > y) && (mY < y+height))
    {
      System.out.print("textWidget " + event + " pressed ");
      return event;
    }
    return EVENT_NULL;
  }
  
  
}
