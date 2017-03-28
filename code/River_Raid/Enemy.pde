public class Enemy extends Element{
  
    public int section;
    public boolean direction = true; //True: right, False: left
    public int score;
    public float lateralSpeed;
    
    public Enemy(float w, float h, PImage img) {
      super(w, h, img); 
    }
    
    public void update(float nD){
      if(this.direction)
        xPos += lateralSpeed * nD;
      else
        xPos -= lateralSpeed * nD;
    }
    

}
    class Tanker extends Enemy {
      public Tanker(int section){
        super(50, 100, loadImage("./images/sprites/enemy_tanker.png"));
        this.lateralSpeed = section;
        this.score = 200;
      }
    }
    class Helicopter extends Enemy {
      public Helicopter(int section){
        super(50, 100, loadImage("./images/sprites/enemy_chopper.png"));
        this.lateralSpeed = 1 + section;
        this.score = 200;
      }
    }
    
    class EnemyJet extends Enemy {
      public EnemyJet(int section){
        super(50, 100, loadImage("./images/sprites/enemy_jet.png"));
        this.lateralSpeed = 2 + section;
        this.score = 200;
    }
}