public class Block extends Element{
  public static float width = 300;
  public static float height = 300;
  
  Block(float x, float y) {
      image= loadImage("./images/sprites/map_block.png");
      image.resize(w(Block.width),h(Block.height));
      yPos = y;
      xPos = x;
  }

  public void draw(){
      image(image, x(xPos), y(yPos));  
  }
  
  public void update(float nD) {
    yPos += gameSpeed * nD; 
  }
  
  public boolean overcome(){
    if(yPos > 1000)
      return true;
    return false;
  }

}