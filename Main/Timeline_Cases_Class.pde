// Andrey 11/04/2021 15:30
import samuelal.squelized.*;
class TimelineCasesScreen extends Screen {
  ArrayList gridList = new ArrayList();
  SQLConnection connection;
  TextWidget dateFrom;
  TextWidget dateTo;
  TextWidget countyInput;
  TextWidget areaInput;
  TextWidget timelineInput;
  Button dateNow;
  Grid casesByState;
  Grid casesByArea;
  Grid casesTimeline;
  Button updateInfo;
  DataSource casesByStateDs;
  DataSource casesByAreaDs;
  DataSource casesTotalDs;
  DataSource casesTimelineDs;
  int selected_event;

  TimelineCasesScreen (
    SQLConnection myConnection, PImage screenBackground) {
    super(screenBackground);
    connection = myConnection;
    selected_event = EVENT_NULL;


    countyInput = new TextWidget(240, 450, 100, 30, " All counties", color(200), EVENT_TEXTWIDGET_2, 30, false);
    this.addTextWidget(countyInput);
    areaInput =  new TextWidget(620, 450, 200, 30, " All areas", color(200), EVENT_TEXTWIDGET_4, 30, false);
    this.addTextWidget(areaInput);
    dateFrom = new TextWidget(1555, 530, 80, 30, "28/01/2020", color(255), EVENT_TEXTWIDGET_1, 10, true);
    this.addTextWidget(dateFrom);
    dateTo = new TextWidget(1555, 640, 80, 30, "28/04/2020", color(255), EVENT_TEXTWIDGET_3, 10, true);
    this.addTextWidget(dateTo);

    updateInfo = new Button(1497, 780, 200, 40, "Update Table", color(100), mainFont, EVENT_UPDATE_TABLE, 1522);
    addButton(updateInfo);

    setupData(false);
  }
  void setupData(boolean refresh) {
    if (refresh) {
      gridList.remove(casesByState);
      gridList.remove(casesByArea);
      gridList.remove(casesTimeline);
    }
//  String queryByState = "SELECT county, SUM(cases) AS cases,p.populationTotal as populationTotal FROM covidData c join popData p on c.geoid = p.geoid WHERE date <= '"+ ConvertDate(dateInput.label) + "' GROUP BY 1 ORDER BY 1 ASC";
   // String queryByArea = "SELECT area, SUM(cases) AS cases,p.populationTotal as populationTotal FROM covidData c join popData p on c.geoid = p.geoid  WHERE date <= '"+ ConvertDate(dateInput.label) + "' and county = '"+countyInput.label+"' GROUP BY 1 ORDER BY 1 ASC";
    String queryByState = "select ' All counties' as county UNION select  distinct county from covidData ORDER BY 1 ASC";
    String queryByArea;
    if (countyInput.label.equals(" All counties")) { 
      queryByArea = "select ' All areas' as area UNION SELECT distinct area FROM covidData ORDER BY 1 ASC";
    } else {
      queryByArea = "select ' All areas' as area UNION SELECT distinct area FROM covidData WHERE county = '"+countyInput.label+"' ORDER BY 1 ASC";
    }
    String queryTimeline;
    if(countyInput.label.equals(" All counties")){
      queryTimeline= "select date, SUM(cases) as cases,((SUM(cases)/SUM(p.populationTotal))*1000000) as casePerM FROM covidData c join popData p on c.geoid/1000 = p.stateid AND (p.geoid%1000 == 0) WHERE date BETWEEN '"+ConvertDate(dateFrom.label)+"' AND '"+ConvertDate(dateTo.label)+"' GROUP BY DATE ORDER BY 1 DESC";
      //  queryTimeline= "select date, SUM(cases) as cases,p.populationTotal as population FROM covidData c join popData p on c.geoid = p.geoid WHERE date BETWEEN '"+ConvertDate(dateFrom.label)+"' AND '"+ConvertDate(dateTo.label)+"' GROUP BY DATE ORDER BY 1 DESC";
    }
    else {
      if(areaInput.label.equals(" All areas")){
        queryTimeline= "select date, SUM(cases) as cases,((SUM(cases)/SUM(p.populationTotal))*1000000) as casePerM FROM covidData c join popData p on c.geoid = p.geoid WHERE county = '"+countyInput.label+"' AND date BETWEEN '"+ConvertDate(dateFrom.label)+"' AND '"+ConvertDate(dateTo.label)+"' GROUP BY DATE ORDER BY 1 DESC";
      }
      else {
         queryTimeline= "select date, SUM(cases) as cases,((SUM(cases)/p.populationTotal)*1000000) as casePerM FROM covidData c join popData p on c.geoid = p.geoid   WHERE area = '"+areaInput.label+"' AND county = '"+countyInput.label+"' AND date BETWEEN '"+ConvertDate(dateFrom.label)+"' AND '"+ConvertDate(dateTo.label)+"' GROUP BY DATE ORDER BY 1 DESC";
      }
      
    }
    println(queryByState);


    if (connection == null) {
      println("connection null");
    }
    casesByStateDs = new DataSource(connection, queryByState);
    casesByState = new Grid(casesByStateDs.table, 240, 520, 600, 400, EVENT_GRID_1);
    gridList.add(casesByState);
    casesByAreaDs = new DataSource(connection, queryByArea);
    casesByArea = new Grid(casesByAreaDs.table, 630, 520, 600, 400, EVENT_GRID_2);
    gridList.add(casesByArea);
    casesTimelineDs = new DataSource(connection, queryTimeline);
    casesTimeline = new Grid(casesTimelineDs.table, 1200, 300, 600, 600, EVENT_GRID_3);
    gridList.add(casesTimeline);
  }

  void drawFocus() {
    switch(selected_event) {
    case EVENT_TEXTWIDGET_1:
      fill(94, 150, 245);        
      rect(dateFrom.x-4, dateFrom.y-4, dateFrom.width+8, dateFrom.height+8);      
      break;
    case EVENT_TEXTWIDGET_3:
      fill(94, 150, 245);        
      rect(dateTo.x-4, dateTo.y-4, dateTo.width+8, dateTo.height+8);      
      break;

    case EVENT_GRID_1:
    println("Grid1");
      fill(94, 150, 245);        
      rect(casesByState.topx-16, casesByState.y-16, casesByState.width+32, casesByState.height+32);        
      break;
    case EVENT_GRID_2:
    println("Grid2");
      fill(94, 150, 245);
      rect(casesByArea.topx-16, casesByArea.y-16, casesByArea.width+32, casesByArea.height+32);        
      break;
    case EVENT_GRID_3:
      println("Grid3");
      fill(94, 150, 245);
      rect(casesTimeline.topx-16, casesTimeline.y-16, casesTimeline.width+32, casesTimeline.height+32);
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
    
    fill(237, 237, 237);
    textFont(largeFont);
    textSize(24);
    text("Date from:", 1545, 500);
    text(" to:", 1575, 610);
    text("Selected County:", 240, 420);
    text("Selected Area:", 620, 420);
    textSize(26);
    text("Select your desired County/Area by using the up/down keys and press Enter to \nchoose it and view the Cases Timeline.", 100, 250);
    fill(237, 237, 237);
    stroke(57, 57, 57);
    rect(100, 300, 950, 3);
    rect(1130, 250, 660, 3);
    rect(1130, 950, 660, 3);
    rect(100, 370, 950, 3);
    rect(100, 950, 950, 3);
     
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

  void processEvent(int event) {

    switch(event) {
    case EVENT_TEXTWIDGET_1:
      selected_event = event;  
      break;
    case EVENT_TEXTWIDGET_3:
      selected_event = event;  
      break;
    case EVENT_GRID_1:
      selected_event = event;
      break;
    case EVENT_GRID_2:
      selected_event = event;
      break;
    case EVENT_GRID_3:
      selected_event = event;
      break;
    }
  }

  void processKey(int key_code, int key_pressed) {
    switch(selected_event) {
    case EVENT_TEXTWIDGET_1:      
      dateFrom.append((char)key_pressed);                
      break;
    case EVENT_TEXTWIDGET_3:      
      dateTo.append((char)key_pressed);                
      break;      
    case EVENT_GRID_1:
      String state = casesByState.keyProcess(key_code, key_pressed);
      if (state.length() > 0) {
        countyInput.label = state;
        areaInput.label = " All areas";
        setupData(true);
      }
      break;
    case EVENT_GRID_2:
      String area = casesByArea.keyProcess(key_code, key_pressed);
      if (area.length() > 0) {
        areaInput.label = area;
        setupData(true);
      }
      break;
      
      case EVENT_GRID_3:
      casesTimeline.keyProcess(key_code, key_pressed);
      break;
      
      
      
      
    }
  }
}
