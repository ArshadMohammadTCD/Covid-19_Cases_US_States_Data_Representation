// Andrey 06/04/2021 16:06
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


  TextWidget(int x, int y, int width, int height, String label, color widgetColor, int event, int maxlen) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.maxlen=maxlen;
  }
  void append(char s) {
    if (s==BACKSPACE) {
      if (!label.equals(""))
        label=label.substring(0, label.length()-1);
    } else if (label.length() <maxlen)
      
      label=label+String.valueOf(s);
      println(s);
  }

  void draw() {
    stroke(0);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(0);
    textSize(20);
    text(label, x, y+height-6);
    stroke(0);
   
  }
  
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
