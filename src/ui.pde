abstract class UIelement{
  protected Timer timer;
  protected color col;
  protected float angle;
  protected float lifetime;
  
  final static float DEFAULT_ANGLE = 0;

  UIelement(){
    this.timer = new Timer();
  } 
  
  abstract void render();
  
  void set_color(color col){
    this.col = col;
  }
  void set_angle(float angle){
    this.angle = angle;
  }
  void set_lifetime(float val){
    this.lifetime = val;
  }
  
  color get_color(){
    return this.col;
  }
  
  float get_angle(){
    return this.angle;
  }
  
  boolean is_dead(){
    return timer.getElapsedTime() > lifetime && lifetime != 0;
  }
  
  
}

class Text extends UIelement{
  public String text;
  public PVector pos;
  public float size;
  
  final static float DEFAULT_SIZE = 24;
  
  Text(String text, float x, float y){
    this(text, x, y, DEFAULT_SIZE, DEFAULT_ANGLE);
  }
  Text(String text, float x, float y, float size){
    this(text, x, y, size, DEFAULT_ANGLE);
  }
  
  Text(String text, float x, float y, float size, float angle){
    this.text = text;
    this.pos = new PVector(x, y);
    this.size = size;
    this.angle = angle;
  }
  
  void render(){
    if(!timer.running) timer.start();
    float t = timer.getElapsedTime()/lifetime;
    float alpha = 255*1f/2*(1+(float)Math.tanh(-10*(t-9f/10)));
    int a = (int) alpha;
    color new_color = (get_color() & 0xffffff) | (a << 24);
    set_color(new_color);
    fill(col);
    textAlign(CENTER);
    textSize(size);
    translate(pos.x, pos.y);
    rotate(-angle);
    text(text, 0, 0);
    rotate(angle);
    translate(-pos.x, -pos.y);
  }
}

class Shape extends UIelement{
  public PShape shape;
  
  Shape(PShape shape){
    this(shape, color(255,255,255,255), DEFAULT_ANGLE);
  }
  Shape(PShape shape, color col){
    this(shape, col, DEFAULT_ANGLE); 
  }
  Shape(PShape shape, color col, float angle){
    this.shape = shape;
    this.col = col;
    this.angle = angle;
  }
  
  void render(){
    if(!timer.running) timer.start();
    noStroke();
    fill(col);
    beginShape();
    for (int i = 0; i < shape.getVertexCount(); i++){
      vertex(shape.getVertex(i).x, shape.getVertex(i).y);
    }
    endShape();
  }
}

class UI{
  private Camera cam;
  private ArrayList<UIelement> elements;
  UI(Camera cam){
    this.cam = cam;
    elements = new ArrayList<UIelement>();
  }
  void add_element(UIelement elem){
    elements.add(elem);
  }
  
  void render(){
    translate(cam.x, cam.y);
    for (int i = elements.size()-1; i >= 0; i--){ //<>//
      elements.get(i).render();
      if(elements.get(i).is_dead()) elements.remove(i);
    }
    translate(-cam.x, -cam.y);
  }
}
