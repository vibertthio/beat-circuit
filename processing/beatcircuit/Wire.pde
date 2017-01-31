class Wire {
  //display paras
  float _strokeWeight = 2;
  color _strokeColor = color (1, 152, 117);
  float _nodeDiameter = 15;
  color _nodeColor = color(243, 156, 18);
  color _detectedColor = color(214, 69, 65);

  //pos and angle
  int xs, ys, xe, ye;
  float x_s, y_s, x_e, y_e;

  float angle, length;
  float finalAngle, finalLength;
  // float angleUnit = PI / 4;

  //related wires
  ArrayList<Wire> prev;
  ArrayList<Wire> next;

  //state
  boolean steady = false;
  boolean posShifting = false;
  boolean angleAdjusting = false;
  boolean lengthAdjusting = true;
  boolean mousePointStartSensed = false;
  boolean mousePointEndSensed = false;
  boolean mousePointStartPressed = false;
  boolean mousePointEndPressed = false;
  boolean mouseWireSensed = false;

  //time line para
  int timeUnit = 25;

  //time tracking objects
  TimeLine timerOfEndPoint;
  TimeLine timerOfAngleAdjusting;

  Circuit circuit = null;

  void init(int _xs, int _ys, int _xe, int _ye) {
    updatePos(_xs, _ys, _xe, _ye);
    x_s = xs * scl;
    y_s = ys * scl;
    angle = finalAngle;
    length = 0;
    // updateLength();
    timerOfEndPoint = new TimeLine(timeUnit / 2);
    triggerEndPoints();

    prev = new ArrayList<Wire>();
    next = new ArrayList<Wire>();
  }
  Wire(int _xs, int _ys, int _xe, int _ye) {
    init(_xs, _ys, _xe, _ye);
  }
  Wire(int _xs, int _ys, int _xe, int _ye, boolean _steady) {
    init(_xs, _ys, _xe, _ye);
    steady = _steady;
  }

  //main functions
  void update() {
    if (posShifting) {
      shiftPos();
    }
    if (lengthAdjusting) {
      adjustLength();
    }
    if (angleAdjusting) {
      adjustAngle();
    }

  }
  void display() {
    mainWireDisplay();
    endPointsDisplay();
  }

  //rotate the angle
  float adjustingRate = 0.2;
  void updateAngle() {
    angleAdjusting = true;
    float a = atan2((ye - ys)*scl, (xe - xs)*scl);
    float threshold = PI / 4;
    if (abs(angle - PI) < threshold && a < 0) { angle -= 2 * PI; }
    else if (abs(angle + PI) < threshold && a > 0) { angle += 2 * PI; }
    finalAngle = a;
    println("current angle: " + angle);
    println("target angle: " + finalAngle);
  }
  void adjustAngle() {
    angle = angle + adjustingRate * (finalAngle - angle);
    x_e = x_s + length * cos(angle);
    y_e = y_s + length * sin(angle);
    shiftNextWires(xe, ye);
    if (abs(angle - finalAngle) < 0.001) {
      angle = finalAngle;
      angleAdjusting = false;
    }
  }
  void updateLength() {
    lengthAdjusting = true;
    finalLength = dist(xs * scl, ys * scl, xe * scl, ye * scl);
  }
  void adjustLength() {
    length = length + adjustingRate * (finalLength - length);
    x_e = x_s + length * cos(angle);
    y_e = y_s + length * sin(angle);
    if (abs(length - finalLength) < 1) {
      length = finalLength;
      lengthAdjusting = false;
    }
  }
  void updatePos(int _xs, int _ys, int _xe, int _ye) {
    xs = _xs;
    ys = _ys;
    xe = _xe;
    ye = _ye;

    updateLength();
    updateAngle();
  }
  void shiftPos(int _xs, int _ys) {
    if (!steady) {
      int dx = _xs - xs;
      int dy = _ys - ys;
      updatePos(xs+dx, ys+dy, xe+dx, ye+dy);
      posShifting = true;
      shiftNextWires(ys, ye);
    }
  }
  void shiftPos() {
    x_s = x_s + adjustingRate * (float(xs * scl) - x_s);
    y_s = y_s + adjustingRate * (float(ys * scl) - y_s);
    x_e = x_s + length * cos(angle);
    y_e = y_s + length * sin(angle);
  }
  void shiftNextWires(int _x, int _y) {
    for (int i=0; i<next.size(); i++) {
      Wire w = next.get(i);
      w.shiftPos(_x, _y);
    }
  }

  //display functions
  //and related utility
  void mainWireDisplay() {
    pushMatrix();
    if (!mouseWireSensed) {
      stroke(_strokeColor);
    }
    else {
      stroke(_detectedColor);
    }
    strokeWeight(_strokeWeight);
    line(x_s, y_s, x_e, y_e);
    popMatrix();
  }
  void endPointsDisplay() {
    pushMatrix();
    strokeWeight(_strokeWeight);
    fill(bk);
    float dia = _nodeDiameter * (1 + timerOfEndPoint.repeatBreathMovement() * 0.3);

    if (mousePointStartSensed) {
      stroke(_detectedColor);
    }
    else {
      stroke(_strokeColor);
    }
    ellipse(x_s, y_s, dia, dia);

    if (mousePointEndSensed) {
      stroke(_detectedColor);
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
    if (mousePointEndPressed) {
      // updateAngle();
    }
    mousePointStartPressed = false;
    mousePointEndPressed = false;
  }
  void mouseDragged(int mX, int mY) {
    if (mousePointStartPressed) {
      // updatePos(mX, mY, x_e, y_e);
      shiftPos(mX, mY);
    }
    if (mousePointEndPressed) {
      updatePos(xs, ys, mX, mY);
    }
  }
  void mouseSensed(int mX, int mY) {
    mousePointStartSensed = (mX == xs && mY == ys)? true:false;
    mousePointEndSensed = (mX == xe && mY == ye)? true:false;
    // if (!mousePointStartSensed && !mousePointEndSensed && (d1+d2 < length * 1.01)) {
    //   mouseWireSensed = true;
    // }
    // else {
      mouseWireSensed = false;
    // }
    // if (mousePointStartSensed) {
    //   return 1;
    // }
    // else if (mousePointEndSensed) {
    //   return 2;
    // }
    // else if (mouseWireSensed) {
    //   return 3;
    // }
    // else {
    //   return 0;
    // }
  }

}
