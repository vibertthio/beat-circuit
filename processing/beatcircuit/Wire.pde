class Wire {

  float _strokeWeight = 2;
  color _strokeColor = color (200, 200, 200);
  float _nodeDiameter = 15;
  color _nodeColor = color(255, 0, 0);

  int timeUnit = 200;

  //pos and angle
  // float xpos, ypos, angle, length;
  float x_s, y_s, x_e, y_e;


  Metro metro;
  TimeLine timerOfSequence;
  TimeLine timerOfEndPoint;



  Wire(float _x_s, float _y_s, float _x_e, float _y_e) {
    x_s = _x_s;
    y_s = _y_s;
    x_e = _x_e;
    y_e = _y_e;

    timerOfSequence = new TimeLine(timeUnit * 16, true);
    timerOfSequence.startTimer();

    timerOfEndPoint = new TimeLine(timeUnit / 2);
    timerOfEndPoint.setLinerRate(2);
    timerOfEndPoint.startTimer();

  }

  void display() {
    //set stroke
    stroke(_strokeColor);
    strokeWeight(_strokeWeight);

    //draw line
    line(x_s, y_s, x_e, y_e);

    //draw node
    fill(bk);
    float dia = _nodeDiameter * (1 + timerOfEndPoint.repeatBreathMovementEndless() * 0.3);
    ellipse(x_s, y_s, dia, dia);
    ellipse(x_e, y_e, dia, dia);

    //the TimeLine
    noStroke();
    fill(_nodeColor);
    float pos = timerOfSequence.liner();
    float x_t = map(pos, 0, 1, x_s, x_e);
    float y_t = map(pos, 0, 1, y_s, y_e);
    ellipse(x_t, y_t, _nodeDiameter, _nodeDiameter);
  }

}
