import java.awt.Rectangle;
import controlP5.*;

public class Filter{
 
  
  String[] typeName;
  color[] typeColor;
  int x;
  int y;
  
  int moduleTop = 80;
  int moduleWidth = 350;
  int marginLeft = 40;
  
  int onOffMargin = 200;
   
  ArrayList<Module> module;
  ControlP5 cp5;
  
  
  Button buttonOn;
  Button buttonOff;
  
  Button buttonNum;
  Button buttonPerc;

  int buttonSize;
  
  int marginTop;
  Overlay overlay;
   
  public Filter(Overlay overlay, String[] typeName, color[] typeColor, int x, int y, ControlP5 cp5){
    
    this.overlay= overlay; 
    marginTop = 100;
    this.cp5 = cp5;
    
     this.typeColor = typeColor;
     this.typeName = typeName;
     this.x = x;
     this.y = y;
     module = new ArrayList<Module>(6);
     
     for (int i=0; i<typeName.length/3; i++){
      module.add(new Module(i,x,y+marginTop, cp5));
      }
      for (int i=typeName.length/3; i<2*(typeName.length/3); i++){
        module.add( new Module(i,x+(moduleWidth+marginLeft),y+marginTop, cp5));
      }
      for (int i=2*(typeName.length/3); i<typeName.length; i++){
        module.add(new Module(i,x+2*(moduleWidth+marginLeft),y+marginTop, cp5));
      }
      this.buttonSize =50;
      
      this.buttonOn= new Button("On",x+onOffMargin,y,buttonSize,buttonSize, filterOn ); //if filter is already on, turn off
      this.buttonOff= new Button("Off",x+onOffMargin+buttonSize,y,buttonSize,buttonSize, filterOn ^ 1);

     int numPercSwitch = 0;
      if(numOrPerc)
        numPercSwitch = 1;
        
      this.buttonNum= new Button("#",x+2*onOffMargin,y,buttonSize,buttonSize, numPercSwitch);
      this.buttonPerc= new Button("%",x+2*onOffMargin+buttonSize,y,buttonSize,buttonSize, numPercSwitch ^ 1);
   }
   
   void drawFilter(){
      textFilter();
      textAlign(LEFT, TOP);
      textFont(font24,24);
      
      buttonOn.draw();
      buttonOff.draw();
      
       buttonNum.draw();
      buttonPerc.draw();
      
      if (filterOn==1){
        filterOn();
      }
      

  }
  
    
  void filterOn(){
    textAlign(LEFT,TOP);
    for(Module mod: module){
        mod.drawModule();
      }
      
     
  }
  


  void setMax(){
    
    for (Module mod: module){
      mod.setSliderMax();
    }
  }
  

  void textFilter(){
    textAlign(LEFT, TOP);
    fill(0);
    textFont(font36,36);
    text("Filter", x, y);
  }
  
  void mousePressed(){

    if(buttonOn.contains(mouseX, mouseY) && filterOn==0){
      filterOn=1;
      buttonOn.setActive(1);
      buttonOff.setActive(0);
    }
    else if(buttonOff.contains(mouseX, mouseY) && filterOn==1){
      filterOn=0;
      
      buttonOn.setActive(0);
      buttonOff.setActive(1);
      
      filterOn(); //redraws to not include slider 
    }
    
    if(buttonNum.contains(mouseX, mouseY) && numOrPerc==false){
  
      numOrPerc=true;
      overlay.fillLists();
      setMax();
      resetModule();
      buttonNum.setActive(1);
      buttonPerc.setActive(0);
      
      
      
      draw.draw();
    }
    else if(buttonPerc.contains(mouseX, mouseY) && numOrPerc){

      numOrPerc=false;
      overlay.fillLists();
      setMax();
      resetModule();
      buttonNum.setActive(0);
      buttonPerc.setActive(1);
      
      draw.draw();
    }
    
    if(filterOn==1){
      for(Module mod: module){
        mod.squareContains();
       // mod.sliderContains();
      }
      
      
    }
  }
  
  void resetModule(){
    for(Module mod: module){
      mod.resetSquare();
    }
  }

  
  private class Module{
    
    int y;
    int x;
    int dataType;
    int visible;
    float textWidth;
 
    int rectSize = 30;
    Rect square;
    Rectangle textBound;
    
    private Slider slider;
    
    private color myColor;
   // Rect square;
    //Rect text;
    ControlP5 cp5;
    
    
    public Module(int dataType, int x, int y, ControlP5 cp5){
      
        this.cp5 = cp5;
        int iy =y;
        if((dataType&1)==1){ // if odd y+height, if even if I is even, y
          iy += moduleTop + rectSize;
        }
        
        
        this.textWidth = textWidth(typeName[dataType]);
        this.myColor = typeColor[dataType];
        this.y = iy;
        this.x = x;
        this.dataType = dataType;
        visible = 1;
        
         // add a horizontal sliders, the value of this slider will be linked
        // to variable 'sliderValue' 
        slider = cp5.addSlider(""+dataType);
        slider.hide()
           .setWidth(200)
           .setHeight(20)
           .setDecimalPrecision(1)
           .setId(dataType)
           .setPosition( (int)(this.x+2*rectSize), this.y+rectSize )
           .setTriggerEvent(Slider.RELEASE) ;
            
            
           setSliderMax();
          
           
        
        
         //--- Mini Box's Rectangle---
      square = new Rect(this.x,this.y, rectSize, rectSize);
      textBound = new Rectangle(this.x+2*rectSize, this.y, rectSize, (int)textWidth);
      
      //slider = new Slider((int)(this.x+textWidth+rectSize), this.y+rectSize, 200, 0, 100, myColor);
      
    }
    
    void setFiltering(boolean tf){
      //filtering = tf;
    }
        
    void drawModule(){
      if(filterOn==1){
        noStroke();
        fill(myColor);
        textFont(font24, 24);
        text(typeName[dataType], x+2*rectSize, y);
        
        
        
        //-- draw square --
        if (visible==0){
          fill(background);
          strokeWeight(2);
          stroke(myColor);
          cp5.getController(""+dataType).hide();
        }
        else{
          cp5.getController(""+dataType).show();
        }
      
        square.draw();
      }
      else{
        cp5.getController(""+dataType).hide();
      }
    }
    
    void setSliderMax(){
      float max =overlay.getFilterMax()[dataType];
      slider.setRange(0f,max).setValue(max);
    }
    
    void squareContains(){
      if(filterOn==1 && square.contains(mouseX,mouseY)){
        visible ^= 1;
        overlay.setFilterToggle(dataType,visible);
        //--User has selected a filter-- 
        draw.filterChange();
      }
    }
    
    void resetSquare(){
      visible = 1;
        overlay.setFilterToggle(dataType,visible);
        //--User has selected a filter-- 
        draw.filterChange();
    }
    

   
  }//end Module
  
}//end Filter
