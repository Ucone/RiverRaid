public class Block extends Element{
  
  Block(int x,int y) {
      image= loadImage("./images/sprites/map_block.png");
      image.resize(w(350),h(300));
      yPos = y;
      xPos = x;
  }
  
  Block(){
      image= loadImage("./images/sprites/map_block.png");
      image.resize(w(350),h(300));
  }

  public void drawBlock(){
      yPos += gameSpeed;
      image(image, x(xPos), yPos);  
  }
  
  public boolean overcome(){
    if(yPos > 1000)
      return true;
    return false;
  }

}