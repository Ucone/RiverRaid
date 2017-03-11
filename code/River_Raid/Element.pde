public class Element{
  private PImage image;
  
  //Coordenates
  private int x;
  private int y;
  
  
  void drawElement(){
    if(yPos >= height){
      updateRandomPosition(); //<>//
      updateRandomSize();
    }
    
    yPos += speed;
    image(this.image, xPos, yPos);
  }
  
  void updateRandomPosition(){
    this.xPos = random(viewportW/3, viewportW-viewportW/3-image.width);
    this.yPos = random(-600, -2000);
  }
  
  void updateRandomSize(){
    int size = (int)random(viewportW / 20, viewportW / 5);
    image = originalImage.copy();
    image.resize(size, size);
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
}