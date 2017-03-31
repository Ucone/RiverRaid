public class ScoreScreen{


Player [] players;

  PImage backGround;
  
  ScoreScreen(){
    backGround = loadImage("./images/sprites/finalScoreboard.png");
    backGround.resize(w(1000),h(1000));
    
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
    
    
  }
  
  
  
}