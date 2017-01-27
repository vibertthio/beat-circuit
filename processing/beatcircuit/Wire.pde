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


  //state
  boolean angleAdjusting = true;

  //time line para
  int timeUnit = 100;

  //time tracking objects
  TimeLine timerOfEndPoint;
  TimeLine timerOfAngleAdjusting;

  Wire(float _x_s, float _y_s, float _x_e, float _y_e) {
    x_s = _x_s;
    y_s = _y_s;
    x_e = _x_e;
    y_e = _y_e;

    angle = atan2(y_e - y_s, x_e - x_s);
    length = dist(x_s, y_s, x_e, y_e);
    finalAngle = (PI / 2) * round(angle * 2 / PI);
    println("angle: " + angle);
    println("final angle: " + finalAngle);

    timerOfEndPoint = new TimeLine(timeUnit / 2);
    triggerEndPoints();

    // timerOfAngleAdjusting = new TimeLine(timeUnit * 4);
    // timerOfAngleAdjusting.startTimer();
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
    ellipse(x_s, y_s, dia, dia);
    ellipse(x_e, y_e, dia, dia);
    popMatrix();
  }
  void triggerEndPoints() {
    // println("tirgger end points!");
    timerOfEndPoint.startTimer();
  }

  //UI
  void mousePressed(int mX, int mY) {}

}
