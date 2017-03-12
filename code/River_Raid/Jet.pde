public class Jet {
  
  private int id;  // in case we desing more jets
  private PImage image = loadImage("./images/sprites/jet.png");
  private PImage imageCrashed = loadImage("./images/sprites/crash.png");
  //jet coordenates
  private int x;
  private int y;
  
  private int fuel;
  
  private boolean crashed = false;
  
  public Jet(){
    x= 500;
    y = 800;
    image.resize(w(width/20), h(height/10));  
    fuel = INITIAL_FUEL;
  }
  
  public void draw(){   
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
      translate(x, y);
      //image(image, x, y);
  }
   
   public void moveRight(){
      x= x+7;
      translate(x, y);
      //image(jet_image, x, y);
  }
  
  public void consume(){
    this.fuel = (int)(this.fuel - VELOCITY_CONSUMPTION*speed);
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
    
    if(speed < DEFAULT_SPEED){
      refuelSpeed = 10;
    }
    if(this.fuel < INITIAL_FUEL){
      this.fuel = (int)(this.fuel + refuelSpeed);
    }
  }
  
  
  public void checkCollision(Element e){
    if(((abs(this.x - e.xPos) < 60 && abs(this.y - e.yPos) < 60))  // check the collision with enemies;
        || (this.x < 0 || this.x > width) // check the collision with map elements (need to fix);
       /* || (abs(this.x - e.xPos) < 30 + e.size / 2 && abs(this.y - e.yPos) < 30 + e.size / 2)  // check the collision with the island;
       */
        ){
        this.crashed = true;
      }
  }
}