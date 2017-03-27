class Bridge extends Element{
  
  Bridge(int yPos){
    this.image = loadImage("./images/sprites/bridge.png");
    this.image.resize(w(1000), h(100));
    this.xPos = 0;
    this.yPos = yPos;
  }
  
  void drawBridge(){
    yPos += gameSpeed;
    image(this.image, x(xPos), yPos);
    
    if(this.getY() == 1000){
      //map.nextLevel();
    }
  }
}