class NewJet extends Element{
  
  PImage imageCrashed;
  
   NewJet(){
     this.image = loadImage("./images/sprites/jet.png");
     this.imageCrashed = loadImage("./images/sprites/crash.png");
     image.resize(w(90), h(160));  
     yPos = 800;
     xPos = 500;
   }
   
   public void drawJet(){
     image(this.image, x(xPos), y(yPos));
   }
}