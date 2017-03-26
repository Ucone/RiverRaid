class Jet extends Element{
  
  PImage imageCrashed;
  private int fuel;
  private boolean crashed = false;
  float speed;
  private int reserveJets = 0;
  
   Jet(){
     this.image = loadImage("./images/sprites/jet.png");
     this.imageCrashed = loadImage("./images/sprites/crash.png");
     image.resize(w(80), h(130));
     imageCrashed.resize(w(80), h(130));
     yPos = 800;
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
   
   public void consume(float nD){
     if(this.fuel > 0)
       this.fuel = (int)(this.fuel - VELOCITY_CONSUMPTION*speed*2*nD);
  }
  
  /*** REFUEL ***/
  public void checkRefuel(FuelDepot fuelDepot, float nD){
    float fuelDepotY = fuelDepot.getY();
    if(fuelDepotY < 0){
      fuelDepotY = 1000 + fuelDepotY;
    }
    
    if((this.getX() >= fuelDepot.getX()) && (this.getX() + this.getImage().width <= fuelDepot.getX() + fuelDepot.getImage().width) &&
        ( (this.getY() >= fuelDepotY) && (this.getY() <= fuelDepotY + fuelDepot.getImage().height) ) ){
          this.refuel(nD);
          VELOCITY_CONSUMPTION = 0;
    }else{
        VELOCITY_CONSUMPTION = 0.1;
    }
  }
  
  public void refuel(float nD){
    int refuelSpeed = 3;
    if(speed < DEFAULT_SPEED){
      refuelSpeed = 8;
    }
    if(this.fuel < INITIAL_FUEL){
      this.fuel = (int)(this.fuel + refuelSpeed * nD);
    }
  }
   
   
   /* COLLISION */
   public void checkCollision(Element e){
    if(elementCollision(e) || mapCollision()){
        this.crashed = true;
        this.removeReserveJet();
    }
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
   
  public int getReserveJets(){
     return this.reserveJets; 
  }
  
  public void addReserveJet(){
    this.reserveJets++;
  }
  
  public void removeReserveJet(){
    if(this.reserveJets > 0)
      this.reserveJets--;
  }
}