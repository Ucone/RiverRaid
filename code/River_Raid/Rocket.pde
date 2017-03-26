public class Rocket extends Element {
  float SPEED = 3.0;
  
  Rocket(float x, float y) {
    image = loadImage("./images/sprites/rocket.png");
    image.resize(viewportW/100, viewportW/100);
    xPos = x;
    yPos = y;
  }
  
  void update(float nD) {
    yPos -= SPEED * nD;
  }
  
  void draw()
  {
     image(this.image, x(xPos), y(yPos)); 
  }
}