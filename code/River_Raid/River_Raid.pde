import controlP5.*;

boolean testing = true;

public enum GameState {
  WELCOME,
  STORY_1,
  STORY_2,
  STORY_3,
  STORY_4,
  GAME,
};  // Different states of the game
public enum ElementType {ISLAND, ENEMY, FUEL_DEPOT};

ControlP5 cp5;
PFont font;
PFont monoFont;
Player player;
GameState gameState = GameState.WELCOME;

PImage startImg, storyImg1, storyImg2, storyImg3, storyImg4;
PImage map1;
PImage fuel_icon, low_fuel;
PImage scoreboard, reserve;
PImage progressBackground, progressIndicator;
Island island;
FuelDepot fuelDepot;

// Aspect ratio variables
int viewportW, viewportH;
float offsetY, offsetX;

// Basic font size
int fontSize;

//Variables for positions
float x,y;

//Speed variables
float DEFAULT_SPEED = 3;
float speed = 3;
//Speed variables to change faster/slower
float restore_speed = speed;
boolean speed_changed = false;
float ACCELERATION = 4; //fast speed = speed + ACCELERATION
float DECELERATION = 2; //low speed = speed - DECELERATION

//fuel variables
int INITIAL_FUEL= 600;
float VELOCITY_CONSUMPTION = 0.01;
float distance = y;

// timekeeping
float TICK_MS = 20;
int lastmillis = -1;

//Score variables
int score = 0;

// SECTION
int section = 1;
int progressValue = (int)y;

// ENEMIES
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

boolean first_time = true; //not used for the moment

//for movement simultaneous
boolean keys [];

Jet jet;

void setup() {
  fullScreen();
  frameRate(60);
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
  startImg.resize(viewportW, viewportH);
  
  map1 = loadImage("./images/background.png");
  map1.resize(viewportW, viewportH);
  scoreboard = loadImage("./images/sprites/scoreboard.png");
  reserve = loadImage("./images/sprites/progress_cursor.png");

  //Elements images
  fuel_icon = loadImage("./images/sprites/fuelgauge.png");
  low_fuel = loadImage("./images/sprites/lowfuel.png");
  low_fuel.resize(viewportW/9, viewportH/5);
  fuel_icon.resize(viewportW/20, viewportH/3);

  progressBackground = loadImage("./images/sprites/progress_background.png");
  progressIndicator = loadImage("./images/sprites/progress_cursor.png");
  progressBackground.resize(w(190), h(50));
  progressIndicator.resize(w(50), h(50));
  
  scoreboard.resize(viewportW/7, viewportH/5);
  reserve.resize(w(40), h(40));
  
  // Defines the island object
  island = new Island();
  
  //Creates new fuel depot
  fuelDepot = new FuelDepot();
  
  //Check if we are on testing environment
  checkTesting();
  
  //Create the jet
  jet = new Jet();
  //for movement simultaneous.
    keys = new boolean[4];  // now is 4 because of: LEFT RIGTH UP DOWN.
    //if we include more (like spacebar for shoot), change the lentgh of the array/ or maybe not, check
    
  //Initialization to false
  for (int cont=0; cont< keys.length; cont++){
    keys[cont]= false;
  }
    
  //keys[0]= false;
  //keys[1]= false;
  //keys[2]= false;
  //keys[3]= false;

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
      image(map1, x(0), y(y));
      image(map1, x(0), y(y) - map1.height);
      
      //implement socerboard
      image(scoreboard, x(30), y(800));
      drawScore(); //Score method determines and paint the score
      

       //just to try, delete this when we can defeat enemies:
      if (y%238 == 0){
         score +=30; 
      }
      
      //Drawing Fuel depots and Islands
      island.update(nD);
      island.drawIsland();
      jet.checkCollision(island);
      fuelDepot.update(nD);
      fuelDepot.drawDepot();
      
     // speedset initial speed
      y+=speed*nD;
      distance +=speed*nD;
      progressValue += speed*nD;
      jet.speed = speed;
      
      if (speed_changed){
           speed= restore_speed;
           speed_changed = false;
      }
       
      //Sections
      image(progressBackground, x(10), y(600));
      int aux = (int)(200*progressValue)/5000;
      image(progressIndicator, x(aux), y(600));

      if(progressValue / 5000 >= section){
        section++;
        progressValue = 0;
        jet.addReserveJet();
      }
      
      //To restart the map and make it ciclique
      if (y >= 1000){
          y=0;
      }
      
      //fuel implementation
      fuel_implementation();
      
      jet.consume(nD);
      
      //fuel icon
      image(fuel_icon, x(875), y(400));

      //jet implementation
      jet.checkRefuel(fuelDepot, nD);
      
      jet.drawJet();
  
      /* Enemies implementation */
      //Create new enemy
      if(random(1) < 0.01 + (float)section / 100){
        float probability = random(1);
        if(probability < 0.3){
          enemies.add(new Tanker(section, speed));
        }else if(probability >= 0.3 && probability < 0.6){
          enemies.add(new Helicopter(section, speed));
        }else{
          enemies.add(new EnemyJet(section, speed));
        }
      }
      
      //Jet efficient movement
      if (keys[0]){  //LEFT
          jet.moveLeft();
      }
      if (keys[1]){  //RIGTH
          jet.moveRight();
      }
      if (keys[2]){  //UP
          speed = speed + ACCELERATION;
          speed_changed = true;
      }
      if (keys[3]){   //DOWN
          speed= speed - DECELERATION;
          speed_changed = true;      
      }
      
      //Draw new enemy
      for(int i=0; i<enemies.size(); i++){
        Enemy enemy = enemies.get(i);
        if(enemy.isVisible()){
          enemy.update(nD);
          enemy.drawEnemy();
          jet.checkCollision(enemy);
        }else{  //Remove invisible enemy
          enemies.remove(i);
          i--;
        }
      }
      


      break;
      
  }
  drawBorders();
}
  
  void drawBorders() {
    fill(0);
    // top
    rect(0, 0, width, offsetY);
    // bottom
    rect(0, height - offsetY, width, offsetY);
    // left
    rect(0, 0, offsetX, height);
    // right
    rect(0, height - offsetX, offsetX, height); 
  }
  
  //***** SCORE ****
  void drawScore (){
    fill(0);
    text(score, x(100), y(880));
    
    text("Level: " + section, x(70), y(920));
    
    image(reserve, x(100), y(890));
    text("x" + jet.getReserveJets(), x(140), y(920));
    
  }


  //***** FUEL IMPLEMENTATION *****
  void fuel_implementation(){
      //Fuel consumption
      fill(#00ff4e);
      
      if(jet.getFuel() > 0){
        rect( x(887), y(1000-283), w(23), h((int)-jet.getFuel()/2));
      }
      //Fuel actions
      if (jet.getFuel() < INITIAL_FUEL / 3){
            image(low_fuel, x(850), y(750));
        if (jet.getFuel() <=0)
            text("GAME OVER, LOSER!!", x(400), y(500));
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
  if (gameState == gameState.GAME){

    if (key == CODED){
      switch(keyCode){
       case LEFT:
          keys[0]= true;
          break;
       case RIGHT:
          keys[1]= true;
          break;
       case UP:
       //speed_changed = true;  
          keys[2]= true;
          break;
       case DOWN:
       //speed_changed = true;  
          keys[3]= true;
       break;    
      }  
    }
    
  }else
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

int w(int fakew)
{
  return (int)(fakew / 1000.0 * viewportW);
}

int h(int fakeh)
{
  return (int)(fakeh / 1000.0 * viewportH);
}