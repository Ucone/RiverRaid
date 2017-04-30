public class World {
 
  static final int C_ENEMIES = 0b1;
  static final int C_FUEL_DEPOTS = 0b10;
  static final int C_BLOCKS = 0b100;
  static final int C_ISLANDS = 0b1000;
  static final int C_OBSTACLES = 0b1101;
  static final int C_EVERYTHING = 0b1111;

  public int ENEMY_COUNT = 3;
  public int DEPOT_SPACING = 1000;
  public int DEPOT_FUZZ = 300;
  public int ISLAND_COUNT = 3;
  public float SECTION_SIZE = 1000;
  public float sectionSize;
  public float islandCount;
  public float enemyCount;
  public float riverPosition;
  
  public ArrayList<Enemy> enemies;
  public ArrayList<FuelDepot> fuelDepots;
  public ArrayList<Island> islands;
  public ArrayList<Block> blocks;
  public ArrayList<Decoration> decorations;
  
  PImage river;
  
  Random randomGen;
  long seed;
  
  World() {
    river = getImage("./images/sprites/river.png", w(1000), h(2000));
  }
  
  public void resetSeed() {
      seed = (long)random(90e9); 
  }
  
  public void resetBackground() {
     riverPosition = randomGen.nextFloat()*2000; 
  }
  
  public void generateSection(int section) {

    randomGen = new Random(seed);
    
    enemies = new ArrayList<Enemy>();
    fuelDepots = new ArrayList<FuelDepot>();
    blocks = new ArrayList<Block>();
    islands = new ArrayList<Island>();
    decorations = new ArrayList<Decoration>();
    
    sectionSize = 2000 + (section - 1) * SECTION_SIZE;
    islandCount = section * ISLAND_COUNT;
    enemyCount = section * ENEMY_COUNT;
    
    //Block creation
    for(float i = 0; i > -sectionSize; i-= new Block(true).height)
    {
      Block block = new Block(false);
      block.xPos = - 0.75*block.width + randomGen.nextFloat()*block.width * 0.5;
      block.yPos = i;
      blocks.add(block);
      block = new Block(true);
      block.xPos = 1000 - 0.75* block.width + randomGen.nextFloat()*block.width * 0.5;
      block.yPos = i;
      blocks.add(block);
    }
    
    //Enemy creation
    int attempts = 0;
    for(int i = 0; i < enemyCount; i++)
    {
      Enemy en;
      do {
        attempts++;
        int enType = randomGen.nextInt(3);
        switch(enType) {
        case 0:
          en = new Tanker(section); // TODO: section
          break;
        case 1:
          en = new Helicopter(section); // TODO: section
          break;
        default:
        case 2:
          en = new EnemyJet(section); // TODO: section
          
        }
        en.xPos = randomGen.nextFloat()* 1000;
        en.yPos = -randomGen.nextFloat()*(sectionSize - 1000);
      } while(checkCollision(en, World.C_EVERYTHING));
      enemies.add(en);
    }
    print("Generated enemies, "+ (attempts - 1) + " failed attempts\n");
    
    //Fuel depot creation
    attempts = 0;
    for(int i = 0; i > -sectionSize; i -= DEPOT_SPACING)
    {
      FuelDepot fd;
      do {
        attempts++;
        fd = new FuelDepot();
        fd.xPos = 200 + randomGen.nextFloat() * 600;
        fd.yPos = (float)i + DEPOT_FUZZ - DEPOT_FUZZ * 2 * randomGen.nextFloat();
      } while(checkCollision(fd, World.C_EVERYTHING) || fd.yPos > -100 || fd.yPos < - sectionSize);
      fuelDepots.add(fd);
    }
    print("Generated fuel depots, "+ (attempts - 1) + " failed attempts\n");
    
    //Island creation
    attempts = 0;
    for(int i = 0; i > -sectionSize; i -= sectionSize / islandCount)
    {
      Island il;
      do {
        attempts++;
        il = new Island();
        il.xPos = randomGen.nextFloat()* 1000;
        il.yPos = i + randomGen.nextFloat() * (sectionSize / islandCount) * 2 - sectionSize / islandCount;
      } while(checkCollision(il, World.C_EVERYTHING) || il.yPos > -100 || il.yPos < - sectionSize);
      if(il.yPos > blocks.get(blocks.size()-3).yPos)
        islands.add(il);
    }
    print("Generated islands, "+ (attempts - 1) + " failed attempts\n");
    
    //Bridge implementaion
    Bridge bridge = new Bridge();
    bridge.xPos = 0;
    bridge.yPos = -sectionSize;
    enemies.add(bridge);
    
    //To ensure fuel between sections
    FuelDepot lastFuelDepot = new FuelDepot();
    lastFuelDepot.xPos = 500;
    lastFuelDepot.yPos = bridge.yPos + 700;
    if (!checkCollision(lastFuelDepot, World.C_EVERYTHING))
      fuelDepots.add(lastFuelDepot);
    
    FuelDepot lastFuelDepot2 = new FuelDepot();
    lastFuelDepot2.xPos = 500;
    lastFuelDepot2.yPos = bridge.yPos - 100;
    fuelDepots.add(lastFuelDepot2);

  }
  
  
  boolean checkCollision(Element el, int cflag) {
    if((cflag & C_BLOCKS) != 0)
      for (Element th : blocks) {
        if(th == el) continue;
        if(el.collide(th)) return true;
      };
    if((cflag & C_FUEL_DEPOTS) != 0)
      for (Element th : fuelDepots) {
        if(th == el) continue;
        if(el.collide(th)) return true;
      };
    if((cflag & C_ISLANDS) != 0)
      for (Element th : islands) {
        if(th == el) continue;
        if(el.collide(th)) return true;
      };
    if((cflag & C_ENEMIES) != 0)
      for (Enemy th : enemies) {
        if((Element)th == el) continue;
        // Crashed enemies no longer collide
        if(th.state != EnemyState.ACTIVE) continue;
        if(el.collide(th)) return true;
      };
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
     riverPosition += gameSpeed * 0.2* nD;
     if(riverPosition > 2000.0)
       riverPosition -= 2000.0;
   }
   
   void draw() {
     image(river, x(0), y(riverPosition));
     image(river, x(0), y(2000+riverPosition));
     image(river, x(0), y(-2000+riverPosition));
     
     for (Block el : blocks) {
       el.drawIfVis(yMaster);
     }
     for (Decoration el : decorations) {
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