public class Jet {
  
  private int id;  // in case we desing more jets
  private PImage jet_image = loadImage("./images/sprites/jet.png");
  
  private Player player;
  
  //jet coordenates
  private int x;
  private int y;
  
  public Jet(PImage image){
    x= image.width/2;
    y = image.height -100;

  }
  
  public void draw(){

    jet_image.resize(width/15, height/11);  
    image(jet_image, x, y);
  }
  /*
  public Jet (){  //Actually in the constructor should receive the map
  jet_image = loadImage("./images/sprites/jet.png");
  image(jet_image, x, y);
  jet_image.resize(width/15, height/11);  
  }
  */
  
  public int getX(){
       return x; 
  }

  public void setX(int x){
     this.x= x; 
  }
  
  public int getY(){
     return y; 
  }
  
  public void setY(int y){
      this.y=y;
  }
  
  public void moveLeft(){
      x= x-10;
      translate(x, y);
      //image(jet_image, x, y);
  }
   
   public void moveRight(){
      x= x+10;
      translate(x, y);
      //image(jet_image, x, y);
  }
}