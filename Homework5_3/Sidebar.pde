
public class Sidebar {
  RadioButton r;
  float x = widthW*.7;
  float y = heightH*.15;
  int myColorBackground = color(white);

  public Sidebar() {
   r = cp5.addRadioButton("radioButton");
   r.setPosition(round(x+20),round(y+20));
   r.addItem("Population",1);
   r.addItem("Health Expenditures",2);
   r.addItem("Percent Uninsured",3);
   r.addItem("Percent Insured",4);
   r.addItem("Median Household Income",5);
   r.setSpacingRow(20);
   }

  public void drawSidebar() {
    stroke(black);
    strokeWeight(3);
    fill(white);
    rect(x, y, widthW*.3, heightH*.7);
    r.show();
  }


  void controlEvent(ControlEvent theEvent) {
    if (theEvent.isGroup() && theEvent.name().equals("radio")) {
      println(theEvent.arrayValue());
    }
  }
  void radioButton(int a) {
    println("a radio Button event: "+a);
  }
}

