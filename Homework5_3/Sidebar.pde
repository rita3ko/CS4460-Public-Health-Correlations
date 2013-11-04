
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
    textSize(18);
    textAlign(LEFT);
    text("Gradient:", x + 26, y + 97);
    
    textSize(20);
    textAlign(CENTER);
    text("State", x + widthW*.15, y * 2.5);
    fill(white);
    rect(x, y*2.25, widthW*.3, 2);
    for (int i = 0; i < typeName.length; i++) {
      text(typeName[i], x + widthW*.15, y*3 + y*.5*i);
      rect(x, y*2.75 + y*i*.5, widthW*.3, 2);
    }
    textSize(18);
    fill(blue);    // Text color
    if (map.highlighted !=  null) {
      float leftC = x + widthW*.06;
      text(map.highlighted.name, leftC, y*2.7);
      text(map.highlighted.population, leftC, y*3.2);
      text(map.highlighted.healthExp, leftC, y*3.7);
      text(map.highlighted.population, leftC, y*4.2);
      text(map.highlighted.population, leftC, y*4.7);
      text(map.highlighted.population, leftC, y*5.2);
    }
    
    fill(red);
    if (map.clicked !=  null) {
      float rightC = x + widthW*.2;
      text(map.clicked.name, rightC, y*2.7);
      text(map.clicked.population, rightC, y*3.2);
      text(map.clicked.healthExp, rightC, y*3.7);
      text(map.clicked.population, rightC, y*4.2);
      text(map.clicked.population, rightC, y*4.7);
      text(map.clicked.population, rightC, y*5.2);
    }
  }
}

