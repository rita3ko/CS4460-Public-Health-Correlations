import  java.awt.geom.Ellipse2D;

public class CircleData implements Comparable<CircleData>{
  
  Ellipse2D circleBound;
  float dataValue;
  State st;
  int dataType;
  color col;
  int diameter;
  int value;
  boolean brushing;
  
  public CircleData(State st, int diameter, int dataType, int value, color col) {
    this.dataValue = (float)(st.getStateData().getDataArray()[dataType]);
    this.dataType = dataType;
    this.st =st;
    this.col = col;
    this.diameter = diameter;
    this.value = value;
    this.circleBound = new Ellipse2D.Float(st.getCenterX()-diameter/2, st.getCenterY()-diameter/2, diameter, diameter);
    brushing = false;
  }
  
  int getDataType(){
    return dataType;
  }
  
  void setBrushing(boolean tf){
    brushing = tf;
  }
  int getValue(){
    return value;
  }
  void draw() {
    if(brushing){
      stroke(100);
      fill(col);
    }
    else{
      stroke(col);
      fill(col,30);
    }
    strokeWeight(2);
    ellipse(st.getCenterX(), st.getCenterY(), diameter, diameter);  
    st.drawName();
  }
  
  State getState(){
    return st;
  }
  
  boolean contains(){
    return circleBound.contains(mouseX,mouseY);
  }
  
  public int compareTo(CircleData other)
  {
    return other.diameter-this.diameter;//populationDensity.comparetTo(other.populationDensity);
  }
  
}
/*
public class CircleComparator implements Comparator<CireData> {
   
    @Override
    public int compare(CircleData c1, CircleData c2) {  
       return c2.diameter - c1.diameter;
    }
}
*/

