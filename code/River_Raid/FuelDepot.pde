public class FuelDepot extends Element{

  FuelDepot(){
    this.type = ElementType.FUEL_DEPOT;
    this.image = loadImage("./images/sprites/fueldepot.png");
    image.resize(viewportW / 6, viewportH / 4);
    updateRandomPosition();
  }
  
  
  void updateRandomPosition(){
    this.xPos = (int)random(200, 600);
    this.yPos = (int)random(-1500, -3000) - this.image.height;
  }

    void drawDepot(){ //<>// //<>//
    if(yPos >= viewportH + image.height){ //<>// //<>//
      updateRandomPosition(); //<>// //<>// //<>//
    }
    
    yPos += gameSpeed;
    image(this.image, x(xPos), yPos);
  }
  
  
}