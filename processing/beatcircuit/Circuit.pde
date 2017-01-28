class Circuit {
  ArrayList<Wire> wires;
  float x1, y1, x2, y2;


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
        wires.add(new SequenceWire(x2, y1, x2, y2, false));
        wires.add(new SequenceWire(x2, y2, x1, y2, false));
        wires.add(new SequenceWire(x1, y2, x1, y1, false));
      }
      else {
        wires.add(new SequenceWire(x1, y1, x1, y2, false));
        wires.add(new SequenceWire(x1, y2, x2, y2, false));
        wires.add(new SequenceWire(x2, y2, x2, y1, false));
        wires.add(new SequenceWire(x2, y1, x1, y1, false));
      }
    }
    else {
      if (y1 < y2) {
        wires.add(new SequenceWire(x1, y1, x1, y2, false));
        wires.add(new SequenceWire(x1, y2, x2, y2, false));
        wires.add(new SequenceWire(x2, y2, x2, y1, false));
        wires.add(new SequenceWire(x2, y1, x1, y1, false));
      }
      else {
        wires.add(new SequenceWire(x1, y1, x2, y1, false));
        wires.add(new SequenceWire(x2, y1, x2, y2, false));
        wires.add(new SequenceWire(x2, y2, x1, y2, false));
        wires.add(new SequenceWire(x1, y2, x1, y1, false));
      }
    }

    


  }

  // void update() {}

  void display() {
    for (int i = 0, n = wires.size(); i < n; i++) {
      Wire w = wires.get(i);
      w.update();
      w.display();
    }
  }


}
