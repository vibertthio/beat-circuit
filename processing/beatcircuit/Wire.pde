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
  boolean shifting = false;
  boolean posShifting = false;
  boolean endPosShifting = false;
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

  Circuit circuit = null;

  void init(int _xs, int _ys, int _xe, int _ye) {
    updatePos(_xs, _ys, _xe, _ye);
    x_s = xs * scl;
    y_s = ys * scl;
    x_e = x_s;
    y_e = y_s;

    angle = atan2((ye - ys)*scl, (xe - xs)*scl);
    shiftEndPos(_xe, _ye);
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
    if (endPosShifting) {
      shiftEndPos();
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
    // println("current angle: " + angle);
    // println("target angle: " + finalAngle);
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
  }
  void shiftEndPos(int _xe, int _ye) {
    xe = _xe;
    ye = _ye;
    endPosShifting = true;
  }
  void shiftEndPos() {
    float xd = float(xe * scl);
    float yd = float(ye * scl);
    float dx = adjustingRate * (xd - x_e);
    float dy = adjustingRate * (yd - y_e);
    x_e = x_e + dx;
    y_e = y_e + dy;
    if (dist(xd, yd, x_e, y_e) < 0.1) {
      x_e = xd;
      y_e = yd;
      endPosShifting = false;
    }
    angle = atan2(y_e - y_s, x_e - x_s);
    length = dist(x_s, y_s, x_e, y_e);

  }
  void shiftPos(int _xs, int _ys) {
    if (!shifting) {
      shifting = true;
      int dx = _xs - xs;
      int dy = _ys - ys;
      xs = _xs;
      ys = _ys;
      xe = xe + dx;
      ye = ye + dy;
      // shiftEndPos(xe + dx, ye + dy);

      posShifting = true;
      shiftNextWires(xe, ye);
      shifting = false;
    }
  }
  void shiftPos() {
    float xd = float(xs * scl);
    float yd = float(ys * scl);
    float dx = adjustingRate * (xd - x_s);
    float dy = adjustingRate * (yd - y_s);
    x_s = x_s + dx;
    y_s = y_s + dy;
    x_e = x_e + dx;
    y_e = y_e + dy;
    if (dist(xd, yd, x_s, y_s) < 0.1) {
      x_s = xd;
      y_s = yd;
      x_e = xe * scl;
      y_e = ye * scl;
      posShifting = false;
    }
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
    if (!next.contains(w)) {
      next.add(w);
    }
  }
  void addPrev(Wire w) {
    if (!prev.contains(w)) {
      prev.add(w);
    }
  }
  // void remove
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
  boolean[] mouseReleased(int mX, int mY) {
    boolean[] ret =  { mousePointStartPressed, mousePointEndPressed} ;
    mousePointStartPressed = false;
    mousePointEndPressed = false;

    return ret;
  }
  void mouseDragged(int mX, int mY) {
    if (mousePointStartPressed) {
      shiftPos(mX, mY);
    }
    if (mousePointEndPressed) {
      shiftEndPos(mX, mY);
    }
  }
  void mouseSensed(int mX, int mY) {
    mousePointStartSensed = (mX == xs && mY == ys)? true:false;
    mousePointEndSensed = (mX == xe && mY == ye)? true:false;
    mouseWireSensed = false;
  }

}
