class Island{
  float xPos, yPos = 0;
  boolean overcome = false;
  PImage image;
  
  Island(){ //<>//
    image = loadImage("./images/sprites/isle.png");
    image.resize(width / 8, height / 8);
    yPos = 0 - image.height;
  }
  
  void drawIsland(){
    yPos += speed;
    image(this.image, width-800, yPos);
  } //<>//
  
  void updatePos(){
    yPos += speed;
  }
}