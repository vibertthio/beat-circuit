class SequenceWire extends Wire {
  //time line para
  // int numberOfBeats = 32;
  // int numberOfBars = 4;
  // int beatsPerBar = numberOfBeats / numberOfBars;
  int numberOfBars = 4;
  int beatsPerBar = 8;
  int numberOfBeats = beatsPerBar * numberOfBars;


  float currentPos = 0; //0 ~ 1
  float currentBar = 1; //1 ~ numberOfBars
  float currentBeat = 1; //1 ~ numberOfBeats

  //state
  boolean loop = false;
  // boolean finishTriggerNext = false;

  //time tracking objects
  Node node;
  // TimeLine timerOfSequence;


  SequenceWire(float _x_s, float _y_s, float _x_e, float _y_e, boolean _l) {
    super(_x_s, _y_s, _x_e, _y_e);
    loop = _l;
    node = new Node(this);
    // timerOfSequence = new TimeLine(timeUnit * numberOfBeats, _l);
    // timerOfSequence.startTimer();
  }
  SequenceWire(float _x_s, float _y_s, float _x_e, float _y_e, boolean _l, boolean _s) {
    super(_x_s, _y_s, _x_e, _y_e);
    loop = _l;
    node = new Node(this);
    // timerOfSequence = new TimeLine(timeUnit * numberOfBeats, _l);
    // if (_s) { timerOfSequence.startTimer(); }
  }

  void update() {
    super.update();
    node.update();
    // currentPos = timerOfSequence.liner();
    // if (currentBeat == numberOfBeats) {
    //   if (!timerOfSequence.state) {
    //     if (!finishTriggerNext) {
    //       triggerNextWires();
    //       finishTriggerNext = true;
    //     }
    //   }
    //   else if (currentPos < float(1) / numberOfBeats) {
    //     // println("restart");
    //     currentBeat = 0;
    //   }
    // }
    //
    // if (currentPos > currentBeat/numberOfBeats ) {
    //   if (currentBeat % beatsPerBar == 0) {
    //     triggerEndPoints();
    //
    //     if (currentBar == numberOfBars) {
    //       currentBar = 0;
    //     }
    //     currentBar = currentBar + 1;
    //   }
    //   currentBeat = currentBeat + 1;
    //   // println("currentPos: " + currentPos);
    //   // println("currentBeat: " + currentBeat);
    //   // println("currentBar: " + currentBar);
    // }
  }
  void display() {
    super.display();
    barSignsDisplay();
    // timeNodeDisplay();
    node.display();
  }

  //time node
  // void timeNodeDisplay() {
  //   if (currentPos < 1 && timerOfSequence.state) {
  //     pushMatrix();
  //     stroke(_strokeColor);
  //     strokeWeight(_strokeWeight);
  //     noStroke();
  //     fill(_nodeColor);
  //     float x_t = map(currentPos, 0, 1, x_s, x_e);
  //     float y_t = map(currentPos, 0, 1, y_s, y_e);
  //     ellipse(x_t, y_t, _nodeDiameter, _nodeDiameter);
  //     popMatrix();
  //   }
  // }
  void trigger() {
    node.trigger();
  }
  void triggerNextWires() {
    // println("trigger Next!!!");
    for (int i=0; i<next.size(); i++) {
      Wire w = next.get(i);
      w.trigger();
    }
  }

  //bar sign
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
        // line(d*i, _barSignSize, d*i, -_barSignSize);
        line(d*i, 0, d*i - 5, _barSignSize);
        line(d*i, 0, d*i - 5, -_barSignSize);
      }
      else {
        // line(d*i, _barSignSize/2, d*i, -_barSignSize/2);
        // noStroke();
        // ellipse(d*i, 0, 3, 3);
      }
    }

    popMatrix();
  }

  //UI
  void mousePressed(int mX, int mY) {
    super.mousePressed(mX, mY);
    if (dist(mX, mY, x_s, y_s) < _nodeDiameter/2) {
      trigger();
    }
  }
}
