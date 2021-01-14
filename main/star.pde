class Star{
  private PVector pos;
  private float size;
  private float alpha_fac = 1;
  
  final static float DEFAULT_SIZE = 5;
  
  Star(float x, float y){
    this(x, y, DEFAULT_SIZE);
  }
  Star(float x, float y, float size){
    pos = new PVector(x, y);
    this.size = size;
  }
  
  void render(){
    float r1 = random(0,1);
    float r2 = random(0,1);
    float r3 = random(0,1);
    r3 = 1f/2*(float)(Math.tanh(3*r3)+1);
    noStroke();
    fill(255*r1,255*r2,255*r3, 255*alpha_fac);
    rect(pos.x-size/4,  pos.y-size/4, size/2, size/2);
    fill(255,255,255, 230*alpha_fac*r3);
    rect(pos.x-size/2,  pos.y-size/2, size, size);
    fill(255,255,255, 210*alpha_fac*r3);
    rect(pos.x-size/4,  pos.y-size, size/2, size/2);
    rect(pos.x-size/4,  pos.y+size/2, size/2, size/2);
    rect(pos.x-size,    pos.y-size/4, size/2, size/2);
    rect(pos.x+size/2,  pos.y-size/4, size/2, size/2);
  }
  
  void set_alpha_fac(float fac){
    this.alpha_fac = fac;
  }
}
