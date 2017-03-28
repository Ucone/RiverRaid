class Island extends Element{
 // int xPos, yPos = 0;
  boolean overcome = false;
 // PImage image;
  PImage originalImage;
  int size;
  
  Island(){
    this.type = ElementType.ISLAND;
    originalImage = loadImage("./images/sprites/isle.png");
    updateRandomPosition();
    updateRandomSize();
  }
  
  void update(float nD) {
    if(y(yPos) > viewportH + image.height*2){
      updateRandomPosition();
      updateRandomSize();
    }
    yPos += gameSpeed * nD;
  }
  
  void drawIsland(){
    image(this.image, x(xPos), yPos);  
  }

  void updateRandomPosition(){
    xPos = (int) random(333, 800);
    yPos = (int)random(-600, -2000);
  }
  
  
  void updateRandomSize(){
    size = (int)random(viewportW / 20, viewportW / 5);
    image = originalImage.copy();
    image.resize(size, size);
  }
}
