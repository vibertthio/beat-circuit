class Wire {

  float _strokeWeight = 2;
  color _strokeColor = color (1, 152, 117);

  //time line para
  int timeUnit = 250;
  int numberOfBeats = 32;
  int numberOfBars = 4;
  int beatsPerBar = numberOfBeats / numberOfBars;

  float currentPos = 0; //0 ~ 1
  float currentBar = 1; //0 ~ numberOfBars-1
  float currentBeat = 1; //1 ~ numberOfBeats

  //pos and angle
  // float xpos, ypos, angle, length;
  float x_s, y_s, x_e, y_e;
  float angle, length;




  Metro metro;
  TimeLine timerOfSequence;
  TimeLine timerOfEndPoint;



  Wire(float _x_s, float _y_s, float _x_e, float _y_e) {
    x_s = _x_s;
    y_s = _y_s;
    x_e = _x_e;
    y_e = _y_e;

    angle = atan2(y_e - y_s, x_e - x_s);
    length = dist(x_s, y_s, x_e, y_e);
    // println("angle" + angle*180/PI);

    timerOfSequence = new TimeLine(timeUnit * numberOfBeats, true);
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
      currentBeat = 0;
    }
    else if (currentPos > currentBeat/numberOfBeats ) {
      if (currentBeat % beatsPerBar == 0) {
        if (currentBar == numberOfBars) {
          currentBar = 0;
        }
        triggerEndPoints();
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

  int strokeWeightRatioOfBarSign = 1;
  int barSignSize = 4;
  void barSignsDisplay() {
    pushMatrix();

    stroke(_strokeColor);
    strokeWeight(_strokeWeight * strokeWeightRatioOfBarSign);
    strokeCap(ROUND);
    fill(_strokeColor);
    rectMode(CENTER);
    translate(x_s, y_s);
    rotate(angle);

    float d = length / numberOfBars;
    for(int i = 1; i < numberOfBars; i++) {
      // float d = map(i, 0, numberOfBars, 0, length);
      line(d*i, barSignSize, d*i, -barSignSize);
    }

    popMatrix();
  }

  float _nodeDiameter = 15;
  color _nodeColor = color(243, 156, 18);
  void timeNodeDisplay() {
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
