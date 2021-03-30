class Bar {

  float population;
  float speed;
  int xpos;
  float ypos;
  int counter;
  color blockColour;
  float blockWidth;
  float blockHeight;

  Bar( float population, int xpos, float mappedWidth ) {
    this.xpos = xpos;
    this.ypos = 850;
    this.speed = population/60;
    this.counter = 0;
    this.blockHeight = 0;
    this.blockWidth = mappedWidth;
    this.blockColour = color(random(0, 255), random(0, 255), random(0, 255));
  }

  void draw() {
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
