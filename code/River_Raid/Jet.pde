class Jet extends Element{
  
  PImage imageCrashed;
  private int fuel;
  private boolean crashed = false;
  private int reserveJets = 3;
  
   Jet(){
     super("./images/sprites/jet.png", 80, 130);
     imageCrashed = getImage("./images/sprites/crash.png", 80, 130);
     yPos = 800;
     xPos = 500;
     fuel = INITIAL_FUEL;
   }
   
   public void draw(float yMaster){
     if(!crashed)
       image(this.image, x(xPos), y(yPos - yMaster));
     else
       image(this.imageCrashed, x(xPos), y(yPos - yMaster));
   }
   
   public void moveLeft(){
     xPos = xPos - 7;
   }
   
   public void moveRight(){
     xPos = xPos + 7;
   }
   
   public void consume(float nD){
     if(this.fuel > 0)
      this.fuel = (int)(this.fuel - VELOCITY_CONSUMPTION*gameSpeed*2*nD);
     else{
      this.crashed = true;
     }
  }
  
  /*** REFUEL ***/
  public void checkRefuel(float nD){

    if(world.checkCollision(this, World.C_FUEL_DEPOTS)){
        this.refuel(nD);
        VELOCITY_CONSUMPTION = 0;
    }else{
        VELOCITY_CONSUMPTION = 0.1;
    }
  }
  
  public void refuel(float nD){
    int refuelSpeed = 3;
    if(gameSpeed < DEFAULT_SPEED){
      refuelSpeed = 8;
    }
    if(this.fuel < INITIAL_FUEL){
      this.fuel = (int)(this.fuel + refuelSpeed * nD);
    }
  }
   
   
   /* COLLISION  */
   public void checkCollision(){
    if(world.checkCollision(this, World.C_OBSTACLES)){
        this.crashed = true;
        //gameSpeed=0;
        
        //sound effect
        sound.playCrashSound();

        timeResetWorld=millis();
        //resetWorld();
    }
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