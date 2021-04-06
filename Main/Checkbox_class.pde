//Andrey 06/04/2021 12:24
class Checkbox {
 int x;
 int y;
 int width;
 int height; 
 String label;
 color checkboxColor;
 int event;
boolean is_checked = false;
   color colour;
    int labelOffset;
Checkbox(int x, int y, int width, int height, String label, color checkboxColor, int event, int labelOffset){
 this.x = x;
 this.y = y;
 this.width = width;
 this.height = height;
 this.label = label;
 this.checkboxColor = checkboxColor;
 this.event = event;
 this.labelOffset = labelOffset;
}

void draw(){
   stroke(0);
    fill(checkboxColor);
    rect(x, y, width, height);
    fill(0);
    textSize(20);
    text(label, x+labelOffset, y+height-6);
   stroke(0);
    fill(checkboxColor);
    rect(x, y, width, height);
    if(is_checked == true){
      line(x,y,x+width,y+height);
      line(x,y+height,x+width,y);
    }
}
// Andrey 06/04/2021 checkbox part 
 
 
  int getEvent(int mX, int mY)
  {
    if ((mX > x) && (mX < x+width) && (mY > y) && (mY < y+height))
    {
      System.out.print("checkbox " + event + " pressed ");
      return event;
    }
    return EVENT_NULL;
  }
 // Andrey 06/04/2021 12:27 Checkboxes for table screen
 
  
  
}
