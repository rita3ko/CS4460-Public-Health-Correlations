import java.awt.Polygon; 

public class Map{
  
 
  
  private ArrayList<State> stateList = new ArrayList<State>(50);
  // not exactly x and y
  
  XML xml;
  
  public Map(){ 
    
    xml = loadXML("statesCoord.xml");
    JSONArray stateData = loadJSONArray("map.json");
    
    XML[] state = xml.getChildren("state");
    
    int relX = 1550;
    int relY = 900;
    int scaleX = 12;
    int scaleY = -15;
    
    //make Hawaii
    makeState(state, stateData, 0, 2260, 750, 13, -13);
    
    //make Alaska
     makeState(state, stateData, 1, 700, 850, 4, -6);
    
    for(int i=2; i<state.length; i++){ //draw Hawaii and Alaska separately
      makeState(state, stateData, i, relX, relY, scaleX, scaleY);
    }

     
    for (State st: stateList){
      st.draw();
    }  
  }
  
  public void makeState(XML[] state, JSONArray stateData, int i, int relX, int relY, int scaleX, int scaleY){
      
      XML[] point = state[i].getChildren("point");
      int pointCount = point.length;
      
      int centerX = relX+int(scaleX* state[i].getFloat("lng"));
      int centerY = relY+int(scaleY* state[i].getFloat("lat"));
      
      int[] x = new int[pointCount];
      int[] y = new int[pointCount];
      for(int j=0; j<pointCount; j++){
        x[j]= relX+int(scaleX* point[j].getFloat("lng"));
        y[j]= relY+int(scaleY* point[j].getFloat("lat"));
        
      }
      Poly shape = new Poly(x,y,pointCount);
      String name = reader.getString(i+1,0);
      int year = reader.getInt(i+1,1);
      int population = reader.getInt(i+1,2);
      float medianIncome = reader.getFloat(i+1,3);
      int healthExp = 0;
      try {
        healthExp = reader.getInt(i+1,4);
      } catch (NullPointerException e) {
        healthExp = 0;
      }
      float noInsCoverage = reader.getFloat(i+1,5);
      float insCoverage = reader.getFloat(i+1,6);
      float employmentBased = reader.getFloat(i+1,7);
      float directPurchase = reader.getFloat(i+1,8);
      float government = reader.getFloat(i+1,9);
      float medicaid = reader.getFloat(i+1,10);
      float medicare = reader.getFloat(i+1,11);
      float military = reader.getFloat(i+1,12);
      //println(name + " " + year+ " " + population + " " + healthExp + " " + insCoverage);
       State aState = new State(name, state[i].getString("abb"), 
          shape, centerX, centerY, year, population, medianIncome, healthExp,
          noInsCoverage, insCoverage, employmentBased, directPurchase,
          government, medicaid, medicare, military);
      
      stateList.add(aState);
  }
  
  public void brush(State state){
    for (State aState: stateList){
      aState.setBrushing(false);
    }
    int index = stateList.indexOf(state);
    if (index!=-1){
      State myState = stateList.get(index);
      myState.setBrushing(true);

    }
  }
  
  // --- What Parameter is being looked at ----
  public void setView(){
  }
  
  public void reset(){
    for(State st: stateList){
      st.setHighlight(false);
    }
  }
  
  public void mouseMoved(){
    reset();
    for(State st: stateList){
      if (st.contains(mouseX, mouseY)){
        break;
      }
    }
    drawMap();
  }
  
  public void mousePressed(){
    for(State st: stateList){
      if (st.highlight){
     
        //return st;
      }
    }
   // return null;
  }
  
 public void drawMap(){

    State selected = null;
    
    for (State st: stateList){
      State oneState = st.draw();
      if (oneState!=null){
        selected = oneState;
      }
    }

    
  }
  
  
  public ArrayList<State> getStateList(){
    return stateList;
  }
}
