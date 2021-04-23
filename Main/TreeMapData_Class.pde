

// 19/04/2021 Arshad
// This is a parallel object array loop
// what this holds is the actual state names of each rectangle for each date present

class TreeMapData
  {
    String[] stateNames; 
    String date;
    TreeMapData (String theArray[], String date)
      {
        this.date = date;
        stateNames = new String[SIZE_OF_TREE_MAP];
        for (int i = 0; i < theArray.length; i++)
        {
          stateNames[i] = theArray[i];
        }
        
        
    }
  }
