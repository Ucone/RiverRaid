public class Rocket extends Element {
  float SPEED = 3.0;
  
  Rocket(float x, float y) {
    super("./images/sprites/rocket.png", 10, 10);
  }
  
  void update(float nD) {
    yPos -= SPEED * nD;
  }
}