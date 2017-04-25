public class Enemy extends Element{
  
    public boolean direction = true; //True: right, False: left
    public int score;
    public float lateralSpeed;
    public String kind;
    boolean fired = false;
    
    public Enemy(String s, float w, float h) {
      super(s, w, h); 
    }
    
    public void update(float nD){
      if(this.direction)
        xPos += lateralSpeed * nD;
      else
        xPos -= lateralSpeed * nD;
      if(world.checkCollision(this, World.C_EVERYTHING)) {
        this.direction = !this.direction;
        if(this.direction)
          xPos += lateralSpeed * nD;
        else
          xPos -= lateralSpeed * nD;
      }
      
      if(this.yPos < jet.yPos && this.yPos > jet.yPos - 700  && !fired)
        if( new Random().nextDouble() <= 0.6 ){
            this.fire();
            fired = true;
        }
    }
    
    public boolean fire() {
     Rocket rocket = new Rocket(true);
     rocket.xPos = this.xPos;
     rocket.yPos = this.yPos + 10;
     rocket.isEnemy = true;
     enemyRockets.add(rocket);

     //sound effect
     sound.playShootSound();
     
     return true;
  }
    
    public Decoration getDebris() {
      return null;
    }
}
    class Tanker extends Enemy {
      public Tanker(int section){
        super("./images/sprites/enemy_tanker.png", 50, 200);
        this.kind = "Tank";
        this.lateralSpeed = section;
        this.score = 200;
      }
    }
    class Helicopter extends Enemy {
      public Helicopter(int section){
        super("./images/sprites/enemy_chopper.png", 50, 100);
        this.kind = "Helicopter";
        this.lateralSpeed = 1 + section;
        this.score = 200;
      }
    }
    
    class EnemyJet extends Enemy {
      public EnemyJet(int section){
        super("./images/sprites/enemy_jet.png", 50, 100);
        this.kind = "EnemyJet";
        this.lateralSpeed = 2 + section;
        this.score = 200;
    }
    }
    
    class FinalEnemy extends Enemy {
      public FinalEnemy(String str, int x, int y){
        super(str, 300, 200);
        this.kind = "";
        this.yPos = y;
        this.xPos = x;

    }
}