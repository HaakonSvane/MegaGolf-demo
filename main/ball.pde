
public class Ball implements PhysicsObj{
 private PVector pos;
 private PVector vel;
 private PVector acc;
 private float rad;
 private float mass = 0.5;
 
 final static float DEFAULT_RADIUS = 10;
 final static float MAX_DRAG_LENGTH = 200;
 final static float HIT_STRENGTH = 600;
 final static float MAX_SPEED = 4000;
 final static float MAX_ACC = 10;
 final static float FORWARD_POINTS = 60*3;
 final static float FORWARD_TIME = 3; // seconds
 final static float TRAJ_ALPHA = 90;
 
 Ball(float init_x, float init_y){
   this(init_x, init_y, DEFAULT_RADIUS);
 }
 
 Ball(float init_x, float init_y, float radius){
   this.pos = new PVector(init_x, init_y);
   this.vel = new PVector(0, 0);
   this.acc = new PVector(0, 0);
   this.rad = radius;
 }
 
 PVector force_function(PhysicsObj obj){
   return new PVector(0,0);
 }
 
 void render(){
   noStroke();
   fill(200,200,200);
   circle(pos.x, pos.y, rad);
 }
 
 void update(ArrayList<PhysicsObj> interactibles, float dt){
   PVector sum_forces = new PVector(0,0);
   for (PhysicsObj i : interactibles){
     sum_forces = sum_forces.add(i.force_function(this));
   }
   PhysicsInfo dat = new PhysicsInfo(pos, vel, acc, mass);
   dat = integrate(dat, sum_forces, dt);
   
   pos = dat.pos;
   vel = dat.vel.limit(MAX_SPEED);
   acc = dat.acc.limit(MAX_ACC);
   
 }
 
 private PVector vel_from_polar(float r, float angle){
   PVector hit_vec = PVector.fromAngle(angle);
   float fac = 1;
   if(r/MAX_DRAG_LENGTH < 1){
     fac = r/MAX_DRAG_LENGTH;
   }
   return PVector.mult(hit_vec, fac*HIT_STRENGTH);
 }
 
 void hit_ball(float mouse_x, float mouse_y){
   PVector mouse_pos = new PVector(mouse_x, mouse_y);
   float angle = angle_between_vectors(pos, mouse_pos)+PI;
   float dist = pos.dist(mouse_pos);
   vel = vel_from_polar(dist, angle);
 }
 
  void pull_up(float mouse_x, float mouse_y, ArrayList<PhysicsObj> interactibles){
    strokeWeight(4);
    PVector end_pos = new PVector(mouse_x, mouse_y);
    float dist = end_pos.dist(pos);
    float angle = angle_between_vectors(pos, end_pos);
    if (dist >= MAX_DRAG_LENGTH){
      end_pos.x = pos.x + cos(angle)*MAX_DRAG_LENGTH;
      end_pos.y = pos.y + sin(angle)*MAX_DRAG_LENGTH;
    }
    float new_dist = end_pos.dist(pos);
    stroke(190*new_dist/MAX_DRAG_LENGTH, 170*(1-new_dist/MAX_DRAG_LENGTH), 90);
    line(pos.x, pos.y, end_pos.x, end_pos.y);
   
    strokeWeight(2);
    stroke(190, 190, 190, TRAJ_ALPHA);
    noFill();
    beginShape();
    // The fake variables are for the simulation of the trajectory.
    float fake_dt = FORWARD_TIME*1f/FORWARD_POINTS;
    Ball fake_ball = new Ball(pos.x, pos.y, rad);
    fake_ball.set_vel(vel_from_polar(dist, angle+PI));
    vertex(fake_ball.get_pos().x, fake_ball.get_pos().y);
    for(int i = 0; i < FORWARD_POINTS; i++){
      float fade = TRAJ_ALPHA*1f/2*((float)(Math.tanh(-3*(i/FORWARD_POINTS-4d/5)))+1);
      stroke(255, 255, 255, fade);
      fake_ball.update(interactibles, fake_dt);
      vertex(fake_ball.get_pos().x, fake_ball.get_pos().y);
    }
    endShape();
  }
 
 boolean is_moving(){
 return vel.mag() != 0;
 }
 
 boolean mouse_touching(float mouse_x, float mouse_y){
   PVector rel = new PVector(mouse_x-pos.x, mouse_y-pos.y);
   float dist = rel.mag();
   if (dist > rad){
     return false;
   }else{
     return true;
   }
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
 
 
 
}
