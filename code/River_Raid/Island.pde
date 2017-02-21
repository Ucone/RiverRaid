class Island{
  float xPos, yPos = 0;
  boolean overcome = false;
  PImage image;
  
  Island(){ //<>//
    image = loadImage("./images/sprites/isle.png");
    image.resize(width / 8, height / 8);
    updateRandomPositions();
  }
  
  void drawIsland(){
    if(yPos >= height){
      updateRandomPositions();
    } //<>//
    
    yPos += speed;
    image(this.image, xPos, yPos);
  }
  
  
  void updateRandomPositions(){
    this.xPos = random(width/3, width-width/3-image.width);
    this.yPos = 0 - image.height;
  }
}