import controlP5.*;

public class Element{
  
  public PImage image;
  //Coordenates
  int xPos = 0;
  int yPos = 0;
  ElementType type;

  void updateRandomPosition(){ //<>// //<>// //<>//
    this.xPos = (int)random(200, 600);
    this.yPos = (int)random(-1500, -3000) - this.image.height;
    this.xPos = 0; //<>// //<>// //<>//
    this.yPos = 0;
  }
  
  public int getX(){
    return xPos;
  }
  
  public int getY(){
    return yPos;
  }
  
  public void setY(int y){
    this.yPos = y(y);
  }
  
  public PImage getImage(){
    return image;
  }
  
  public boolean elementCollision(Element e){
    if(abs(x(e.getX()) - x(this.getX())) <= e.getImage().width && abs(y(e.getY()) - y(this.getY())) <= e.getImage().height) 
        return true;
    return false;
  }
  
  public boolean mapCollision(){
    if(this.getX() <= 0 || x(this.getX() + this.getImage().width) >= viewportW)
      return true;
    return false;
  }
}