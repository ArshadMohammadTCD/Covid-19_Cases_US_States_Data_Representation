// Andrey 01/04/2021 17:39
import samuelal.squelized.*;

class DbImport {
public Table table;
public void Run(SQLConnection myConnection){
    // Using a stringBuilder in order to effisciently forms strings for queries
  StringBuilder stringBuilder = new StringBuilder(16000);
  // Forming strings to delete previous table if it previously existed and creating new one if it had not existed previously
  String dropTable = "DROP TABLE IF EXISTS covidData";
  String createNewTable = "CREATE TABLE IF NOT EXISTS covidData(date DATE NOT NULL,area TEXT (100) NOT NULL,county TEXT (100) NOT NULL,geoid INTEGER,cases  INTEGER,country TEXT (100));";

  // Passing those queries to the database
  myConnection.updateQuery(dropTable);
  myConnection.updateQuery(createNewTable);

  // Loading lines from csv file and seperating into variables for their specific columns using .split()
  String[] lines = loadStrings("cases-97k.csv");
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
  
    // Andrey 25/03/2021 #17:56
  // Deleting previous and creating Index to make query's more effective
  
  String deleteIndex = "DROP INDEX IF EXISTS county_id";
  String createIndex = "CREATE INDEX IF NOT EXISTS county_id ON covidData(county);";
  myConnection.updateQuery(deleteIndex);
  myConnection.updateQuery(createIndex);

  print("done");

}
}
