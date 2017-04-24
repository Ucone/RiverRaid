class JetSelection{

  int boxSize = 200;  
  float xFirst, yFirst, xSecond, ySecond;
  
  JetSelection(){
    xFirst = 100.0;
    yFirst = 100.0;
    xSecond = 400.0;
    ySecond = 100.0;
    
  }
  
  void drawSelection(){
    image(startImg, x(0), y(0));
    fill(0, 80);
    rect(x(0), y(0), w(1000), h(1000));
    
    //First box
    if(mouseX > xFirst && mouseX < xFirst + boxSize
      && mouseY > yFirst && mouseY < yFirst + boxSize){
      drawBoxes(0);
    }else if(mouseX > xSecond && mouseX < xSecond + boxSize
      && mouseY > ySecond && mouseY < ySecond + boxSize){
      drawBoxes(1);
    }else{
      drawBoxes(-1);
    }
  }
  
  void drawBoxes(int selected){
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