SpinSpots spots;
SpinArm arm;
ArrayList<Spin> list;

void setup() {
  size(640, 360);

  list = new ArrayList<Spin>();
  list.add(new SpinArm(width/2, height/2, 0.01));
  list.add(new SpinSpots(width/2, height/2, -0.02, 90.0));

  // arm = new SpinArm(width/2, height/2, 0.01);
  // spots = new SpinSpots(width/2, height/2, -0.02, 90.0);
}

void draw() {
  background(204);
  // arm.update();
  // arm.display();
  // spots.update();
  // spots.display();
  for (int i=0; i<list.size(); i++) {
    Spin item = list.get(i);
    item.update();
    item.display();
  }
  // for(Spin item : list) {
  //   item.update();
  //   item.display();
  // }
}

class Spin {
  float x, y, speed;
  float angle = 0.0;
  String debbug = "mother";
  Spin(float xpos, float ypos, float s) {
    x = xpos;
    y = ypos;
    speed = s;
  }
  void update() {
    angle += speed;
  }

  void display() {
    println("spin display function!");
  }
}

class SpinArm extends Spin {
  // String debbug = "chidren";
  SpinArm(float x, float y, float s) {
    super(x, y, s);
  }
  void display() {
    println("debbug: "+debbug);
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(x, y);
    angle += speed;
    rotate(angle);
    line(0, 0, 165, 0);
    popMatrix();
  }
}

class SpinSpots extends Spin {
  float dim;
  SpinSpots(float x, float y, float s, float d) {
    super(x, y, s);
    dim = d;
  }
  void display() {
    noStroke();
    pushMatrix();
    translate(x, y);
    angle += speed;
    rotate(angle);
    ellipse(-dim/2, 0, dim, dim);
    ellipse(dim/2, 0, dim, dim);
    popMatrix();
  }
}
