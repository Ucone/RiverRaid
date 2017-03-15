import controlP5.*;

public class Element{
  
  public PImage image;
  
  //Coordenates
  int xPos = 100;
  int yPos = -1500;

   //<>// //<>//
  //void drawElement(){
  //  if(yPos >= height + image.height){
  //    updateRandomPosition(); //<>// //<>//
  //  }
    
  //  yPos += speed;
  //  image(this.image, x(xPos), y(yPos));
  //}
  
  void updateRandomPosition(){
    this.xPos = (int)random(200, 600);
    this.yPos = (int)random(-1500, -3000) - this.image.height;
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