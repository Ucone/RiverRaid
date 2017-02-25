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

ControlP5 cp5;
PFont font;
Player player;
GameState gameState = GameState.WELCOME;

PImage startImg, storyImg1, storyImg2, storyImg3, storyImg4;
PImage map1;
PImage fuel_icon;
Island island;

// Aspect ratio variables
int viewportW, viewportH;
int offsetY;

//Variables for positions
int x,y;
//Initial speed
int speed = 3;

//fuel variables
int INITIAL_FUEL= 200;
float VELOCITY_CONSUMPTION = 0.1;
float fuel;
float distance = y;

boolean first_time = true;

Jet jet;

void setup() {
  fullScreen();
  
  viewportW = width;
  viewportH = width / 16 * 9;
  
  if(viewportH < height)
  {
    offsetY = (height - viewportH) / 2;
    print("Offset = "+offsetY+"\n");
  }
  
  font = createFont("./fonts/Oceanside.ttf", 20);
  textFont(font, 20);
  fill(0);
  
  cp5 = new ControlP5(this);
  
  /* Input field */
  cp5.addTextfield("name_input")
      .setPosition(x(500) - 100,  y(1000) - 130)
      .setSize(200, 40)
      .setFocus(true)
      .setFont(font)
      .setValue("Your name here...")
      .setColorBackground(0)
      .setColorForeground(0)
      .setLabelVisible(false);
  cp5.getController("name_input").getCaptionLabel().setVisible(false);
  
  /* Start button */
  cp5.addBang("Start")
      .setPosition(x(500) - 100, y(1000) - 70)
      .setSize(200, 40)
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      
  // Load images
  // TODO: dynamically resize these
  storyImg1 = loadStoryImage(GameState.STORY_1);
  storyImg2 = loadStoryImage(GameState.STORY_2);
  storyImg3 = loadStoryImage(GameState.STORY_3);
  storyImg4 = loadStoryImage(GameState.STORY_4);
  
  map1 = loadImage("./images/background.png");
  map1.resize(viewportW, viewportH);

  //Elements images
  fuel_icon = loadImage("./images/sprites/fuel_icon.png");
  
  // Defines the island object
  island = new Island();
  jet = new Jet(map1);

  
  //Check if we are on testing environment
  checkTesting();
  //Create the jet
  //!! warnign, if we divide the background on 3 images
  //we should pass to the constructor the addition of the width and heigth
  //And also change te constructor on the Jet class

}

void draw() {
  switch(gameState){
    case WELCOME:
      startImg=loadImage("./images/welcome.png");
      startImg.resize(viewportW, viewportH);
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
      text("Local time: 00:32, border Air Force base", x(-500), y(-50));
      drawPressKey();
      break;
    case STORY_3:
      image(storyImg3, x(0), y(0));
      text("Pilot "+this.player.getName()+", to the general!", x(-200), y(-50));
      drawPressKey();
      break;
    case STORY_4:
      image(storyImg4, x(0), y(0));
      
      fill(255, 0, 0);
      text(this.player.getName().charAt(0) + ": Yes, general!", x(50), y(50));
      text(this.player.getName().charAt(0) + ": It's easy to shoot a bridge sir!\nIt doesn't move!\nIt also doesn't shoot back, sir!", x(50), y(370));
      text(this.player.getName().charAt(0) + ": Did anybody try this experimental jet yet?", x(50), y(620));
      text(this.player.getName().charAt(0) + ": Yes sir, ready to serve!", x(50), y(840));
      
      fill(255, 255, 255);
      text("G: " + this.player.getName() + ", you're our best pilot.\nOur neighbors, Planet Z, \nare amassing military forces\nacross the border canyon.\nOur only hope is preemptive strike against them.\nYou will pilot an experimental prototype jet,\ndestroying all bridges...", x(600), y(80));
      text("G: Not so fast, hotshot.\nEnemy will protect the assets\n with their local numerous forces,\nand also you'll need to fly low to avoid AAA.", x(600), y(390));
      text("G: No, we can't risk warning the enemy.\n\n You're our best hope", x(600), y(640));

      drawPressKey();
      break;
      
      case GAME:
/*
      if (first_time){
         first_draw(); 
      }
*/
      //Map movement
      image(map1,0, y);
      image(map1,0, y - map1.height);
      
      island.drawIsland();
      
     // speedset initial speed
      y+=speed;
      distance +=speed;
      if (changed){
           speed= restore_speed;
           changed = false;
      }
       
      //To restart the map and make it ciclique
      if (y >= map1.height){
          y=0;
      }
      
      //fuel icon
      image(fuel_icon, width - 90, height - 180);

      //jet implementation
      jet.draw();      
      
      //fuel implementation
      fuel_implementation();
  
      break;
      
  }
}

  //***** FUEL IMPLEMENTATION *****
  void fuel_implementation(){
   
      //Fuel frame
      fill(255);
      rect( width - 70, height - 200, 30, -INITIAL_FUEL);
      
      //Fuel consumption
      fill(#FF0000);
      fuel = (INITIAL_FUEL - distance*VELOCITY_CONSUMPTION);
      rect( width - 70, height - 200, 30, -fuel);
      
      //Fuel actions
      if (fuel < 50){
            text("FUEL WARING!!", width-200, height-60);
        if (fuel <=0)
            text("GAME OVER, LOOSER!!", width/2-100, height/2);
      }
  }
  
//    WE SHOULD DRAW THE FIRST THINKS OUTSIDE, but don't know how yet
/*
  void first_draw(){
    fill(100);
    rect( width - 70, height - 200, 60, -INITIAL_FUEL);
    first_time=false;
  }
*/

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
   text("Press any key to continue...", viewportW - 275, 30);
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

    int restore_speed = speed;
    boolean changed = false;
/* Controller to switch between the different screens. It changes the GameState and draw() function is launched automatically */
void keyPressed(){
  // I put this here as is more efficient (mostly the state is GAME, so don't need to do the swich)
  if (gameState == gameState.GAME){

    if (key == CODED){
      switch(keyCode){
       case LEFT:
          jet.moveLeft();
          break;
       case RIGHT:
          jet.moveRight();
          break;
       case UP:
          speed= speed+4;
          changed = true;
          break;
       case DOWN:
          speed= speed-2;
          changed = true;
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

// Helpers to use abstract -1000 -- 1000 X/Y instead of current values
int x(int fakex)
{
  if(fakex < 0)
    fakex += 1000;
  return (int)((float)fakex / 1000 * viewportW);
}

int y(int fakey)
{
  if(fakey < 0)
    fakey += 1000;
  return (int)((float)fakey / 1000 * viewportH) + offsetY;
}