class Island{
  float xPos, yPos = 0;
  boolean overcome = false;
  PImage image;
  
  Island(){ //<>//
    image = loadImage("./images/sprites/isle.png");
    image.resize(width / 5, width / 5);
    updateRandomPosition();
    updateRandomSize();
  }
  
  void drawIsland(){
    if(yPos >= height){
      updateRandomPosition(); //<>//
      updateRandomSize();
    }
    
    yPos += speed;
    image(this.image, xPos, yPos);
  }
  
  
  void updateRandomPosition(){
    this.xPos = random(width/3, width-width/3-image.width);
    this.yPos = random(-600, -2000);
  }
  
  void updateRandomSize(){
    int size = (int)random(width / 20, width / 5);
    image.resize(size, size);
  }
}