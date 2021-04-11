// Andrey 06/04/2020
class Grid {
  private Table testTable;
  private float topx;
  private float topy;
  private float width;
  private float height;
  private float y;
  Cell grid[][];
  int rowAmount;
  int columnAmount;
  int startX = 0; // startx and starty represent the scrolling
  int startY = 0;
  color titleCellFillRect;  // color rect fill  
  color titleCellStroke;    // color rect outline
  color titleCellFillText;  // color text
  color selectCellFillRect;  // color rect fill  
  color selectCellStroke;    // color rect outline
  color selectCellFillText;  // color text
  int selectedRow; 
  int event;

  Grid(Table t, float x, float y, float w, float h, int event) {
    this.event = event;
    testTable = t;
    topx = x;
    topy = y+(cellHeight+spaceBetweenRows)+spaceBetweenRows*2;
    this.y = y;
    width = w;
    height = h;
    rowAmount = testTable.getRowCount();
    println("rows "+ rowAmount);    
    columnAmount = testTable.getColumnCount();
    println("columns "+ columnAmount);
    if(rowAmount == 0){
      rowAmount = 1;
      TableRow newRow = testTable.addRow();
      for(int i=0; i< columnAmount; i++){
        newRow.setString(i, "");
      }
      newRow.setString(0, "No data");
    }
    grid = new Cell[rowAmount][columnAmount]; // +1 ???  
    titleCellFillRect = color(208, 179, 214);  // color rect fill  
    titleCellStroke = color(252, 255, 31);    // color rect outline
    titleCellFillText = color(0);  // color text

    selectCellFillRect = color(94, 150, 245);  // color rect fill  
    selectCellStroke = color(252, 255, 31);    // color rect outline
    selectCellFillText = color(0);  // color text
    selectedRow = 0;

    for (int i = 0; i < rowAmount; i++ ) {
      for (int j = 0; j < columnAmount; j++)
      {
        //println(i, j);
        grid[i][j] = new Cell (testTable.getString(i, j), i * (width/columnAmount) + 12, j * (cellHeight+11)+12, color (255, 255, 240), color (251, 255, 31), color(0) );
        grid[i][j].w = ColumnMinWidth;
        grid[i][j].h = cellHeight;
      }
    }
    // measure max width of each column 
    float [] widthOfColumns = new float [columnAmount];
    for (int j = 0; j < columnAmount; j++ ) {
      for (int i = 0; i < rowAmount; i++)
      {
        // find the longest text

        float colw = textWidth(testTable.getString(i, j))+14;
        if (widthOfColumns[j] < colw) 
          widthOfColumns[j] = colw;
      }
    }

    // assign the width from above to the columns cells
    for (int j = 0; j < columnAmount; j++ ) {
      for (int i = 0; i < rowAmount; i++)
      {
        // make sure all columns are at least minWidthColumn wide
        widthOfColumns[j] = max (widthOfColumns[j], ColumnMinWidth); 
        grid[i][j].w = widthOfColumns[j];
      }
    }

    // assign the x values to cells. 
    float xCount = topx+ spaceBetweenColumns;
    for (int j = 0; j < columnAmount; j++ ) {
      for (int i = 0; i < rowAmount; i++)
      {
        grid[i][j].x = xCount;
      }
      xCount += widthOfColumns[j] + spaceBetweenColumns;
    }
    // assign the y values to cells. 
    float yCount = topy+ spaceBetweenRows;
    for (int i = 0; i < rowAmount; i++ ) {
      for (int j = 0; j < columnAmount; j++)
      {
        grid[i][j].y = yCount;
      }
      yCount += (cellHeight+spaceBetweenRows);
    }
    width = grid[0][columnAmount-1].x + widthOfColumns[columnAmount-1]+spaceBetweenColumns- topx;
  }

  void displayHeader(int j) {
    float x = grid[0][j].x;
    float y = this.y + spaceBetweenRows*2;
    float w = grid[0][j].w;
    float h = cellHeight;
    fill(titleCellFillRect);
    stroke(titleCellStroke);
    rect(x, y, w, h);
    //
    fill(titleCellFillText);
    text ( testTable.getColumnTitle(j), x+5, y+3, w, h );
  }

  void draw() {

   fill(120);
    stroke(0);
    rect(topx, y, width, height); 
    for (int j = 0; j < columnAmount; j++) {
      
      displayHeader(j);
    }
    for (int i = 0; i < rowAmount; i++) {

      if (startY+ grid[i][0].y + cellHeight > this.y+height) {
        break;
      }

      for (int j = 0; j < columnAmount; j++) {
        if(startY+grid[i][j].y > topy)
        grid[i][j].display2(startX, startY);
      }
    }
    for (int j = 0; j < columnAmount; j++) {
      grid[selectedRow][j].displaySelected(startX, startY, selectCellFillRect, selectCellStroke, selectCellFillText);
     
    }
  }

  String keyProcess(int keyCode, int key)
  {
    //println(keyCode);
    if (keyCode==UP) {
      selectedRow--;
    } else if (keyCode==DOWN) {
      selectedRow++;
    } else if (keyCode==LEFT) {
      //startX -=10;
    } else if (keyCode==RIGHT) {
      //startX +=10;
    } 
    else if ( key == ENTER){
      return testTable.getString(selectedRow,0);
    }
    //---
    // Home / reset 
    else if (keyCode=='h'||keyCode=='H') {
      startX = 0;
      startY = 0;
      selectedRow = 0;
    }
    //--------------------------
    // boundaries 
     
       
     
    if(selectedRow >= 0 && selectedRow < rowAmount  && 
      grid[selectedRow][0].y + cellHeight + spaceBetweenRows*2 > this.y+height-startY){
      println("hit y-- "+grid[selectedRow][0].y + " height "+cellHeight+ " space "+spaceBetweenRows*2);
      println("y "+this.y, " this.height " +height);
      startY -= (cellHeight + spaceBetweenRows);
      println("startY  "+startY);
    }
    if(selectedRow >= 0 && selectedRow < rowAmount  && 
      grid[selectedRow][0].y - spaceBetweenRows < topy-startY){
      println("hit y++");
      println("grid y "+grid[selectedRow][0].y + " height "+cellHeight+ " space "+spaceBetweenRows*2);
      println("y "+this.y, " this.height " +height);
      
      startY += (cellHeight + spaceBetweenRows);
      println("startY  "+startY);      
    }
     if(selectedRow < 0) selectedRow = 0;  
     if(selectedRow >= rowAmount) selectedRow = rowAmount-1;

      return "";
  }
  
  int getEvent(int mX, int mY)
  {
    if ((mX > topx) && (mX < topx+width) && (mY > y) && (mY < y+height))
    {
      System.out.print("grid event " + event + " selected ");
      return event;
    }
    return EVENT_NULL;
  }
  
}
