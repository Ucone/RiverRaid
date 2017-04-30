class Bridge extends Enemy{
 
  Bridge(){
    super("./images/sprites/bridge.png", 1000, 444);
    this.isBridge = true;
  }
  
  Decoration getDebris() {
    return new Decoration("./images/sprites/bridge_destroyed.png", 1000, 444);
  }
}