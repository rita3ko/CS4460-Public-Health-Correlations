import java.awt.Polygon; 
import controlP5.*;
import de.bezier.data.*; //Xlsreader library 
public Map map;
public Sidebar sidebar;

public static color background;

public PFont font48;
public PFont font36;
public PFont font24;
public PFont font14;

public static Draw draw;

public static int filterOn;

private int widthW;
private int heightH;
String[] typeName = {"Population","Health Expeditures","Percent Uninsured","Percent Insured","Median Household Income"};

ControlP5 cp5;
XlsReader reader;
      
color[] typeColor;
color blue, green, purple, orange, magenta, red, lightGray, black, white, darkGray;



void setup(){
  draw = new Draw();

  colorMode(HSB,100);
  
  cp5 = new ControlP5(this);
  reader = new XlsReader(this, "Data1.xls");
  reader.firstRow();
  
  // --- Colors Setup ----
  blue = color(55,76,100); 
  green = color(24,100,100); 
  purple = color(77,80,100);
  orange = color(9,100,100);
  magenta = color(90,80,100);
  red = color(100,83,100);
  lightGray = color(80);
  darkGray = color(34);
  black = color(0);
  white = color(100);
  color[] typeColorTemp = {blue,green,purple,orange, magenta,red};
  typeColor= typeColorTemp;
  

  
  // --- Canvas Setup ----
  heightH = 760;
  widthW = 1200;
  size(widthW,heightH);
  background = white;
  background(background);
  noStroke();
  
  // --- Text Setup ----
  fontLoad();
  cp5.setControlFont(font14);
  cp5.setColorLabel(black);
  
  // --- Create Map ----
  int marginTop = 130;
  int mapWidth = 800;
  map = new Map();
  sidebar = new Sidebar();

}

/*loads all fonts*/
void fontLoad(){
  font48 = loadFont("SofiaProLight-48.vlw");
  font36 = loadFont("SofiaProLight-36.vlw");
  font24 = loadFont("SofiaProLight-24.vlw");
  font14 = loadFont("SofiaProLight-14.vlw");
}

/* Trigged when mouse moves. Ideally smart 
*  enough to check bounds before going into function
*  calls
*/
void mouseMoved(){
  
  //if (draw.within(10,150,720,800)){
      map.mouseMoved();
  //}


}

/* 
* Trigged when mouse is pressed. Ideally smart 
*  enough to check bounds before going into
*  function calls
*/
void mousePressed(){
  
  // --- Mouse is pressed on Map ----
  map.mousePressed();
}


// --- Exists so Draw isn't called every time ----
void redraw(){
}

void draw(){
  draw.draw();
}


