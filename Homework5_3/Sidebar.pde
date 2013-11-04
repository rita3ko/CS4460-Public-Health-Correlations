
public class Sidebar {
  float x = widthW*.7;
  float y = heightH*.15;
  int myColorBackground = color(white);

  public Sidebar() {
    Dropdown vars = new Dropdown("Variables", x + 120, y + 100, 216, 500);
    
    // Add Items
    for (int i = 0; i < typeName.length; i++) 
      vars.addItem(typeName[i],i);
    vars.setIndex(0);
   }

  public void drawSidebar() {
    // Creates the panel
    fill(darkGray);
    strokeWeight(3);
    noStroke();
    rect(x, y, widthW*.3, heightH*.7);
    
    // Creates the title
    fill(white);
    textFont(font48, 48);
    textAlign(CENTER);
    text("Control Center", x + widthW*.15, y*1.4);  
    
    // Creates the label
    textSize(16);
    textAlign(LEFT);
    text("Gradient:", x + 26, y + 97);
  }
}

