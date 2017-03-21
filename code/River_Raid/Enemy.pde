public class Enemy extends Element{

    /* EXTENDS
      public PImage image;
      int xPos = 100;
      int yPos = -1500;
    */
    
    public boolean isVisibile = true;
    public int section;
    public boolean direction = true; //True: right, False: left
    public boolean isVisible = true;
    public int score;
    public int lateralSpeed;
    
    public Enemy(int section, int mapSpeed){
      this.type = ElementType.ENEMY;
      this.xPos = (int)random(width);
      this.section = section;
    }
    
    public void drawEnemy(){

       this.move();
       yPos += speed;
      
      image(image, x(xPos), y(yPos));
      
    }
    
    public void move(){
      if(xPos >= width || xPos <= 0)
        this.direction = !direction;
      
      if(this.direction)
        xPos += lateralSpeed;
      else
        xPos -= lateralSpeed;
        
    }
    
    public void checkIsVisible(){
      if(this.yPos >= height){
        this.isVisible = false;
      }else{
        this.isVisible = true;
      }
    }
}
    class Tanker extends Enemy {
      public Tanker(int section, int speed){
        super(section, speed);
        this.image = loadImage("./images/sprites/enemy_tanker.png");
        image.resize(w(50), h(100));
        this.lateralSpeed = section;
        this.score = 200;
      }
    }
    class Helicopter extends Enemy {
      public Helicopter(int section, int speed){
        super(section, speed);
        this.image = loadImage("./images/sprites/enemy_chopper.png");
        image.resize(w(50), h(100));
        this.lateralSpeed = 1 + section;
        this.score = 200;
      }
    }
    
    class EnemyJet extends Enemy {
      public EnemyJet(int section, int speed){
        super(section, speed);
        this.image = loadImage("./images/sprites/enemy_jet.png");
        image.resize(w(50), h(100));
        this.lateralSpeed = 2 + section;
        this.score = 200;
    }
}