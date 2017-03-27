public class Map{

  
  Block [] blocks; 
  int NUM_BLOCKS = 12;
  int nextPositionY;  
  int blockWidth, blockHeight;
  Bridge bridge;
  
  Map(){
    blocks = new Block[NUM_BLOCKS];
    Block blockTest= new Block();
    blockWidth = blockTest.image.width;
    blockHeight = blockTest.image.height;
    
    nextPositionY = (int) (viewportH + offsetY - blockHeight);

    createMap();
    //bridge = new Bridge(this.getCoordenateBridge());
  }
  
  // This method just happen once at the beggining.
  public void createMap(){
    
    blocks[0] = new Block(0, nextPositionY);
    blocks[1] = new Block(600, nextPositionY);
    nextPositionY -= blockHeight;
    
    for(int i=2; i<NUM_BLOCKS - 2; i+=2){
      blocks[i] = new Block((int) random(-200, 0), nextPositionY);
      blocks[i+1] = new Block(1000 - ((int) random(0, 400)), nextPositionY);
      nextPositionY -= blockHeight;
    }
    
    blocks[NUM_BLOCKS - 2] = new Block(0, nextPositionY);
    blocks[NUM_BLOCKS - 1] = new Block(600, nextPositionY);
    nextPositionY -= blockHeight;
    
    /*
    blocks[0]= new Block(-200 , nextPositionY);
    blocks[1]= new Block(800, nextPositionY);
    blocks[NUM_BLOCKS - 2]= new Block(-200 , nextPositionY);
    blocks[NUM_BLOCKS - 1]= new Block(800, nextPositionY);
    nextPositionY -= blocks[0].image.height;
    
    for (int i=2; i<NUM_BLOCKS - 2; i+=2){
      blocks[i]= new Block((int) random(-200, 0) , nextPositionY);
      blocks[i+1]= new Block(1000 - ((int) random(0, 200)), nextPositionY);
      nextPositionY -= blocks[i].image.height;
    }

    nextPositionY -= blocks[NUM_BLOCKS - 1].image.height;
    */
}

  //Draw each block;
  public void drawMap(){
      for (int i=0; i<NUM_BLOCKS; i++){
       blocks[i].drawBlock(); 
      }
      
      if(blocks[NUM_BLOCKS - 1].yPos > 1000)
        nextLevel();
      //bridge.drawBridge();
      /*
      if(blocks[NUM_BLOCKS-1].getY() >= 1000){
        nextPositionY = (int)(0 - blocks[0].image.height + offsetY);
        nextLevel();
      }
      */
  }
  
  public void repeatLevel(){
      text("REPEAT LEVEL", x(100), y(100));
      
     //masterY = masterY - levelDistance;
     //levelDistance-= levelDistance;
  }
  
  public void nextLevel(){
    nextPositionY = 0 - blockHeight;
    for (int i=0; i<NUM_BLOCKS; i+=2){
         blocks[i].xPos = x((int) random(-200, 0));
         blocks[i].yPos = nextPositionY ;//-= masterY;//initial_y + levelDistance; 
         blocks[i+1].xPos =1000 - ((int) random(0, 200));
         blocks[i+1].yPos = nextPositionY ;//// initial_y + levelDistance; 
         nextPositionY -= blockHeight;
    }
  }
 
  public int getCoordenateBridge(){
    return blocks[NUM_BLOCKS - 1].getY();
  }
}