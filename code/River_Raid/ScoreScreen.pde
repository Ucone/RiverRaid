public class ScoreScreen{


Player [] players;

  PImage backGround;
  PImage imageTank;
  
  ScoreScreen(){
    backGround = loadImage("./images/sprites/finalScoreboard.png");
    backGround.resize(w(1000),h(1000));
    

    imageTank = new Tanker(3).image;
    imageTank.resize(w(20),h(0));
    
    players = new Player [5];
    
    players[0] = new Player("player 1", 1200);
    players[1] = new Player("player 2", 200);
    players[2] = new Player("player 3", 800);
    players[3] = new Player("player 4", 600);
    players[4] = new Player("player 5", 1200);
    
  }

  public void addPlayer(Player player){
    
    
  }
  
  public void drawScoreScreen(){
    
    image(backGround, 0, 0);
    int y = 320;
    int x = 400;
    textSize(h(40));
    
    for (int i=0; i< players.length; i++){
       
      text("" + (i + 1) + ". Player: " + players[i].name, x, y);
      image(imageTank, x + 200, y - imageTank.height/2);
      text ("x5", (x + 200 + imageTank.width +20), y);
      
      y = y + 70;  
      x = 400;
    }
    
    
  }
  
  
  
}