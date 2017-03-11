public class FuelDepot extends Element{

  FuelDepot(){
    this.image = loadImage("./images/sprites/fueldepot.png");
    image.resize(viewportW / 5, viewportH / 3);
  }
  
}