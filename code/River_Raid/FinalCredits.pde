public class FinalCredits {
  
  public ArrayList<Enemy> finalEnemies;
  
  
  FinalCredits(){
    finalEnemies = new ArrayList<Enemy>();
    
    FinalEnemy finalEnemy1 = new FinalEnemy("./images/credits/credits.png", 500, -500);
    finalEnemies.add(finalEnemy1);
    FinalEnemy finalEnemy2 = new FinalEnemy("./images/credits/credits2.png", 200, -200);
    finalEnemies.add(finalEnemy2);
    FinalEnemy finalEnemy3 = new FinalEnemy("./images/credits/credits.png", 600, -100);
    finalEnemies.add(finalEnemy3);
    
    
  }
  
  
  void draw(){
    
   
    for (Enemy fe : finalEnemies) {
       fe.drawIfVis(yMaster);
     }
    
  }
  
  

  
}