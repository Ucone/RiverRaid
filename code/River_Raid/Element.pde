import controlP5.*;

public class Element{
  
  public PImage image;
  //Coordenates
  public float xPos = 0;
  public float yPos = 0;
  ElementType type;

  void updateRandomPosition(){
    this.xPos = (int)random(200, 600);
    this.yPos = (int)random(-1500, -3000) - this.image.height;
    this.xPos = 0;
    this.yPos = 0;
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
  
  boolean collide(Element other) {
    return (x(this.getX()) + this.image.width > x(other.getX()) && x(this.getX()) < x(other.getX()) + other.image.width) && 
      (y(this.getY()) + this.image.height > y(other.getY()) && y(this.getY()) < y(other.getY()) + other.image.height);
  }
  
  public void draw() {};
  public void update(float nD) {};
}
