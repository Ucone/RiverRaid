class JetSelection{

  int boxSize = 200;  
  float xFirst, yFirst, xSecond, ySecond;
  int selected = 0;
  PImage firstJet, secondJet;
  
  JetSelection(){
    xFirst = 100.0;
    yFirst = 100.0;
    xSecond = 400.0;
    ySecond = 100.0;
    
    firstJet = getImage("./images/sprites/jet.png", 150, 130);
    secondJet = getImage("./images/sprites/jet_2.png", 150, 130); 
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
    int xPos = 0;
    if(selected == 0){
      xPos = 80;
    }
    if(selected == 1){
      xPos = 380;
    }
    
    rect(xPos, 100, boxSize, boxSize);

    drawJets();
  }
  
  void drawJets(){
    image(firstJet, 100, 100);
    
    image(secondJet, 400, 100);
  }
}