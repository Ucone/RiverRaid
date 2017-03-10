class Island{
  float xPos, yPos = 0;
  boolean overcome = false;
  PImage image;
  PImage originalImage;
  Island(){ //<>//
    originalImage = loadImage("./images/sprites/isle.png");
    image = originalImage.copy();
    image.resize(viewportW / 5, viewportH / 5);
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
    this.xPos = random(viewportW/3, viewportW-viewportW/3-image.width);
    this.yPos = random(-600, -2000);
  }
  
  void updateRandomSize(){
    int size = (int)random(viewportW / 20, viewportW / 5);
    image = originalImage.copy();
    image.resize(size, size);
  }
}