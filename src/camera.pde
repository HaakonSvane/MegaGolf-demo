class Camera {
  private Ball following = null;

  public float x = 0;
  public float y = 0;

  final static float X_TRIG_ZONE_R = 3f/8;
  final static float X_TRIG_ZONE_L = 1f/8;
  final static float Y_TRIG_ZONE_U = 1f/8;
  final static float Y_TRIG_ZONE_D = 7f/8;
  final static float CAM_SPEED = 15;

  void following(Ball b) {  
    this.following = b;
  }

  void update() {
    if (following != null) {
      float rel_pos_x = (following.get_pos().x-x)/width;
      float rel_pos_y = (following.get_pos().y-y)/height;
      int sign_x = (rel_pos_x > X_TRIG_ZONE_R) ? 1 : ((rel_pos_x < X_TRIG_ZONE_L) ? -1 : 0);
      int sign_y = (rel_pos_y > Y_TRIG_ZONE_D) ? 1 : ((rel_pos_y < Y_TRIG_ZONE_U) ? -1 : 0);
      float dx = abs(rel_pos_x-1f/2*((sign_x+1)*X_TRIG_ZONE_R -(sign_x-1)*X_TRIG_ZONE_L));
      float dy = abs(rel_pos_y-1f/2*((sign_y+1)*Y_TRIG_ZONE_D -(sign_y-1)*Y_TRIG_ZONE_U));
      float move_x = CAM_SPEED*sign_x*sqrt(dx);
      float move_y = CAM_SPEED*sign_y*sqrt(dy);
      beginCamera();
      translate(-move_x, -move_y, 0);
      x += move_x;
      y += move_y;
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
