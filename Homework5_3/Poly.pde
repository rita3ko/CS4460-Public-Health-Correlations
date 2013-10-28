/*
 The class inherit all the fields, constructors and functions 
 of the java.awt.Polygon class, including contains(), xpoint,ypoint,npoint
 http://wiki.processing.org/w/Using_AWT's_Polygon_class
*/
 
public class Poly extends java.awt.Polygon {
  public Poly(int[] x,int[] y, int n) {
    //call the java.awt.Polygon constructor
    super(x, y, n);
  }
 
  void draw() {
    beginShape();
    for (int i = 0; i < npoints; i++) {
      vertex(xpoints[i], ypoints[i]);
    }
    endShape(CLOSE);
  }
}


public class Rect extends java.awt.Rectangle {
  
  int w;
  int h;
  int active;
  String text;
  
  public Rect(int x,int y, int w, int h) {
    //call the java.awt.Polygon constructor
    super(x, y, w,h);

    this.w = w;
    this.h = h;
    
  }
 
  void draw() {

    rect(x,y,w,h);
    
  }

  
}

public class Button extends java.awt.Rectangle {
  
  int w;
  int h;
  int active;
  String text;
  
  public Button(String text, int x,int y, int w, int h, int active) {
    //call the java.awt.Polygon constructor
    super(x, y, w,h);
    this.text = text;
    this.w = w;
    this.h = h;
    this.active = active;
    
  }
 
  void draw() {
    
    stroke(0);
    if(active==1){
      fill(0);
      strokeWeight(2);
    }
    else{
      fill(66); 
      noStroke();
      //strokeWeight(1);   
    }
    rect(x,y,w,h);
    
    noStroke();
    if (active==1){
      fill(100);
      
    }
    else{
      fill(44);
    }  
    textAlign(CENTER,CENTER);
    textFont(font24,24);
    text(text,x+w/2,y+h/2);
    
  }
    
  void setActive(int active){
    this.active = active;
  }
  
}
