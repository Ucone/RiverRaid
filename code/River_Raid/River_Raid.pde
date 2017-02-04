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
  cp5.addTextfield("playerName")
     .setPosition(width / 2 - 100, height - 70)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(255)
     ;
}
void draw() {
   image(startImg, 0, 0);
   textFont(font, 50); 
   fill(0, 102, 153, 51);
   text("Input Your Name to Start...", width / 2 - 300, height / 2);
   
   //text(playerName, 0, 100);    // enter to test the player name

}