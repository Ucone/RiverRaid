public class FinalWorld {
  
  public ArrayList<Enemy> finalEnemies;
  
  
  FinalWorld(){
    finalEnemies = new ArrayList<Enemy>();
    
    FinalEnemy finalEnemy1 = new FinalEnemy("./images/sprites/credits.png", 500);
    finalEnemies.add(finalEnemy1);
    FinalEnemy finalEnemy2 = new FinalEnemy("./images/sprites/credits.png", 200);
    finalEnemies.add(finalEnemy2);
    FinalEnemy finalEnemy3 = new FinalEnemy("./images/sprites/credits.png", 600);
    finalEnemies.add(finalEnemy3);
    
    
  }
  
  
  void draw(){
    
   
    for (Enemy fe : finalEnemies) {
       fe.drawIfVis(yMaster);
     }
    
  }
  
  

  
}