public class Map{

  Block [] blocksLeft; 
  Block [] blocksRight;
  int NUM_BLOCKS = 12;
  int nextPositionY;  
  float blockWidth = 350, blockHeight = 300;
  Bridge bridge;
  Block lastModified;
  float nextBridgePosition = 0;
  
  Map(){
    blocksLeft = new Block[NUM_BLOCKS];
    blocksRight = new Block[NUM_BLOCKS];
    Block blockTest= new Block();
    lastModified = blockTest;
    blockWidth = blockTest.image.width;
    blockHeight = blockTest.image.height;
    nextPositionY = (int) (viewportH + offsetY - blockHeight);

    createMap();
    bridge = new Bridge(nextBridgePosition);
  }
  
  // This method just happen once at the beggining.
  public void createMap(){     
    for(int i=0; i<NUM_BLOCKS; i++){
      blocksLeft[i] = new Block((int) random(-200, -10), nextPositionY, blockWidth, blockHeight);
      blocksRight[i] = new Block(1000 - (int) random(50, 300), nextPositionY, blockWidth, blockHeight);
      
      nextPositionY -= blockHeight;
      lastModified = blocksLeft[i];
    }
    setNextBridgePosition();
}

  public void draw(){
      for (int i=0; i<NUM_BLOCKS; i++){
       blocksLeft[i].draw();
       blocksRight[i].draw();
       
       if(blocksLeft[i].overcome()){
         blocksLeft[i].yPos = lastModified.yPos - blockHeight;
         blocksLeft[i].xPos = random(-200, -10);
         blocksRight[i].yPos = lastModified.yPos - blockHeight;
         blocksRight[i].xPos = 1000 - random(50, 300);
         lastModified = blocksLeft[i];
         
         if(i == NUM_BLOCKS - 1)
           setNextBridgePosition();
       }
      }
      
      bridge.draw();
      
      if(bridge.yPos > 1000)
        bridge.yPos = nextBridgePosition;
  }
 
   private void setNextBridgePosition(){
     this.nextBridgePosition = lastModified.yPos;
   }
}