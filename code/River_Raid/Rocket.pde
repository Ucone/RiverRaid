public class Rocket extends Element {
  float SPEED = 10.0;
  boolean enemyRocket = false;
  
  Rocket() {
    super("./images/sprites/rocket.png", 40, 40);
  }
  
  void update(float nD) {
    if(!enemyRocket)
      yPos -= SPEED * nD;
    else
      yPos += SPEED * nD;
  }
  
  boolean isEnemy(){
    return this.enemyRocket;
  }
}