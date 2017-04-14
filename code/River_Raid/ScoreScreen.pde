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
    

    this.imageTank = new Tanker(3).image;
    //this.imageTank.resize(w(20),h(0));
    
    helicopter = new Helicopter(3).image;
    //helicopter.resize(w(20),h(0));
    
    enemyJet = new EnemyJet(3).image;
    //enemyJet.resize(w(20),h(0));
    

    
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
    
    image(backGround, 0, 0);
    int y = 320;
    int x = 400;
    textSize(h(40));
    
    for (int i=0; i< 5 ; i++){ //just show the first 5 players
       
      fill(0);
      
      text("" + (i + 1) + ".     Player: " + players.get(i).name, x, y);
      
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
      text("Total Score: " + players.get(i).score, x, y);
      
      
      y = y + 70;  
      x = 400;
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