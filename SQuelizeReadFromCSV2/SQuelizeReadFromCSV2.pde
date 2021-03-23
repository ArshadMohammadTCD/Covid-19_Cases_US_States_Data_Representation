// In order to establish connection to database we use and import SQuelized librabry
import samuelal.squelized.*;
Table table;
SQLConnection myConnection;
void setup() {
  // Using a stringBuilder in order to effisciently forms strings for queries
  StringBuilder stringBuilder = new StringBuilder(16000);
  myConnection = new SQLiteConnection("jdbc:sqlite:/D:\\Users\\Andrey\\sqlite\\covid_data.db");

  // Forming strings to delete previous table if it previously existed and creating new one if it had not existed previously
  String dropTable = "DROP TABLE IF EXISTS covidData";
  String createNewTable = "CREATE TABLE IF NOT EXISTS covidData(date DATE NOT NULL,area TEXT (100) NOT NULL,county TEXT (100) NOT NULL,geoid INTEGER,cases  INTEGER,country TEXT (100));";

  // Passing those queries to the database
  myConnection.updateQuery(dropTable);
  myConnection.updateQuery(createNewTable);

  // Loading lines from csv file and seperating into variables for their specific columns using .split()
  String[] lines = loadStrings("cases97k.csv");
  String date[] = new String[lines.length];
  String[] area = new String[lines.length];
  String[] county = new String[lines.length];
  String[] geoid = new String[lines.length];
  String[] cases = new String[lines.length];
  String[] country = new String[lines.length];
  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    String string = lines[i];
    String[] splitString = string.split(",", -1);
    date[i] = splitString[0];
    area[i] = splitString[1];
    county[i] = splitString[2];
    geoid[i] = splitString[3];
    cases[i] = splitString[4];
    country[i]= splitString[5];
  }

  // For loop that goes through each row of data and forms a query using stringBuilder class and variables of data
  stringBuilder.append("INSERT INTO covidData(date,area,county,geoid,cases,country) VALUES");
  for (int k = 1; k<lines.length; k++) {
    stringBuilder.append("(");
    stringBuilder.append('"');
    stringBuilder.append(date[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(area[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(county[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(geoid[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(cases[k]);
    stringBuilder.append("\",\"");
    stringBuilder.append(country[k]);
    stringBuilder.append("\")");
    //Print for testing purposes(Can be removed)
    if (k % 3000 == 0) {
      println(k);
    }
    // Joins each line  except last line of string together using commas so it registers as one long query
    if (k != lines.length-1) {
      stringBuilder.append(",");
    }
  }
  // Sends that query to database
  myConnection.updateQuery(stringBuilder.toString());
  print("done");
  
  // Code with several examples of how to form queries for data, Look at sqlite tutorial site from important links for more commands and examples //<>//
  String query = "SELECT * FROM covidData WHERE county = 'Wyoming'";
  int time1 = millis();
  Table testTable = myConnection.runQuery(query);
  int time2 = millis();
  printTable(testTable);
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


// In order to establish connection to database we use and import SQuelized librabry
