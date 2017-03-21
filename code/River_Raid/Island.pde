class Island extends Element{
 // int xPos, yPos = 0;
  boolean overcome = false;
 // PImage image;
  PImage originalImage;
  int size; //<>// //<>// //<>// //<>//
  
  Island(){ //<>// //<>// //<>// //<>//
    this.type = ElementType.ISLAND;
    originalImage = loadImage("./images/sprites/isle.png");
    this.image = originalImage.copy();
    image.resize(w(200), h(200));
    updateRandomPosition();
    updateRandomSize();
  }
   //<>//
  void drawIsland(){ //<>// //<>// //<>//
    if(yPos > viewportH + image.height*2){ //<>//
      updateRandomPosition(); //<>// //<>// //<>//
      updateRandomSize();
    }
    
    yPos += speed;
    image(this.image, x(xPos), y(yPos));
  }
  
  
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