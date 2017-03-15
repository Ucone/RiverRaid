class Island extends Element{
 // int xPos, yPos = 0;
  boolean overcome = false;
 // PImage image;
  PImage originalImage;
  int size; //<>// //<>//
  
  Island(){ //<>// //<>//
    originalImage = loadImage("./images/sprites/isle.png");
    this.image = originalImage.copy();
    image.resize(w(200), h(200));
    updateRandomPosition();
    updateRandomSize();
  }
  
    //FuelDepot(){ //<>//
    //this.image = loadImage("./images/sprites/fueldepot.png");
    //image.resize(viewportW / 5, viewportH / 3); //<>//
//  }
//  
  
  
  void drawIsland(){ //<>//
    if(yPos >= height){
      updateRandomPosition(); //<>//
      updateRandomSize();
    }
    
    yPos += speed;
    image(this.image, x(xPos), y(yPos));
  }
  
  //    void drawDepot(){
  //  if(yPos >= height + image.height){
  //    updateRandomPosition(); //<>//
  //  }
    
  //  yPos += speed;
  //  image(this.image, x(xPos), y(yPos));
  //}
  
  
  
  
  
  void updateRandomPosition(){
    xPos = (int) random(viewportW/3, viewportW-viewportW/3-image.width);
    yPos = (int)random(-600, -2000);
  }
  
  void updateRandomSize(){
    size = (int)random(viewportW / 20, viewportW / 5);
    image = originalImage.copy();
    image.resize(size, size);
  }
}