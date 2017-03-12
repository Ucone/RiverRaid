public class Enemy extends Element{

    /* EXTENDS
      public PImage image;
      int xPos = 100;
      int yPos = -1500;
    */
    
    public boolean isVisibile = true;
    public int section;
    public int mapSpeed;
    public boolean direction = true; //True: right, False: left
    public boolean isVisible = true;
    public int score;
    public int speed;
    
    public Enemy(int section, int mapSpeed){
      this.xPos = (int)random(width);
      this.section = section;
      this.mapSpeed = mapSpeed;
    }
    
    public void draw(){
      image(image, x(xPos), y(yPos));
      this.move();
    }
    
    public void move(){
      if(this.xPos >= width || this.xPos <= 0)
        this.direction = !direction;
      
      if(this.direction)
        this.xPos += speed;
      else
        this.xPos -= speed;
        
      this.yPos += this.mapSpeed;
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
        image.resize(w(width/20), h(height/10));
        this.speed = section;
        this.score = 200;
      }
    }
    class Helicopter extends Enemy {
      public Helicopter(int section, int speed){
        super(section, speed);
        this.image = loadImage("./images/sprites/enemy_chopper.png");
        image.resize(w(width/20), h(height/10));
        this.speed = 1 + section;
        this.score = 200;
      }
    }
    
    class EnemyJet extends Enemy {
      public EnemyJet(int section, int speed){
        super(section, speed);
        this.image = loadImage("./images/sprites/enemy_jet.png");
        image.resize(w(width/20), h(height/10));
        this.speed = 2 + section;
        this.score = 200;
    }
}