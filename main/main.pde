import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

Ball golf;
PostFX fx;
Stars s;

float cam_x = 0;
float cam_y = 0;
float CAM_X_BORDER;
final PVector START_POS = new PVector(400, 400);

ArrayList<PhysicsObj> planets = new ArrayList<PhysicsObj>();
float t = 0;
float prev_t = 0;

void setup(){
  size(1624, 750, P3D);
  fx = new PostFX(this);
  smooth(6);
  ellipseMode(RADIUS);
  golf = new Ball(START_POS.x, START_POS.y);
  planets.add(new Planet(width/2.0, 3*height/4.0, 40));
  planets.add(new Planet(3*width/4.0, 1*height/4.0));
  planets.add(new Planet(3*width/4.0, 3*height/4.0, 200));
  s = new Stars(-7000 ,-3000, width*10, height*10);
  
  CAM_X_BORDER = 3*width/8;
}

void draw(){
  background(40,40,40);
  s.render();
  if(drag_state){
    golf.pull_up(mouseX+cam_x, mouseY+cam_y, planets);  
  }
  for (PhysicsObj po : planets){
    Planet p = (Planet) po;
    p.render();
  }
   golf.render();
   
   if (golf.get_pos().x > CAM_X_BORDER+cam_x){
     float dx = golf.get_pos().x-(CAM_X_BORDER+cam_x);
     float move = 1f/2*sqrt(dx);
     beginCamera();
     translate(-move,0,0);
     cam_x += move;
     endCamera();
   }
   
   
  
  // Physics part
  t = millis()/1000.0;

  float dt = t-prev_t;
  golf.update(planets, dt);
  
  // This comes last   
  prev_t = t;
  
  fx.render()
    .rgbSplit(20)
    .noise(0.01, 100)
    .bloom(10, 4, 8)
    .compose();
}


void keyPressed(){
  if (keyCode == RIGHT){
    beginCamera();
    for(int i = 0; i < 100; i++){
      translate(-1,0,0);
      cam_x += 1;
    }
    endCamera();
  }
  if(keyCode == ' '){
    textSize(48);
    text("Restart", 10, 30);
    
    golf.set_acc(new PVector(0,0));
    golf.set_vel(new PVector(0,0));
    golf.set_pos(new PVector(START_POS.x,START_POS.y));
    
    beginCamera();
    translate(cam_x, cam_y);
    endCamera();
    cam_x = 0;
    cam_y = 0;

  }
}

boolean drag_state = false;
void mouseReleased(){
  if (drag_state){
    golf.hit_ball(mouseX+cam_x, mouseY+cam_y);
  }
  drag_state = false;
}

void mousePressed(){
  if (golf.mouse_touching(mouseX+cam_x, mouseY+cam_y) && !golf.is_moving()){
    drag_state = true;
  }
}
