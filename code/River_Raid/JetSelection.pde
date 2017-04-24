class JetSelection{

  int boxWidth = 190, boxHeight = 220;  
  float xFirst, yFirst, xSecond, ySecond;
  int selected = 0;
  PImage firstJet, secondJet;
  
  JetSelection(){
    xFirst = 350.0;
    yFirst = 200.0;
    xSecond = 700.0;
    ySecond = 200.0;
    
    firstJet = getImage("./images/sprites/jet.png", 150, 130);
    secondJet = getImage("./images/sprites/jet_2.png", 150, 130); 
  }
  
  void draw(){
    image(startImg, x(0), y(0));
    fill(0, 220);
    rect(x(0), y(0), w(1000), h(1000));
    
    drawBoxes();
    
  }
  
  void mouseHandler(){
    if(mouseX > xFirst && mouseX < xFirst + boxWidth
      && mouseY > yFirst && mouseY < yFirst + boxHeight){
      this.selected = 0;
    }else if(mouseX > xSecond && mouseX < xSecond + boxWidth
      && mouseY > ySecond && mouseY < ySecond + boxHeight){
      this.selected = 1;
    }
    
    drawBoxes();
  }
  
  void drawBoxes(){
    int xPos = 0;
    if(selected == 0){
      xPos = (int)xFirst - 20;
    }
    if(selected == 1){
      xPos = (int)xSecond - 20;
    }
    
    rect(xPos, yFirst, boxWidth, boxHeight);

    drawJets();
  }
  
  void drawJets(){
    image(firstJet, xFirst, yFirst);
    fill(#ffffff);
    textFont(font, 24);
    text("CHOOSE YOUR JET", x(500), y(100));
    
    textFont(font, fontSize);
    textAlign(LEFT);
    text("SPEED: High", xFirst, yFirst + 150);
    text("SHOOTING RATE: High", xFirst, yFirst + 170);
    text("Speed.. Speed.. Are you ready to \nbe fast with this jet?", xFirst, yFirst + 190);
    
    
    image(secondJet, xSecond, ySecond);
    text("SPEED: Medium", xSecond, ySecond + 150);
    text("SHOOTING RATE: Medium", xSecond, ySecond + 170);
    text("You can fly with lower speed... \nbut what about shooting?", xSecond, ySecond + 190);
    
    fill(0);
    textAlign(CENTER);
  }
  
  void saveSelection(){
    jet.updateSelected(selected);
  }
}