public class Player {
  private String name;

  private int score = 0;;
  public int section = 1;
  int tanksDestroyed = 0;
  int helicoptersDestroyed = 0;
  int enemyJetsDestroyed = 0;
  
  public Player(String name){
    this.name = name;
    this.score = 0;
  }
  
  public String getName(){
    return name;
  }
  
  public int getScore(){
    return score;
  }
  
  public void setScore(int score){
      this.score = score;
  }
  
    public Player(String name, int score){
    this.name = name;
    this.score = score;
  }
}