public class Jet {
  
  private int id;  // in case we desing more jets
  private PImage image = loadImage("./images/sprites/jet.png");
  private PImage imageCrashed = loadImage("./images/sprites/crash.png");
  //jet coordenates
  private int x;
  private int y;
  
  private int fuel;
  
  public int speed;
  
  private boolean crashed = false;
  
  public Jet(){
    x= 500;
    y = 800;
    image.resize(w(90), h(160));  
    imageCrashed.resize(w(90), h(160));  
    fuel = INITIAL_FUEL;
    speed = DEFAULT_SPEED;
  }
  
  public void drawJet(){   
    if(!crashed)
      image(image, x(x), y(y));
    else
      image(imageCrashed, x(x), y(y));
  }

  
  public int getX(){
       return x; 
  }

  public void setX(int x){
     this.x= x; 
  }
  
  public int getY(){
     return y; 
  }
  
  public void setY(int y){
      this.y=y;
  }
  
  public int getFuel(){
    return fuel;
  }
  
  public void setFuel(int fuel){
    this.fuel = fuel;
  }
  public PImage getImage(){
    return image;
  }
  
  public void moveLeft(){
      x= x-7;
      //translate(x, y);
      image(image, x, y);
  }
   
   public void moveRight(){
      x= x+7;
      //translate(x, y);
      image(image, x, y);
  }
  
  public void consume(){
    this.fuel = (int)(this.fuel - VELOCITY_CONSUMPTION*this.speed*2);
  }
  
  /*** REFUEL ***/
  public void checkRefuel(FuelDepot fuelDepot){
    int fuelDepotY = fuelDepot.getY();
    if(fuelDepotY < 0){
      fuelDepotY = 1000 + fuelDepotY;
    }
    
    if((jet.getX() >= fuelDepot.getX()) && (jet.getX() + jet.getImage().width <= fuelDepot.getX() + fuelDepot.getImage().width) &&
        ( (jet.getY() >= fuelDepotY) && (jet.getY() <= fuelDepotY + fuelDepot.getImage().height) ) ){
          jet.refuel();
          VELOCITY_CONSUMPTION = 0;
    }else{
        VELOCITY_CONSUMPTION = 0.1;
    }
  }

  public void refuel(){
    int refuelSpeed = 3;
    
    if(this.speed < DEFAULT_SPEED){
      refuelSpeed = 8;
    }
    if(this.fuel < INITIAL_FUEL){
      this.fuel = (int)(this.fuel + refuelSpeed);
    }
  }
  
  
  public void checkCollision(Element e){
    if(((abs(this.x - e.xPos) < 60 && abs(this.y - e.yPos) < 60))  // check the collision with enemies;
        || (this.x < 0 || this.x > width) // check the collision with map elements (need to fix);
         || islandCollision()
        ){
        this.crashed = true;
      }
  }
  
  private boolean islandCollision(){
    if( (abs(this.getY() - island.yPos) <=  island.image.height * 1.5) && (abs(this.getX() - island.xPos) < 30 + island.image.width / 2))
      return true;
    return false;
  }
}