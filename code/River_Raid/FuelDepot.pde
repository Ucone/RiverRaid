public class FuelDepot extends Element{

  FuelDepot(){
    this.type = ElementType.FUEL_DEPOT;
    this.image = loadImage("./images/sprites/fueldepot.png");
    image.resize(viewportW / 5, viewportH / 3);
  }
  
  /*
  void updateRandomPosition(){
    this.xPos = (int)random(200, 600);
    this.yPos = (int)random(-1500, -3000) - this.image.height;
  }
  */
    void drawDepot(){
    if(yPos >= height + image.height){ //<>//
      updateRandomPosition(); //<>// //<>//
    }
    
    yPos += speed;
    image(this.image, x(xPos), y(yPos));
  }
  
  
}