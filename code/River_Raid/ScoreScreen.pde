public class ScoreScreen{


Player [] players;

  PImage backGround;
  private PImage imageTank;
  private PImage helicopter;
  private PImage enemyJet;
  
  ScoreScreen(){
    backGround = loadImage("./images/sprites/finalScoreboard.png");
    backGround.resize(w(1000),h(1000));
    

    imageTank = new Tanker(3).image;
    //imageTank.resize(w(20),h(0));
    
    helicopter = new Helicopter(3).image;
    //helicopter.resize(w(20),h(0));
    
    enemyJet = new EnemyJet(3).image;
    //enemyJet.resize(w(20),h(0));
    
    players = new Player [5];
    
    players[0] = new Player("Tom", 1200);
    players[1] = new Player("Iaros",1200);
    players[2] = new Player("Likai", 800);
    players[3] = new Player("viti", 600);
    players[4] = new Player("Uko", 1200);
    
  }

  public void addPlayer(Player player){
    
    
  }
  
  public void drawScoreScreen(){
    
    image(backGround, 0, 0);
    int y = 320;
    int x = 400;
    textSize(h(40));
    
    for (int i=0; i< players.length; i++){
       
      text("" + (i + 1) + ".     Player: " + players[i].name, x, y);
      
      //tanks defeated
      x+= 200;
      image(imageTank, x, y - imageTank.height/2);
      text ("x5", (x + imageTank.width +20), y);
      
      //Helicopters defeated
      x += 100;
      image(helicopter, x, y - helicopter.height);
      text ("x12", (x  + helicopter.width +20), y);
      
      //EnemyJets defeated
      x+= 100;
      image(enemyJet, x, y - enemyJet.height);
      text ("x7", (x + enemyJet.width +20), y);
      
      x+=200;
      text("Total Score: " + players[i].score, x, y);
      
      
      y = y + 70;  
      x = 400;
    }
    
    
  }
  
  
  
}