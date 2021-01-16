class PhysicsInfo{
  PhysicsInfo(PVector pos, PVector vel, PVector acc, float mass){
    this.pos = pos;
    this.vel = vel;
    this.acc = acc;
    this.mass = mass;
  }
  public PVector pos;
  public PVector vel;
  public PVector acc;
  public float mass;
}
public interface PhysicsObj{
  // the force function desribes how another object interacts with this.
  PVector force_function(PhysicsObj obj);
  
  PVector get_pos();
  PVector get_vel();
  PVector get_acc();
  float get_mass();
  
  void set_pos(PVector pos);
  void set_vel(PVector vel);
  void set_acc(PVector acc);
  void set_mass(float mass);
  void ignore_physics(boolean val, boolean force_stop);
  
  boolean is_moving();
}

// Verlet integration.
PhysicsInfo integrate(PhysicsInfo init, PVector sum_forces, float dt){
  float dt1 = (1.0/2)*dt;
  float dt2 = (1.0/2)*pow(dt, 2);
  
  PVector new_pos = PVector.add(PVector.add(init.pos, PVector.mult(init.vel, dt)), PVector.mult(init.acc, dt2));
  PVector new_acc = sum_forces.div(init.mass);
  PVector new_vel = init.vel.add((init.acc.add(new_acc)).mult(dt1));
  return new PhysicsInfo(new_pos, new_vel, new_acc, init.mass);
}

float angle_between_vectors(PVector vec1, PVector vec2){
  return atan2(vec2.y-vec1.y, vec2.x-vec1.x);
}
