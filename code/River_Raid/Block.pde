public class Block extends Element{
  
  Block(float x, float y, float w, float h) {
      image= loadImage("./images/sprites/map_block.png");
      image.resize(w(w),h(h));
      yPos = y;
      xPos = x;
  }
  
  Block(){
      image= loadImage("./images/sprites/map_block.png");
      image.resize(w(350),h(300));
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