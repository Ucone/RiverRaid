import controlP5.*;

public class Element{
  
  public PImage image;
  //Coordenates
  public float xPos = 0;
  public float yPos = 0;
  
  public float width;
  public float height;

  public Element(String imagePath, float w, float h) {
    image = getImage(imagePath, w(w), h(h));
    this.width = w;
    this.height = h;
  }
  
  public boolean mapCollision(){
    if(this.xPos <= 0 || this.xPos + this.width >= 1000)
      return true;
    return false;
  }
  
  boolean collide(Element other) {
    return (this.xPos + this.width > other.xPos && this.xPos < other.xPos + other.width) && 
      (this.yPos + this.height > other.yPos && this.yPos < other.yPos + other.height);
  }
  
  public void draw(float yMaster) {
      image(image, x(xPos), y(yPos - yMaster));
  };
  
  public void update(float nD) {};
  
  public boolean visible(float yMaster) { // hack-y
    return (this.yPos + height >= yMaster && this.yPos <= yMaster + 1000 && this.xPos + this.width >= 0 && this.xPos <= 1000);
  }
  
  public boolean drawIfVis(float yMaster) {
    if(this.visible(yMaster)) {
      draw(yMaster);
      return true;
    } else {
      return false;
    }
  }
}
