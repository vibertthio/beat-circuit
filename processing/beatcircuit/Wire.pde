class Wire {
  //display paras
  float _strokeWeight = 2;
  color _strokeColor = color (1, 152, 117);
  float _nodeDiameter = 15;
  color _nodeColor = color(243, 156, 18);

  //pos and angle
  float x_s, y_s, x_e, y_e;
  float angle, length;
  float finalAngle;
  float angleUnit = PI / 4;

  //related wires
  ArrayList<Wire> prev;
  ArrayList<Wire> next;

  //state
  boolean angleAdjusting = true;
  boolean mousePointStartSensed = false;
  boolean mousePointEndSensed = false;
  boolean mousePointStartPressed = false;
  boolean mousePointEndPressed = false;

  //time line para
  int timeUnit = 100;

  //time tracking objects
  TimeLine timerOfEndPoint;
  TimeLine timerOfAngleAdjusting;

  Wire(float _x_s, float _y_s, float _x_e, float _y_e) {
    updatePos(_x_s, _y_s, _x_e, _y_e);
    finalAngle = angleUnit * round(angle / angleUnit);
    // println("angle: " + angle);
    // println("final angle: " + finalAngle);

    timerOfEndPoint = new TimeLine(timeUnit / 2);
    triggerEndPoints();

    // timerOfAngleAdjusting = new TimeLine(timeUnit * 4);
    // timerOfAngleAdjusting.startTimer();

    prev = new ArrayList<Wire>();
    next = new ArrayList<Wire>();
  }

  //main functions
  void update() {
    if (angleAdjusting) {
      adjustAngle();
    }

  }
  void display() {
    mainWireDisplay();
    endPointsDisplay();
  }

  //rotate the angle
  float angleAdjustingRate = 0.1;
  void adjustAngle() {
    angle = angle + angleAdjustingRate * (finalAngle - angle);
    x_e = x_s + length * cos(angle);
    y_e = y_s + length * sin(angle);
    if (abs(angle - finalAngle) < 0.001) {
      angle = finalAngle;
      angleAdjusting = false;
    }
  }
  void updatePos(float _x_s, float _y_s, float _x_e, float _y_e) {
    x_s = _x_s;
    y_s = _y_s;
    x_e = _x_e;
    y_e = _y_e;
    angle = atan2(y_e - y_s, x_e - x_s);
    length = dist(x_s, y_s, x_e, y_e);
  }

  //display functions
  //and related utility
  void mainWireDisplay() {
    pushMatrix();
    stroke(_strokeColor);
    strokeWeight(_strokeWeight);
    line(x_s, y_s, x_e, y_e);
    popMatrix();
  }
  void endPointsDisplay() {
    pushMatrix();
    stroke(_strokeColor);
    strokeWeight(_strokeWeight);
    fill(bk);
    float dia = _nodeDiameter * (1 + timerOfEndPoint.repeatBreathMovement() * 0.3);

    if (mousePointStartSensed) {
      stroke(255, 0, 0);
    }
    else {
      stroke(_strokeColor);
    }
    ellipse(x_s, y_s, dia, dia);

    if (mousePointEndSensed) {
      stroke(255, 0, 0);
    }
    else {
      stroke(_strokeColor);
    }
    ellipse(x_e, y_e, dia, dia);

    // if (next.isEmpty()) {
    //   ellipse(x_e, y_e, dia, dia);
    // }
    popMatrix();
  }
  void triggerEndPoints() {
    // println("tirgger end points!");
    timerOfEndPoint.startTimer();
  }

  //related wires functions
  void addNext(Wire w) {
    next.add(w);
  }
  void addPrev(Wire w) {
    prev.add(w);
  }
  void trigger() {}

  //UI
  void mousePressed(int mX, int mY) {
    if( mousePointStartSensed ) {
      mousePointStartPressed = true;
    }
    if( mousePointEndSensed ) {
      mousePointEndPressed = true;
    }

  }
  void mouseReleased(int mX, int mY) {
    mousePointStartPressed = false;
    mousePointEndPressed = false;
  }
  void mouseDragged(int mX, int mY) {
    if (mousePointStartPressed) {
      updatePos(mX, mY, x_e, y_e);
    }
    if (mousePointEndPressed) {
      updatePos(x_s, y_s, mX, mY);
    }
  }
  void mouseSensed(int mX, int mY) {
    mousePointStartSensed = (dist(mX, mY, x_s, y_s) < _nodeDiameter / 2)? true:false;
    mousePointEndSensed = (dist(mX, mY, x_e, y_e) < _nodeDiameter / 2)? true:false;
  }

}
