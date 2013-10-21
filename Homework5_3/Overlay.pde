import java.util.*;

public class Overlay{
  
  Map map;
  float filterMax[];
  float filterValue[];
  int filterToggle[];
  
  //--These are shallow arraylist copies of StateList, in
  // various orders
  ArrayList<ArrayList<State>> arrayList;
  
  //top 3
  ArrayList<ArrayList<State>> stateData;
  
  
  CircleData[] circleData;
  
  int topNo =3;
 
  public Overlay(Map map){
    
    this.map = map;
    filterMax = new float[6];
    filterValue = new float[6];
    filterToggle = new int[6];
    arrayList = new ArrayList<ArrayList<State>>(6);
    
    circleData = new CircleData[6];
    stateData = new ArrayList<ArrayList<State>>(6);
    
    fillLists();
    /*
    
    //-- future update: try passing functions.
    */
  }
  
   //-- Gets called also when percentage turns to numbers and vice versa
  void fillLists(){

    for(int i=0; i<filterMax.length; i++){
      stateData.add(new ArrayList<State>(3));
      
      //int dataType = i+1; //data array in stateData starts with num workers
      arrayList.add(new ArrayList<State>(map.getStateList()));
   
      Collections.sort(arrayList.get(i), new StateComparator( numOrPerc ,i));
      float max = arrayList.get(i).get(0).getStateData().getDataArray()[i];
      filterMax[i] = max;
      setMax(i, max, true);
      
      filterValue[i]=filterMax[i];
      filterToggle[i]=1;

    }
    
    makeCircles();
    
  }
  
  float[] getFilterMax(){
    return filterMax;
  }  
  
  void setMax(int dataType, float max){
    setMax(dataType, max, false);
    makeCircles();
  }
  
    void setMax(int dataType, float max, boolean firstTime){
    filterValue[dataType]=max;
    
    //change what gets displayed
    int top = topInRange(dataType);
    topState(dataType, top);

  }
  
  void topState(int dataType, int start){
    ArrayList<State> topData = new ArrayList<State>(topNo);
     
    //if(start != -1){ //if there's something in this range
      for(int i =0; i< topNo; i++){
        
        if(start+i < arrayList.get(dataType).size() && start+i >= 0){
          topData.add(arrayList.get(dataType).get(start+i));
        }
      }   
      stateData.set(dataType,topData);
      
      //if it doesn't exist, stateData will have an arraylist of nulls.
  }
  
  int topInRange(int dataType){
    for (int i =0; i<arrayList.get(dataType).size();i++){
      if(arrayList.get(dataType).get(i).getStateData().getDataArray()[dataType] <= filterValue[dataType]){ //data array in stateData starts with num workers
        return i;
      }
    }
    return -1;
  }
  
  void setFilterToggle(int dataType, int visible){
    filterToggle[dataType]=visible;
    
  }
  
  void makeCircles(){
     int j =0;
     //ArrayList<CircleData> circles = new ArrayList<CircleData>(topNo);
     
     PriorityQueue<CircleData> pqCircle = new PriorityQueue<CircleData>();
     for(int i=0; i< stateData.size(); i++){
       for(State st: stateData.get(i)){
             if (st!=null){
                color col = typeColor[i];
                
                int multiplier1 = 0;
                int multiplier2 =0;
                  
                if(numOrPerc){
                   multiplier1 = 75;
                   multiplier2 =30;
                }
                else{
                   multiplier1 = 50;
                   multiplier2 =20;
                }
                float dataValue = (float)(st.getStateData().getDataArray()[i]);
                
                int diameter = j *10 + (int) (multiplier1*(dataValue/filterMax[i])) +(int)(multiplier2*dataValue/filterMax[0]);
                
           
                pqCircle.add(new CircleData(st, diameter, i, (int)dataValue, col));
                j++;
             }
       }
       j=0;
     }
     
     circleData = pqCircle.toArray(new CircleData[6*topNo]);
     
     //circleData.set(dataType, circles);
   
      
    
    }
  
  String overlay="";
  
  void drawOverlay(){
     for (int i=0; i< circleData.length; i++){
       if(circleData[i]!=null && filterToggle[circleData[i].getDataType()]==1){
         circleData[i].draw();
       }
     }
     draw.overlayText(overlay);
    }//end draw Overlay
    


   void mousePressed(){
        //check from lowest diameter to highest
        boolean pass = true;
       for(int i = circleData.length-1; i>=0; i--){
         if(circleData[i]!=null && circleData[i].contains() && filterToggle[circleData[i].getDataType()]==1){
              draw.setWindowState(circleData[i].getState());
              //mouseMoved();
              pass = false;
              break;         
         }
      }
      
      if(pass)
        reset();
   }
   
  
   void setOverlayState(State state, int dataType){
     if(filterToggle[dataType]==1){
       for(int i = circleData.length-1; i>=0; i--){
             if(circleData[i]!=null && circleData[i].getState()==state && circleData[i].getDataType()==dataType){
                  circleData[i].setBrushing(true);
                  break;         
             }
       }
     }
   }
   
   //--this is if I'm outside my overlay mousemove check
  void reset(){
    overlay="";
    for(int i = circleData.length-1; i>=0; i--){
         if(circleData[i]!=null){
             circleData[i].setBrushing(false); //reset every time
       }
    }
  }
  
  
  
  void mouseMoved(){
        //check from lowest diameter to highest
      // mousePressed();
       reset();
       draw.pieReset();
     
       for(int i = circleData.length-1; i>=0; i--){
         if( circleData[i]!=null && circleData[i].contains() && filterToggle[circleData[i].getDataType()]==1){
              overlay=typeName[circleData[i].getDataType()]+" : "+circleData[i].getValue();
               circleData[i].setBrushing(true);
              draw.windowCheck(circleData[i].getState(), circleData[i].getDataType());
              break;    
         }          
      }
   }

}//end class


