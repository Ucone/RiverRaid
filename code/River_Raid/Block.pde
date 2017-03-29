public class Block extends Element{
  
  Block() {
      super("./images/sprites/map_block.png", 300, 300);
  }

  public void draw(){
      image(image, x(xPos), y(yPos));  
  }
}