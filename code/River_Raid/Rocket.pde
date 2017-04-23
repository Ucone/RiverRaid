public class Rocket extends Element {
  float SPEED = 10.0;
  
  Rocket() {
    super("./images/sprites/rocket.png", 40, 40);
  }
  
  void update(float nD) {
    yPos -= SPEED * nD;
  }
}