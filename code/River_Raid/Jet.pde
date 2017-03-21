class Jet extends Element{
  
  PImage imageCrashed;
  private int fuel;
  private boolean crashed = false;
  int speed;
  
   Jet(){
     this.image = loadImage("./images/sprites/jet.png");
     this.imageCrashed = loadImage("./images/sprites/crash.png");
     image.resize(w(90), h(160));
     imageCrashed.resize(w(90), h(160));
     yPos = 600;
     xPos = 500;
     fuel = INITIAL_FUEL;
   }
   
   public void drawJet(){
     if(!crashed)
       image(this.image, x(xPos), y(yPos));
     else
       image(this.imageCrashed, x(xPos), y(yPos));
   }
   
   public void moveLeft(){
     xPos = xPos - 7;
   }
   
   public void moveRight(){
     xPos = xPos + 7;
   }
   
   public void consume(){
      this.fuel = (int)(this.fuel - VELOCITY_CONSUMPTION*speed*2);
  }
  
  /*** REFUEL ***/
  public void checkRefuel(FuelDepot fuelDepot){
    int fuelDepotY = fuelDepot.getY();
    if(fuelDepotY < 0){
      fuelDepotY = 1000 + fuelDepotY;
    }
    
    if((this.getX() >= fuelDepot.getX()) && (this.getX() + this.getImage().width <= fuelDepot.getX() + fuelDepot.getImage().width) &&
        ( (this.getY() >= fuelDepotY) && (this.getY() <= fuelDepotY + fuelDepot.getImage().height) ) ){
          this.refuel();
          VELOCITY_CONSUMPTION = 0;
    }else{
        VELOCITY_CONSUMPTION = 0.1;
    }
  }
  
  public void refuel(){
    int refuelSpeed = 3;
    if(speed < DEFAULT_SPEED){
      refuelSpeed = 8;
    }
    if(this.fuel < INITIAL_FUEL){
      this.fuel = (int)(this.fuel + refuelSpeed);
    }
  }
   
   
   /* COLLISION */
   public void checkCollision(Element e){
    if(enemyCollision(e) || mapCollision() || islandCollision(e)){
        this.crashed = true;
    }
  }
  
  private boolean enemyCollision(Element e){
    if(e.type == ElementType.ENEMY){
      if((abs(e.getX() - this.getX()) <= e.getImage().width / 2) && abs(e.getY() - this.getY()) <= e.getImage().height){
        return true;
      }
    }
    return false;
  }
  
  private boolean islandCollision(Element e){
    if(e.type == ElementType.ISLAND){
      if((abs(e.getX() - this.getX()) <= e.getImage().width / 2) && abs(e.getY() - this.getY()) <= e.getImage().height){ 
        return true;
      }
    }
    return false;
  }
  
  private boolean mapCollision(){
    if(this.getX() < 0 || this.getY() > width)
      return true;
    return false;
  }
  
  
  public int getFuel(){
     return fuel;
   }
   
   public void setFuel(int fuel){
     this.fuel = fuel;
   }
}