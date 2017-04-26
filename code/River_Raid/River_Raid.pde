import java.util.Iterator;
import java.util.Random;
import java.util.HashMap;
import ddf.minim.*;
import controlP5.*;
import java.nio.file.Paths;

boolean testing = false;

public enum GameState {WELCOME, JET_SELECTION, STORY, GAME, END, CREDITS};  // Different states of the game
public enum StoryStage {STORY_1, STORY_2, STORY_3, STORY_4A, STORY_4B, STORY_4C, STORY_4D, STORY_4E, STORY_4F, STORY_4G, END}

// Input fields and text
ControlP5 cp5, cpSelection;
ControlP5 cpEnd;
PFont font;
PFont monoFont;
int fontSize;

GameState gameState = GameState.WELCOME;


//Images
PImage startImg;
PImage river;
PImage fuelGauge, lowFuelIcon;
PImage dashboard, underDashboard, reserve;
PImage progressBackground, progressCursor, progressBridge;
PImage musicOn, musicOff;
PImage play, pause;

HashMap<String, PImage> imageMap = null;

// Objects
JetSelection jetSelection;
Player player;
Jet jet;
Jet jet2;
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
float VELOCITY_CONSUMPTION = 0.005;
float distance = y;

// timekeeping
float TICK_MS = 20;
int lastmillis = -1;

// For movement simultaneous
ArrayList<Rocket> rockets = new ArrayList<Rocket>();
ArrayList<Rocket> enemyRockets = new ArrayList<Rocket>();

//for blinking function
int time=0;
boolean booleanDelay = false;
int timeDelay= 400;

//for delay when reset world
int timeResetWorld = 0;

boolean keys [];

//finalScreen
ScoreScreen scoreScreen;

Story story;

//sound player
Minim minim;
AudioPlayer soundPlayer, musicPlayer;
Sound sound, music;

//background music
boolean isMusicOn;

//Credits
FinalCredits finalCredits;
Enemy finalEnemy;

boolean twoPlayers = false;

boolean tutorial = true;

float nD;

boolean gamePaused = false;

// If testing mode is enabled (variable testing), the game skips the story and goes directly to the map 
void checkTesting(){
  if(this.testing){
    //cp5.remove("Start");
    cp5.setVisible(false);
    player = new Player("tester player");
    gameState = GameState.GAME;
  }
}



void setup() {
  fullScreen(P2D);
  //size(1200,600,P2D);
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
      .setPosition(x(435) - w(50),  y(1000) - h(220))
      .setSize(w(200), h(60))
      .setFocus(true)
      .setFont(font)
      .setValue("Your name here...")
      .setColorBackground(0)
      .setColorForeground(0)
      .setLabelVisible(false);
  cp5.getController("name_input").getCaptionLabel().setVisible(false);
  
  /* Start button */
  cp5.addButton("Start")
      .setPosition(x(435) - w(50), y(1000) - h(150))
      .setSize(w(200), h(60))
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      
  cp5.addButton("Two_Players")
      .setPosition(x(435) - w(50), y(1000) - h(70))
      .setSize(w(200), h(60))
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      
    //controler fro the SCOREBOARD screen
    cpEnd = new ControlP5(this);
    
    cpEnd.addButton("Replay")
      .setPosition(x(350) - w(50), y(1000) - h(100))
      .setSize(w(150), h(60))
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      
   cpEnd.addButton("End")
      .setPosition(x(600) - w(50), y(1000) - h(100))
      .setSize(w(150), h(60))
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      
      cpEnd.setVisible(false);
      
    cpSelection = new ControlP5(this);
    
    cpSelection.addButton("Continue")
      .setPosition(x(435) - w(50), y(1000) - h(100))
      .setSize(w(150), h(60))
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      
      cpSelection.setVisible(false);
  // Load images
  startImg=loadImage("./images/welcome.png");
  
  dashboard = loadImage("./images/interface/dashboard.png");
  underDashboard = loadImage("./images/interface/dashboard_under.png");
  reserve = loadImage("./images/sprites/progress_cursor.png");
  fuelGauge = loadImage("./images/sprites/fuelgauge.png");
  lowFuelIcon = loadImage("./images/sprites/lowfuel.png");
  progressBackground = loadImage("./images/sprites/progress_background.png");
  progressCursor = loadImage("./images/interface/progress_cursor.png");
  progressBridge = loadImage("./images/interface/progress_bridge.png");
  musicOn = loadImage("./images/interface/sound_on.png");
  musicOff = loadImage("./images/interface/sound_off.png");
  play = loadImage("./images/sprites/play.png");
  pause = loadImage("./images/sprites/pause.png");
  
  //Resize images
  startImg.resize(viewportW, viewportH);
  dashboard.resize(viewportW, viewportH);
  underDashboard.resize(viewportW, viewportH);
  reserve.resize(w(40), h(40));
  lowFuelIcon.resize(w(60), h(100));
  fuelGauge.resize(w(50), viewportH/3 + h(50));
  progressCursor.resize(w(30), w(30));
  progressBridge.resize(w(30), w(30));
  musicOn.resize(w(50), h(50));
  musicOff.resize(w(50), h(50));
  play.resize(viewportW / 20, viewportW / 20);
  pause.resize(viewportW / 20, viewportW / 20);

  //Check if we are on testing environment
  checkTesting();

  player = new Player("");

  // Instances of objects
  world = new World();
  world.resetSeed();
  world.generateSection(player.section);
  world.resetBackground();

  
    keys = new boolean[10];  // LEFT RIGTH UP DOWN.SPACE + A S D W Q (2CND PLAYER)
  //Initialization to false
  for (int cont=0; cont< keys.length; cont++){
    keys[cont]= false;
  }
  
  //Final ScoreBoard
  scoreScreen = new ScoreScreen();
  
  // Story
  story = new Story();
  
  //sound player
  minim = new Minim(this);
  sound = new Sound();

  //background music
  music = new Sound();
  isMusicOn = false;
  music.toggleMusic();
  
  if(!testing)
     music.toggleMusic();
  
  depotTutorial = new FuelDepot();  
  depotTutorial.yPos = 400;  
  depotTutorial.xPos = 400; 
  world.fuelDepots.add(depotTutorial); 
  //ifd.add(depotTutorial);     
       
  //credits  
  finalCredits = new FinalCredits();  
   
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
  background(0);       
      
  int delta = getDelta();        
  nD = delta / TICK_MS;
  //Pause game
  if(gamePaused) {  
    nD = 0.0;  
  }
  switch(gameState){ 
    case WELCOME:      
      image(startImg, x(0), y(0));      
      cp5.setVisible(true); 
      break; 
     
    case JET_SELECTION:
      jetSelection.draw();
      cpSelection.setVisible(true);
      jetSelection.saveSelection();
      break;
    case STORY:
      story.draw();   
      drawPressKey();   
      break;
    case GAME:
      //Map movement
      background(#eeeeee);
      world.update(nD);
      
      yMaster -= gameSpeed * nD;
        
      if(((jet.crashed == true) && !twoPlayers) || (jet.crashed == true && jet2.crashed == true)){  
        resetWorld();  
      }else  
        if(yMaster < -world.SECTION_SIZE-1000)     
        {     
          world.resetSeed();
          player.section++;

          //sound effect
          sound.playCrossSound();

          jet.addReserveJet();
          world.generateSection(player.section);
          Iterator<Rocket> i = rockets.iterator();
          while(i.hasNext()) {   
            Rocket rocket = i.next();   
            rocket.yPos -= (yMaster - 1000);
          }
          yMaster = 1000;
        }
      

      world.draw();
      
     if(tutorial){
          tutorial();
     }
      
      //Draw some elements
      drawScore();
      drawMusicIcon();
      drawPlayPauseIcon();
      
      jet.update(nD);
      jet.draw(yMaster);
      
      if(twoPlayers){
         jet2.yPos = yMaster + 800;
         jet2.update(nD);
         jet2.draw(yMaster);
      }
       
      //Draw more elements
      if(jet.crashed == false){
        drawProgress();

        //if(!tutorial)
          jet.consume(nD);
        jet.checkRefuel(nD);
        jet.checkCollision();
      }
      
      if(twoPlayers){
        if(jet2.crashed == false){
          //Jet two should consume also
          drawFuel(jet2, 2);
          //if(!tutorial)
            jet2.consume(nD);
          jet2.checkRefuel(nD);
          jet2.checkCollision();
        }
      }
      //blinking function
      blinkFunction();
      
     if (speedChanged){
         gameSpeed = DEFAULT_SPEED;
         speedChanged = false;
      }
      
      //Jet only response when is not crashed
      if(!jet.crashed){
        
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
           jet.fire();
        }
      }
      if(!jet2.crashed){
        if (keys[5]){ //A
          jet2.moveLeft();          
        }
        if (keys[6]){ //D
          jet2.moveRight();          
        }
       if (keys[7]){
           if(!speedChanged)
              gameSpeed -= DECELERATION;
          speedChanged = true;      
        }
       if (keys[8]){   
         if(!speedChanged)
            gameSpeed += ACCELERATION;
          speedChanged = true;
        }
       if (keys[9]){        
            jet2.fire();
        }
      }
      
      // Enemy rockets collision
      Iterator<Rocket> iter = enemyRockets.iterator();
      while(iter.hasNext()){
        Rocket rocket = iter.next();
        rocket.update(nD);
        if(!rocket.visible(yMaster)){
          iter.remove();
        }else{
          if(jet.collide(rocket)){
            jet.removeLive();
            iter.remove();
            if(jet.getLives() == 0){
              jet.crash();
            }
          } 
        }
        rocket.draw(yMaster);
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

              //sound effect
              sound.playDefeatSound();
              if(en.kind == "Tank"){
                 player.tanksDestroyed ++;
              }
              if(en.kind == "Helicopter"){
                 player.helicoptersDestroyed ++;
              }
              if(en.kind == "EnemyJet"){
                 player.enemyJetsDestroyed ++;
              }
              
              ie.remove();
              i.remove();
              Decoration dec = en.getDebris();
              if(dec != null) {
                dec.xPos = en.xPos;
                dec.yPos = en.yPos;
                world.decorations.add(dec);
              }

              player.setScore(player.getScore() + en.score);
              if (player.getScore() % 3000 == 0){
                 jet.addReserveJet(); 
              }

              break;
            }
          }
              
          rocket.draw(yMaster);
        }
        
        //Fuel rocket collision implementation
          Iterator<FuelDepot> ifd = world.fuelDepots.iterator();
          while(ifd.hasNext()) {
                FuelDepot fd =ifd.next();
                if (fd.collide(rocket) && !jet.refueling) {
                    fd.removeLive();
                    sound.playDefeatSound();
                    i.remove();
                    
                    if (fd.getLives() == 4){
                       fd.damaged(1); 
                    }
                    if (fd.getLives() == 2){  
                       fd.damaged(2);   
                    }
                    if (fd.getLives() == 0){
                       ifd.remove();  
                    } 
                }  
          }   
      }         
            
     if(gamePaused){ 
       fill(255, 0, 0); 
       text("Paused!", x(500), y(400)); 
     } 
            
      break;      
      case END:    
        twoPlayers = false;     
         scoreScreen.drawScoreScreen();    
         //cpEND has the buttons and controllers for restart/end    
         cpEnd.setVisible(true); 
       break;
            
       case CREDITS:            
         //Credits game   
         credits();    
         //rocketTime = millis();     
       break;    
  }
} 
    
   
   
  //Tutorial, just appear the first time   
  public void tutorial(){
    
    gameSpeed = 1;
    fill(0);
       
    int xText = 500;   
    if(yMaster >= 500){      
      if(twoPlayers){
        xText = 300;   
        fill(237,28,36);    
        text("D: move to right", x(xText + 150), y(790));
        text("A: move to left", x(xText - 60), y(790));
        text("Q: shoot", x(xText + 40), y(490));
        text("W: speed up", x(xText + 40), y(690));
        text("S: slow down", x(xText + 40), y(960));
        xText = 650;
      }
      
      textSize(h(25));
      fill(0);
      text("→: move to right", x(xText + 150), y(790));
      text("←: move to left", x(xText - 80), y(790));
      text("SPACE BAR: shoot", x(xText + 30), y(790));
      text("↑: speed up", x(xText + 30), y(690));
      text("↓: slow down", x(xText + 40), y(840));
      
    }
    depotTutorial.draw(yMaster);
    
    if(yMaster <= 500 && yMaster > 150){ 
        //depotTutorial.yPos = 700;
        //depotTutorial.draw(y(200));
        text("This is a fuel depot", x(500), y(600));
        text("BE CAREFUL, you can damage it with your rockets", x(500), y(700));
        text("Check here the\nfuel level ↓", x(70), y(750));
    }
            
    if(yMaster<=150){
      gameSpeed = DEFAULT_SPEED;
      text("Go slowly through it to charge more fuel", x(500),  y(600));
      textAlign(LEFT);
      text("Check here the\nfuel level ↓", x(10), y(750));
      textAlign(CENTER);
      
    }  
      
      
    if(yMaster <= -400){
      tutorial= false;
      println("fin tutorial"); 
       
    }   
  }  
      
  FuelDepot depotTutorial;      
      
//CREDITS METHOD  
  public void credits(){   
     
         tint(255, 80);  
         image(startImg, x(0), y(0));     
             
         tint(255);
         jet.crashed = false;     
         yMaster -= 2 * nD;     
         
         //background(0, 162, 232); 
         fill(255); 
         
         //Draw the jet and the credits map   
            
         finalCredits.draw();   
         
         jet.update(nD);
         jet.yPos = yMaster+800;
         jet.draw(yMaster);
   
         //Jet movement   
         if (keys[0]){  //LEFT
            jet.moveLeft();   
          }   
          if (keys[1]){  //RIGTH  
              jet.moveRight();  
          }
          //if (keys[2]){  //UP
          //    yMaster -= ACCELERATION;  
          //    speedChanged = true;   
          //} 
          if (keys[4]){   //SPACE     
              jet.fire();
          }     
     
       //Jet rockets interaction with credits
          Iterator<Rocket> finalRoquets = rockets.iterator(); 
          while(finalRoquets.hasNext()) {     
            Rocket rocket = finalRoquets.next();    
            rocket.update(nD);
            if(!rocket.visible(yMaster)) {  
              finalRoquets.remove();   
            } else {  
              //see iterator content in finalWorld Class
              Iterator<Enemy> finalEnemiIterator = finalCredits.finalEnemies.iterator();
              while(finalEnemiIterator.hasNext()) {
                Enemy en = finalEnemiIterator.next(); 
                if (en.collide(rocket)) { 
                  //sound effect  
                  sound.playDefeatSound();         
                  finalEnemiIterator.remove();       
                  finalRoquets.remove();     
                  break;
                }     
              }       
              rocket.draw(yMaster);  
            }
          }      
  }    
 
  public void resetWorld(){  
    if(millis()- timeResetWorld >= 3000){ 
      
      world.generateSection(player.section);    
      world.resetBackground();    
      yMaster = 0;
      jet.resurrect(); 
      jet.fuel = INITIAL_FUEL;   
      jet2.resurrect();
      jet2.fuel = INITIAL_FUEL; 
      timeResetWorld = millis();
    }
  }
   
  void drawScore (){
    image(underDashboard, x(0), y(0));
      
    fill(0, 255, 0);  
    //Score value
    text(player.getScore(), x(250), y(970));
    
    // Reserve jets indicator
    text(jet.getReserveJets(), x(380), y(975));
    
    drawFuel(jet, 1);
    
    image(dashboard, x(0), y(0));

  }

  void drawProgress(){
    float aux = 450 + (150*(-yMaster))/world.SECTION_SIZE; 
    image(progressCursor, x(aux), y(920));
    image(progressBridge, x(600), y(920));
  }

  void drawMusicIcon(){
    if(isMusicOn == true){
      image(musicOn, x(885), y(910));
    }
    else{
      image(musicOff, x(885), y(910));
    }
  } 
  
  void drawPlayPauseIcon(){
    if(gamePaused == true){
      image(play, x(850), y(10));
    }
    else{
      image(pause, x(850), y(10));
    }  
  }  

  //***** FUEL IMPLEMENTATION *****
  void drawFuel(Jet jet, int player){

      //Fuel consumption
      fill(#00ff4e);
      stroke(#00ff4e);
      int xDepot = 5; 
      int yDepot = 900; 
      
      if (player == 2){        
         xDepot = 60;    
      }    
      if(jet.getFuel() > 0){
        rect( x(xDepot), y(yDepot), w((jet.getFuel() * 180)/INITIAL_FUEL), h(60));
      }
      
      //Fuel actions
      if ((jet.getFuel() < INITIAL_FUEL / 3)&&(booleanDelay)){
            fill(255, 0, 0, 80);
            rect(x(0), y(0), w(1000), h(1000));
      }
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
      
ControlEvent theEvent;      
void controlEvent(ControlEvent theEvent) {     
  if (gameState == gameState.WELCOME){ 
    if(cp5.get(Textfield.class, "name_input").isFocus()){ 
      println("Start....");    
      Start();    
    }
  }
  this.theEvent=theEvent;
}

//PRESS START BUTTON ON THE WELCOME SCREEN   
public void Start() {     
  //String event_id = theEvent.getLabel();   
  story = new Story();   
       
  jet = new Jet();   
  jet2 = new StealthJet(); 

      
  if (twoPlayers){ 
    jet.xPos = 650;  
  } 
  
  String playerName = "";    
     

  playerName = cp5.get(Textfield.class, "name_input").getText();   
      
  if(playerName.equals("") || playerName.equals("Your name here...")){  
      playerName = "Player";         
    }       

   
  player = new Player(playerName);   
  scoreScreen.addPlayer(player);   
  cp5.setVisible(false); //remove("Start");    
  //cp5.remove("name_input");  
  if(!twoPlayers){
    gameState = GameState.JET_SELECTION;
    jetSelection = new JetSelection(); 
  }else 
    gameState = GameState.STORY;
}

public void Two_Players(){
  twoPlayers = true; 
  Start();  
}


//PRESS END BUTTON ON THE SCORE SCREEN
public void End() { 
    gameState = GameState.CREDITS; 
    yMaster = 0;  
    cpEnd.setVisible(false);  
} 
   
public void Replay() {   

    yMaster = 0;       
    cpEnd.setVisible(false);    
    gameState = GameState.WELCOME;
}

public void Continue(){
    cpSelection.setVisible(false);
    gameState = GameState.STORY;
}

/* Controller to switch between the different screens. It changes the GameState and draw() function is launched automatically */   
void keyPressed(){   
  
  if (gameState == gameState.WELCOME){
       //Retrocess (delete)
         if (key == 8){
            cp5.get(Textfield.class, "name_input").setText("");
     } 
  }
  
  if (gameState == gameState.JET_SELECTION){
    if(key == CODED){
      switch(keyCode){
        case LEFT:
          jetSelection.selectLeft();
          break;
        case RIGHT:
          jetSelection.selectRight();
          break;
      }
    }
    if(key == ENTER){
      jetSelection.saveSelection();
      Continue();
    }
  }
  
  // I put this here as is more efficient (mostly the state is GAME, so don't need to do the swich)
  if (gameState == gameState.GAME && !gamePaused || gameState == gameState.CREDITS) {
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
        case 'm':
        case 'M':
          music.toggleMusic();
          break;
        //Second player keys
      }if(twoPlayers){
       switch(key){
        case 'a':
        case 'A':
          keys[5] = true;
        break;
        case 'd':
        case 'D':
          keys[6] = true;
        break;
         case 's':
         case 'S':
          keys[7] = true;
        break;
        case 'w':
        case 'W':
          keys[8] = true;
        break;
        case 'q':
        case 'Q':
          keys[9] = true;
        break;
      }
     }
    }
  } else {
    switch(gameState){
      case STORY:
        story.advance();
        if(story.over()) {
          gameState = GameState.GAME; 
        }
        break;
    }
  }
}  

void mousePressed(){
  if (gameState == gameState.GAME){
    //x(885), y(920)
    if(mouseX > x(885) && mouseX < x(885) + w(50) && mouseY > y(920) && mouseY < y(920) + h(50)){
      music.toggleMusic();
    }
    if(mouseX > x(850) && mouseX < x(850) + viewportW / 20 && mouseY > y(10) && mouseY < y(10) + viewportW / 20){
      toggleGame();
    }
  }
  
  if(gameState == GameState.JET_SELECTION){
      jetSelection.mouseHandler();
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
         break;
       } if (twoPlayers){
        switch(key){
        case 'a':
        case 'A':
          keys[5] = false;
          break;
        case 'd':
        case 'D':
          keys[6] = false;
          break;
        case 's':
        case 'S':
          keys[7] = false;
          break;
        case 'w':
        case 'W':
          keys[8] = false;
          break;
        case 'q':
        case 'Q':
          keys[9] = false;
          break;
        }
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
   
void toggleGame(){
    if(gamePaused){
       gamePaused = false;
       noTint();
    }
    else{
       gamePaused = true;
       tint(255, 126);
    }
}