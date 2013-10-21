import java.awt.Polygon; 

// --- Different "Windows" ----
public Map map;
public Filter filter;
public Overlay overlay;

public static color background;
private StateWindow stateWindow;
 //true if number, false if percentage
public static boolean numOrPerc;

public static int dataType;
//1 for alone
//2 for carpooled
//3 for public
//4 for walked
//5 for other
//6 for home


public PFont font48;
public PFont font36;
public PFont font24;
public PFont font14;

public static Draw draw;

public static int filterOn;

private int widthW;
private int heightH;
String[] typeName = {"Drove Alone","Carpooled","Public Trans.","Walked","Other","Home"};

ControlP5 cp5;
      
color[] typeColor;

int filterWindowY;


void setup(){
  draw = new Draw();
  
  filterOn = 1;
  filterWindowY= 550;
  
  cp5 = new ControlP5(this);
  colorMode(HSB,100);
  
  color blue = color(55,76,100); 
  color green = color(24,100,100); 
  color purple = color(77,80,100);
  color orange = color(9,100,100);
  color magenta = color(90,80,100);
  color red = color(100,83,100);
  
  color[] typeColorTemp = {blue,green,purple,orange, magenta, red};
  typeColor= typeColorTemp;
  
  background = color(0,0,100);
  
  // --- Canvas Setup ----
  heightH = 900;
  widthW = 1200;
  size(widthW,heightH);
  background(background);
  noStroke();
  
  // --- Text Setup ----
  fontLoad();
  
  // --- Create Map ----
  int marginTop = 130;
  int mapWidth = 800;
  map = new Map();
  stateWindow = new StateWindow(mapWidth, marginTop);
  
  // --- Start with Numbers ----
  numOrPerc = true;
  overlay = new Overlay(map);
  filter = new Filter(overlay, typeName, typeColor, 50,filterWindowY, cp5);
  
  
   //(and other stuff)
  
  

}

void fontLoad(){
  font48 = loadFont("SofiaProLight-48.vlw");
  font36 = loadFont("SofiaProLight-36.vlw");
  font24 = loadFont("SofiaProLight-24.vlw");
  font14 = loadFont("SofiaProLight-14.vlw");
}

void mouseMoved(){
  
  if (draw.within(10,150,720,800)){
    
    if(filterOn==0){
      map.mouseMoved();
      overlay.reset();
    }
    else{
      overlay.mouseMoved();
    }
  }
  else{
    map.reset();
    overlay.reset();
    
  }

  if (draw.within(800,200,width,height)){
    stateWindow.mouseMoved();
  }
  

}


void mousePressed(){
  
     // --- Mouse is pressed on Map ----
  map.mousePressed();

  
  //window box check
  if (draw.within(50,filterWindowY,width,height)){
    filter.mousePressed();
  }
  //if ((10,150,720,800)){
    if(filterOn==1){
        overlay.mousePressed();
      }
  //}
}


// --- Exists so Draw isn't called every time ----
void redraw(){
}

void draw(){
  draw.draw();
}

// --- This is the CP5 Controller that hooks to the slider ----
void controlEvent(ControlEvent theEvent){
  if(theEvent.getId()!=-1){
    overlay.setMax(theEvent.getId(), (int)theEvent.getValue());
   
  }
}
