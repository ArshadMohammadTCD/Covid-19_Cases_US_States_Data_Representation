class Cell {
  //
  float x;  // pos 
  float y;
 
  float w;  // size
  float h;
  // 
  color colCellFillRect;  // color rect fill  
  color colCellStroke;    // color rect outline
  color colCellFillText;  // color text
  //
  String textCell = "";   // content 
  //
  // constr 
  Cell ( String text_, float x_, float y_, color cf_, color cs_, color ct_ ) {
    textCell = text_;
    x        = x_;
    y        = y_;
    colCellFillRect = cf_;
    colCellStroke   = cs_;
    colCellFillText = ct_;
  } // constr 
 
  void display () {
    // uses fixed Pos
    // (no scrolling)
    // not in use 
    fill(colCellFillRect);
    stroke(colCellStroke);
    rect(x, y, w, h);
    //
    fill(colCellFillText);
    text ( textCell, x+5, y+3, w, h );
  }
 
  void display2 ( int offsetX, int offsetY  ) {
    // uses fixed Pos PLUS offsetX and offsetY
    // for scrolling
    fill(colCellFillRect);
    stroke(colCellStroke);
    rect(x+offsetX, y+offsetY, 
    w, h);
    //
    fill(colCellFillText);
    text ( textCell, x+5+offsetX, y+14+offsetY);
  }

  void displaySelected ( int offsetX, int offsetY,   color selectCellFillRect,  color selectCellStroke, color selectCellFillText) {
    // uses fixed Pos PLUS offsetX and offsetY
    // for scrolling
    fill(selectCellFillRect);
    stroke(selectCellStroke);
    rect(x+offsetX, y+offsetY, 
    w, h);
    //
    fill(selectCellFillText);
    text ( textCell, 
    x+5+offsetX, y+14+offsetY);
  }


}
