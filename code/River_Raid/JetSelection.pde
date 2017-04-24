class JetSelection{

  int boxSize = 200;  
  float xFirst, yFirst, xSecond, ySecond;
  int selected = 0;
  
  JetSelection(){
    xFirst = 100.0;
    yFirst = 100.0;
    xSecond = 400.0;
    ySecond = 100.0;
    
  }
  
  void draw(){
    image(startImg, x(0), y(0));
    fill(0, 80);
    rect(x(0), y(0), w(1000), h(1000));
    
    //mouseHandler();
    drawBoxes();
    //First box
    
  }
  
  void mouseHandler(){
    if(mouseX > xFirst && mouseX < xFirst + boxSize
      && mouseY > yFirst && mouseY < yFirst + boxSize){
      this.selected = 0;
    }else if(mouseX > xSecond && mouseX < xSecond + boxSize
      && mouseY > ySecond && mouseY < ySecond + boxSize){
      this.selected = 1;
    }
    
    drawBoxes();
  }
  
  void drawBoxes(){
    if(selected == 0){
      fill(0, 0, 255);
      rect(100, 100, boxSize, boxSize);
    
      fill(0, 255, 0);
      rect(400, 100, boxSize, boxSize);
    }else if(selected == 1){
      fill(255, 0, 0);
      rect(100, 100, boxSize, boxSize);
    
      fill(0, 0, 255);
      rect(400, 100, boxSize, boxSize);
    }else{
      fill(255, 0, 0);
      rect(100, 100, boxSize, boxSize);
    
      fill(0, 255, 0);
      rect(400, 100, boxSize, boxSize);
    }
  }
}