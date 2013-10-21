public class Draw{
  
  public Draw(){
    //draw();
  }
  
  public void title(){
    fill(34);
    noStroke();
    rect(0,0,width,100);
    fill(background);
    textFont(font48, 48);
    textAlign(CENTER);
    text("U.S. Commuting by State", width/2, 65);  
  }
  
  public void draw(){
    background(background);
    title();
    map.drawMap();
    stateWindow.drawWindow();
    filter.drawFilter();
    if(filterOn==1){
      overlay.drawOverlay();
    }
  }
  
  public void brushMap(State state){
    //background(background);
    map.brush(state);
    
  }
  
  public void filterChange(){
    draw.draw();
  }
  
  public void setWindowState(State state){
    map.brush(state);
    stateWindow.setState(state);
  }
  
  public void setOverlayState(State state, int dataType){
    overlay.setOverlayState(state, dataType);
  }
  
  //--if brushing on an overlay
  public void windowCheck(State state, int dataType){
      stateWindow.windowCheck(state, dataType);
  }

 public void pieReset(){
      stateWindow.pieReset();
  }
 
 public void overlayText(String overlay){
     if(overlay!=null && !"".equals(overlay)){
       noStroke();
       fill(0,60);
       textFont(font14,14);
       textAlign(LEFT,BOTTOM);
       rect(mouseX-5,mouseY-20,textWidth(overlay)+10,20);
       fill(100);
       text(overlay, mouseX, mouseY);
     }
   }
 
//saves processing power by only checking when near an object
boolean within(int x1, int y1, int x2, int y2){
  if (mouseX>x1 && mouseX<x2 && mouseY>y1 && mouseY<y2){
    return true;
  }
    return false;
}
  
}

