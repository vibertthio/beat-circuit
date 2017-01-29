class Circuit {
  ArrayList<Wire> wires;
  float x1, y1, x2, y2;

  Circuit() {
    wires = new ArrayList<Wire>();
  }
  Circuit(float _x1, float _y1, float _x2, float _y2) {
    wires = new ArrayList<Wire>();
    // x1 = min(_x1, _x2);
    // x2 = max(_x1, _x2);
    // y1 = min(_y1, _y2);
    // y2 = max(_y1, _y2);
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;
    if (x1 < x2) {
      if (y1 < y2) {
        wires.add(new SequenceWire(x1, y1, x2, y1, false));
        wires.add(new SequenceWire(x2, y1, x2, y2, false, false));
        wires.add(new SequenceWire(x2, y2, x1, y2, false, false));
        wires.add(new SequenceWire(x1, y2, x1, y1, false, false));
      }
      else {
        wires.add(new SequenceWire(x1, y1, x1, y2, false));
        wires.add(new SequenceWire(x1, y2, x2, y2, false, false));
        wires.add(new SequenceWire(x2, y2, x2, y1, false, false));
        wires.add(new SequenceWire(x2, y1, x1, y1, false, false));
      }
    }
    else {
      if (y1 < y2) {
        wires.add(new SequenceWire(x1, y1, x1, y2, false));
        wires.add(new SequenceWire(x1, y2, x2, y2, false, false));
        wires.add(new SequenceWire(x2, y2, x2, y1, false, false));
        wires.add(new SequenceWire(x2, y1, x1, y1, false, false));
      }
      else {
        wires.add(new SequenceWire(x1, y1, x2, y1, false, false));
        wires.add(new SequenceWire(x2, y1, x2, y2, false, false));
        wires.add(new SequenceWire(x2, y2, x1, y2, false, false));
        wires.add(new SequenceWire(x1, y2, x1, y1, false, false));
      }
    }

    wires.get(0).addNext(wires.get(1));
    wires.get(1).addNext(wires.get(2));
    wires.get(2).addNext(wires.get(3));
    wires.get(3).addNext(wires.get(0));

  }

  // void update() {}

  void display() {
    for (int i = 0, n = wires.size(); i < n; i++) {
      Wire w = wires.get(i);
      w.update();
      w.display();
    }
  }
  void mouseReleased(int mX, int mY) {
    for (int i=0; i<wires.size(); i++) {
      Wire w = wires.get(i);
      w.mouseReleased(mX, mY);
    }
  }
  void mousePressed(int mX, int mY) {
    for (int i=0; i<wires.size(); i++) {
      Wire w = wires.get(i);
      w.mousePressed(mX, mY);
    }
  }
  void mouseSensed(int mX, int mY) {
    for (int i=0; i<wires.size(); i++) {
      Wire w = wires.get(i);
      w.mouseSensed(mX, mY);
    }
  }
}
