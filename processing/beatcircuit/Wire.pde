class Wire {

  float _strokeWeight = 2;
  color _strokeColor = color (1, 152, 117);

  //time line para
  int timeUnit = 100;
  int numberOfBeats = 32;
  int numberOfBars = 4;
  int beatsPerBar = numberOfBeats / numberOfBars;

  float currentPos = 0; //0 ~ 1
  float currentBar = 1; //1 ~ numberOfBars
  float currentBeat = 1; //1 ~ numberOfBeats

  //pos and angle
  float x_s, y_s, x_e, y_e;
  float angle, length;


  //state
  boolean loop = false;

  Metro metro;
  TimeLine timerOfSequence;
  TimeLine timerOfEndPoint;



  // Wire(float _x_s, float _y_s, float _x_e, float _y_e) {
  //   x_s = _x_s;
  //   y_s = _y_s;
  //   x_e = _x_e;
  //   y_e = _y_e;
  //
  //   angle = atan2(y_e - y_s, x_e - x_s);
  //   length = dist(x_s, y_s, x_e, y_e);
  //   // println("angle" + angle*180/PI);
  //
  //   timerOfSequence = new TimeLine(timeUnit * numberOfBeats, true);
  //   timerOfSequence.setLinerRate(1);
  //   timerOfSequence.startTimer();
  //
  //   timerOfEndPoint = new TimeLine(timeUnit / 2);
  //   timerOfEndPoint.setLinerRate(1);
  //   timerOfEndPoint.startTimer();
  //
  // }
  Wire(float _x_s, float _y_s, float _x_e, float _y_e, boolean _l) {
    x_s = _x_s;
    y_s = _y_s;
    x_e = _x_e;
    y_e = _y_e;

    angle = atan2(y_e - y_s, x_e - x_s);
    length = dist(x_s, y_s, x_e, y_e);
    // println("angle" + angle*180/PI);

    timerOfSequence = new TimeLine(timeUnit * numberOfBeats, _l);
    timerOfSequence.setLinerRate(1);
    timerOfSequence.startTimer();

    timerOfEndPoint = new TimeLine(timeUnit / 2);
    timerOfEndPoint.setLinerRate(1);
    timerOfEndPoint.startTimer();

  }

  void update() {

    currentPos = timerOfSequence.liner();
    if (currentBeat == numberOfBeats &&
        currentPos < float(1) / numberOfBeats) {
      println("check");
      currentBeat = 0;
    }
    // else if (currentPos > currentBeat/numberOfBeats ) {
    if (currentPos > currentBeat/numberOfBeats ) {
      if (currentBeat % beatsPerBar == 0) {
        triggerEndPoints();

        if (currentBar == numberOfBars) {
          currentBar = 0;
        }
        currentBar = currentBar + 1;
      }
      currentBeat = currentBeat + 1;
      println("currentPos: " + currentPos);
      println("currentBeat: " + currentBeat);
      println("currentBar: " + currentBar);
    }

    // println("currentPos: " + currentPos);
    // println("currentBar: " + currentBar);
    // println("currentBeat: " + currentBeat);



  }
  void display() {
    mainWireDisplay();
    endPointsDisplay();
    barSignsDisplay();
    timeNodeDisplay();
  }

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
    println("tirgger end points!");
    timerOfEndPoint.startTimer();
  }

  int _strokeWeightRatioOfBarSign = 1;
  int _barSignSize = 6;
  color _barSignColor = color(236, 240, 241);
  void barSignsDisplay() {
    pushMatrix();

    // stroke(_barSignColor);
    // stroke(_strokeColor);
    // strokeWeight(_strokeWeight * _strokeWeightRatioOfBarSign);
    // strokeCap(ROUND);
    // fill(_strokeColor);

    fill(_barSignColor);
    rectMode(CENTER);
    translate(x_s, y_s);
    rotate(angle);

    float d = length / numberOfBeats;

    for(int i = 1; i < numberOfBeats; i++) {
      if (i % beatsPerBar == 0) {
        stroke(_barSignColor);
        strokeWeight(_strokeWeight * _strokeWeightRatioOfBarSign);
        line(d*i, _barSignSize, d*i, -_barSignSize);
      }
      else {
        // line(d*i, _barSignSize/2, d*i, -_barSignSize/2);
        noStroke();
        ellipse(d*i, 0, 3, 3);
      }
    }

    popMatrix();
  }

  float _nodeDiameter = 15;
  color _nodeColor = color(243, 156, 18);
  void timeNodeDisplay() {
    if (currentPos < 1) {
      pushMatrix();
      stroke(_strokeColor);
      strokeWeight(_strokeWeight);
      noStroke();
      fill(_nodeColor);
      float x_t = map(currentPos, 0, 1, x_s, x_e);
      float y_t = map(currentPos, 0, 1, y_s, y_e);
      ellipse(x_t, y_t, _nodeDiameter, _nodeDiameter);
      popMatrix();
    }
  }
  void triggerTimeNode() {
    currentBar = 0;
    currentBeat = 0;
    timerOfSequence.startTimer();
    triggerEndPoints();

  }


  //UI
  void mousePressed(int mX, int mY) {
    if (dist(mX, mY, x_s, y_s) < _nodeDiameter/2) {
      triggerTimeNode();
    }
  }

}
