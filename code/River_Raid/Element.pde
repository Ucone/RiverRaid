public class Element{
  public PImage image;
  
  //Coordenates
  int xPos = x(100);
  int yPos = y(-1000);

  
  void drawElement(){
    if(yPos >= height + image.height){
      updateRandomPosition(); //<>//
    }
    
    yPos += speed;
    image(this.image, x(xPos), y(yPos));
  }
  
  void updateRandomPosition(){
    this.xPos = x(100);
    this.yPos = y(-1000);
  }
  
  public int getX(){
    return xPos;
  }
  
  public int getY(){
    return yPos;
  }
  
  public PImage getImage(){
    return image;
  }
}