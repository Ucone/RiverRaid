public class Map{

  Block [] blocksLeft; 
  Block [] blocksRight;
  int NUM_BLOCKS = 6;
  int nextPositionY;  
  int blockWidth, blockHeight;
  Bridge bridge;
  Block lastModified;
  int nextBridgePosition = 0;
  
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
      blocksLeft[i] = new Block((int) random(-200, 0), nextPositionY);
      blocksRight[i] = new Block(1000 - (int) random(100, 400), nextPositionY);
      
      nextPositionY -= blockHeight;
      lastModified = blocksLeft[i];
    }
    setNextBridgePosition();

}

  public void drawMap(){
      for (int i=0; i<NUM_BLOCKS; i++){
       blocksLeft[i].drawBlock();
       blocksRight[i].drawBlock();
       
       if(blocksLeft[i].overcome()){
         blocksLeft[i].yPos = lastModified.yPos - blockHeight;
         blocksRight[i].yPos = lastModified.yPos - blockHeight;
         lastModified = blocksLeft[i];
         
         if(i == NUM_BLOCKS - 1)
           setNextBridgePosition();
       }
      }
      
      bridge.drawBridge();
      
      if(bridge.yPos > 1000)
        bridge.yPos = nextBridgePosition;
  }
 
   private void setNextBridgePosition(){
     this.nextBridgePosition = lastModified.yPos;
   }
}