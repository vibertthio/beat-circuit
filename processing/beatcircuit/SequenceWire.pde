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

  //time tracking objects
  Node node;


  SequenceWire(int _xs, int _ys, int _xe, int _ye, boolean _l) {
    super(_xs, _ys, _xe, _ye);
    loop = _l;
    node = new Node(this);
  }
  SequenceWire(int _xs, int _ys, int _xe, int _ye, boolean _l, boolean _steady) {
    super(_xs, _ys, _xe, _ye);
    loop = _l;
    node = new Node(this);
  }

  void update() {
    super.update();
    node.update();
  }
  void display() {
    super.display();
    barSignsDisplay();
    node.display();
  }

  //time node
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
    if (mousePointStartPressed) {
      trigger();
    }
  }
}
