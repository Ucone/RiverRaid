class Animation {
  float time = 0.0;
  ArrayList<PImage> frames;
  public boolean finished;
  boolean oneshot;
  float tpf;
  
  Animation(String name, int w, int h, float tpf, boolean oneshot) {
    int frameId = 0;
    frames = new ArrayList<PImage>();
    
    String s;
    while(new File(s = sketchPath("./images/animations/" + name + "/" + frameId + ".png")).exists()) {
      frames.add(getImage(s, w, h));
      frameId++;
    }
    
    if(frameId == 0)
      print("loaded animation ",name," with no frames\n");
    this.oneshot = oneshot;
    this.finished = false;
    this.tpf = tpf;
  }
  
  public PImage image() {
    if(frames.size()-1 < (int)(time / tpf))
    {
      return getImage("./images/interface/error.png", w(50), w(50));
    }
    return frames.get((int)(time / tpf));
  }
  
  public void update(float nD) {
    if(finished)
      return;
    time += nD;
    if(time > frames.size() * tpf)
    {
      time %= frames.size() * tpf;
      if(oneshot) {
        finished = true;
        time = (frames.size() - 1) * tpf;
      }
    }
  }
}