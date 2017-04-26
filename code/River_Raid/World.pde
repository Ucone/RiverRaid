public class World {
 
  static final int C_ENEMIES = 0b1;
  static final int C_FUEL_DEPOTS = 0b10;
  static final int C_BLOCKS = 0b100;
  static final int C_ISLANDS = 0b1000;
  static final int C_OBSTACLES = 0b1101;
  static final int C_EVERYTHING = 0b1111;

  public int ENEMY_COUNT = 30;
  public int DEPOT_SPACING = 1500;
  public int DEPOT_FUZZ = 300;
  public int ISLAND_COUNT = 10;
  public float SECTION_SIZE = 10000;
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
    
    for(float i = 0; i > -SECTION_SIZE; i-= new Block(true).height)
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
    
    int attempts = 0;
    for(int i = 0; i < ENEMY_COUNT; i++)
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
        en.yPos = -randomGen.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(en, World.C_EVERYTHING));
      enemies.add(en);
    }
    print("Generated enemies, "+ (attempts - 1) + " failed attempts\n");
    
    attempts = 0;
    for(int i = 0; i > -SECTION_SIZE; i -= DEPOT_SPACING)
    {
      FuelDepot fd;
      do {
        attempts++;
        fd = new FuelDepot();
        fd.xPos = 200 + randomGen.nextFloat() * 600;
        fd.yPos = (float)i + DEPOT_FUZZ - DEPOT_FUZZ * 2 * randomGen.nextFloat();
      } while(checkCollision(fd, World.C_EVERYTHING));
      fuelDepots.add(fd);
    }
    print("Generated fuel depots, "+ (attempts - 1) + " failed attempts\n");
    
    attempts = 0;
    for(int i = 0; i < ISLAND_COUNT; i++)
    {
      Island il;
      do {
        attempts++;
        il = new Island();
        il.xPos = randomGen.nextFloat()* 1000;
        il.yPos = -randomGen.nextFloat()*(SECTION_SIZE - 1000);
      } while(checkCollision(il, World.C_EVERYTHING));
      islands.add(il);
    }
    print("Generated islands, "+ (attempts - 1) + " failed attempts\n");
    
    Bridge bridge = new Bridge();
    bridge.xPos = 0;
    bridge.yPos = -SECTION_SIZE;
    enemies.add(bridge);
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
      for (Element th : enemies) {
        if(th == el) continue;
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