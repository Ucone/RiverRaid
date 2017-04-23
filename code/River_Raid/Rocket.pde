public class Rocket extends Element {
  float SPEED = 10.0;
  boolean isEnemy = false;
  
  Rocket(boolean isEnemy) {
    super("./images/sprites/rocket.png", 40, 40);
    this.isEnemy = isEnemy;
    
    if(isEnemy)
      this.image = getImage("./images/sprites/rocket_enemy.png", w(20), h(40));
  }
  
  void update(float nD) {
    if(!isEnemy)
      yPos -= SPEED * nD;
    else
      yPos += SPEED/2 * nD;
  }
}