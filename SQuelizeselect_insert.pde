
// In order to establish connection to database we use and import SQuelized librabry
import samuelal.squelized.*;
void setup() {
  SQLConnection myConnection = new SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\sqlite\\covid_data.db");
  // Code with several examples of how to form queries for data, Look at sqlite tutorial site from important links for more commands and examples //<>// //<>//
  String query = "SELECT * FROM covidData WHERE county = 'Wyoming'";
  int time1 = millis();
 // Table testTable = myConnection.runQuery(query);
  int time2 = millis();
//  printTable(testTable);
  System.out.println(time2-time1);
// String query2 = "SELECT area,county,cases FROM covidData WHERE date = DATE('2021-02-20') AND area LIKE '%Virginia%'";  
  //query = "SELECT county, SUM(cases) AS SUM, AVG(cases) AS AVG FROM covidData WHERE date = DATE('2021-02-20') GROUP BY county ORDER BY SUM DESC LIMIT 10";   
  time1 = millis();
  //Table testTable2 = myConnection.runQuery(query2);
  time2 = millis();
   
  // printTable(testTable2);
   System.out.println(time2-time1);
   
}

void printTable(Table table) {

  for (TableRow row : table.rows())
  {
    for (int i = 0; i < row.getColumnCount(); i++)
    {
      System.out.print(row.getString(i) + "  ");
    }
    System.out.println();
  }
}
