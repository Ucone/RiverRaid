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
  
  cp5.addTextfield("name_input")
      .setPosition(width / 2 - 100,  height/2 + 40)
      .setSize(200, 40)
      .setFocus(true)
      .setFont(font)
      .setValue("Your name here...")
      .setColorBackground(0)
      .setColorForeground(0);
      
  cp5.addBang("Start")
      .setPosition(width / 2 - 100, height/2 + 100)
      .setSize(200, 40)
      .setFont(font)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  

}
void draw() {
   image(startImg, 0, 0);

}