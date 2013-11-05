import java.awt.Polygon; 

public class State{
  private String name;
  private Poly polygon;
  private int year;
  private int healthExp;
  private int population;
  private boolean highlight;
  
  // --- If it's being accessed in another window
  private boolean brushing;
  private color stateColor;
  
  private StateData data;
  private int centerX;
  private int centerY;
  private String abb;
  
  public  color highlightColor= color(34,203,100);
  public  color brushingColor= color(0,10,100);
  
  public color gray;

  
  public State(String name, String abb, Poly polygon, int centerX, int centerY, int year,
          int population, float medianIncome, int healthExp, float noInsCoverage, float insCoverage,
          float employmentBased, float directPurchase, float government,
          float medicaid, float medicare, float military){
    this.name = name;
    this.abb = abb;
    this.polygon = polygon;
    this.centerX = centerX;
    this.centerY = centerY;
    
    this.year = year;
    
    this.healthExp = healthExp;
    this.population = population;
    
    gray = color(random(75)+25);
    this.abb = abb;
    
    this.centerX = centerX;
    this.centerY = centerY;

    data = new StateData(name, year, population, medianIncome, healthExp, noInsCoverage, 
                    insCoverage, employmentBased, directPurchase, government,
                    medicaid, medicare, military);
    
    highlight = false;
    brushing = false;
    stateColor = createColor();
  }
  
  public String getName(){
    return name;
  }
  
  public color createColor(){
    colorMode(RGB, 255);
    int r = (125+((int)(.0000036*this.population)));
    int g = 125+(int)(.0000036*this.population);
    int b = 0;
    color c1 = color(r, g, b);
    return c1;
  }
  /*public color createUninsuredColor(){
    colorMode(RGB, 255);
    return color((int)(noInsCoverage*1.35)+120, 0, 0);
  }*/
  /*
  public color createInsuredColor(){
    
    colorMode(RGB, 255);
    return color(0, (int)(insCoverage*1.2)+135, (int)(insCoverage*.66)+74);
  
  }*/
  public color createHealthExpColor(){
    colorMode(RGB, 255);
    System.out.println(healthExp);
    int r = (70+((int)(.046*this.healthExp)));
    int g = 0;
    int b = 71+(int)(.0498*this.healthExp);
    color c1 = color(r, g, b);
    return c1;
  }
  
  
  public void setHighlight(boolean tf){
    highlight = tf;
  }
  
  public void setBrushing(boolean tf){
    brushing = tf;
  }
  
  public boolean contains(int mx, int my){
    if (filterOn==0 && polygon.contains(mx,my)){
      highlight = true;
    }
    return highlight;
  }
  
  public State draw(){
    State ret = null;
    drawName();
    if(filterOn==1){
      fill(gray);
      noStroke();
      polygon.draw();
    }
    else{
      if (brushing){
        fill(brushingColor);
        strokeWeight(3);
        stroke(stateColor); //work on this
      }
      else if (highlight){
        fill(brushingColor);
        strokeWeight(4);
        stroke(black); //work on 
        ret = this;
      }
      else{
        fill(stateColor);
        noStroke();
      }
      
    }
    
    polygon.draw(); 
    drawName();
    return ret;
  }
  
  public void drawName(){
     //-- Draw Names of State
    textFont(font14, 14);
    textAlign(CENTER,CENTER);
    fill(0);
    text(abb, centerX, centerY);
  }
  
  public void dataBox(){
    //data.drawBox(mouseX,mouseY);
    data.drawBox(centerX,centerY);
  } 
  
  public StateData getStateData(){
    return data;
  }
  
  public int getCenterX(){
     return centerX;
  }
  
  public int getCenterY(){
     return centerY;
  }

}


