import controlP5.*;

public class Element{
  
  public PImage image;
  //Coordenates
  float xPos = 0;
  float yPos = 0;
  ElementType type;

  void updateRandomPosition(){
    this.xPos = (int)random(200, 600);
    this.yPos = (int)random(-1500, -3000) - this.image.height;
    this.xPos = 0;
    this.yPos = 0;
  }
  
  public float getX(){
    return xPos;
  }
  
  public float getY(){
    return yPos;
  }
  
  public PImage getImage(){
    return image;
  }
}
