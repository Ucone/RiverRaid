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

PImage startImg;
PImage storyImg1;
PImage storyImg2;
PImage storyImg3;
PImage storyImg4;
PImage map1;

int x,y;
int speed;

void setup() {
  size(1024, 768);
  
  font = createFont("Arial", 20, true);
  textFont(font);
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
  map1 = loadStoryImage(GameState.GAME);
}

PImage loadStoryImage(GameState gameState)
{
  PImage img = loadImage("./images/story/"+gameState+".png");
  img.resize(width, height);
  return img;
}

void draw() {
  switch(gameState){
    case WELCOME:
      startImg=loadImage("./images/welcome.png");
      startImg.resize(1024, 768);
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
      
      text("Yes, general!", x(50), y(50));
      text(this.player.getName() + ", you're our best pilot.\nOur neighbors, <countryname>, \nare amassing military forces\nacross the border canyon.\nOur only hope is preemptive strike against them.\nYou will pilot an experimental prototype jet,\ndestroying all bridges...", x(600), y(80));
      
      text("It's easy to shoot a bridge sir!\nIt doesn't move!\nIt also doesn't shoot back, sir!", x(50), y(370));
      text("Not so fast, hotshot.\nEnemy will protect the assets\n with their local numerous forces,\nand also you'll need to fly low to avoid AAA.", x(600), y(390));
      
      text("Did anybody try this experimental jet yet?", x(50), y(620));
      text("No, we can't risk warning the enemy.\n\n You're our best hope", x(600), y(640));
      
      text("Yes sir, ready to serve!", x(50), y(840));
      fill(255);
      drawPressKey();
      break;
      
      case GAME:
      image(map1,x,y);
      speed=2; //set initial speed
      y+=speed;
      
      break;
  }
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