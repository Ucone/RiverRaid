import controlP5.*;
import java.util.Iterator;
import java.util.Random;
import java.util.HashMap;

boolean testing = true;

public enum GameState {WELCOME, STORY_1, STORY_2, STORY_3, STORY_4, GAME, END};  // Different states of the game
public enum ElementType {ISLAND, ENEMY, FUEL_DEPOT};

// Input fields and text
ControlP5 cp5;
PFont font;
PFont monoFont;
int fontSize;

GameState gameState = GameState.WELCOME;

//Images
PImage startImg, storyImg1, storyImg2, storyImg3, storyImg4;
PImage map1;
PImage fuelGauge, lowFuelIcon;
PImage scoreboard, reserve;
PImage progressBackground, progressIndicator;

HashMap<String, PImage> imageMap = null;

// Objects
Player player;
Jet jet;
World world;

// Aspect ratio variables
int viewportW, viewportH;
float offsetY, offsetX;

//Variables for positions
float x,y;

float yMaster = 1000;

//Speed variables
float DEFAULT_SPEED = 3;
float gameSpeed = DEFAULT_SPEED;

//Speed variables to change faster/slower
boolean speedChanged = false;
float ACCELERATION = 4; //fast speed = speed + ACCELERATION
float DECELERATION = 2; //low speed = speed - DECELERATION

//Fuel constants
int INITIAL_FUEL= 600; //normally at 600
float VELOCITY_CONSUMPTION = 0.01;
float distance = y;

// timekeeping
float TICK_MS = 20;
int lastmillis = -1;

//Score variables
int score = 0;

// Section
int section = 1;

// For movement simultaneous
ArrayList<Rocket> rockets = new ArrayList<Rocket>();

//for blinking function
int time=0;
boolean booleanDelay = false;
int timeDelay= 400;

//for time between roquets
int shootTime = 600;
int rocketTime;

boolean keys [];

//finalScreen
ScoreScreen finalScreen;

void setup() {
  fullScreen(P2D);
  
  setViewports();
  
  fontSize = (int)(20. / 1920. * (float)viewportW);
  monoFont = createFont("./fonts/DejaVuSansMono.ttf", fontSize);
  font = createFont("./fonts/DejaVuSansCondensed.ttf", fontSize);
  textFont(font, fontSize);
  textAlign(CENTER);
  fill(0);
  
  cp5 = new ControlP5(this);
  /* Input field */
  cp5.addTextfield("name_input")
      .setPosition(x(500) - w(50),  y(1000) - h(130))
      .setSize(w(100), h(40))
      .setFocus(true)
      .setFont(font)
      .setValue("Your name here...")
      .setColorBackground(0)
      .setColorForeground(0)
      .setLabelVisible(false);
  cp5.getController("name_input").getCaptionLabel().setVisible(false);
  
  /* Start button */
  cp5.addBang("Start")
      .setPosition(x(500) - w(50), y(1000) - h(70))
      .setSize(w(100), h(40))
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      
  // Load images
  // TODO: dynamically resize these
  storyImg1 = loadStoryImage(GameState.STORY_1);
  storyImg2 = loadStoryImage(GameState.STORY_2);
  storyImg3 = loadStoryImage(GameState.STORY_3);
  storyImg4 = loadStoryImage(GameState.STORY_4);
  startImg=loadImage("./images/welcome.png");
  map1 = loadImage("./images/background.png");
  scoreboard = loadImage("./images/sprites/scoreboard.png");
  reserve = loadImage("./images/sprites/progress_cursor.png");
  fuelGauge = loadImage("./images/sprites/fuelgauge.png");
  lowFuelIcon = loadImage("./images/sprites/lowfuel.png");
  progressBackground = loadImage("./images/sprites/progress_background.png");
  progressIndicator = loadImage("./images/sprites/progress_cursor.png");
  
  //Resize images
  startImg.resize(viewportW, viewportH);
  map1.resize(viewportW, viewportH);
  scoreboard.resize(viewportW/7, viewportH/5);
  reserve.resize(w(40), h(40));
  lowFuelIcon.resize(w(60), h(100));
  fuelGauge.resize(w(50), viewportH/3);
  progressBackground.resize(w(190), h(50));
  progressIndicator.resize(w(50), h(50));
  
  // Instances of objects
  world = new World();
  world.resetSeed();
  world.generateSection(section);
  jet = new Jet();
    keys = new boolean[5];  // LEFT RIGTH UP DOWN.SPACE
  //Initialization to false
  for (int cont=0; cont< keys.length; cont++){
    keys[cont]= false;
  }
  
  //Final ScoreBoard
  finalScreen = new ScoreScreen();
  
  //Check if we are on testing environment
  checkTesting();
}

int getDelta() {
  if(lastmillis == -1) {
    lastmillis = millis();
    return 0;
  }
  int delta = millis() - lastmillis;
  lastmillis = millis();
  return delta;
}

void draw() {
  int delta = getDelta();
  float nD = delta / TICK_MS;
  switch(gameState){
    case WELCOME:
      image(startImg, x(0), y(0));
      break;
    
    case STORY_1:
      cp5.remove("Start");
      cp5.remove("name_input");
      fill(255, 0, 0);
      image(storyImg1, x(0), y(0));
      drawPressKey();
      break;
    
    case STORY_2:
      image(storyImg2, x(0), y(0));
      fill(0, 150, 0);
      text("Local time: 00:32, border Air Force base", x(-500), y(950));
      drawPressKey();
      break;
    case STORY_3:
      image(storyImg3, x(0), y(0));
      textAlign(RIGHT);
      fill(0, 150, 0);
      text("Pilot "+this.player.getName()+", to the general!", x(950), y(950));
      textAlign(CENTER);
      drawPressKey();
      break;
    case STORY_4:
      image(storyImg4, x(0), y(0));
      
      fill(100, 255, 100);
      text(this.player.getName().charAt(0) + ": Yes, general!", x(200), y(50));
      text(this.player.getName().charAt(0) + ": It's easy to shoot a bridge sir!\nIt doesn't move!\nIt also doesn't shoot back, sir!", x(200), y(370));
      text(this.player.getName().charAt(0) + ": Did anybody try this experimental jet yet?", x(200), y(620));
      text(this.player.getName().charAt(0) + ": Yes sir, ready to serve!", x(200), y(840));
      
      fill(255, 255, 255);
      text("G: " + this.player.getName() + ", you're our best pilot.\nOur neighbors, Planet Z, \nare amassing military forces\nacross the border canyon.\nOur only hope is preemptive strike against them.\nYou will pilot an experimental prototype jet,\ndestroying all bridges...", x(800), y(80));
      text("G: Not so fast, hotshot.\nEnemy will protect the assets\n with their local numerous forces,\nand also you'll need to fly low to avoid AAA.", x(800), y(390));
      text("G: No, we can't risk warning the enemy.\n\n You're our best hope", x(800), y(640));

      drawPressKey();
      break;
      
    case GAME:
      //Map movement
      //image(map1, x(0), y(y));
      //image(map1, x(0), y(y) - map1.height);
      background(#eeeeee);
      world.update(nD);
      yMaster -= gameSpeed * nD;
      if(yMaster < -world.SECTION_SIZE-1000)
      {
        world.resetSeed();
        section++;
        jet.addReserveJet();
        world.generateSection(section);
        Iterator<Rocket> i = rockets.iterator();
        while(i.hasNext()) {
          Rocket rocket = i.next();
          rocket.yPos -= (yMaster - 1000);
        }
        yMaster = 1000;
      }
      world.draw();
      
      //Draw some elements
      drawScore();
         
      if (speedChanged){
           gameSpeed = DEFAULT_SPEED;
           speedChanged = false;
      }
       
      //Draw more elements
      drawProgress();
      drawFuel();
      jet.consume(nD);
      jet.checkRefuel(nD);
      jet.yPos = yMaster+800;
      jet.checkCollision();
      jet.draw(yMaster);
      //blinking function
      blinkFunction();
      
      //Jet efficient movement
      if (keys[0]){  //LEFT
          jet.moveLeft();
      }
      if (keys[1]){  //RIGTH
          jet.moveRight();
      }
      if (keys[2]){  //UP
          gameSpeed += ACCELERATION;
          speedChanged = true;
      }
      if (keys[3]){   //DOWN
          gameSpeed -= DECELERATION;
          speedChanged = true;      
      }
      if (keys[4]){   //SPACE      
            if (millis() - rocketTime > shootTime){
              rocketTime=millis();
              
              Rocket rocket = new Rocket();
              rocket.xPos = jet.xPos;
              rocket.yPos = jet.yPos;
              rockets.add(rocket);
        }
      }
   
      
      Iterator<Rocket> i = rockets.iterator();
      while(i.hasNext()) {
        Rocket rocket = i.next();
        rocket.update(nD);
        if(!rocket.visible(yMaster)) {
          i.remove();
        } else {
          Iterator<Enemy> ie = world.enemies.iterator();
          while(ie.hasNext()) {
            Enemy en = ie.next();
            if (en.collide(rocket)) {
              ie.remove();
              i.remove();
              score += en.score;
              break;
            }
          }
          rocket.draw(yMaster);
        }
      }  
     
      break;
      case END:
         finalScreen.drawScoreScreen();         
      break;
  }
}

  public void resetWorld(){
        world.generateSection(section);
        yMaster = 0;
        jet.crashed = false;
        //Iterator<Rocket> i = rockets.iterator();
        //while(i.hasNext()) {
        //  Rocket rocket = i.next();
        //  rocket.yPos -= (yMaster - 1000);
        //}   
        
  }

  void drawScore (){
    image(scoreboard, x(30), y(800));
    fill(0);
    // Score value
    text(score, x(100), y(880));
    // Level indicator
    text("Level: " + section, x(70), y(920));
    // Reserve jets indicator
    image(reserve, x(100), y(890));
    text("x" + jet.getReserveJets(), x(140), y(920));
  }

  void drawProgress(){
    image(progressBackground, x(10), y(600));
    float aux = (150*(-yMaster))/world.SECTION_SIZE;
    image(progressIndicator, x(aux), y(600));
  }
  //***** FUEL IMPLEMENTATION *****
  void drawFuel(){

      //Fuel consumption
      fill(#00ff4e);
      
      if(jet.getFuel() > 0){
        rect( x(940), y(850), w(25), h((int)-jet.getFuel()/2));
      }
      
      //Fuel actions
      if ((jet.getFuel() < INITIAL_FUEL / 3)&&(booleanDelay)){
            image(lowFuelIcon, x(930), y(800 - fuelGauge.height));
        if (jet.getFuel() <= 0)
            text("GAME OVER, LOSER!!", x(400), y(500));
      }
      
      image(fuelGauge, x(930), y(900 - fuelGauge.height));
      
      
  }


  
   public void blinkFunction(){
     if(millis()-time>=timeDelay){
        booleanDelay = !booleanDelay;
        time = millis(); 
   }

 }

/* Loads the image of the story defined by the GameState */
/* @return The image loaded*/
PImage loadStoryImage(GameState gameState)
{
  PImage img = loadImage("./images/story/"+gameState+".png");
  img.resize(viewportW, viewportH);
  return img;
}



/* Draws the text of "Press any key to continue" in the screen */
void drawPressKey()
{
   textAlign(RIGHT);
   fill(255,0,0);
   textFont(monoFont, fontSize);
   text("Press any key to continue...", viewportW - w(20), y(30));
   textFont(font, fontSize);
   textAlign(CENTER);
}


/* When the "enter key" or "Start" button is pressed, gets the name of the user.
*  If the name is empty, set "Guest" as default name.
*/
void controlEvent(ControlEvent theEvent) {
  String event_id = theEvent.getLabel();
  String playerName = "";
  if(event_id.equals("name_input") || event_id.equals("Start")){
    playerName = cp5.get(Textfield.class, "name_input").getText();
    
    if(playerName.equals("")){
      playerName = "Guest";
    }
  }
  
  player = new Player(playerName);
  gameState = GameState.STORY_1;
}

/* Controller to switch between the different screens. It changes the GameState and draw() function is launched automatically */
void keyPressed(){
  // I put this here as is more efficient (mostly the state is GAME, so don't need to do the swich)
  if (gameState == gameState.GAME) {
    if ( key == CODED){
      switch(keyCode){
       case LEFT:
          keys[0]= true;
          break;
       case RIGHT:
          keys[1]= true;
          break;
       case UP:
       //speedChanged = true;  
          keys[2]= true;
          break;
       case DOWN:
       //speedChanged = true;  
          keys[3]= true;
          break; 
      }
    } else {
      switch(key){
        case ' ':
        keys[4]=true;
        break;   
      }
    }
  } else {
    switch(gameState){
      case STORY_1:
        gameState = GameState.STORY_2;
        break;
      case STORY_2:
        gameState = GameState.STORY_3;
        break;
      case STORY_3:
        gameState = GameState.STORY_4;
        break;
        
      case STORY_4:
        gameState = GameState.GAME;
        break;
    }
  }
}  

// If testing mode is enabled (variable testing), the game skips the story and goes directly to the map 
void checkTesting(){
  if(this.testing){
    cp5.remove("Start");
    cp5.remove("name_input");
    gameState = GameState.GAME;
  }
}


//For jet movement, to know when the key is released and stop movement.
void keyReleased(){
     if (key == CODED){
        switch(keyCode){
         case LEFT:
            keys[0]= false;
            break;
         case RIGHT:
            keys[1]= false;
            break;
         case UP:
            keys[2]= false;
            break;
         case DOWN:
            keys[3]= false;
         break;
        }
     } else {
       switch(key){
         case ' ':
           keys[4] = false;
       }
     }
}


// Helpers to use abstract -1000 -- 1000 X/Y instead of current values
int x(float fakex)
{
  return (int)(fakex / 1000. * viewportW + offsetX);
}

int y(float fakey)
{
  return (int)(fakey / 1000. * viewportH + offsetY);
}

int w(float fakew)
{
  return (int)(fakew / 1000.0 * viewportW);
}

int h(float fakeh)
{
  return (int)(fakeh / 1000.0 * viewportH);
}

void setViewports(){
    viewportW = width;
  viewportH = (int)((float)width / 16. * 9.);
  
  if(viewportH > height)
  {
    viewportH = height;
    viewportW = (int)((float)height / 9. * 16.);
  }
  
  if(viewportH < height)
  {
    offsetY = (float)(height - viewportH) / 2.;
  }
  
  if(viewportW < width)
  {
    offsetX = (float)(width - viewportW) / 2.;
  }
}

PImage getImage(String imageName, int w, int h) {
     String imageId = imageName + "x"+ w + "x" + h;
     if(imageMap == null)
       imageMap = new HashMap<String, PImage>();
     if(imageMap.containsKey(imageId)) {
        return imageMap.get(imageId); 
     } else {
       PImage img = loadImage(imageName);
       img.resize(w, h);
       imageMap.put(imageId, img);
       return img;
     }
   }