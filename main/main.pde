import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

Camera cam;
Ball golf;
PostFX fx;
Stars s;
UI ui;

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
  planets.add(new Planet(width/2.0-200, 3*height/4.0, 40));
  planets.add(new Planet(width-50, 1*height/5.0));
  planets.add(new Planet(3*width/4.0, 3*height/4.0, 190));
  s = new Stars(-7000 ,-3000, width*10, height*10);
  cam = new Camera();
  cam.following(golf);
  ui = new UI(cam);
}

void draw(){
  background(40,40,40);
  cam.update();
  s.render();
  if(drag_state){
    golf.pull_up(mouseX+cam.x, mouseY+cam.y, planets);  
  }
  for (PhysicsObj po : planets){
    Planet p = (Planet) po;
    p.render();
  }
   golf.render();

   
   
  
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
    
    ui.render();
}


void keyPressed(){
  if (keyCode == RIGHT){
    beginCamera();
    for(int i = 0; i < 100; i++){
      translate(-1,0,0);
    }
    endCamera();
  }
  if(keyCode == ' '){
    textSize(48);
    Text t = new Text("RESTART", width/2, height/2, 48);
    t.set_lifetime(1000);
    t.set_color(color(255,255,255));
    ui.add_element(t);
    
    golf.set_acc(new PVector(0,0));
    golf.set_vel(new PVector(0,0));
    golf.set_pos(new PVector(START_POS.x,START_POS.y));
   
    cam.reset(false);

  }
}

boolean drag_state = false;
void mouseReleased(){
  if (drag_state){
    golf.hit_ball(mouseX+cam.x, mouseY+cam.y);
  }
  drag_state = false;
}

void mousePressed(){
  if (golf.mouse_touching(mouseX+cam.x, mouseY+cam.y) && !golf.is_moving()){
    drag_state = true;
  }
}
