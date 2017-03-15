class NewJet extends Element{
  
  PImage imageCrashed;
  private int fuel;
  private boolean crashed = false;
  
   NewJet(){
     this.image = loadImage("./images/sprites/jet.png");
     this.imageCrashed = loadImage("./images/sprites/crash.png");
     image.resize(w(90), h(160));
     imageCrashed.resize(w(90), h(160));
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
   public int getFuel(){
     return fuel;
   }
   
   public void setFuel(int fuel){
     this.fuel = fuel;
   }
}