class Bar {

  String areaName;
  float population;
  float speed;
  int xpos;
  float ypos;
  int counter;
  color blockColour;
  float blockWidth;
  float blockHeight;
  boolean mouseOver;

  Bar( float population, int xpos, float mappedWidth, String areaName ) {
    this.areaName = areaName;
    this.xpos = xpos;
    this.ypos = 850;
    this.speed = population/60;
    this.counter = 0;
    this.blockHeight = 0;
    this.blockWidth = mappedWidth;
    this.blockColour = color(random(0, 255), random(0, 255), random(0, 255));
    mouseOver = false;
  }

  void draw() {
    if (mouseOver) {
      stroke(255);
    } else {
      stroke(0);
    }
    fill(blockColour);
    rect(xpos, ypos, blockWidth, blockHeight);
    if ( counter <= 90 ) {
      ypos -= speed;
      counter++;
      blockHeight += speed;
      if ( speed - 0.075 > 0.5 ) {
        speed -= 0.075;
      }
    }
  }
}
