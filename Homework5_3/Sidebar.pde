import controlP5.*;

public class Sidebar {
  RadioButton r;
  float x = widthW*.7;
  float y = heightH*.15;
  
  public void drawSidebar() {
    stroke(red);
    strokeWeight(3);
    fill(lightGray);
    rect(x, y, widthW*.3, heightH*.7);
    r = cp5.addRadioButton("radio", 800, 80);
    r.addItem("a",1);
    //r.addItem("b",2);

    
  }
}
