public class World {
  
  int ENEMY_COUNT = 20;
  int FUEL_DEPOT_COUNT = 10;
  int ISLAND_COUNT = 10;
  float SECTION_SIZE = 5000;
  
  ArrayList<Enemy> enemies;
  ArrayList<FuelDepot> fuelDepots;
  ArrayList<Island> islands;
  ArrayList<Block> blocks;
  
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
    
    for(float i = 0; i < SECTION_SIZE; i+= new Block().height)
    {
      Block block = new Block();
      block.xPos = -50 + currentRandom.nextFloat()*50;
      block.yPos = i;
      blocks.add(block);
      block.xPos = 1050 - currentRandom.nextFloat()*50;
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
        en.yPos = 1000 + currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(en));
      print("en");
      enemies.add(en);
    }
    
    for(int i = 0; i < FUEL_DEPOT_COUNT; i++)
    {
      FuelDepot fd;
      do {
        fd = new FuelDepot();
        fd.xPos = currentRandom.nextFloat()* 1000;
        fd.yPos = 1000 + currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(fd));
      fuelDepots.add(fd);
      print("fd");
    }
    
    for(int i = 0; i < ISLAND_COUNT; i++)
    {
      Island il;
      do {
        il = new Island();
        il.xPos = currentRandom.nextFloat()* 1000;
        il.yPos = 1000 + currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(il));
      islands.add(il);
      print("il");
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