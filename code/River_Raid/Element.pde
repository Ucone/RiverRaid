public class Element{
  public PImage image;
  
  //Coordenates
  float xPos = random(300, 700);
  float yPos = 0;

  
  void drawElement(){
    if(yPos >= height){
      updateRandomPosition(); //<>//
    }
    
    yPos += speed;
    image(this.image, xPos, yPos);
  }
  
  void updateRandomPosition(){
    this.xPos = random(300, 700);
    this.yPos = random(-2000, -5000);
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
}