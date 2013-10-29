
public class Sidebar {
  RadioButton r;
  float x = widthW*.7;
  float y = heightH*.15;
  int myColorBackground = color(0,0,0);

  public void drawSidebar() {
    stroke(red);
    strokeWeight(3);
    fill(lightGray);
    rect(x, y, widthW*.3, heightH*.7);
    r = cp5.addRadioButton("radioButton")
         .setPosition(round(x+20),round(y+20))
         .addItem("Population",1)
         .addItem("Health Expenditures",2)
         .addItem("Percent Uninsured",3)
         .addItem("Percent Insured",4)
         .addItem("Median Household Income",5)
         .setSpacingRow(20)
         
         .setLabel("");
  }

  
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isGroup() && theEvent.name().equals("radio")) {
    println(theEvent.arrayValue());
  }
}
  void radioButton(int a) {
    println("a radio Button event: "+a);
  }
  
}

