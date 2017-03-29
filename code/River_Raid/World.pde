public class World {
  
  int ENEMY_COUNT = 20;
  int FUEL_DEPOT_COUNT = 10;
  int ISLAND_COUNT = 10;
  float SECTION_SIZE = 100000;
  
  public ArrayList<Enemy> enemies;
  public ArrayList<FuelDepot> fuelDepots;
  public ArrayList<Island> islands;
  public ArrayList<Block> blocks;
  
  Random currentRandom;
  Random previousRandom;
  
  World() {
    currentRandom = new Random();
    generateSection();
  }
  
  public void generateSection() {
    previousRandom = currentRandom;
    
    enemies = new ArrayList<Enemy>();
    fuelDepots = new ArrayList<FuelDepot>();
    blocks = new ArrayList<Block>();
    islands = new ArrayList<Island>();
    
    for(float i = 0; i > -SECTION_SIZE; i-= new Block(true).height)
    {
      Block block = new Block(false);
      block.xPos = - 0.75*block.width + currentRandom.nextFloat()*block.width * 0.5;
      block.yPos = i;
      blocks.add(block);
      block = new Block(true);
      block.xPos = 1000 - 0.75* block.width + currentRandom.nextFloat()*block.width * 0.5;
      block.yPos = i;
      blocks.add(block);
    }
    
    for(int i = 0; i < ENEMY_COUNT; i++)
    {
      
      Enemy en;
      do {
        int enType = currentRandom.nextInt(3);
        switch(enType) {
        case 0:
          en = new Tanker(1); // TODO: section
          break;
        case 1:
          en = new Helicopter(1); // TODO: section
          break;
        default:
        case 2:
          en = new EnemyJet(1); // TODO: section
          
        }
        en.xPos = currentRandom.nextFloat()* 1000;
        en.yPos = -currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(en));
      enemies.add(en);
    }
    
    for(int i = 0; i < FUEL_DEPOT_COUNT; i++)
    {
      FuelDepot fd;
      do {
        fd = new FuelDepot();
        fd.xPos = currentRandom.nextFloat()* 1000;
        fd.yPos = -currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(fd));
      fuelDepots.add(fd);
    }
    
    for(int i = 0; i < ISLAND_COUNT; i++)
    {
      Island il;
      do {
        il = new Island();
        il.xPos = currentRandom.nextFloat()* 1000;
        il.yPos = -currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(il));
      islands.add(il);
    }
  }
  
  boolean checkCollision(Element el) {
    for (Block th : blocks) {
      if(el.collide(th)) return true;
    }
    for (FuelDepot th : fuelDepots) {
      if(el.collide(th)) return true;
    }
    for (Enemy th : enemies) {
      if(el.collide(th)) return true;
    }
    for (Island th : islands) {
      if(el.collide(th)) return true;
    }
    return false;
  }
  
   void update(float nD) {
     for (Block el : blocks) {
       el.update(nD);
     }
     for (FuelDepot el : fuelDepots) {
       el.update(nD);
     }
     for (Island el : islands) {
       el.update(nD);
     }
     for (Enemy el : enemies) {
       el.update(nD);
     }
   }
   
   void draw() {
     for (Block el : blocks) {
       el.drawIfVis(yMaster);
     }
     for (FuelDepot el : fuelDepots) {
       el.drawIfVis(yMaster);
     }
     for (Island el : islands) {
       el.drawIfVis(yMaster);
     }
     for (Enemy el : enemies) {
       el.drawIfVis(yMaster);
     }
   }
}