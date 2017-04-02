public class Player {
  private String name;

  private int score = 0;;
  public int section = 1;
  
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