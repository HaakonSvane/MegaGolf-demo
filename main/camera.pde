class Camera {
  private Ball following = null;

  public float x = 0;
  public float y = 0;

  final static float X_TRIG_ZONE_R = 3f/8;
  final static float X_TRIG_ZONE_L = 1f/8;
  final static float CAM_SPEED = 15;

  void following(Ball b) {  
    this.following = b;
  }

  void update() {
    if (following != null) {
      float rel_pos = (following.get_pos().x-x)/width;
      int sign = (rel_pos > X_TRIG_ZONE_R) ? 1 : ((rel_pos < X_TRIG_ZONE_L) ? -1 : 0);
      float dx = abs(rel_pos-1f/2*((sign+1)*X_TRIG_ZONE_R -(sign-1)*X_TRIG_ZONE_L));
      float move = CAM_SPEED*sign*sqrt(dx);
      beginCamera();
      translate(-move, 0, 0);
      x += move;
      endCamera();
    }
  }

  void reset(boolean remove_follower) {
    beginCamera();
    translate(x,y,0);
    endCamera();
    this.x = 0;
    this.y = 0;
    if (remove_follower) following = null;
  }
}
