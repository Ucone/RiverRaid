public class Block extends Element{
  
  Block() {
      super(300, 300, loadImage("./images/sprites/map_block.png"));
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