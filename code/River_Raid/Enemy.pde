public class Enemy extends Element{

    /* EXTENDS
      public PImage image;
      int xPos = 100;
      int yPos = -1500;
    */
    
    public int section;
    public boolean direction = true; //True: right, False: left
    public int score;
    public int lateralSpeed;
    
    public Enemy(int section){
      this.type = ElementType.ENEMY;
      this.xPos = (int)random(width);
      this.section = section;
    }
    
    public boolean isVisible(){
      return (yPos <= viewportH + this.image.height*3);
    }
    
    public void update() {
      this.move();
    }
    
    public void drawEnemy(){
      image(image, x(xPos), y(yPos + masterY));
    }
    
    public void move(){
      if(mapCollision() || islandCollision() || fuelDepotCollision())
        this.direction = !direction;
      
      if(this.direction)
        xPos += lateralSpeed;
      else
        xPos -= lateralSpeed;    
    }
    
    private boolean islandCollision(){
       return elementCollision(island);
    }
    
    private boolean fuelDepotCollision(){
       return elementCollision(fuelDepot);
    }
    
}
    class Tanker extends Enemy {
      public Tanker(int section){
        super(section);
        this.image = loadImage("./images/sprites/enemy_tanker.png");
        image.resize(w(50), h(100));
        this.lateralSpeed = section;
        this.score = 200;
      }
    }
    class Helicopter extends Enemy {
      public Helicopter(int section){
        super(section);
        this.image = loadImage("./images/sprites/enemy_chopper.png");
        image.resize(w(50), h(100));
        this.lateralSpeed = 1 + section;
        this.score = 200;
      }
    }
    
    class EnemyJet extends Enemy {
      public EnemyJet(int section){
        super(section);
        this.image = loadImage("./images/sprites/enemy_jet.png");
        image.resize(w(50), h(100));
        this.lateralSpeed = 2 + section;
        this.score = 200;
    }
}