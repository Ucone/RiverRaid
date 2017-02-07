import controlP5.*;

int gameState = 1;
ControlP5 cp5;
PFont font;
String playerName = "";

PImage startImg;
void setup() {
  size(1024, 768);
  startImg=loadImage("http://i.imgur.com/27yNw28.png");
  startImg.resize(1024, 768);
  font = createFont("Arial", 20, true);
  
  cp5 = new ControlP5(this);
  
  /* Input field */
  cp5.addTextfield("name_input")
      .setPosition(width / 2 - 100,  height/2 + 40)
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
      .setPosition(width / 2 - 100, height/2 + 100)
      .setSize(200, 40)
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
}

void draw() {
   image(startImg, 0, 0);
}

/* When the "enter key" or "Start" button is pressed, gets the name of the user.
*  If the name is empty, set "Guest" as default name.
*/
void controlEvent(ControlEvent theEvent) {
  String event_id = theEvent.getLabel();
  if(event_id.equals("name_input") || event_id.equals("Start")){
    playerName = cp5.get(Textfield.class, "name_input").getText();
  }
  
  if(playerName.equals("")){
    playerName = "Guest";
  }
  
  println("User: " + playerName);
}