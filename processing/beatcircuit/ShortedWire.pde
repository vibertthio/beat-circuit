class ShortedWire extends Wire {


  TimeLine timer;

  ShortedWire(int _xs, int _ys, int _xe, int _ye) {
    super(_xs, _ys, _xe, _ye);
    timer = new TimeLine(500);
  }

  void display() {
    mainWireDisplay();
    endPointsDisplay();
  }
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
    if (timer.state) {
      stroke(_detectedColor, 200 * (1-timer.liner()));
      line(x_s, y_s, x_e, y_e);
    }
    popMatrix();
  }
  void trigger() {
    timer.startTimer();
    triggerNextWires();
  }
  void triggerNextWires() {
    // println("trigger Next!!!");
    for (int i=0; i<next.size(); i++) {
      Wire w = next.get(i);
      w.trigger();
    }
  }

}
