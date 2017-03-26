public class Enemies{
  ArrayList<Enemy> list;
  
  Enemies(){
    list = new ArrayList<Enemy>();
  }
  
  public void addEnemy(Enemy enemy){
    if(list.isEmpty()){
      list.add(enemy);
    }else{
      Enemy last = list.get(list.size() - 1);
      int newY = (int) random(0, 200) + last.image.height;
      enemy.setY(last.getY() - newY);
      list.add(enemy);
    }
  }
}