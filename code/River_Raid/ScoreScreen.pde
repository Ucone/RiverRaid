import java.util.Collections;

public class ScoreScreen{


ArrayList<Player> players = new ArrayList<Player>();

  PImage backGround;
  private PImage imageTank;
  private PImage helicopter;
  private PImage enemyJet;
  
  ScoreScreen(){
    backGround = loadImage("./images/sprites/finalScoreboard.png");
    backGround.resize(w(1000),h(1000));
    

    this.imageTank = new Tanker(3).image.copy();
    this.imageTank.resize(w(20),h(0));
    
    helicopter = new Helicopter(3).image.copy();
    helicopter.resize(w(30),h(0));
    
    enemyJet = new EnemyJet(3).image.copy();
    enemyJet.resize(w(20),h(0));
    
    //Add some players to the list by Default
    players.add(new Player("Tom", 1200));
    players.add(new Player("Iaros", 200));
    players.add(new Player("Likai", 800));
    players.add(new Player("viti", 600));
    players.add(new Player("Uko", 1200));
    
  }

  public void addPlayer(Player player){
      players.add(player);
  }
  
  public void drawScoreScreen(){
    
    orderArray();
    
    image(backGround, x(0), y(0));
    float y = 360;
    float x = 165;
    textSize(h(40));
    
    for (int i=0; i< 5 ; i++){ //just show the first 5 players
       
      fill(0);
      
      textAlign(LEFT);
      text("" + (i + 1) + ".     Player: " + players.get(i).name, x(x), y(y));
      
      //tanks defeated
      x+= 230;
      image(imageTank, x(x), y(y - imageTank.height/2));
      text ("x" + player.tanksDestroyed , x(x + imageTank.width +20), y(y));
      
      //Helicopters defeated
      x += 100;
      image(helicopter, x(x), y(y - helicopter.height));
      text ("x" + player.helicoptersDestroyed , x(x  + helicopter.width +20), y(y));
      
      //EnemyJets defeated
      x+= 100;
      image(enemyJet, x(x), y(y - enemyJet.height));
      text ("x" + player.enemyJetsDestroyed , x(x + enemyJet.width +20), y(y));
      
      x+=100;
      text("Total Score: " + players.get(i).score, x(x), y(y));
      
      
      y = y + 100;  
      x = 165;
    }
    

  }
  
  
  public void orderArray(){
    int i; 
    int j;
    Player aux;
    
    for (i=0; i< players.size(); i++){

       for(j = i; j < players.size(); j++){

          if (players.get(i).getScore() < players.get(j).getScore()){
            aux = players.get(j);
           
            players.set(j, players.get(i));
            players.set(i, aux);              
          }         
       }
       
      
    }
  }
  
  
}