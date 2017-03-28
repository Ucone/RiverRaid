public class Rocket extends Element {
  float SPEED = 3.0;
  
  Rocket(float x, float y) {
    super(10, 10, loadImage("./images/sprites/rocket.png"));
  }
  
  void update(float nD) {
    yPos -= SPEED * nD;
  }
}