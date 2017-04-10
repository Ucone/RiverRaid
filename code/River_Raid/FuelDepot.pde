public class FuelDepot extends Element{

  private int lives = 5;
  
  FuelDepot(){
    super("./images/sprites/fueldepot.png", 90, 160);
  }
  
  public void removeLive(){
    lives--;
  }
  
  public int getLives(){
     return lives; 
  }
  
  public void damaged(){
      int newWidth = this.image.width;
      int newHeight = this.image.height;
      this.image = loadImage("./images/sprites/fueldepotDamaged.png");
      this.image.resize(newWidth,newHeight);
  }
}