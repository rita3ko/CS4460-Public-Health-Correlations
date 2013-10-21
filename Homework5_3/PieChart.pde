//import java.lang.Math;

public class PieChart{
    

    ArrayList<Arc> arcs = new ArrayList<Arc>(7);
    // data[0] is total, data[1] is alone, etc.
    float xD;
    float yD;
    State state;
    float[] data;
    int display;
    
    public PieChart(int x, int y, int w, int h){
      this.state = state;
      xD = (float)x;
      yD = (float)y;
      
    }
    
    public void setState(State state){
      
      if(state!=null && !state.equals(this.state)){
        arcs = new ArrayList<Arc>(6);

        this.state = state;
        data = state.getStateData().getPercArray();
        
        float angleSum = 0;
        //for(int i = data.length-1; i>0; i--){
        for(int i=0; i<data.length; i++){
          float rad = data[i]/100 * 2*PI;
          
          Arc arc = new Arc(i, xD, yD, 300.0f, 300.0f, angleSum, angleSum+rad, PIE);

          arcs.add(arc);
          angleSum+=rad;
          
        }
      }
    }
    
    int oldDisplay = -1;
    String overlay ="";
    
    void drawPie(){
      ellipseMode(CORNER);
        for (int i=0; i<arcs.size();i++){
          arcs.get(i).draw(); 
        }
        
        
        if(display!=-1 ){
          int type = 1;
          if(numOrPerc){
            type = state.getWorkers();
          }
      
          if(oldDisplay!=display)
            overlay =typeName[display]+" : "+ (int)(Math.ceil((double)type*data[display]/100));
          draw.overlayText(overlay);
          oldDisplay = display;
        }

      ellipseMode(CENTER);
    }
    
    public void mouseMoved(){
    display = -1;
     pieReset();
      for(int i=0; i<arcs.size(); i++){
        if(arcs.get(i).contains()){
          arcs.get(i).setHighlight(true);
          display = i;
          //--Set Overlay to Brush--
          draw.setOverlayState(state, i);
          break;
        }
      }
      draw.draw();
    }
    
    //When brushed in the other view    
    void pieHighlight(int dataType){
      pieReset();
      for(Arc arc: arcs){
        if(arc.dataType==dataType){
          arc.setHighlight(true);
          break;
        }
      }
    }
    
    void pieReset(){
      display = -1;
      for(Arc arc: arcs){
        arc.setHighlight(false);
      }  
     draw.overlayText(null);
    }
    
    
    private class Arc{
  
        int dataType;
        float x;
        float y;
        float widthPie;
        float heightPie;
        float start;
        float stop;
        int fill;
        boolean highlight;
        color col;
        
       
        public Arc(int dataType, float x, float y, float widthPie, float heightPie, float start , float stop , int fill){
       
          this.widthPie = widthPie;
          this.heightPie = heightPie;
          
          this.dataType = dataType;
          this.x = x;
          this.y = y;
          this.col = typeColor[dataType];
          
          this.start = start;
          this.stop = stop;
          this.fill = fill;
          this.highlight = false;

        }
        
         void draw() {
          if(highlight){
            fill(col,50);
            stroke(col);
            strokeWeight(3);
          }
          else{
            fill(col);
            noStroke();
          }
          arc(this.x, this.y, widthPie, heightPie, start, stop, fill);
        }
        
        void setHighlight(boolean tf){
          highlight = tf;
        }
        
         
        
      boolean contains(){
         double angle = getAngle();
          
          if (angle>=start && angle<=stop){
            return true;
          }
          return false;
       }
      
      
       /* Fetches angle relative to screen centre point
       * where 3 O'Clock is 0 and 12 O'Clock is 270 degrees
       * From StackOverflow
       * @param screenPoint
       * @return angle in degress from 0-360.
       */
       
      public double getAngle(){
        
        
          double dx = mouseX - (this.x+widthPie/2);
          // Minus to correct for coord re-mapping
          double dy = (double)-1*(mouseY - (this.y+heightPie/2));
      
          double inRads = Math.atan2(dy,dx);
      
          // We need to map to coord system when 0 degree is at 3 O'clock, 270 at 12 O'clock
          if (inRads < 0)
              inRads = Math.abs(inRads);
          else
              inRads = 2*Math.PI - inRads;
      
          return inRads;
      }
            
    
       
    }//end arc
  }//end pie


