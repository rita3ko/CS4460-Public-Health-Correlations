import java.awt.Polygon; 

public class State{
  private String name;
  private Poly polygon;
  
  private boolean highlight;
  
  // --- If it's being accessed in another window
  private boolean brushing;
  private color stateColor;
  
  private StateData data;
  private int centerX;
  private int centerY;
  private String abb;
  
  public  color highlightColor= color(34,203,100);
  public  color brushingColor= color(0,10,100);
  
  public color gray;

  
  public State(String name, String abb, Poly polygon, int centerX, int centerY, int workers, int alone, int carpooled, int publicTrans, int walked, int other, int home, float travelTime){
    this.name = name;
    this.polygon = polygon;
    
    gray = color(random(75)+25);
    this.abb = abb;
    
    this.centerX = centerX;
    this.centerY = centerY;

    data = new StateData(name, workers, alone, carpooled, publicTrans, walked, other, home, travelTime);
    
    highlight = false;
    brushing = false;
    stateColor = createColor();
  }
  
  public String getName(){
    return name;
  }
  
  public color createColor(){
   // this.stateColor = workers%1000000;
   //int[] saturation = {65, 12, 
    return color(random(100), random(80)+20, random(10)+90); //random(10)+90
  }
  
  public void setHighlight(boolean tf){
    highlight = tf;
  }
  
  public void setBrushing(boolean tf){
    brushing = tf;
  }
  
  public boolean contains(int mx, int my){
    if (filterOn==0 && polygon.contains(mx,my)){
      highlight = true;
    }
    return highlight;
  }
  
  public State draw(){
    State ret = null;
    if(filterOn==1){
      fill(gray);
      noStroke();
      polygon.draw();
    }
    else{
      if (brushing){
        fill(brushingColor);
        strokeWeight(3);
        stroke(stateColor); //work on this
      }
      else if (highlight){
        fill(stateColor);
        strokeWeight(4);
        stroke(color(10,10,100)); //work on this
        ret = this;
      }
      else{
        fill(stateColor);
        noStroke();
      }
      
    }
    
    polygon.draw();
      drawName();
      

    return ret;
  }
  
  public void drawName(){
     //-- Draw Names of State
    textFont(font14, 14);
    textAlign(CENTER,CENTER);
    fill(0);
    text(abb, centerX, centerY);
  }
  
  public void dataBox(){
    //data.drawBox(mouseX,mouseY);
    data.drawBox(centerX,centerY);
  } 
  
  public StateData getStateData(){
    return data;
  }
  
  public int getCenterX(){
     return centerX;
  }
  
  public int getCenterY(){
     return centerY;
  }
  
  public int getWorkers(){
     return data.getWorkers();
  }
}

public class StateComparator implements Comparator<State> {
    boolean numOrPerc;
    int dataType;
    public StateComparator(boolean numOrPerc, int dataType){
        this.numOrPerc= numOrPerc;
        this.dataType= dataType;
        

    }
    
    @Override
    public int compare(State state1, State state2) {  //number or percentage
        int answer = 0;
        float[] data1 = (state1.getStateData().getDataArray());
        float[] data2 = (state2.getStateData().getDataArray());
        
        

       // if(this.numOrPerc){
          answer = (int)(data2[dataType]-data1[dataType]);
       /*}
        else{
          int worker1 = state.1.getWorkers();
          int worker2 = state.2.getWorkers();
          answer = data2[dataType]/worker1 - data1[dataType]/worker2;
        }*/
       return answer;
    }
}


