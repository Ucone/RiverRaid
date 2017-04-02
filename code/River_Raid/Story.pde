public class Story {
  
  StoryStage storyStage; 
  
  Story() {
     storyStage = StoryStage.STORY_1; 
  }
  
  void draw() {
    switch(storyStage) {
    case STORY_1:
      image(getImage("./images/story/"+storyStage+".png", w(1000), h(1000)), x(0), y(0));
      break;
    case STORY_2:
      image(getImage("./images/story/"+storyStage+".png", w(1000), h(1000)), x(0), y(0));
      fill(0, 150, 0);
      text("Local time: 00:32, border Air Force base", x(-500), y(950));
      break;
    case STORY_3:
      image(getImage("./images/story/"+storyStage+".png", w(1000), h(1000)), x(0), y(0));
      textAlign(RIGHT);
      fill(0, 150, 0);
      text("Pilot "+player.getName()+", to the general!", x(950), y(950));
      textAlign(CENTER);
      break;
    case STORY_4:
      image(getImage("./images/story/"+storyStage+".png", w(1000), h(1000)), x(0), y(0));
      fill(100, 255, 100);
      text(player.getName().charAt(0) + ": Yes, general!", x(200), y(50));
      text(player.getName().charAt(0) + ": It's easy to shoot a bridge sir!\nIt doesn't move!\nIt also doesn't shoot back, sir!", x(200), y(370));
      text(player.getName().charAt(0) + ": Did anybody try this experimental jet yet?", x(200), y(620));
      text(player.getName().charAt(0) + ": Yes sir, ready to serve!", x(200), y(840));
      
      fill(255, 255, 255);
      text("G: " + player.getName() + ", you're our best pilot.\nOur neighbors, Planet Z, \nare amassing military forces\nacross the border canyon.\nOur only hope is preemptive strike against them.\nYou will pilot an experimental prototype jet,\ndestroying all bridges...", x(800), y(80));
      text("G: Not so fast, hotshot.\nEnemy will protect the assets\n with their local numerous forces,\nand also you'll need to fly low to avoid AAA.", x(800), y(390));
      text("G: No, we can't risk warning the enemy.\n\n You're our best hope", x(800), y(640));
    }
  }
  
  void advance() {
     switch(storyStage) {
     case STORY_1:
       storyStage = StoryStage.STORY_2;
       break;
     case STORY_2:
       storyStage = StoryStage.STORY_3;
       break;
     case STORY_3:
       storyStage = StoryStage.STORY_4;
       break;
     case STORY_4:
       storyStage = StoryStage.END;
       break;
     }
  }
  
  boolean over() {
     return (storyStage == StoryStage.END);
  }
}