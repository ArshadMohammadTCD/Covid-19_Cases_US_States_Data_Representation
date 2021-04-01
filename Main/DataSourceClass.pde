//Andrey 01/04/2021 17:39
import samuelal.squelized.*;

class DataSource {
public Table table;
public SQLConnection myConnection;
public DataSource(SQLConnection myConnection, String query){
    table = myConnection.runQuery(query);
}
}
