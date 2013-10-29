
public class StateData{
  // --- Called during app to populate all states. ----
  
  private int[] dataArray;
  
  public StateData(String name, int year, int healthExp, int population){               

    
    int[] anArray = {year, healthExp, population};
    
    dataArray = anArray;
    

  }
  

  // --- Draw Hover Box ----
  public void drawBox(int mx, int my){
    fill(2,2,2,60);
    noStroke();
    rect(mx,my, 20, 20);
  }
  
}
