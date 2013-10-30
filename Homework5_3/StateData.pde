
public class StateData{
  // --- Called during app to populate all states. ----
  
  private int[] dataArray;
  
  public StateData(String name, int year, int population, float medianIncome, int healthExp,
          float noInsCoverage, float insCoverage, float employmentBased,
          float directPurchase, float government, float medicaid, float medicare,
          float military){               

    int medianIncomeInt = (int)Math.round(medianIncome);
    int noInsCoverageInt = (int)Math.round(noInsCoverage*1000);
    int insCoverageInt = (int)Math.round(insCoverage*1000);
    int employmentBasedInt = (int)Math.round(employmentBased*1000);
    int directPurchaseInt = (int)Math.round(directPurchase*1000);
    int governmentInt = (int)Math.round(government*1000);
    int medicaidInt = (int)Math.round(medicaid*1000);
    int medicareInt = (int)Math.round(medicare*1000);
    int militaryInt = (int)Math.round(military*1000);
    
    int[] anArray = {year, population, medianIncomeInt, healthExp, noInsCoverageInt, insCoverageInt,
                    employmentBasedInt, directPurchaseInt, governmentInt, medicaidInt,
                    medicareInt, militaryInt};
    
    dataArray = anArray;
    

  }
  

  // --- Draw Hover Box ----
  public void drawBox(int mx, int my){
    fill(2,2,2,60);
    noStroke();
    rect(mx,my, 20, 20);
  } 
}
