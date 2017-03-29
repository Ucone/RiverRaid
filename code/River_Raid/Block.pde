public class Block extends Element{
  
  Block() {
      super("./images/sprites/map_block.png", 300, 300);
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