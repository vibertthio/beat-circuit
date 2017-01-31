class Wire {
  //display paras
  float _strokeWeight = 2;
  color _strokeColor = color (1, 152, 117);
  float _nodeDiameter = 15;
  color _nodeColor = color(243, 156, 18);
  color _detectedColor = color(214, 69, 65);

  //pos and angle
  float x_s, y_s, x_e, y_e;
  float angle, length;
  float finalAngle, finalLength;
  float angleUnit = PI / 4;

  //related wires
  ArrayList<Wire> prev;
  ArrayList<Wire> next;

  //state
  boolean steady = false;
  boolean angleAdjusting = true;
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

  void init(float _x_s, float _y_s, float _x_e, float _y_e) {
    updatePos(_x_s, _y_s, _x_e, _y_e);
    finalAngle = angleUnit * round(angle / angleUnit);
    length = 0;
    finalLength = dist(_x_s, _y_s, _x_e, _y_e);
    timerOfEndPoint = new TimeLine(timeUnit / 2);
    triggerEndPoints();

    prev = new ArrayList<Wire>();
    next = new ArrayList<Wire>();
  }
  Wire(float _x_s, float _y_s, float _x_e, float _y_e) {
    init(_x_s, _y_s, _x_e, _y_e);
  }
  Wire(float _x_s, float _y_s, float _x_e, float _y_e, boolean _steady) {
    init(_x_s, _y_s, _x_e, _y_e);
    steady = _steady;
  }

  //main functions
  void update() {
    if (lengthAdjusting) {
      adjustLength();
    }
    else if (angleAdjusting) {
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
    finalAngle = angleUnit * round(angle / angleUnit);
  }
  void adjustAngle() {
    angle = angle + adjustingRate * (finalAngle - angle);
    x_e = x_s + length * cos(angle);
    y_e = y_s + length * sin(angle);
    shiftNextWires(x_e, y_e);
    if (abs(angle - finalAngle) < 0.001) {
      angle = finalAngle;
      angleAdjusting = false;
    }
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
  void updatePos(float _x_s, float _y_s, float _x_e, float _y_e) {
    x_s = _x_s;
    y_s = _y_s;
    x_e = _x_e;
    y_e = _y_e;
    angle = atan2(y_e - y_s, x_e - x_s);
    length = dist(x_s, y_s, x_e, y_e);
  }
  void shiftPos(float _x_s, float _y_s) {
    if (!steady) {
      x_s = _x_s;
      y_s = _y_s;
      x_e = x_s + length * cos(angle);
      y_e = y_s + length * sin(angle);
      shiftNextWires(x_e, y_e);
    }
  }
  void shiftNextWires(float _x, float _y) {
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
      updateAngle();
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
      updatePos(x_s, y_s, mX, mY);
    }
  }
  void mouseSensed(int mX, int mY) {
    float d1 = dist(mX, mY, x_s, y_s);
    float d2 = dist(mX, mY, x_e, y_e);
    mousePointStartSensed = (d1 < _nodeDiameter / 2)? true:false;
    mousePointEndSensed = (d2 < _nodeDiameter / 2)? true:false;
    if (!mousePointStartSensed && !mousePointEndSensed && (d1+d2 < length * 1.01)) {
      mouseWireSensed = true;
    }
    else {
      mouseWireSensed = false;
    }
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
