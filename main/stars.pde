class Stars{
  private Star[] stars;
  private float x;
  private float y;
  private float w;
  private float h;
  
  
  private float alpha_fac = 1;
  final static int NUM_STARS = 800;
  
  Stars(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    stars = new Star[NUM_STARS];
    for(int i = 0; i < NUM_STARS; i++){
      float r_x = random(x, x+w);
      float r_y = random(y, y+h);
      float r_s = random(10, 20);
      stars[i] = new Star(r_x, r_y, r_s);
    }
  }
  
  void render(){
    translate(0,0,-5000);
    for(int i = 0; i < NUM_STARS; i++){
      stars[i].render();
    }
    translate(0,0,5000);
  }
  
  

}
