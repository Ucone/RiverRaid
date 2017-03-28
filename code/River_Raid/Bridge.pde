class Bridge extends Element{
  
  Bridge(float yPos){
    this.image = loadImage("./images/sprites/bridge.png");
    this.image.resize(w(1000), h(100));
    this.xPos = 0;
    this.yPos = yPos;
  }
  
  void draw(){
    image(this.image, x(xPos), yPos);
  }
  
  void update(float nD) {
    yPos += gameSpeed * nD;
  }
}