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
  
  public void damaged(int i){
      int newWidth = this.image.width;
      int newHeight = this.image.height;
      if(i == 1){
      this.image = loadImage("./images/sprites/fuelDepotDamaged1.png");
      this.image.resize(newWidth,newHeight);
      }else{
      this.image = loadImage("./images/sprites/fuelDepotDamaged2.png");
      this.image.resize(newWidth,newHeight);        
      }
  }
}