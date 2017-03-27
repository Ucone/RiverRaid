public class Map{
  
  //int levelSpeed;
  //int numberOfTanks;
  //int numberOfHelicopter;
  //int numberOfEnemyJets;
  int blocksHeight = 690; //460; //new Block().image.h; // 460;  // WARNING CHANGE WITH THE REAL BLOCK WIDTH
  int blockWidth = 450;   // WARNING CHANGE WITH THE REAL BLOCK WIDTH
  int reaparitionY = 0;
  
  Block [] blocks; 
  int numberBlocksDefined = 32;
  
  //int initial_x=0;
   int yBlockPosition = (int) (viewportH + offsetY);
  
  Map(){
    Block blockTest= new Block();
    blocksHeight = blockTest.image.height;
    blockWidth = blockTest.image.width;
    
    blocks = new Block [numberBlocksDefined];
    createMap();    
  }
  
  // This method just happen once at the beggining.
  public void createMap(){
    for (int i=0; i<numberBlocksDefined; i+=2){
      blocks[i]= new Block((int) random(-blockWidth + 50, -20) , yBlockPosition);
      blocks[i+1]= new Block(1000 - ((int) random(50,blockWidth)), yBlockPosition);
      yBlockPosition -= blocks[i].image.height;
    }

}

  //Draw each block;
  public void drawMap(){
      for (int i=0; i<numberBlocksDefined; i++){
       blocks[i].drawBlock(); 
      }
  }
  
  public void repeatLevel(){
     //masterY = masterY - levelDistance;
     //levelDistance-= levelDistance;
  }
  
  public void nextLevel(){
    yBlockPosition = -masterY + height;
    for (int i=0; i<numberBlocksDefined; i+=2){
         blocks[i].xPos = ((int) random(-blockWidth + 50, -20));
         blocks[i].yPos = yBlockPosition ;//-= masterY;//initial_y + levelDistance; 
         blocks[i+1].xPos =width - (int) random(50,blockWidth);
         blocks[i+1].yPos = yBlockPosition ;//// initial_y + levelDistance; 
         yBlockPosition -= blocksHeight;
    }
  }
  
}