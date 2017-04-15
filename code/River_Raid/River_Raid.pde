import java.util.Iterator;
import java.util.Random;
import java.util.HashMap;
import ddf.minim.*;

boolean testing = false;

public enum GameState {WELCOME, STORY, GAME, END, CREDITS};  // Different states of the game
public enum StoryStage {STORY_1, STORY_2, STORY_3, STORY_4A, STORY_4B, STORY_4C, STORY_4D, STORY_4E, STORY_4F, STORY_4G, END}

// Input fields and text
ControlP5 cp5;
ControlP5 cpEnd;
PFont font;
PFont monoFont;
int fontSize;

GameState gameState = GameState.WELCOME;


//Images
PImage startImg;
PImage river;
PImage fuelGauge, lowFuelIcon;
PImage scoreboard, reserve;
PImage progressBackground, progressIndicator;
PImage musicOn, musicOff;

HashMap<String, PImage> imageMap = null;

// Objects
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

float nD;

// If testing mode is enabled (variable testing), the game skips the story and goes directly to the map 
void checkTesting(){
  if(this.testing){
    //cp5.remove("Start");
    cp5.setVisible(false);
    player = new Player("tester player");
    gameState = GameState.END;
  }
}



void setup() {
  //fullScreen(P2D);
  size(1200,600);
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
      
  cp5.addButton("Two_Players")
      .setPosition(x(300) - w(50), y(1000) - h(70))
      .setSize(w(100), h(40))
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
      
  // Load images
  startImg=loadImage("./images/welcome.png");
  
  scoreboard = loadImage("./images/sprites/scoreboard.png");
  reserve = loadImage("./images/sprites/progress_cursor.png");
  fuelGauge = loadImage("./images/sprites/fuelgauge.png");
  lowFuelIcon = loadImage("./images/sprites/lowfuel.png");
  progressBackground = loadImage("./images/sprites/progress_background.png");
  progressIndicator = loadImage("./images/sprites/progress_cursor.png");
  musicOn = loadImage("./images/sprites/musicon.png");
  musicOff = loadImage("./images/sprites/musicoff.png");
  
  //Resize images
  startImg.resize(viewportW, viewportH);
  scoreboard.resize(viewportW/7, viewportH/5);
  reserve.resize(w(40), h(40));
  lowFuelIcon.resize(w(60), h(100));
  fuelGauge.resize(w(50), viewportH/3 + 50);
  progressBackground.resize(w(190), h(50));
  progressIndicator.resize(w(50), h(50));
  musicOn.resize(viewportW / 20, viewportW / 20);
  musicOff.resize(viewportW / 20, viewportW / 20);

  //Check if we are on testing environment
  checkTesting();

  player = new Player("");

  // Instances of objects
  world = new World();
  world.resetSeed();
  world.generateSection(player.section);
  world.resetBackground();
  jet = new Jet();
  jet2 = new Jet(2);
  
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
  
  //credits
  finalCredits = new FinalCredits();

}
 //<>//
int getDelta() { //<>// //<>//
  if(lastmillis == -1) {
    lastmillis = millis();
    return 0;
  } //<>// //<>// //<>//
  int delta = millis() - lastmillis;
  lastmillis = millis();
  return delta;
}
 //<>//
void draw() { //<>// //<>// //<>//
  int delta = getDelta(); //<>// //<>//
  nD = delta / TICK_MS;
  switch(gameState){
    case WELCOME:
      image(startImg, x(0), y(0));
      cp5.setVisible(true);
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
        resetWorld(); //<>// //<>//
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
      
      //Draw some elements
      drawScore();
      drawMusicIcon();
       
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
        drawFuel();
        jet.consume(nD);
        jet.checkRefuel(nD);
        jet.checkCollision();
      }
      
      if(twoPlayers){
        if(jet2.crashed == false){
          //Jet two should consume also
            drawFuel();
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
        if (keys[5]){ //A
          jet2.moveLeft();
          
        }
        if (keys[6]){ //D
          jet2.moveRight();
          
        }
       if (keys[7]){    
          gameSpeed -= DECELERATION;
          speedChanged = true;      
        }
       if (keys[8]){       
                   gameSpeed += ACCELERATION;
          speedChanged = true;
        }
       if (keys[9]){        
            jet2.fire();
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
                     println("añado jet!");
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
                if (fd.collide(rocket)) {
                    fd.removeLive();
                    sound.playDefeatSound();
                    i.remove();
                    
                    if (fd.getLives() == 3){
                       fd.damaged(); 
                    }
                    
                    if (fd.getLives() == 0){
                       ifd.remove(); 
                    }
                }
          }
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

 //int rocketTime = 0; //<>//
 //float shootTime = 0.4;

//CREDITS METHOD //<>//
  public void credits(){
    
          jet.crashed = false; //<>//
         yMaster -= 2 * nD;
         
         background(0, 162, 232); //<>//
         fill(255);
         
         //Draw the jet and the credits map
         
         finalCredits.draw();
         
         jet.yPos = yMaster+800;
         jet.draw(yMaster);

         //Jet movement
         if (keys[0]){  //LEFT
            jet.moveLeft();
          }
          if (keys[1]){  //RIGTH
              jet.moveRight();
          }
          if (keys[4]){   //SPACE     
          
          jet.fire();
          
                //if (millis() - rocketTime > shootTime){ //<>//
                //  rocketTime=millis();                  
                //  Rocket rocket = new Rocket();
                //  rocket.xPos = jet.xPos;
                //  rocket.yPos = jet.yPos;
                //  rockets.add(rocket);    
                //  //sound effect //<>// //<>//
                //  sound.playShootSound();
            }
  //        }
        //<>// //<>//
       //Jet rockets interaction with credits
          Iterator<Rocket> finalRoquets = rockets.iterator(); //<>//
          while(finalRoquets.hasNext()) {
            Rocket rocket = finalRoquets.next();
            rocket.update(nD);
            if(!rocket.visible(yMaster)) { //<>// //<>//
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
                } //<>//
              }
              rocket.draw(yMaster);
            }
          }  
       
     //<>//
    
  }

  public void resetWorld(){ //<>//
    if(millis()- timeResetWorld >= 2000){
      
      world.generateSection(player.section);
      world.resetBackground();
      yMaster = 0;
      jet.crashed = false; //<>//
      jet.fuel = INITIAL_FUEL;
      timeResetWorld = millis();
    }
  }

  void drawScore (){
    image(scoreboard, x(30), y(800));
    fill(0);
    // Score value

    text(player.getScore(), x(100), y(880));

    // Level indicator
    text("Level: " + player.section, x(70), y(920));
    // Reserve jets indicator
    image(reserve, x(100), y(890));
    text("x" + jet.getReserveJets(), x(140), y(920));
  }

  void drawProgress(){
    image(progressBackground, x(10), y(600));
    float aux = (150*(-yMaster))/world.SECTION_SIZE;
    image(progressIndicator, x(aux), y(600));
  }

  void drawMusicIcon(){
    if(isMusicOn == true){
      image(musicOn, x(940), y(10));
    }
    else{
      image(musicOff, x(940), y(10));
    }
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
            image(lowFuelIcon, x(930), y(800) - fuelGauge.height);
        if (jet.getFuel() <= 0)
            text("GAME OVER, LOSER!!", x(400), y(500));
      }
      image(fuelGauge, x(930), y(900) - fuelGauge.height);
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
 //<>//
ControlEvent theEvent;
void controlEvent(ControlEvent theEvent) {
  if (gameState == gameState.WELCOME){ //<>//
    if(cp5.get(Textfield.class, "name_input").isFocus()){
      Start();
    }
  }
  this.theEvent=theEvent;
}

//PRESS START BUTTON ON THE WELCOME SCREEN
public void Start() {
  //String event_id = theEvent.getLabel(); //<>//
  String playerName = ""; //<>// //<>//
  
  playerName = cp5.get(Textfield.class, "name_input").getText();
    
  if(playerName.equals("")){ //<>//
      playerName = "Guest";
    }

  player = new Player(playerName);
  scoreScreen.addPlayer(player);
  cp5.setVisible(false); //remove("Start");
  //cp5.remove("name_input");
  gameState = GameState.STORY;
}

public void Two_Players(){
  twoPlayers = true;
  
}


//PRESS END BUTTON ON THE SCORE SCREEN
public void End() { //<>//
    gameState = GameState.CREDITS;
    yMaster = 0;  
    cpEnd.setVisible(false); //<>// //<>//
}

public void Replay() {

    yMaster = 0;   //<>// //<>//
    cpEnd.setVisible(false);
    gameState = GameState.WELCOME;
}


//void controlEvent(ControlEvent theEvent) {
//  String event_id = theEvent.getLabel();
//  String playerName = "";
//  if(event_id.equals("name_input") || event_id.equals("Start")){
//    playerName = cp5.get(Textfield.class, "name_input").getText();
    
//    if(playerName.equals("")){
//      playerName = "Guest";
//    }
//  }
    
//    if(event_id.equals("name_input") || event_id.equals("Two Players")){
//    playerName = cp5.get(Textfield.class, "name_input").getText();
    
//    if(playerName.equals("")){
//      playerName = "Guest";
//    }
//  }
  
//  player = new Player(playerName);
//  scoreScreen.addPlayer(player);
//  cp5.setVisible(false); //remove("Start");
//  //cp5.remove("name_input");
//  gameState = GameState.STORY;
//}

/* Controller to switch between the different screens. It changes the GameState and draw() function is launched automatically */
void keyPressed(){
  // I put this here as is more efficient (mostly the state is GAME, so don't need to do the swich)
  if (gameState == gameState.GAME || gameState == gameState.CREDITS ) {
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
  if(mouseX > x(940) && mouseX < x(940) + viewportW / 20 && mouseY > y(10) && mouseY < y(10) + viewportW / 20){
    music.toggleMusic();
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