class Planet implements PhysicsObj{
  private PVector pos;
  private PVector vel;
  private PVector acc;
  private float rad;
  private float g_rad; 
  private float mass;
  
  final static float G_CONST = 1000;
  final static float DEFAULT_RADIUS = 90;
  final static float INIT_MASS = 1000;
  
  Planet(float x, float y){
    this(x, y, DEFAULT_RADIUS);
  }
  
  Planet(float x, float y, float rad){
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.rad = rad;
    this.g_rad = 5*rad/2.0;
    this.mass = INIT_MASS + 5*pow(rad, 2);

  }
  
  PVector force_function(PhysicsObj obj){
    float c = 0;
    if(PVector.dist(pos, obj.get_pos()) <= g_rad) {
      if(PVector.dist(pos, obj.get_pos()) <= rad && obj.is_moving()){
        obj.set_vel(new PVector(0,0));
        obj.set_acc(new PVector(0,0));
      }else{
        c = G_CONST*mass*obj.get_mass() / (pow(pos.dist(obj.get_pos()), 3));
      }  
  }
    return PVector.mult(PVector.sub(pos,obj.get_pos()), c);
  }
  
  void render(){

    noStroke();
    fill(200,60,0, 30);
    circle(pos.x, pos.y, g_rad);
    fill(0,230,0);
    circle(pos.x, pos.y , rad);

  }
  
  PVector get_pos(){
   return pos;
 }
  PVector get_vel(){
   return vel;
 }
  PVector get_acc(){
   return acc;
 }
  float get_mass(){
   return mass;
 }
 float get_rad(){
   return rad;
 }
 
  void set_pos(PVector pos){
   this.pos = pos;
 }
 void set_vel(PVector vel){
   this.vel = vel;
 }
 void set_acc(PVector acc){
   this.acc = acc;
 }
 void set_mass(float mass){
   this.mass = mass;
 }
 
 boolean is_moving(){
   return vel.mag() != 0; 
 }
 
}
