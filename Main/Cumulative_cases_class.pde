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

    dateInput = new TextWidget(150, 100, 80, 30, "28/04/2020", color(255), EVENT_TEXTWIDGET_1, 10, true);
    this.addTextWidget(dateInput);
    countyInput = new TextWidget(650, 240, 100, 30, "Alabama", color(200), EVENT_TEXTWIDGET_2, 30, false);
    this.addTextWidget(countyInput);

    String queryTotal = "SELECT SUM(cases) AS cases FROM covidData WHERE date < '"+ dateInput.label + "'";    
    casesTotalDs = new DataSource(connection, queryTotal);
    totalInput = new TextWidget(150, 240, 100, 30, casesTotalDs.table.getString(0, 0), color(200), EVENT_TEXTWIDGET_3, 30, false);
    this.addTextWidget(totalInput);
    
    updateInfo = new Button(650, 100, 200, 40, "Update Table", color(100), mainFont, EVENT_UPDATE_TABLE, 670);
    addButton(updateInfo);

    setupData();
  }
  void setupData() {


    String queryByState = "SELECT county, SUM(cases) AS cases FROM covidData WHERE date < '"+ dateInput.label + "' GROUP BY 1 ORDER BY 1 ASC";
    String queryByArea = "SELECT area, SUM(cases) AS cases FROM covidData WHERE date < '"+ dateInput.label + "' and county = '"+countyInput.label+"' GROUP BY 1 ORDER BY 1 ASC";
    println(queryByState);
    println(queryByArea);

    if (connection == null) {
      println("connection null");
    }
    casesByStateDs = new DataSource(connection, queryByState);
    casesByState = new Grid(casesByStateDs.table, 50, 300, 600, 600, EVENT_GRID_1);
    gridList.add(casesByState);
    casesByAreaDs = new DataSource(connection, queryByArea);
    casesByArea = new Grid(casesByAreaDs.table, 650, 300, 600, 600, EVENT_GRID_2);

    gridList.add(casesByState);
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
        rect(casesByState.topx-4,casesByState.y-4, casesByState.width+8, casesByState.height+8);        
      break;
      case EVENT_GRID_2:
        fill(94, 150, 245);
        rect(casesByArea.topx-4,casesByArea.y-4, casesByArea.width+8, casesByArea.height+8);        
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
      currentGrid.draw();
    }
    textSize(20);
    text("Date :", 90, 125);
    text("Total cases over \nall counties :",10,240);
    text("Total cases over \nall area's in the county :",450,240);
    text("Select a county using up/down keys \nand press enter to choose it.",50,935);
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

//Andrey 06/04/2021 12:22
/*
 
 
 int textWidgetEvent = currentScreen.getTextWidgetEvent(); 
 switch(textWidgetEvent) {
 case EVENT_TEXTWIDGET_1:
 focus = (TextWidget)textWidget1;
 break; 
 case EVENT_TEXTWIDGET_2:
 focus = (TextWidget)textWidget2;
 break; 
 case EVENT_TEXTWIDGET_3:
 focus = (TextWidget)textWidget3;
 break; 
 case EVENT_TEXTWIDGET_4:
 focus = (TextWidget)textWidget4;
 break; 
 case EVENT_TEXTWIDGET_5:
 focus = (TextWidget)textWidget5;
 break; 
 case EVENT_TEXTWIDGET_6:
 focus = (TextWidget)textWidget6;
 break; 
 default:
 
 }
 
 String newQuery = "SELECT ";
 //Andrey 06/04/2021 13:27
 
 
 case EVENT_UPDATE_TABLE:
 
 
 // default:
 // newQuery += "* FROM covidData WHERE county = 'California'";
 }
 //Andrey 06/04/2021 16:21
 
 
 
 */
