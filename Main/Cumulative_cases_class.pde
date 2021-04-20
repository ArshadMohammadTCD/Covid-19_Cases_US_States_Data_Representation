// Andrey 06/04/2020 22:00
import samuelal.squelized.*;
class CumulativeCasesScreen extends Screen {
  ArrayList gridList = new ArrayList();
  SQLConnection connection;
  TextWidget dateInput;
  TextWidget countyInput;
  TextWidget totalInput;
  Button dateNow;
  Grid casesByState;
  Grid casesByArea;
  Button updateInfo;
  DataSource casesByStateDs;
  DataSource casesByAreaDs;
  DataSource casesTotalDs;
  int selected_event;

  CumulativeCasesScreen(
    SQLConnection myConnection, PImage screenBackground) {
    super(screenBackground);
    connection = myConnection;
    selected_event = EVENT_NULL;

    dateInput = new TextWidget(910, 620, 80, 30, "28/04/2020", color(255), EVENT_TEXTWIDGET_1, 10, true);
    this.addTextWidget(dateInput);
    countyInput = new TextWidget(1475, 265, 100, 30, "Alabama", color(200), EVENT_TEXTWIDGET_2, 30, false);
    this.addTextWidget(countyInput);

    String queryTotal = "SELECT SUM(cases) AS cases FROM covidData WHERE date < '"+ dateInput.label + "'";    
    casesTotalDs = new DataSource(connection, queryTotal);
    totalInput = new TextWidget(260, 265, 100, 30, casesTotalDs.table.getString(0, 0), color(200), EVENT_TEXTWIDGET_3, 30, false);
    this.addTextWidget(totalInput);
    
    updateInfo = new Button(850, 800, 200, 40, "Update Table", color(100), mainFont, EVENT_UPDATE_TABLE, 870);
    addButton(updateInfo);

    setupData(false);
  }
  void setupData(boolean refresh) {
    if (refresh) {
      gridList.remove(casesByState);
      gridList.remove(casesByArea);
    }
  /// Andrey 19/04/2021 01:31 Changes to add population
  String queryByState = "SELECT county, SUM(cases) AS cases,p.populationTotal as population,((SUM(cases)/(p.populationTotal))*1000000) as casePerM FROM covidData c join popData p on c.geoid/1000 = p.stateid AND (p.geoid%1000 == 0)WHERE date <= '"+ ConvertDate(dateInput.label) + "' GROUP BY 1 ORDER BY 1 ASC";
   // String queryByState = "SELECT county, SUM(cases) AS cases,p.populationTotal as population FROM covidData c join popData p on c.geoid = p.geoid OR ((p.geoid % 1000) == 0) WHERE date <= '"+ ConvertDate(dateInput.label) + "' GROUP BY 1 ORDER BY 1 ASC";
    String queryByArea = "SELECT area, SUM(cases) AS cases,p.populationTotal as population,((SUM(cases)/(p.populationTotal))*1000000) as casePerM FROM covidData c join popData p on c.geoid = p.geoid  WHERE date <= '"+ ConvertDate(dateInput.label) + "' and county = '"+countyInput.label+"' GROUP BY 1 ORDER BY 1 ASC";
    
    if (connection == null) {
      println("connection null");
    }
    casesByStateDs = new DataSource(connection, queryByState);
    casesByState = new Grid(casesByStateDs.table, 150, 330, 600, 600, EVENT_GRID_1);
    gridList.add(casesByState);
    casesByAreaDs = new DataSource(connection, queryByArea);
    casesByArea = new Grid(casesByAreaDs.table, 1390, 330, 600, 600, EVENT_GRID_2);
    gridList.add(casesByArea);
  }

  void drawFocus(){
     switch(selected_event){
      case EVENT_TEXTWIDGET_1:
        fill(94, 150, 245);        
        rect(dateInput.x-4,dateInput.y-4, dateInput.width+8, dateInput.height+8);      
      break;
      case EVENT_GRID_1:
        fill(94, 150, 245);        
        rect(casesByState.topx-16,casesByState.y-16, casesByState.width+32, casesByState.height+32);        
      break;
      case EVENT_GRID_2:
        fill(94, 150, 245);
        rect(casesByArea.topx-16,casesByArea.y-16, casesByArea.width+32, casesByArea.height+32);        
      break;
    }  
    
  }
  
  void draw() {
    
    super.draw();
    drawFocus();
    textSize(14);    
    for (int i=0; i< textWidgetList.size(); i++)
    {
      TextWidget currentTextWidget = (TextWidget) textWidgetList.get(i);
      currentTextWidget.draw();
    }
    textSize(14);
    for (int i=0; i< gridList.size(); i++)
    {
      Grid currentGrid = (Grid) gridList.get(i);
      stroke(57, 57, 57);
      fill(193,193,193);
      rect(currentGrid.topx-10, currentGrid.y-10, currentGrid.width+20, currentGrid.height+20);
      currentGrid.draw();
    }
    //textSize(20);
    //textSize(20);
    fill(237, 237, 237);
    textFont(largeFont);
    textSize(24);
    text("Date :", 920, 600);
    text("Total cases over all counties :",170,250);
    text("Total cases over all area's in the county :",1340,250);
    text("Select a county on the left table using the up/down \n              keys, and press Enter to choose it.",700,300);
    text("Select a date using the text box below and click the \n 'Update Table' button below to see the cumulative \n      cases in your chosen state and area for your \n                              selected date.",700,400);
    fill(237, 237, 237);
    stroke(57, 57, 57);
    rect(700, 245, 510, 3);
    rect(700, 355, 510, 3);
    rect(700, 520, 510, 3);
    rect(700, 570, 510, 3);
    rect(700, 665, 510, 3);
    rect(700, 865, 510, 3);
    rect(700, 775, 510, 3);
  }

  int getEvent()
  {
    int event = super.getEvent();
    if (event != EVENT_NULL) {
      return event;
    }

      for (int i=0; i< textWidgetList.size(); i++)
      {
        TextWidget currentTextWidget = (TextWidget) textWidgetList.get(i);
        event = currentTextWidget.getEvent(mouseX, mouseY);
        if (event!=EVENT_NULL)
        {
          return event;
        }
      }


      for (int i=0; i< gridList.size(); i++)
      {
        Grid currentGrid = (Grid) gridList.get(i);
        event = currentGrid.getEvent(mouseX, mouseY);
        if (event!=EVENT_NULL)
        {
          return event;
        }
      }

    return EVENT_NULL;      
  }
  
  void processEvent(int event){
    
    switch(event){
      case EVENT_TEXTWIDGET_1:
      selected_event = event;  
      break;
      case EVENT_TEXTWIDGET_2:
      //selected_event = event;
      break;
      case EVENT_GRID_1:
      selected_event = event;
      break;
      case EVENT_GRID_2:
      selected_event = event;
      break;

    }
  }
  
  void processKey(int key_code, int key_pressed){
    switch(selected_event){
      case EVENT_TEXTWIDGET_1:      
        dateInput.append((char)key_pressed);                
      break;
      case EVENT_TEXTWIDGET_2:
        //countyInput.append((char)key_pressed);
      break;
      case EVENT_GRID_1:
         String state = casesByState.keyProcess(key_code,key_pressed);
         if(state.length() > 0){
           countyInput.label = state;
         }
      break;
      case EVENT_GRID_2:
         casesByArea.keyProcess(key_code,key_pressed);    
      break;
    }
    
    
  }

}
