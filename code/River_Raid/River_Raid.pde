import controlP5.*;
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

//Variables for positions
int x,y;
//Initial speed
int speed = 2;

void setup() {
  fullScreen();
  
  font = createFont("/fonts/Oceanside.ttf", 20);
  textFont(font, 20);
  fill(0);
  
  cp5 = new ControlP5(this);
  
  /* Input field */
  cp5.addTextfield("name_input")
      .setPosition(width / 2 - 100,  height - 130)
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
      .setPosition(width / 2 - 100, height - 70)
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
  map1.resize(width, height);

  //Elements images
  fuel_icon = loadImage("./images/sprites/fuel_icon.png");
  
  island = new Island();
}

void draw() {
  switch(gameState){
    case WELCOME:
      startImg=loadImage("./images/welcome.png");
      startImg.resize(width, height);
      image(startImg, 0, 0);
      break;
    
    case STORY_1:
      cp5.remove("Start");
      cp5.remove("name_input");
      fill(255, 0, 0);
      image(storyImg1, 0, 0);
      drawPressKey();
      break;
    
    case STORY_2:
      image(storyImg2, 0, 0);
      text("Local time: 00:32, border Air Force base", x(-500), y(-50));
      drawPressKey();
      break;
    case STORY_3:
      image(storyImg3, 0, 0);
      text("Pilot "+this.player.getName()+", to the general!", x(-200), y(-50));
      drawPressKey();
      break;
    case STORY_4:
      image(storyImg4, 0, 0);
      
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

      //Map movement
      imageMode(CORNER);
      image(map1,0, y);
      image(map1,0, y - map1.height);
      
      island.drawIsland();
      
     // speedset initial speed
      y+=speed;
       
      //To restart the map and make it ciclique
      if (y >= map1.height){
          y=0;
      }
      
      //fuel icon
      image(fuel_icon, width - 100, height - 200);
      break;
  }
}

/* Loads the image of the story defined by the GameState */
/* @return The image loaded*/
PImage loadStoryImage(GameState gameState)
{
  PImage img = loadImage("./images/story/"+gameState+".png");
  img.resize(width, height);
  return img;
}

// Helpers to use abstract -1000 -- 1000 X/Y instead of current values
int x(int fakex)
{
  if(fakex < 0)
    fakex += 1000;
  return (int)((float)fakex / 1000 * width);
}

int y(int fakey)
{
  if(fakey < 0)
    fakey += 1000;
  return (int)((float)fakey / 1000 * height);
}

/* Draws the text of "Press any key to continue" in the screen */
void drawPressKey()
{
   text("Press any key to continue...", width - 275, 30);
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