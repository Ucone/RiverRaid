class StealthJet extends Jet{
   StealthJet(){
     this.image = getImage("images/sprites/stealth_jet.png", w(80), w(80));
     this.width = 80;
     this.height = 80;
     jet_name = "stealth_jet";
     FIRE_DELAY = 80.0;
     DEFAULT_SPEED = 2.5;
     
     yPos = 600;
     xPos = 500;
     fuel = INITIAL_FUEL;
   }
}