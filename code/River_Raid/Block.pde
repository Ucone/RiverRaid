public class Block extends Element{

  
  int blockInitialY;
  
  Block(int x,int y) {
      image= loadImage("./images/sprites/map_block.png");
      image.resize(w(400),h(600));
      yPos = y;
      xPos = x;
      blockInitialY =y;  
  }
  
  Block() {
    //WARNING, IF CHANGE THE BLOCK CHANGE THE ROUTE
      image= loadImage("./images/sprites/map_block.png");
      image.resize(w(400),h(600));
  }

  public void drawBlock(){
      //yPos += speed;
      image(image, x(xPos), y(masterY + yPos));  
      //I don't know why if I use the next doesn't work
      //image(image, x(xPos), y(yPos));  
  }
  
  public void reestablish(){
    yPos=blockInitialY;
  }
  
  //public int getRandom(){
  //  int random = (int) random(-block.width, +0); 
  //  return random;
  //}
   

}