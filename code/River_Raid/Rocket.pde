public class Rocket extends Element {
  float SPEED = 10.0;
  boolean isEnemy = false;
  
  Rocket() {
    super("./images/sprites/rocket.png", 40, 40);
  }
  
  void update(float nD) {
    if(!isEnemy)
      yPos -= SPEED * nD;
    else
      yPos += SPEED * nD;
  }
}