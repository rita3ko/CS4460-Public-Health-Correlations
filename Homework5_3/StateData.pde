
public class StateData{
  // --- Called during app to populate all states. ----
  
  private float travelTime;
  private float[] dataArray;
  private float[] percArray;
  
  private int workers;
  
  public StateData(String name, int workers, int alone, 
                    int carpooled, int publicTrans, int walked, int other, int home, float travelTime){               
    float workDivide = (float)workers;
    percArray = new float[6];
    
    float[] anArray = {alone, carpooled, publicTrans, walked, other, home};
    
    for(int i=0; i<anArray.length; i++){
      percArray[i] = (100*(anArray[i]/workDivide));
    }
    
    dataArray = anArray;
    
    this.travelTime = travelTime;
    this.workers = workers;
  }
  
  public float[] getDataArray(){
    if(numOrPerc)
      return dataArray;
    else
      return percArray;
  }
  
  public float[] getPercArray(){
      return percArray;
  }
  
  public int getWorkers(){
    return workers;
  }
  
  // --- Draw Hover Box ----
  public void drawBox(int mx, int my){
    fill(2,2,2,60);
    noStroke();
    rect(mx,my, 20, 20);
  }
  
}
