public class World {
  
  int ENEMY_COUNT = 50;
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
    currentRandom = new Random(Random.long());
    generateSection();
  }
  
  public void generateSection() {
    previousRandom = currentRandom.clone();
    
    enemies.clear();
    fuelDepots.clear();
    blocks.clear();
    
    for(float i = 0; i < SECTION_SIZE; i+= Block.height)
    {
      Block block = new Block(-50 + currentRandom.nextFloat()*50, i);
      blocks.add(block);
      block = new Block(1050 - currentRandom.nextFloat()*50, i);
      blocks.add(block);
    }
    
    for(int i = 0; i < ENEMY_COUNT; i++)
    {
      
      enemy en;
      do {
        int enType = currentRandom.nextInt(3);
        switch(enType) {
        case 0:
          en = new Tanker(1); // TODO: section
        case 1:
          en = new Helicopter(1); // TODO: section
        case 2:
          en = new EnemyJet(1); // TODO: section
        }
        en.xPos = currentRandom.nextFloat()* 1000;
        en.yPos = 1000 + currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(en))
      enemies.add(en);
    }
    
    for(int i = 0; i < FUEL_DEPOT_COUNT; i++)
    {
      FuelDepot fd;
      do {
        fd = new FuelDepot();
        fd.xPos = currentRandom.nextFloat()* 1000;
        fd.yPos = 1000 + currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(fd))
      fuelDepots.add(fD);
    }
    
    for(int i = 0; i < ISLAND_COUNT; i++)
    {
      Island il;
      do {
        il = new Island();
        il.xPos = currentRandom.nextFloat()* 1000;
        il.yPos = 1000 + currentRandom.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(il))
      islands.add(il);
    }
  }
  
  void checkCollision(Element el) {
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
  
}