public class FinalCredits {
  
  public ArrayList<Enemy> finalEnemies;
  
  
  FinalCredits(){
    finalEnemies = new ArrayList<Enemy>();
    
    //game design
    FinalEnemy finalEnemy1 = new FinalEnemy("./images/credits/Game_Design.png", 350, -100);
    finalEnemies.add(finalEnemy1);
    //Developers
    FinalEnemy finalEnemy2 = new FinalEnemy("./images/credits/Developers.png", 600, -400);
    finalEnemies.add(finalEnemy2);
    //Graphics
    FinalEnemy finalEnemy3 = new FinalEnemy("./images/credits/Graphics.png", 200, -700);
    finalEnemies.add(finalEnemy3);
    //Music
    FinalEnemy finalEnemy4 = new FinalEnemy("./images/credits/Music.png", 650, -1000);
    finalEnemies.add(finalEnemy4);
    //Game Logic
    FinalEnemy finalEnemy5 = new FinalEnemy("./images/credits/Game_logic.png", 100, -1300);
    finalEnemies.add(finalEnemy5);
    //Scrum maste
    FinalEnemy finalEnemy6 = new FinalEnemy("./images/credits/Scrum_master.png", 600, -1600);
    finalEnemies.add(finalEnemy6);
    //Testers
    FinalEnemy finalEnemy7 = new FinalEnemy("./images/credits/Testers.png", 150, -1900);
    finalEnemies.add(finalEnemy7);
    //Product owner
    FinalEnemy finalEnemy8 = new FinalEnemy("./images/credits/Product_Owner.png", 500, -2200);
    finalEnemies.add(finalEnemy8);
    //Project review
    FinalEnemy finalEnemy9 = new FinalEnemy("./images/credits/Project_Review.png", 70, -2500);
    finalEnemies.add(finalEnemy9);
    //Countries involved
    FinalEnemy finalEnemy10 = new FinalEnemy("./images/credits/Countries_Involved.png", 650, -2800);
    finalEnemies.add(finalEnemy10);
    // tutlogo
    FinalEnemy finalEnemy11 = new FinalEnemy("./images/credits/tutLogo.jpg", 200, -3100);
    finalEnemies.add(finalEnemy11);
    //The end
    FinalEnemy finalEnemy12 = new FinalEnemy("./images/credits/The_End.png", 350, -3400);
    finalEnemies.add(finalEnemy12);
    
  }
  
  
  void draw(){
    
   
    for (Enemy fe : finalEnemies) {
       fe.drawIfVis(yMaster);
     }
    
  }
  
  

  
}