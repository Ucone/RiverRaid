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
      if(xPos >= viewportW - this.image.width || xPos <= 0 || islandCollision() || fuelDepotCollision())
        this.direction = !direction;
      
      if(this.direction)
        xPos += lateralSpeed;
      else
        xPos -= lateralSpeed;    
    }
    
    private boolean islandCollision(){
       if((abs(island.getX() - this.getX()) <= island.getImage().width / 2) && abs(island.getY() - this.getY()) <= island.getImage().height)
         return true;
       return false;
    }
    
    private boolean fuelDepotCollision(){
      if((abs(fuelDepot.getX() - this.getX()) <= fuelDepot.getImage().width / 2) && abs(fuelDepot.getY() - this.getY()) <= fuelDepot.getImage().height)
         return true;
      return false;
    }
    
    public void checkIsVisible(){
      if(yPos > viewportH + this.image.height*3){
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