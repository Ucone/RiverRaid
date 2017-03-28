class Island extends Element{
 // int xPos, yPos = 0;
  boolean overcome = false;
 // PImage image;
  PImage originalImage;
  int size;
  
  Island(){
    super(100, 100, loadImage("./images/sprites/isle.png"));
  }
}