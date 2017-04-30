class JetSelection{

  int boxWidth = 190, boxHeight = 370;  
  float xFirst, yFirst, xSecond, ySecond;
  int selected = 0;
  PImage firstJet, secondJet;
  
  JetSelection(){
    xFirst = 250.0;
    yFirst = 200.0;
    xSecond = 600.0;
    ySecond = 200.0;
    
    firstJet = getImage("./images/sprites/jet.png", w(150), w(130));
    secondJet = getImage("./images/sprites/jet_2.png", w(150), w(130)); 
  }
  
  void draw(){
    image(startImg, x(0), y(0));
    fill(0, 220);
    rect(x(0), y(0), w(1000), h(1000));
    
    drawBoxes();
    
  }
  
  void mouseHandler(){
    if(mouseX > x(xFirst) && mouseX < x(xFirst) + w(boxWidth)
      && mouseY > y(yFirst) && mouseY < y(yFirst) + h(boxHeight)){
      this.selected = 0;
    }else if(mouseX > x(xSecond) && mouseX < x(xSecond) + h(boxWidth)
      && mouseY > y(ySecond) && mouseY < y(ySecond) + h(boxHeight)){
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
    
    rect(x(xPos), y(yFirst), w(boxWidth), h(boxHeight));

    drawJets();
  }
  
  void drawJets(){
    image(firstJet, x(xFirst), y(yFirst));
    fill(#ffffff);
    textFont(font, 24);
    text("CHOOSE YOUR JET", x(500), y(100));
    
    textFont(font, fontSize);
    textAlign(LEFT);
    text("SPEED: High", x(xFirst), y(yFirst + 250));
    text("SHOOTING RATE: High", x(xFirst), y(yFirst + 270));
    text("Speed.. Speed.. Are you ready to \nbe fast with this jet?", x(xFirst), y(yFirst + 300));
    
    
    image(secondJet, x(xSecond), y(ySecond));
    text("SPEED: Medium", x(xSecond), y(ySecond + 250));
    text("SHOOTING RATE: Medium", x(xSecond), y(ySecond + 270));
    text("You can fly with lower speed... \nbut what about shooting?", x(xSecond), y(ySecond + 300));
    
    fill(0);
    textAlign(CENTER);
  }
  
  void saveSelection(){
    if(selected == 0)
      jet = new Jet();
    else
      jet = new StealthJet();
  }
  
  void selectLeft(){
    selected--;
    if(selected < 0)
      selected = 1;
  }
  
  void selectRight(){
    selected++;
    if(selected > 1)
      selected = 0;
  }
}