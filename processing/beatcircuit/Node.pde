class Node {
  SequenceWire sqw;
  TimeLine timer;

  float currentPos = 0; //0 ~ 1
  float currentBar = 1; //1 ~ numberOfBars
  float currentBeat = 1; //1 ~ numberOfBeats

  boolean finishTriggerNext = false;

  Node(SequenceWire _sqw) {
    sqw = _sqw;
    timer = new TimeLine(sqw.timeUnit * sqw.numberOfBeats);
  }

  void update() {
    int nOfb = sqw.numberOfBeats;
    int nOfbar = sqw.numberOfBars;
    int bPerb = sqw.beatsPerBar;
    currentPos = timer.liner();
    if (currentBeat == nOfb) {
      if (!timer.state) {
        if (!finishTriggerNext) {
          sqw.triggerNextWires();
          finishTriggerNext = true;
        }
      }
      else if (currentPos < float(1) / nOfb) {
        // println("restart");
        currentBeat = 0;
      }
    }

    if (currentPos > currentBeat/nOfb ) {
      if (currentBeat % bPerb == 0) {
        sqw.triggerEndPoints();

        if (currentBar == nOfbar) {
          currentBar = 0;
        }
        currentBar = currentBar + 1;
      }
      currentBeat = currentBeat + 1;
      // println("currentPos: " + currentPos);
      // println("currentBeat: " + currentBeat);
      // println("currentBar: " + currentBar);
    }
  }

  void display() {
    if (currentPos < 1 && timer.state) {
      pushMatrix();
      // stroke(sqw._strokeColor);
      // strokeWeight(sqw._strokeWeight);
      noStroke();
      fill(sqw._nodeColor);
      float x_t = map(currentPos, 0, 1, sqw.x_s, sqw.x_e);
      float y_t = map(currentPos, 0, 1, sqw.y_s, sqw.y_e);
      ellipse(x_t, y_t, sqw._nodeDiameter, sqw._nodeDiameter);
      popMatrix();
    }
  }

  void trigger() {
    currentBar = 0;
    currentBeat = 0;
    timer.startTimer();
    sqw.triggerEndPoints();
    finishTriggerNext = false;
  }

}

// class LinearNode extends Node {
//
// }
