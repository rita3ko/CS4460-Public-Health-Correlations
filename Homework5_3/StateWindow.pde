
public class StateWindow{
  
  //make bar graph for now.
  


  private int x;
  private int y;
  private int width;
  private int height;
  private State state;
  private PieChart pie;
  int pieSize ;
  int pieY;
  int pieX;
  
  private StateWindow(int x, int y){
    this.x = x;
    this.y = y;
    width = 300;
    height = 500;
    defaultText();
    pieSize = 300;
    pieX=x+10;
    pieY = y+100;
    pie = new PieChart(pieX, pieY, pieSize, pieSize);
  }
  
  public void defaultText(){
    textFont(font14,14);
    String s = "Click on a state to see more detail.";
    fill(22);
    text(s, x, y, x+this.width, y+this.height);  // Text wraps within text box
  }
  
  public void mouseMoved(){
    if(draw.within(pieX,pieY,pieX+pieSize,pieY+pieSize)){
      rect(pieX,pieY,pieSize,pieSize);
      pie.mouseMoved();
      draw.brushMap(state);
   }
   else{
      pieReset();
   }
  }
  
  public void setState(State state){
    if (!state.equals(this.state)){
      this.state = state;
      pie.setState(state);
      draw.draw();
    }
  }
  
  public void writeName(){
    fill(0);
    textFont(font36, 36);
    textAlign(CENTER);
    text(state.getName(), x+this.width/2, y+60);
  }
  
  public void drawWindow(){
    if (state!=null){
      writeName();
      pie.drawPie();
      //draw bargraph
    }
    else{
      defaultText();
    }
  }

 public void windowCheck(State myState, int dataType){
   if(state!=null && state.equals(myState)){
     pie.pieHighlight(dataType);
   }
 }
 
 public void pieReset(){
   pie.pieReset();
 }
 

}//end class


