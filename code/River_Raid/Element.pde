public class Element{
  public PImage image;
  
  //Coordenates
  int xPos = (int)random(300, 700);
  int yPos = 0;

  
  void drawElement(){
    if(yPos >= height){
      updateRandomPosition(); //<>//
    }
    
    yPos += speed;
    image(this.image, x(xPos), y(yPos));
  }
  
  void updateRandomPosition(){
    this.xPos = (int)random(50, 900);
    this.yPos = (int)random(-2000, -5000);
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