class Jet extends Element{
  
  PImage imageCrashed;
  private float fuel;
  private boolean crashed = false;

  private int reserveJets = 1;
  private int lastFired = 0;
  private final float FIRE_DELAY = 50.0;
  public float fireCooldown = 0;
  public boolean firingMode = false;

  
   Jet(){
     super("./images/sprites/jet.png", 80, 130);
     imageCrashed = getImage("./images/sprites/crash.png", 80, 130);
     yPos = 800;
     xPos = 500;
     fuel = INITIAL_FUEL;
   }
   
   Jet(int jetB){
     super("./images/sprites/jet_2.png", 80, 130);
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
      this.fuel = (this.fuel - VELOCITY_CONSUMPTION*gameSpeed*2*nD);
     else{
        this.crashed = true;
        jet.removeReserveJet();
        //sound effect
        sound.playCrashSound();

        timeResetWorld=millis();
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
        jet.removeReserveJet();
        //sound effect
        sound.playCrashSound();

        timeResetWorld=millis();
    }
  }
  
  public boolean fire() {
     if(fireCooldown > 0) return false;
     
     fireCooldown += FIRE_DELAY;
     Rocket rocket = new Rocket();
     if(this.firingMode == true)
       rocket.xPos = this.xPos + jet.width - rocket.width;
     else
       rocket.xPos = this.xPos;
     this.firingMode = !this.firingMode;
     rocket.yPos = this.yPos + 60;
     rockets.add(rocket);

     //sound effect
     sound.playShootSound();
     
     return true;
  }
  
  public void update(float nD) {
    if(fireCooldown > 0)
      fireCooldown -= nD;
    jet.yPos = yMaster+800;
  }
  
  public float getFuel(){
     return fuel;
   }
   
   public void setFuel(int fuel){ //<>//
     this.fuel = fuel;
   }
   
  public int getReserveJets(){
     return this.reserveJets; 
  }
  
  public void addReserveJet(){
    this.reserveJets++;
  }
  
  public void removeReserveJet(){
    if(this.reserveJets >= 0) //<>// //<>// //<>//
      this.reserveJets--;
      
    if (this.reserveJets < 0)
      gameState = gameState.END;     
     
  }
}