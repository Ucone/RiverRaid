public class Block extends Element{
  
  Block(boolean right) {
      super("./images/sprites/side_block_" + (right ? "right" : "left")  + ".png", 300, 300);
  }

  public void draw(){
      image(image, x(xPos), y(yPos));  
  }
}