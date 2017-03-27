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
   int initial_y= height ; // This variable allows to predefine all the map
  
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
      blocks[i]= new Block((int) random(-blockWidth + 50, -20) , initial_y);
      blocks[i+1]= new Block(1000 - ((int) random(50,blockWidth)), initial_y);
      initial_y -= 600;
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
    initial_y = -masterY + height;
    for (int i=0; i<numberBlocksDefined; i+=2){
         blocks[i].xPos = ((int) random(-blockWidth + 50, -20));
         blocks[i].yPos = initial_y ;//-= masterY;//initial_y + levelDistance; 
         blocks[i+1].xPos =width - (int) random(50,blockWidth);
         blocks[i+1].yPos = initial_y ;//// initial_y + levelDistance; 
         initial_y -= blocksHeight;
    }
  }
  
}